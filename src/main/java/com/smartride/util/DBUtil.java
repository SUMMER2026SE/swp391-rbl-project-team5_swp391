package com.smartride.util;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBUtil {

    // =============================================
    // KẾT NỐI SUPABASE (PostgreSQL)
    // =============================================
    private static final String DB_URL =
        "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres" +
        "?sslmode=require&socketTimeout=30&connectTimeout=15&loginTimeout=15&prepareThreshold=0";
    private static final String DB_USER = "postgres.zfvgigfjmbtgwgirdify";
    private static final String DB_PASS = "Bimdiendie1@";

    // Pool kết nối raw (KHÔNG wrap proxy)
    private static final ConcurrentLinkedQueue<Connection> pool = new ConcurrentLinkedQueue<>();

    // Theo dõi tất cả proxy handlers đang hoạt động để keepalive có thể ping
    private static final Set<ConnectionProxyHandler> activeHandlers =
        ConcurrentHashMap.newKeySet();

    // Flag để dừng keepalive thread khi webapp bị unload
    private static volatile boolean shuttingDown = false;

    // Keepalive thread: dùng Thread đơn giản thay vì ScheduledExecutorService
    // để tránh memory leak khi Tomcat hot-reload
    private static final Thread keepaliveThread;

    static {
        // Đăng ký driver một lần
        try { Class.forName("org.postgresql.Driver"); } catch (Exception ignored) {}

        // Keepalive thread: dùng daemon thread + volatile flag thay vì Executor
        keepaliveThread = new Thread(() -> {
            System.out.println("[DBUtil-Keepalive] Thread started.");
            // Đợi 5 giây rồi bắt đầu
            try { Thread.sleep(5_000); } catch (InterruptedException e) { return; }

            while (!shuttingDown && !Thread.currentThread().isInterrupted()) {
                try {
                    Thread.sleep(90_000); // Ping mỗi 90 giây
                } catch (InterruptedException e) {
                    break;
                }
                if (shuttingDown) break;
                pingAll();
            }
            System.out.println("[DBUtil-Keepalive] Thread stopped.");
        }, "DBUtil-Keepalive");
        keepaliveThread.setDaemon(true);
        keepaliveThread.start();
    }

    /** Ping tất cả kết nối (pool + proxy handlers) để giữ sống với Supabase */
    private static void pingAll() {
        int poolPinged = 0, handlerPinged = 0, replaced = 0;

        // 1. Ping các kết nối trong pool
        int size = pool.size();
        for (int i = 0; i < size; i++) {
            Connection c = pool.poll();
            if (c == null) break;
            try {
                if (!c.isClosed()) {
                    c.createStatement().execute("SELECT 1");
                    pool.offer(c);
                    poolPinged++;
                } else {
                    c.close();
                    Connection fresh = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                    pool.offer(fresh);
                    replaced++;
                }
            } catch (Exception e) {
                try { c.close(); } catch (Exception ignored) {}
                try {
                    Connection fresh = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                    pool.offer(fresh);
                    replaced++;
                } catch (Exception ignored) {}
            }
        }

        // 2. Ping kết nối của các DAO singleton đang hoạt động
        for (ConnectionProxyHandler handler : activeHandlers) {
            if (shuttingDown) break;
            try {
                Connection c = handler.realConn;
                if (c != null && !c.isClosed()) {
                    c.createStatement().execute("SELECT 1");
                    handlerPinged++;
                } else {
                    // Thay thế kết nối chết của DAO
                    Connection fresh = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                    handler.realConn = fresh;
                    replaced++;
                }
            } catch (Exception e) {
                // Kết nối chết, thay thế
                try {
                    Connection fresh = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                    handler.realConn = fresh;
                    replaced++;
                } catch (Exception ignored) {}
            }
        }

        System.out.println("[DBUtil-Keepalive] Pinged: pool=" + poolPinged +
            ", handlers=" + handlerPinged + ", replaced=" + replaced);
    }

    /** Gọi khi webapp bị stop/undeploy để dừng keepalive thread sạch sẽ */
    public static void shutdown() {
        shuttingDown = true;
        keepaliveThread.interrupt();
        activeHandlers.clear();
        pool.forEach(c -> { try { c.close(); } catch (Exception ignored) {} });
        pool.clear();
        System.out.println("[DBUtil] Shutdown complete.");
    }

    /** Lấy kết nối raw từ pool, hoặc tạo mới nếu pool rỗng */
    static synchronized Connection getRawConnection() {
        // Thử pool trước – nhanh vì không cần kết nối mới
        Connection conn = pool.poll();
        while (conn != null) {
            try {
                if (!conn.isClosed()) return conn;
                conn.close();
            } catch (Exception e) {
                try { conn.close(); } catch (Exception ignored) {}
            }
            conn = pool.poll();
        }
        // Pool rỗng: tạo kết nối mới
        try {
            System.out.println("[DBUtil] Creating fresh DB connection...");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        } catch (Exception ex) {
            System.err.println("[DBUtil] FATAL: Cannot create DB connection: " + ex.getMessage());
            return null;
        }
    }

    public static Connection makeConnection() {
        try {
            Connection raw = getRawConnection();
            ConnectionProxyHandler handler = new ConnectionProxyHandler(raw);
            activeHandlers.add(handler); // Đăng ký để keepalive có thể ping
            return (Connection) Proxy.newProxyInstance(
                    DBUtil.class.getClassLoader(),
                    new Class<?>[] { Connection.class },
                    handler);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    static class ConnectionProxyHandler implements InvocationHandler {
        volatile Connection realConn;

        ConnectionProxyHandler(Connection realConn) {
            this.realConn = realConn;
        }

        @Override
        public synchronized Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
            // Khi DAO gọi close(): trả kết nối về pool
            if ("close".equals(method.getName())) {
                // Xóa khỏi danh sách activeHandlers để keepalive thread không cố khôi phục lại kết nối đã đóng
                activeHandlers.remove(this);
                Connection c = realConn;
                if (c != null) {
                    try {
                        if (!c.isClosed() && pool.size() < 30) {
                            pool.offer(c);
                            realConn = null;
                        } else {
                            c.close();
                            realConn = null;
                        }
                    } catch (Exception e) {
                        realConn = null;
                    }
                }
                return null;
            }

            // Đảm bảo có kết nối sống trước khi thực thi
            ensureConnection();

            if (realConn == null) {
                throw new SQLException("Database connection is currently unavailable.");
            }

            try {
                return method.invoke(realConn, args);
            } catch (InvocationTargetException e) {
                Throwable cause = e.getCause();
                // Nếu lỗi do kết nối chết (server-side close không detect được qua isClosed())
                // thì reconnect và thử lại 1 lần
                if (cause instanceof SQLException && isConnectionError((SQLException) cause)) {
                    System.out.println("[DBUtil-Proxy] Connection-dead error detected: " +
                        cause.getMessage() + ". Reconnecting and retrying...");
                    try { if (realConn != null) realConn.close(); } catch (Exception ignored) {}
                    realConn = getRawConnection();
                    if (realConn != null) {
                        try {
                            return method.invoke(realConn, args);
                        } catch (InvocationTargetException retryEx) {
                            throw retryEx.getCause();
                        }
                    }
                }
                throw cause;
            }
        }

        private void ensureConnection() {
            try {
                if (realConn == null || realConn.isClosed()) {
                    System.out.println("[DBUtil-Proxy] Connection null/closed, fetching from pool...");
                    realConn = getRawConnection();
                }
            } catch (Exception e) {
                System.out.println("[DBUtil-Proxy] Error checking conn: " + e.getMessage() + ". Reconnecting...");
                realConn = getRawConnection();
            }
        }

        /** Phát hiện lỗi liên quan đến kết nối bị chết */
        private boolean isConnectionError(SQLException e) {
            if (e == null) return false;
            String msg = e.getMessage();
            if (msg == null) msg = "";
            msg = msg.toLowerCase();
            String sqlState = e.getSQLState();
            if (sqlState == null) sqlState = "";
            return msg.contains("closed")
                || msg.contains("connection")
                || msg.contains("socket")
                || msg.contains("broken pipe")
                || msg.contains("i/o error")
                || sqlState.startsWith("08"); // SQL State 08xxx = Connection exceptions
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(DBUtil.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void main(String[] args) throws SQLException {
        System.out.println("Testing Supabase connection...");
        Connection conn = makeConnection();
        if (conn != null) {
            DatabaseMetaData dm = conn.getMetaData();
            System.out.println("Ket noi thanh cong!");
            System.out.println("Driver: " + dm.getDriverName());
            System.out.println("Version: " + dm.getDriverVersion());
            closeConnection(conn);
        } else {
            System.out.println("Ket noi that bai! Kiem tra lai password.");
        }
        shutdown();
    }
}

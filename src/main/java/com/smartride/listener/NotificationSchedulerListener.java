package com.smartride.listener;

import com.smartride.util.DBUtil;
import com.smartride.constant.SendEmail;
import com.smartride.dao.AccountDAO;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.CustomerDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.Customer;
import java.util.List;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.Duration;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@WebListener
public class NotificationSchedulerListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Starting NotificationSchedulerListener...");
        // Auto-migrate database table
        try {
            Connection conn = DBUtil.makeConnection();
            if (conn != null) {
                Statement stmt = conn.createStatement();
                String sql = "CREATE TABLE IF NOT EXISTS notification_tracker ("
                        + "booking_id VARCHAR(50) PRIMARY KEY,"
                        + "pickup_1h BOOLEAN DEFAULT FALSE,"
                        + "pickup_30m BOOLEAN DEFAULT FALSE,"
                        + "return_2h BOOLEAN DEFAULT FALSE,"
                        + "return_1h BOOLEAN DEFAULT FALSE,"
                        + "return_30m BOOLEAN DEFAULT FALSE,"
                        + "overdue_notified BOOLEAN DEFAULT FALSE"
                        + ");"
                        + "ALTER TABLE notification_tracker ADD COLUMN IF NOT EXISTS overdue_notified BOOLEAN DEFAULT FALSE;";
                stmt.execute(sql);
                stmt.close();
                DBUtil.closeConnection(conn);
                System.out.println("Notification_Tracker table ensured.");
            }
        } catch (Exception e) {
            System.err.println("Failed to initialize Notification_Tracker table: " + e.getMessage());
        }

        // Start schedulers
        scheduler = Executors.newScheduledThreadPool(2);
        // Check notifications every 1 minute
        scheduler.scheduleAtFixedRate(this::checkAndSendNotifications, 0, 1, TimeUnit.MINUTES);
        // Check overdue bookings every 5 minutes
        scheduler.scheduleAtFixedRate(this::checkAndMarkOverdue, 1, 5, TimeUnit.MINUTES);
    }

    private void checkAndSendNotifications() {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.makeConnection();
            if (conn == null) return;
            
            // Lấy các Booking có trạng thái Confirmed hoặc Active
            String sql = "SELECT b.\"BookingID\", b.\"StartDate\", b.\"EndDate\", b.\"StatusBooking\", b.\"CustomerID\" "
                       + "FROM \"Booking\" b "
                       + "WHERE b.\"StatusBooking\" IN ('Confirmed', 'Active')";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
            
            CustomerDAO customerDAO = CustomerDAO.getInstance();
            AccountDAO accountDAO = AccountDAO.getInstance();
            
            while (rs.next()) {
                String bookingId = rs.getString("BookingID");
                String startDateStr = rs.getString("StartDate");
                String endDateStr = rs.getString("EndDate");
                String status = rs.getString("StatusBooking");
                int customerId = rs.getInt("CustomerID");
                
                LocalDateTime startDate = null;
                LocalDateTime endDate = null;
                
                try {
                    startDate = LocalDateTime.parse(startDateStr, formatter);
                    endDate = LocalDateTime.parse(endDateStr, formatter);
                } catch (Exception e) {
                    // Fallback to standard iso format if .S is missing
                    DateTimeFormatter fallbackFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    try {
                        startDate = LocalDateTime.parse(startDateStr, fallbackFormatter);
                        endDate = LocalDateTime.parse(endDateStr, fallbackFormatter);
                    } catch (Exception ex) {
                        continue; // Skip if date is malformed
                    }
                }
                
                long minutesToStart = Duration.between(now, startDate).toMinutes();
                long minutesToEnd = Duration.between(now, endDate).toMinutes();
                
                // Get tracker flags using simple statement to avoid PSQLException prepared statement conflict
                boolean pickup1h = false, pickup30m = false;
                boolean return2h = false, return1h = false, return30m = false;
                
                try (PreparedStatement psTracker = conn.prepareStatement("SELECT * FROM notification_tracker WHERE booking_id = ?")) {
                    psTracker.setString(1, bookingId);
                    try (ResultSet rsTracker = psTracker.executeQuery()) {
                        if (rsTracker.next()) {
                            pickup1h = rsTracker.getBoolean("pickup_1h");
                            pickup30m = rsTracker.getBoolean("pickup_30m");
                            return2h = rsTracker.getBoolean("return_2h");
                            return1h = rsTracker.getBoolean("return_1h");
                            return30m = rsTracker.getBoolean("return_30m");
                        } else {
                            try (PreparedStatement psInsert = conn.prepareStatement("INSERT INTO notification_tracker (booking_id) VALUES (?)")) {
                                psInsert.setString(1, bookingId);
                                psInsert.executeUpdate();
                            }
                        }
                    }
                }
                
                Customer customer = customerDAO.getCustomerbyID(customerId);
                if (customer == null) continue;
                
                Account account = accountDAO.getAccountbyID(customer.getAccountId());
                if (account == null) continue;
                
                // Logic gửi thông báo Pickup (cho Confirmed)
                if ("Confirmed".equalsIgnoreCase(status)) {
                    if (!pickup1h && minutesToStart <= 60 && minutesToStart > 30) {
                        sendNotificationEmail(account.getEmail(), bookingId, "lấy xe", "1 tiếng");
                        updateTracker(conn, bookingId, "pickup_1h");
                    }
                    if (!pickup30m && minutesToStart <= 30 && minutesToStart >= 0) {
                        sendNotificationEmail(account.getEmail(), bookingId, "lấy xe", "30 phút");
                        updateTracker(conn, bookingId, "pickup_30m");
                    }
                }
                
                // Logic gửi thông báo Return (cho Active)
                if ("Active".equalsIgnoreCase(status)) {
                    if (!return2h && minutesToEnd <= 120 && minutesToEnd > 60) {
                        sendNotificationEmail(account.getEmail(), bookingId, "trả xe", "2 tiếng");
                        updateTracker(conn, bookingId, "return_2h");
                    }
                    if (!return1h && minutesToEnd <= 60 && minutesToEnd > 30) {
                        sendNotificationEmail(account.getEmail(), bookingId, "trả xe", "1 tiếng");
                        updateTracker(conn, bookingId, "return_1h");
                    }
                    if (!return30m && minutesToEnd <= 30 && minutesToEnd >= 0) {
                        sendNotificationEmail(account.getEmail(), bookingId, "trả xe", "30 phút");
                        updateTracker(conn, bookingId, "return_30m");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                DBUtil.closeConnection(conn);
            } catch (Exception e) {}
        }
    }
    
    private void updateTracker(Connection conn, String bookingId, String column) throws Exception {
        PreparedStatement ps = conn.prepareStatement("UPDATE notification_tracker SET " + column + " = TRUE WHERE booking_id = ?");
        ps.setString(1, bookingId);
        ps.executeUpdate();
        ps.close();
    }
    
    private void sendNotificationEmail(String email, String bookingId, String action, String timeWindow) {
        String title = "Chào bạn, SmartRide xin thông báo thời gian " + action + " của bạn sắp đến!!! (" + timeWindow + " nữa)";
        StringBuilder emailContent = new StringBuilder();
        emailContent.append("<!DOCTYPE html>\n")
                    .append("<html>\n")
                    .append("<head>\n")
                    .append("<meta charset=\"UTF-8\">\n")
                    .append("</head>\n")
                    .append("<body style=\"font-family: Arial, sans-serif; line-height: 1.6; color: #333;\">\n")
                    .append("    <div style=\"width: 80%; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px; background-color: #f9f9f9;\">\n")
                    .append("        <h2 style=\"color: #0056b3; text-align: center;\">").append(title).append("</h2>\n")
                    .append("        <p>Đây là lời nhắc tự động từ hệ thống SmartRide cho mã đơn hàng: <strong>").append(bookingId).append("</strong>.</p>\n")
                    .append("        <div style=\"margin-top: 20px; padding: 10px; background-color: #fff; border-left: 4px solid #0056b3;\">\n")
                    .append("            <p style=\"margin: 0; font-weight: bold;\">Lưu ý:</p>\n")
                    .append("            <ul style=\"margin: 10px 0 0 20px; padding: 0;\">\n");
        if (action.contains("lấy")) {
            emailContent.append("                <li>Vui lòng mang theo giấy tờ tùy thân khi nhận xe.</li>\n")
                        .append("                <li>Kiểm tra kỹ thông tin xe trước khi nhận.</li>\n");
        } else {
            emailContent.append("                <li>Vui lòng mang xe đến đúng giờ để tránh phí phạt trả muộn.</li>\n");
        }
        emailContent.append("                <li>Liên hệ với SmartRide nếu có bất kỳ thắc mắc nào.</li>\n")
                    .append("            </ul>\n")
                    .append("        </div>\n")
                    .append("    </div>\n")
                    .append("</body>\n")
                    .append("</html>\n");
        SendEmail.sendVerificationEmail(email, emailContent.toString());
    }

    /**
     * Chạy mỗi 5 phút: tự động đổi DeliveryStatus → "Quá hạn" và gửi email cảnh báo 1 lần.
     */
    private void checkAndMarkOverdue() {
        Connection conn = null;
        try {
            // 1. Đổi trạng thái các booking đã quá hạn
            List<String> overdueIds = BookingDAO.getInstance().markOverdueBookings();

            if (overdueIds.isEmpty()) return;

            // 2. Với từng bookingID mới bị overdue → gửi email 1 lần (check flag)
            conn = DBUtil.makeConnection();
            if (conn == null) return;

            CustomerDAO customerDAO = CustomerDAO.getInstance();
            AccountDAO accountDAO = AccountDAO.getInstance();

            for (String bookingId : overdueIds) {
                try {
                    // Kiểm tra flag overdue_notified
                    PreparedStatement psCheck = conn.prepareStatement(
                        "SELECT overdue_notified FROM notification_tracker WHERE booking_id = ?"
                    );
                    psCheck.setString(1, bookingId);
                    ResultSet rsCheck = psCheck.executeQuery();

                    boolean alreadyNotified = false;
                    boolean rowExists = false;
                    if (rsCheck.next()) {
                        rowExists = true;
                        alreadyNotified = rsCheck.getBoolean("overdue_notified");
                    }
                    rsCheck.close();
                    psCheck.close();

                    if (alreadyNotified) continue;

                    // Lấy email khách hàng từ booking
                    PreparedStatement psInfo = conn.prepareStatement(
                        "SELECT b.\"CustomerID\", COALESCE(e.\"NewEndDate\", b.\"EndDate\") AS eff_end "
                        + "FROM \"Booking\" b LEFT JOIN \"Extension\" e ON b.\"BookingID\" = e.\"BookingID\" "
                        + "WHERE b.\"BookingID\" = ?"
                    );
                    psInfo.setString(1, bookingId);
                    ResultSet rsInfo = psInfo.executeQuery();
                    if (rsInfo.next()) {
                        int customerId = rsInfo.getInt("CustomerID");
                        String effEnd = rsInfo.getString("eff_end");
                        Customer customer = customerDAO.getCustomerbyID(customerId);
                        if (customer != null) {
                            Account account = accountDAO.getAccountbyID(customer.getAccountId());
                            if (account != null) {
                                sendOverdueEmail(account.getEmail(), bookingId, effEnd);
                            }
                        }
                    }
                    rsInfo.close();
                    psInfo.close();

                    // Cập nhật flag overdue_notified = TRUE
                    if (!rowExists) {
                        PreparedStatement psInsert = conn.prepareStatement(
                            "INSERT INTO notification_tracker (booking_id, overdue_notified) VALUES (?, TRUE)"
                        );
                        psInsert.setString(1, bookingId);
                        psInsert.executeUpdate();
                        psInsert.close();
                    } else {
                        PreparedStatement psUpdate = conn.prepareStatement(
                            "UPDATE notification_tracker SET overdue_notified = TRUE WHERE booking_id = ?"
                        );
                        psUpdate.setString(1, bookingId);
                        psUpdate.executeUpdate();
                        psUpdate.close();
                    }
                } catch (Exception ex) {
                    System.err.println("Overdue email error for " + bookingId + ": " + ex.getMessage());
                }
            }
            System.out.println("[Overdue Check] Marked " + overdueIds.size() + " bookings as overdue.");
        } catch (Exception e) {
            System.err.println("[Overdue Check] Error: " + e.getMessage());
        } finally {
            DBUtil.closeConnection(conn);
        }
    }

    private void sendOverdueEmail(String email, String bookingId, String endDate) {
        String title = "⚠️ THÔNG BÁO: Đơn thuê xe #" + bookingId + " đã QUÁ HẠN TRẢ XE!";
        String body = "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"></head><body style=\"font-family:Arial,sans-serif;\">"
            + "<div style=\"max-width:600px;margin:0 auto;padding:24px;border:2px solid #ef4444;border-radius:12px;\">"
            + "<div style=\"background:#ef4444;border-radius:8px;padding:16px;text-align:center;margin-bottom:20px;\">"
            + "<h2 style=\"color:white;margin:0;\">🚨 QUÁ HẠN TRẢ XE</h2></div>"
            + "<p>Kính gửi Quý khách,</p>"
            + "<p>Đơn thuê xe mã <strong>#" + bookingId + "</strong> đã <strong style=\"color:#dc2626;\">QUÁ HẠN TRẢ XE</strong>.</p>"
            + "<div style=\"background:#fef2f2;border-left:4px solid #ef4444;padding:14px;border-radius:6px;margin:16px 0;\">"
            + "<strong>Hạn trả ban đầu:</strong> " + endDate + "<br>"
            + "<strong>Lưu ý:</strong> Mỗi ngày giữ xe thêm sẽ phát sinh <strong>phí phạt trễ hạn 150% giá thuê ngày</strong>.</div>"
            + "<p>Quý khách có 2 lựa chọn:</p>"
            + "<ul><li>✅ <strong>Gia hạn</strong>: Đăng nhập vào SmartRide để gia hạn và thanh toán.</li>"
            + "<li>🏪 <strong>Trả xe</strong>: Mang xe đến cửa hàng SmartRide ngay hôm nay.</li></ul>"
            + "<p style=\"color:#6b7280;font-size:13px;\">Liên hệ: <strong>SmartRide Support</strong> để được hỗ trợ.</p>"
            + "</div></body></html>";
        SendEmail.sendVerificationEmail(email, body);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
            System.out.println("NotificationSchedulerListener stopped.");
        }
    }
}

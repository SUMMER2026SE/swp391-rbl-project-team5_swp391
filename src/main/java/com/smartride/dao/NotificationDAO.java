package com.smartride.dao;

import com.smartride.dto.Notification;
import com.smartride.util.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NotificationDAO implements Serializable {
    private static NotificationDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private NotificationDAO() {}

    public static NotificationDAO getInstance() {
        if (instance == null) {
            instance = new NotificationDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public boolean isEventPublished(String eventTitle) {
        String searchTitle = "🎉 Sự Kiện Mới: " + eventTitle;
        String sql = "SELECT 1 FROM \"Notification\" WHERE title = ? AND account_id IS NULL LIMIT 1";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, searchTitle);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean isVoucherPublished(String voucherCode) {
        String searchMessage = "%" + voucherCode + "%";
        String sql = "SELECT 1 FROM \"Notification\" WHERE title LIKE '%Voucher%' AND message LIKE ? AND account_id IS NULL LIMIT 1";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, searchMessage);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public List<Notification> getNotificationsForAccount(int accountId, int roleId) {
        List<Notification> list = new ArrayList<>();
        // Khách hàng (roleId == 1) nhận được thông báo chung (NULL), Staff/Admin (roleId > 1) chỉ nhận thông báo cá nhân
        String sql;
        if (roleId == 1) {
            sql = "SELECT * FROM \"Notification\" WHERE account_id = ? OR account_id IS NULL ORDER BY created_at DESC LIMIT 20";
        } else {
            sql = "SELECT * FROM \"Notification\" WHERE account_id = ? ORDER BY created_at DESC LIMIT 20";
        }
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Notification notif = new Notification();
                notif.setNotificationId(rs.getInt("notification_id"));
                notif.setAccountId(rs.getInt("account_id") == 0 ? null : rs.getInt("account_id"));
                notif.setTitle(rs.getString("title"));
                notif.setMessage(rs.getString("message"));
                notif.setLink(rs.getString("link"));
                notif.setRead(rs.getBoolean("is_read"));
                notif.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(notif);
            }
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean markAsRead(int notificationId) {
        String sql = "UPDATE \"Notification\" SET is_read = TRUE WHERE notification_id = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, notificationId);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean markAllAsRead(int accountId) {
        String sql = "UPDATE \"Notification\" SET is_read = TRUE WHERE account_id = ? OR account_id IS NULL";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean insertBroadcastNotification(String title, String message, String link) {
        String sql = "INSERT INTO \"Notification\" (account_id, title, message, link, is_read) VALUES (NULL, ?, ?, ?, FALSE)";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, title);
            stm.setString(2, message);
            stm.setString(3, link);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean insertStaffNotification(String title, String message, String link) {
        String sql = "INSERT INTO \"Notification\" (account_id, title, message, link, is_read) " +
                     "SELECT \"AccountID\", ?, ?, ?, FALSE FROM \"Account\" WHERE \"RoleID\" IN (2, 3)";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, title);
            stm.setString(2, message);
            stm.setString(3, link);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean checkNotificationExists(int accountId, String title) {
        String sql = "SELECT 1 FROM \"Notification\" WHERE account_id = ? AND title = ? LIMIT 1";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            stm.setString(2, title);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean insertNotification(int accountId, String title, String message, String link) {
        String sql = "INSERT INTO \"Notification\" (account_id, title, message, link, is_read) VALUES (?, ?, ?, ?, FALSE)";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            stm.setString(2, title);
            stm.setString(3, message);
            stm.setString(4, link);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(NotificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}

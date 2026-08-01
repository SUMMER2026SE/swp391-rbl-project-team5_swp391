package com.smartride.dao;

import com.smartride.dto.Payment;
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

public class PaymentDAO implements Serializable {

    private static PaymentDAO instance;

    private PaymentDAO() {
    }

    public static PaymentDAO getInstance() {
        if (instance == null) {
            instance = new PaymentDAO();
        }
        return instance;
    }

    private Connection getConnection() {
        return DBUtil.makeConnection();
    }

    public Payment getPayMentbyBookingId(String bookingId) {
        String sql = "SELECT \"PaymentID\", \"BookingID\", \"PaymentMethod\", \"PaymentDate\", \"PaymentAmount\", \"PaymentStatus\" "
                   + "FROM \"Payment\" WHERE \"BookingID\" = ? AND \"PaymentStatus\" = ? ORDER BY \"PaymentDate\" DESC";
        try (Connection conn = getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, bookingId);
            stm.setString(2, "Thành công");
            try (ResultSet rs = stm.executeQuery()) {
                List<Payment> allPayments = new ArrayList<>();
                double totalAmount = 0;
                while (rs.next()) {
                    Payment p = new Payment(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6));
                    allPayments.add(p);
                    totalAmount += p.getPaymentAmount();
                }
                if (!allPayments.isEmpty()) {
                    Payment latest = allPayments.get(0);
                    Payment aggregated = new Payment();
                    aggregated.setPaymentId(latest.getPaymentId());
                    aggregated.setBookingId(latest.getBookingId());
                    aggregated.setPaymentMethod(latest.getPaymentMethod());
                    aggregated.setPaymentDate(latest.getPaymentDate());
                    aggregated.setPaymentAmount(totalAmount);
                    aggregated.setPaymentStatus(latest.getPaymentStatus());
                    return aggregated;
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(ExtensionDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public void addPayment(String bookingId, String method, String paymentDate, double amount, String status) {
        String sql = "INSERT INTO \"Payment\" (\"BookingID\", \"PaymentMethod\", \"PaymentDate\", \"PaymentAmount\", \"PaymentStatus\") VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            ps.setString(2, method);
            ps.setString(3, paymentDate);
            ps.setDouble(4, amount);
            ps.setString(5, status);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("[PaymentDAO] Pool connection failed for booking " + bookingId + ": " + e.getMessage());
            // Retry with a fresh connection (bypass pool) to avoid prepared statement conflicts
            try (Connection freshConn = com.smartride.util.DBUtil.makeFreshConnection();
                 PreparedStatement freshPs = freshConn.prepareStatement(sql)) {
                freshPs.setString(1, bookingId);
                freshPs.setString(2, method);
                freshPs.setString(3, paymentDate);
                freshPs.setDouble(4, amount);
                freshPs.setString(5, status);
                freshPs.executeUpdate();
                System.out.println("[PaymentDAO] Retry succeeded for booking " + bookingId);
            } catch (Exception e2) {
                System.out.println("[PaymentDAO] addPayment error for booking " + bookingId + ": " + e2.getMessage());
                java.io.StringWriter sw = new java.io.StringWriter();
                e2.printStackTrace(new java.io.PrintWriter(sw));
                System.out.println("[PaymentDAO] StackTrace: " + sw.toString());
            }
        }
    }

    public List<Payment> getListByBookingId(String id) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM \"Payment\" WHERE \"BookingID\" = ? ORDER BY \"PaymentDate\" DESC";
        try (Connection conn = getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, id);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Payment p = new Payment(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6));
                    list.add(p);
                    System.out.println("[PaymentDAO.getListByBookingId] Added payment - Amount: " + p.getPaymentAmount() + ", Status: " + p.getPaymentStatus() + ", Date: " + p.getPaymentDate());
                }
                System.out.println("[PaymentDAO.getListByBookingId] Total payments for " + id + ": " + list.size());
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Payment> getAllPaymentsByCustomer(int accountId) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT \"PaymentID\", p.\"BookingID\", \"PaymentMethod\", to_char(\"PaymentDate\", 'DD-MM-YYYY HH24:MI:SS') AS \"PaymentDate\", \"PaymentAmount\", \"PaymentStatus\"\n"
                + "FROM \"Payment\" p\n"
                + "JOIN \"Booking\" b on b.\"BookingID\" = p.\"BookingID\"\n"
                + "WHERE \"CustomerID\" = (SELECT \"CustomerID\" FROM \"Customer\" WHERE \"AccountID\" = ?)\n"
                + "ORDER BY p.\"PaymentDate\" DESC";
        try (Connection conn = getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, accountId); 
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Payment p = new Payment();
                    p.setPaymentId(rs.getInt(1));
                    p.setBookingId(rs.getString(2));
                    p.setPaymentMethod(rs.getString(3));
                    p.setPaymentDate(rs.getString(4));
                    p.setPaymentAmount(rs.getDouble(5));
                    p.setPaymentStatus(rs.getString(6));
                    list.add(p);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void addLateFeePayment(String bookingId, String method, String paymentDate, double amount) {
        String sql = "INSERT INTO \"Payment\" (\"BookingID\", \"PaymentMethod\", \"PaymentDate\", \"PaymentAmount\", \"PaymentStatus\") VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            ps.setString(2, method);
            ps.setString(3, paymentDate);
            ps.setDouble(4, amount);
            ps.setString(5, "Phí trễ hạn - Chờ thu");
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("addLateFeePayment error: " + e);
        }
    }
}

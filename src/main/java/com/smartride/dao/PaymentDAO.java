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
    private Connection conn = DBUtil.makeConnection();

    private Connection getConnection() {
        if (conn == null) {
            conn = DBUtil.makeConnection();
        }
        return conn;
    }

    private PaymentDAO() {
    }

    public static PaymentDAO getInstance() {

        if (instance == null) {
            instance = new PaymentDAO();
        }
        return instance;
    }

    public Payment getPayMentbyBookingId(String bookingId) {
        PreparedStatement stm;
        ResultSet rs;
        String sql = "Select * from \"Payment\" where \"BookingID\" = ?";
        try {
            stm = getConnection().prepareStatement(sql);
            stm.setString(1, bookingId);
            rs = stm.executeQuery();
            if (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt(1));
                payment.setBookingId(rs.getString(2));
                payment.setPaymentMethod(rs.getString(3));
                payment.setPaymentDate(rs.getString(4));
                payment.setPaymentAmount(rs.getDouble(5));
                payment.setPaymentStatus(rs.getString(6));
                return payment;
            }
        } catch (SQLException e) {
            Logger.getLogger(ExtensionDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public void addPayment(String bookingId, String method, String paymentDate, int amount, String status) {
        String sql = "INSERT INTO \"Payment\" \n"
                + "    (\"BookingID\", \"PaymentMethod\", \"PaymentDate\", \"PaymentAmount\", \"PaymentStatus\")\n"
                + "VALUES \n"
                + "    (?,?, ?, ?, ?);";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setString(1, bookingId);
            ps.setString(2, method);
            ps.setString(3, paymentDate);
            ps.setInt(4, amount);
            ps.setString(5, status);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public List<Payment> getListByBookingId(String id) {
        List<Payment> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "Select * from \"Payment\" where \"BookingID\" = ?";
            stm = getConnection().prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Payment(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6)));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Payment> getAllPaymentsByCustomer(int accountId) {
        PreparedStatement stm;
        ResultSet rs;
        List<Payment> list = new ArrayList<>();
        String sql = "select \"PaymentID\", p.\"BookingID\", \"PaymentMethod\", to_char(\"PaymentDate\", 'DD-MM-YYYY HH24:MI:SS') AS \"PaymentDate\", \"PaymentAmount\", \"PaymentStatus\"\n"
                + "from \"Payment\" p\n"
                + "JOIN \"Booking\" b on b.\"BookingID\" = p.\"BookingID\"\n"
                + "WHERE \"CustomerID\" = (Select \"CustomerID\" from \"Customer\" where \"AccountID\" = ?)\n"
                + "order by p.\"PaymentDate\" desc";
        try {
            stm = getConnection().prepareStatement(sql);
            stm.setInt(1, accountId); 
            rs = stm.executeQuery();
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
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Insert bản ghi phí phạt trễ hạn vào bảng Payment.
     * PaymentMethod = "Phí trễ hạn" để phân biệt với cọc ban đầu.
     */
    public void addLateFeePayment(String bookingId, String method, String paymentDate, int amount) {
        String sql = "INSERT INTO \"Payment\" "
                + "(\"BookingID\", \"PaymentMethod\", \"PaymentDate\", \"PaymentAmount\", \"PaymentStatus\") "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setString(1, bookingId);
            ps.setString(2, method);
            ps.setString(3, paymentDate);
            ps.setInt(4, amount);
            ps.setString(5, "Phí trễ hạn - Chờ thu");
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            System.out.println("addLateFeePayment error: " + e);
        }
    }

    public static void main(String[] args) {
        PaymentDAO dao = getInstance();
//        for (Payment x : dao.getListByBookingId("BOOK908040")) {
//            System.out.println(x);
//        }
        System.out.println(dao.getAllPaymentsByCustomer(1));
    }
}

// Minor update 9

// Minor update 15

// Minor update 31

// fix patch 5

// fix patch 22

// fix patch 34

// fix patch 54

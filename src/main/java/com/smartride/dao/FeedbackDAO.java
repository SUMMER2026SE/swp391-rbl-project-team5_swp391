package com.smartride.dao;

import com.smartride.dto.Feedback;
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

public class FeedbackDAO implements Serializable {

    private static FeedbackDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private FeedbackDAO() {
    }

    public static FeedbackDAO getInstance() {
        if (instance == null) {
            instance = new FeedbackDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public int getQuantityFeedback() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM \"Feedback\"";
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public List<Feedback> getAllFeedbacks() {
        List<Feedback> list = new ArrayList<>();
        try {
            String sql = "SELECT f.*, a.\"FirstName\" || ' ' || a.\"LastName\", a.\"Image\"\n"
                    + "FROM \"Feedback\" f\n"
                    + "JOIN \"Customer\" c ON f.\"CustomerID\" = c.\"CustomerID\"\n"
                    + "JOIN \"Account\" a ON c.\"AccountID\" = a.\"AccountID\"";
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Feedback(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getInt(3),
                    rs.getInt(4),
                    rs.getInt(5),
                    rs.getString(6),
                    rs.getString(9),
                    rs.getString(10),
                    rs.getInt(7),
                    rs.getString(8)
                ));
            }
        } catch (Exception ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean insertFeedback(String content, int productRate, int serviceRate, int deliveryRate, int customerId, String bookingID) {
        String sql = "INSERT INTO \"Feedback\" (\"Content\", \"ProductRate\", \"ServiceRate\", \"DeliveryRate\", \"FeedbackTime\", \"CustomerID\", \"BookingID\") VALUES (?, ?, ?, ?, CURRENT_DATE, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, content);
            ps.setInt(2, productRate);
            ps.setInt(3, serviceRate);
            ps.setInt(4, deliveryRate);
            ps.setInt(5, customerId);
            ps.setString(6, bookingID);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public Feedback getFeedbackByBookingId(String bookingId) {
        String sql = "SELECT * FROM \"Feedback\" WHERE \"BookingID\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Feedback(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8));
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public boolean updateFeedback(String content, int productRate, int serviceRate, int deliveryRate, int customerId, String bookingID) {
        String sql = "UPDATE \"Feedback\" SET \"Content\" = ?, \"ProductRate\" = ?, \"ServiceRate\" = ?, \"DeliveryRate\" = ?, \"CustomerID\" = ? "
                + "WHERE \"BookingID\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, content);
            ps.setInt(2, productRate);
            ps.setInt(3, serviceRate);
            ps.setInt(4, deliveryRate);
            ps.setInt(5, customerId);
            ps.setString(6, bookingID);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public List<Feedback> getFeedbacksByMotorcycleId(String motorcycleId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, a.\"FirstName\" || ' ' || a.\"LastName\" as \"CustomerName\", a.\"Image\" " +
                     "FROM \"Feedback\" f " +
                     "JOIN \"Booking\" b ON f.\"BookingID\" = b.\"BookingID\" " +
                     "JOIN \"Booking Detail\" bd ON b.\"BookingID\" = bd.\"BookingID\" " +
                     "JOIN \"MotorcycleDetail\" md ON bd.\"MotorcycleDetailID\" = md.\"MotorcycleDetailID\" " +
                     "JOIN \"Customer\" c ON f.\"CustomerID\" = c.\"CustomerID\" " +
                     "JOIN \"Account\" a ON c.\"AccountID\" = a.\"AccountID\" " +
                     "WHERE md.\"MotorcycleID\" = ? " +
                     "ORDER BY f.\"feedbackTime\" DESC";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, motorcycleId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackID(rs.getInt("FeedbackID"));
                fb.setContent(rs.getString("Content"));
                fb.setProductRate(rs.getInt("ProductRate"));
                fb.setServiceRate(rs.getInt("ServiceRate"));
                fb.setDeliveryRate(rs.getInt("DeliveryRate"));
                fb.setFeedbackTime(rs.getString("feedbackTime"));
                fb.setCustomerId(rs.getInt("CustomerID"));
                fb.setBookingID(rs.getString("BookingID"));
                fb.setCustomerName(rs.getString("CustomerName"));
                fb.setCustomerImage(rs.getString("Image"));
                list.add(fb);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

}

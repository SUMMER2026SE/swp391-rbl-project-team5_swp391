package com.smartride.dao;

import com.smartride.dto.SOSRequest;
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

public class SOSRequestDAO implements Serializable {
    private static SOSRequestDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private SOSRequestDAO() {}

    public static SOSRequestDAO getInstance() {
        if (instance == null) {
            instance = new SOSRequestDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(SOSRequestDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public boolean createSOSRequest(String bookingId, double latitude, double longitude, String note) {
        String sql = "INSERT INTO \"SOSRequest\" (booking_id, latitude, longitude, note, status) VALUES (?, ?, ?, ?, 'Đang chờ xử lý')";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, bookingId);
            stm.setDouble(2, latitude);
            stm.setDouble(3, longitude);
            stm.setString(4, note);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(SOSRequestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateStatus(int sosId, String status) {
        String sql = "UPDATE \"SOSRequest\" SET status = ? WHERE sos_id = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, sosId);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(SOSRequestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public List<SOSRequest> getAllPendingSOSRequests() {
        List<SOSRequest> list = new ArrayList<>();
        String sql = "SELECT s.*, a.\"FirstName\" as first_name, a.\"LastName\" as last_name, m.\"LicensePlate\" as license_plate " +
                     "FROM \"SOSRequest\" s " +
                     "JOIN \"Booking\" b ON s.booking_id = b.\"BookingID\" " +
                     "JOIN \"Account\" a ON b.\"CustomerID\" = a.\"AccountID\" " +
                     "JOIN \"BookingDetail\" bd ON b.\"BookingID\" = bd.\"BookingID\" " +
                     "JOIN \"Motorcycle\" m ON bd.\"MotorcycleID\" = m.\"MotorcycleID\" " +
                     "WHERE s.status = 'Đang chờ xử lý' " +
                     "ORDER BY s.created_at DESC";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                SOSRequest req = new SOSRequest();
                req.setSosId(rs.getInt("sos_id"));
                req.setBookingId(rs.getString("booking_id"));
                req.setLatitude(rs.getDouble("latitude"));
                req.setLongitude(rs.getDouble("longitude"));
                req.setNote(rs.getString("note"));
                req.setStatus(rs.getString("status"));
                req.setCreatedAt(rs.getTimestamp("created_at"));
                req.setCustomerName(rs.getString("first_name") + " " + rs.getString("last_name"));
                req.setLicensePlate(rs.getString("license_plate"));
                list.add(req);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SOSRequestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}

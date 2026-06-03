package com.smartride.dao;

import com.smartride.dto.Extension;
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

public class ExtensionDAO implements Serializable {

    private static ExtensionDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private ExtensionDAO() {
    }

    public static ExtensionDAO getInstance() {

        if (instance == null) {
            instance = new ExtensionDAO();
        }
        return instance;
    }

    public boolean addExtension(String previousEndDate, String newEndDate,
            double extensionFee, String bookingId) {
        String sql = "INSERT INTO \"Extension\"\n"
                + "           (\"ExtensionDate\"\n"
                + "           ,\"PreviousEndDate\"\n"
                + "           ,\"NewEndDate\"\n"
                + "           ,\"ExtenstionFee\"\n"
                + "           ,\"BookingID\"\n"
                + "           ,\"StaffID\")\n"
                + "     VALUES\n"
                + "           (NOW(), ?, ?, ?, ?, null)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, previousEndDate);
            ps.setString(2, newEndDate);
            ps.setDouble(3, extensionFee);
            ps.setString(4, bookingId);
            ps.executeUpdate();
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public Extension getExtensionByBookingID(String bookingID) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "SELECT * FROM Extension WHERE BookingID = ?";

        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, bookingID);
            rs = stm.executeQuery();
            if (rs.next()) {
                Extension extension = new Extension();
                extension.setExtensionID(rs.getInt("ExtensionID"));
                extension.setExtensionDate(rs.getString("ExtensionDate"));
                extension.setPreviousEndDate(rs.getString("PreviousEndDate"));
                extension.setNewEndDate(rs.getString("NewEndDate"));
                extension.setExtensionFee(rs.getDouble("ExtenstionFee"));
                extension.setBookingID(rs.getString("BookingID"));
                extension.setStaffID(rs.getString("StaffID"));
                return extension;
            }
        } catch (SQLException e) {
            Logger.getLogger(ExtensionDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public List<Extension> getAllExtension() {
        List<Extension> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        String sql = "SELECT ExtensionID, \n"
                + "       TO_CHAR(ExtensionDate, 'DD-MM-YYYY HH24:MI:SS') AS ExtensionDateFormatted,\n"
                + "       TO_CHAR(PreviousEndDate, 'DD-MM-YYYY HH24:MI:SS') AS PreviousEndDateFormatted,\n"
                + "       TO_CHAR(NewEndDate, 'DD-MM-YYYY HH24:MI:SS') AS NewEndDateFormatted,\n"
                + "       ExtenstionFee, \n"
                + "       BookingID, \n"
                + "       StaffID\n"
                + "FROM Extension;";
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Extension e = new Extension();
                e.setExtensionID(rs.getInt(1));
                e.setExtensionDate(rs.getString(2));
                e.setPreviousEndDate(rs.getString(3));
                e.setNewEndDate(rs.getString(4));
                e.setExtensionFee(rs.getDouble(5));
                e.setBookingID(rs.getString(6));
                e.setStaffID(rs.getString(7));
                list.add(e);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public boolean updateExtensionByStaff(String staffId, String bookingId) {
        PreparedStatement stm;
        String sql = "Update Extension SET StaffID = ? where BookingID = ?";
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, staffId);
            stm.setString(2, bookingId);

            int rowAffect = stm.executeUpdate();
            if (rowAffect > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
//        System.out.println(ExtensionDAO.getInstance().getExtensionByBookingID("BOOK000006"));
        System.out.println(getInstance().getAllExtension());
        System.out.println(getInstance().updateExtensionByStaff("STAFF00001", "BOOK000006"));
    }

}

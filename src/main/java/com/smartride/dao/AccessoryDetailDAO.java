package com.smartride.dao;

import com.smartride.dto.AccessoryDetail;
import com.smartride.util.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AccessoryDetailDAO implements Serializable, DAO<AccessoryDetail> {

    private static AccessoryDetailDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private AccessoryDetailDAO() {
    }

    public static AccessoryDetailDAO getInstance() {

        if (instance == null) {
            instance = new AccessoryDetailDAO();
        }
        return instance;
    }

    public LinkedHashMap<Integer, Integer> getListByBookingId(String id) {
        LinkedHashMap<Integer, Integer> list = new LinkedHashMap<>();
        ResultSet rs;
            String sql = "Select AccessoryID,Quantity from \"AccessoryDetail\" where BookingID like ?;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                int accessoryID = rs.getInt("AccessoryID");
                int quantity = rs.getInt("Quantity");
                list.put(accessoryID, quantity);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertMotorcycleStatus(int motorcycleStatusId, String staffid, String status, String updatedate, String note) {
        String sql = "INSERT INTO \"Motorcycle Status\" (\"MotorcycleDetailID\", \"StaffID\", \"StatusAction\", \"UpdateDate\", \"Note\")\n"
                + "VALUES (?, ?, ?, ?, ?);";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, motorcycleStatusId);
            ps.setString(2, staffid);
            ps.setString(3, status);
            ps.setString(4, updatedate);
            ps.setString(5, note);

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public List<AccessoryDetail> getAccessoryDetail(String accessoryID) {
        List<AccessoryDetail> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "select * from AccessoryDetail where AccessoryID=?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, accessoryID);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new AccessoryDetail(rs.getString("bookingID"), rs.getInt("accessoryID"), rs.getInt("quantity"), rs.getDouble("totalPrice")));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        AccessoryDetailDAO dao = getInstance();
        LinkedHashMap<Integer, Integer> list = dao.getListByBookingId("BOOK000002");
        System.out.println(list.get(1));
    }

    @Override
    public List<AccessoryDetail> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(AccessoryDetail t) {
        String sql = "INSERT INTO \"AccessoryDetail\" (\"BookingID\", AccessoryID, Quantity, \"TotalPrice\") \n"
                + "VALUES \n"
                + "(?, ?, ?, ?);";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, t.getBookingID());
            ps.setInt(2, t.getAccessoryID());
            ps.setInt(3, t.getQuantity());
            ps.setDouble(4, t.getTotalPrice());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    @Override
    public void update(AccessoryDetail t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(AccessoryDetail t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}

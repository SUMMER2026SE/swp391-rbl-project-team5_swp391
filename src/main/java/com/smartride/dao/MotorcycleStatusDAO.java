package com.smartride.dao;

import com.smartride.dto.MotorcycleDetail;
import com.smartride.dto.MotorcycleStatus;
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

public class MotorcycleStatusDAO implements Serializable, DAO<MotorcycleStatus>{
    private static MotorcycleStatusDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private MotorcycleStatusDAO() {
    }

    public static MotorcycleStatusDAO getInstance() {

        if (instance == null) {
            instance = new MotorcycleStatusDAO();
        }
        return instance;
    }
        
    public void insertMotorcycleStatus(int motorcycleStatusId, String staffid, String status,String updatedate, String note) {
         String sql = "INSERT INTO [dbo].[Motorcycle Status] ([MotorcycleDetailID], [StaffID], [StatusAction], [UpdateDate], [Note])\n" +
                    "VALUES (?, ?, ?, ?, ?);";
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
    
    public static void main(String[] args) {
        MotorcycleStatusDAO dao = getInstance();
        dao.insertMotorcycleStatus(1, "STAFF00001", "Khong Có sẵn", "2024-05-01", "Không có vấn đề gì");
        
    }

  

    @Override
    public void update(MotorcycleStatus t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(MotorcycleStatus t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<MotorcycleStatus> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(MotorcycleStatus t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}

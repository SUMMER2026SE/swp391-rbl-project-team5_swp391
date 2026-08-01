package com.smartride.dao;

import com.smartride.dto.Account;
import com.smartride.dto.MotorcycleDetail;
import com.smartride.dto.PriceList;
import com.smartride.util.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MotorcycleDetailDAO implements Serializable, DAO<MotorcycleDetail> {
    
    private static MotorcycleDetailDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private MotorcycleDetailDAO() {
    }
    
    public static MotorcycleDetailDAO getInstance() {
        
        if (instance == null) {
            instance = new MotorcycleDetailDAO();
        }
        return instance;
    }
    
    public List<MotorcycleDetail> getAllMotorcycleDetail() {
        List<MotorcycleDetail> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "WITH LatestStatus AS (\n"
                       + "    SELECT\n"
                       + "        ms.\"MotorcycleDetailID\",\n"
                       + "        ms.\"StatusAction\",\n"
                       + "        ms.\"Note\",\n"
                       + "        ROW_NUMBER() OVER (PARTITION BY ms.\"MotorcycleDetailID\" ORDER BY ms.\"MotorcycleStatusID\" DESC) AS \"RowNum\"\n"
                       + "    FROM\n"
                       + "        \"Motorcycle Status\" ms\n"
                       + ")\n"
                       + "SELECT\n"
                       + "    md.*,\n"
                       + "    ls.\"StatusAction\",\n"
                       + "    ls.\"Note\"\n"
                       + "FROM\n"
                       + "    \"Motorcycle Detail\" md\n"
                       + "LEFT JOIN\n"
                       + "    LatestStatus ls ON md.\"MotorcycleDetailID\" = ls.\"MotorcycleDetailID\" AND ls.\"RowNum\" = 1;";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                MotorcycleDetail md = new MotorcycleDetail(rs.getInt("MotorcycleDetailID"), rs.getString("MotorcycleID"), rs.getString("LicensePlate"));
                md.setStatusAction(rs.getString("StatusAction"));
                md.setNote(rs.getString("Note"));
                list.add(md);
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<MotorcycleDetail> getMotorcycleDetail(String motorcycleId) {
        List<MotorcycleDetail> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "select * from \"Motorcycle Detail\" where \"MotorcycleID\" = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, motorcycleId);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new MotorcycleDetail(rs.getInt("MotorcycleDetailID"), rs.getString("MotorcycleID"), rs.getString("LicensePlate")));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<Integer> getListAvailableMotorcycleDetailIdByMotorcycleName(String motorcycleName) {
        List<Integer> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "WITH LatestStatus AS (\n"
                    + "    SELECT\n"
                    + "        ms.\"MotorcycleDetailID\",\n"
                    + "        ms.\"StatusAction\",\n"
                    + "        ROW_NUMBER() OVER (PARTITION BY ms.\"MotorcycleDetailID\" ORDER BY ms.\"MotorcycleStatusID\" DESC) AS \"RowNum\"\n"
                    + "    FROM\n"
                    + "        \"Motorcycle Status\" ms\n"
                    + ")\n"
                    + "SELECT\n"
                    + "    md.\"MotorcycleDetailID\"\n"
                    + "   \n"
                    + "FROM\n"
                    + "    \"Motorcycle Detail\" md\n"
                    + "INNER JOIN\n"
                    + "    LatestStatus ls ON md.\"MotorcycleDetailID\" = ls.\"MotorcycleDetailID\" AND ls.\"RowNum\" = 1\n"
                    + "INNER JOIN\n"
                    + "    \"Motorcycle\" m ON md.\"MotorcycleID\" = m.\"MotorcycleID\"\n"
                    + "WHERE\n"
                    + "    ls.\"StatusAction\" like 'Có sẵn' and (m.\"Model\" || ' ' || m.\"Displacement\") LIKE ?\n"
                    + "ORDER BY\n"
                    + "    md.\"MotorcycleID\";\n"
                    + "\n"
                    + "";
            stm = conn.prepareStatement(sql);
            stm.setString(1, motorcycleName);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt(1));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public void addMotorDetail(MotorcycleDetail detail) {
        String sql = "INSERT INTO \"Motorcycle Detail\"\n"
                + "           (\"MotorcycleID\"\n"
                + "           ,\"LicensePlate\")\n"
                + "     VALUES\n"
                + "           (?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, detail.getMotorcycleId());
            ps.setString(2, detail.getLicensePlate());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public MotorcycleDetail getDetailByLicensePlate(String licensePlate) {
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "select * \n"
                    + "from \"Motorcycle Detail\" \n"
                    + "where \"LicensePlate\" = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, licensePlate);
            rs = stm.executeQuery();
            if (rs.next()) {
                return new MotorcycleDetail(rs.getInt("MotorcycleDetailID"), rs.getString("MotorcycleID"), licensePlate);
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    @Override
    public List<MotorcycleDetail> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public void insert(MotorcycleDetail t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public void update(MotorcycleDetail t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public void delete(MotorcycleDetail t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public static void main(String[] args) {
        MotorcycleDetailDAO dao = getInstance();
//        for (int x : dao.getListAvailableMotorcycleDetailIdByMotorcycleName("VinFast Klara S 62 kW")) {
//            System.out.println(x);
//        }
        System.out.println(dao.getMotorcycleDetail("M00001"));
    }
}

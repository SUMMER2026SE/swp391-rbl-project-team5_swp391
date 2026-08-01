package com.smartride.dao;

import com.smartride.dto.Demand;
import com.smartride.dto.Motorcycle;
import com.smartride.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DemandDAO {
     private static DemandDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private DemandDAO() {
    }

    public static DemandDAO getInstance() {

        if (instance == null) {
            instance = new DemandDAO();
        }
        return instance;
    }
    
    public List<Demand> getAllDemand() {
        List<Demand> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"Demand\"";

            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Demand(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception ex) {
            Logger.getLogger(DemandDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public static void main(String[] args) {
        System.out.println(DemandDAO.getInstance().getAllDemand());
    }
}
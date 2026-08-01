package com.smartride.dao;

import com.smartride.dto.Brand;
import com.smartride.util.DBUtil;
import java.io.Serializable;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BrandDAO implements Serializable {

    private static BrandDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private BrandDAO() {
    }

    public static BrandDAO getInstance() {

        if (instance == null) {
            instance = new BrandDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public List<Brand> getAllBrand() {
        List<Brand> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"Brand\"";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                //feedback.setContent(feedback.getContent()+ customerName);
                list.add(new Brand(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public LinkedHashMap<String, Integer> getTotalPriceBrand() {
        LinkedHashMap<String, Integer> list = new LinkedHashMap<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT\n"
                    + "	B.\"BrandID\",\n"
                    + "    B.\"BrandName\",\n"
                    + "    COALESCE(SUM(CASE \n"
                    + "                WHEN BD.\"BookingID\" IS NOT NULL THEN P.\"DailyPriceForDay\"\n"
                    + "                ELSE 0\n"
                    + "               END), 0) AS \"TotalPrice\"\n"
                    + "FROM\n"
                    + "    \"Brand\" B\n"
                    + "    LEFT JOIN \"Motorcycle\" M ON B.\"BrandID\" = M.\"BrandID\"\n"
                    + "    LEFT JOIN \"Motorcycle Detail\" MD ON M.\"MotorcycleID\" = MD.\"MotorcycleID\"\n"
                    + "    LEFT JOIN \"Booking Detail\" BD ON MD.\"MotorcycleDetailID\" = BD.\"MotorcycleDetailID\"\n"
                    + "    LEFT JOIN \"PriceList\" P ON M.\"PriceListID\" = P.\"PriceListID\"\n"
                    + "GROUP BY\n"
                    + "    B.\"BrandID\", B.\"BrandName\"\n"
                    + "ORDER BY\n"
                    + "    B.\"BrandID\"";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.put(rs.getString("BrandName"), rs.getInt("TotalPrice"));
            }
        } catch (Exception ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getBrandIdByName(String brandName) {
        try {
            String sql = "SELECT \"BrandID\" FROM \"Brand\" WHERE LOWER(\"BrandName\") = LOWER(?)";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, brandName.trim());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ex) {
            Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int addBrand(String brandName) {
        int newId = -1;
        try {
            String sql = "INSERT INTO \"Brand\" (\"BrandName\") VALUES (?) RETURNING \"BrandID\"";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, brandName);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                newId = rs.getInt(1);
            }
        } catch (Exception ex) {
            Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return newId;
    }

    public static void main(String[] args) {
        BrandDAO bd = BrandDAO.getInstance();
        
        for (Map.Entry<String, Integer> entry : bd.getTotalPriceBrand().entrySet()) {
            System.out.println("Motorcycle: " + entry.getKey() + ", Quantity: " + entry.getValue());
        }
    }

}

package com.smartride.dao;

import com.smartride.dto.Motorcycle;
import com.smartride.dto.PriceList;
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

public class PriceListDAO implements Serializable {

    private static PriceListDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private PriceListDAO() {
    }

    public static PriceListDAO getInstance() {
        if (instance == null) {
            instance = new PriceListDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(PriceListDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public List<PriceList> getAllPriceList() {

        List<PriceList> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {

            String sql = "SELECT * FROM \"PriceList\"";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                //feedback.setContent(feedback.getContent()+ customerName);
                list.add(new PriceList(rs.getInt(1), rs.getDouble(2), rs.getDouble(3), rs.getDouble(4)));

            }
        } catch (Exception ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);

        }
        return list;
    }

    public List<PriceList> getPagingPriceList(int index) {
        List<PriceList> list = new ArrayList<>();
        String sql = "SELECT * FROM \"PriceList\" ORDER BY \"PriceListID\" OFFSET ? LIMIT 9";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 9);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new PriceList(rs.getInt(1), rs.getDouble(2), rs.getDouble(3), rs.getDouble(4)));
            }
        } catch (Exception ex) {
            Logger.getLogger(PriceListDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalPriceListCount() {
        String sql = "SELECT COUNT(*) FROM \"PriceList\"";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ex) {
            Logger.getLogger(PriceListDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public PriceList getPricingByid(String id) {
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"PriceList\" WHERE \"PriceListID\" = ?";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, Integer.parseInt(id));
            rs = stm.executeQuery();
            if (rs.next()) {
                int priceListId = rs.getInt("PriceListID");
                double pricePerDay = rs.getDouble("DailyPriceForDay");
                double pricePerWeek = rs.getDouble("DailyPriceForWeek");
                double pricePerMonth = rs.getDouble("DailyPriceForMonth");
                return new PriceList(priceListId, pricePerDay, pricePerWeek, pricePerMonth);
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void addPricing(PriceList price) {
        String sql = "INSERT INTO \"PriceList\"\n"
                + "           (\"DailyPriceForDay\"\n"
                + "           ,\"DailyPriceForWeek\"\n"
                + "           ,\"DailyPriceForMonth\")\n"
                + "     VALUES\n"
                + "           (?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, price.getDailyPriceForDay());
            ps.setDouble(2, price.getDailyPriceForWeek());
            ps.setDouble(3, price.getDailyPriceForMonth());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updatePricing(double priceForDay, double priceForWeek, double priceForMonth, int ID) {
        String sql = "UPDATE \"PriceList\"\n"
                + "   SET \"DailyPriceForDay\" = ?\n"
                + "      ,\"DailyPriceForWeek\" = ?\n"
                + "      ,\"DailyPriceForMonth\" = ?\n"
                + " WHERE \"PriceListID\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, priceForDay);
            ps.setDouble(2, priceForWeek);
            ps.setDouble(3, priceForMonth);
            ps.setDouble(4, ID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<PriceList> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void insert(PriceList t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void update(PriceList t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean deletePricing(int id) {
        String sql = "DELETE FROM \"PriceList\" WHERE \"PriceListID\" = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(PriceListDAO.class.getName()).log(Level.SEVERE, "Error deleting pricing: " + e.getMessage(), e);
            return false;
        }
    }

    public static void main(String[] args) {
        PriceListDAO dao = getInstance();
//        List<PriceList> list = dao.getAllPriceList();
//        for (PriceList x : list) {
//            System.out.println(x);
//        }
        PriceList p = new PriceList();
        p.setDailyPriceForDay(230.00);
        p.setDailyPriceForWeek(230.00);
        p.setDailyPriceForMonth(230.00);
        dao.addPricing(p);
    }

}
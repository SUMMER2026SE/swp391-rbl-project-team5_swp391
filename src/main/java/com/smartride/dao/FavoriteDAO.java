package com.smartride.dao;

import com.smartride.dto.Favorite;
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

public class FavoriteDAO implements Serializable {
    private static FavoriteDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private FavoriteDAO() {}

    public static FavoriteDAO getInstance() {
        if (instance == null) {
            instance = new FavoriteDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(FavoriteDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public boolean isFavorite(int accountId, String motorcycleId) {
        String sql = "SELECT 1 FROM \"Favorite\" WHERE account_id = ? AND motorcycle_id = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            stm.setString(2, motorcycleId);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(FavoriteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean addFavorite(int accountId, String motorcycleId) {
        if (isFavorite(accountId, motorcycleId)) return true;
        String sql = "INSERT INTO \"Favorite\" (account_id, motorcycle_id) VALUES (?, ?)";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            stm.setString(2, motorcycleId);
            int result = stm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(FavoriteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean removeFavorite(int accountId, String motorcycleId) {
        String sql = "DELETE FROM \"Favorite\" WHERE account_id = ? AND motorcycle_id = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            stm.setString(2, motorcycleId);
            int result = stm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(FavoriteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public List<Favorite> getFavoritesByAccountId(int accountId) {
        List<Favorite> list = new ArrayList<>();
        String sql = "SELECT f.*, m.\"Model\" AS \"MotorcycleName\", m.\"Image\", pl.\"DailyPriceForDay\" AS \"RentPrice\" " +
                     "FROM \"Favorite\" f " +
                     "JOIN \"Motorcycle\" m ON f.motorcycle_id = m.\"MotorcycleID\" " +
                     "LEFT JOIN \"PriceList\" pl ON m.\"PriceListID\" = pl.\"PriceListID\" " +
                     "WHERE f.account_id = ? ORDER BY f.created_at DESC";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Favorite fav = new Favorite();
                fav.setFavoriteId(rs.getInt("favorite_id"));
                fav.setAccountId(rs.getInt("account_id"));
                fav.setMotorcycleId(rs.getString("motorcycle_id"));
                fav.setCreatedAt(rs.getTimestamp("created_at"));
                fav.setMotorcycleName(rs.getString("MotorcycleName"));
                fav.setMotorcycleImage(rs.getString("Image"));
                fav.setRentPrice(rs.getInt("RentPrice"));
                list.add(fav);
            }
        } catch (SQLException ex) {
            Logger.getLogger(FavoriteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}

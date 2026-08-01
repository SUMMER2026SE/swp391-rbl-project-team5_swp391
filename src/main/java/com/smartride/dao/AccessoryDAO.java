package com.smartride.dao;

import com.smartride.dto.Accessory;
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

public class AccessoryDAO implements Serializable, DAO<Accessory> {

    private static AccessoryDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private AccessoryDAO() {
    }

    public static AccessoryDAO getInstance() {
        if (instance == null) {
            instance = new AccessoryDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(AccessoryDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    @Override
    public List<Accessory> getAll() {
        List<Accessory> list = new ArrayList<>();
        String sql = "SELECT * FROM \"Accessory\"";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Accessory(rs.getInt("AccessoryID"), rs.getString("AccessoryName"), rs.getString("AccessoryImage"), rs.getString("AccessoryImageIcon"),
                        rs.getString("AccessoryDescription"), rs.getInt("Price")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public LinkedHashMap<Accessory, Integer> getListByBookingId(String id) {
        LinkedHashMap<Accessory, Integer> list = new LinkedHashMap<>();
        String sql = "SELECT\n"
                + "    a.\"AccessoryID\",\n"
                + "    a.\"AccessoryName\",\n"
                + "    a.\"AccessoryImage\",\n"
                + "    a.\"AccessoryImageIcon\",\n"
                + "    a.\"AccessoryDescription\",\n"
                + "    ad.\"Quantity\",\n"
                + "    ad.\"TotalPrice\"\n"
                + "FROM\n"
                + "    \"AccessoryDetail\" ad\n"
                + "JOIN\n"
                + "    \"Accessory\" a ON ad.\"AccessoryID\" = a.\"AccessoryID\"\n"
                + "WHERE\n"
                + "    ad.\"BookingID\" = ?;";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.put(new Accessory(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(7)), rs.getInt(6));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Accessory getAccessoryByid(int id) {
        try {
            String sql = "SELECT * FROM \"Accessory\" WHERE \"AccessoryID\" = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Accessory(rs.getInt("AccessoryID"), rs.getString("AccessoryName"), rs.getString("AccessoryImage"),
                        rs.getString("AccessoryImageIcon"), rs.getString("AccessoryDescription"), rs.getInt("Price"));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccessoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void addNewAccessory(Accessory accessory) {
        try {
            String sql = "INSERT INTO \"Accessory\" (\"AccessoryName\", \"AccessoryImage\", \"AccessoryImageIcon\", \"AccessoryDescription\", \"Price\") VALUES (?, ?, ?, ?, ?);";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, accessory.getAccessoryName());
            stm.setString(2, accessory.getAccessoryImage());
            stm.setString(3, accessory.getAccessoryImageicon());
            stm.setString(4, accessory.getAccessoryDescription());
            stm.setDouble(5, accessory.getPrice());
            stm.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(AccessoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateAccessory(Accessory accessory) {
        try {
            String sql = "UPDATE \"Accessory\" SET \"AccessoryName\" = ?, \"AccessoryImage\" = ?, \"AccessoryImageIcon\" = ?, \"AccessoryDescription\" = ?, \"Price\" = ? WHERE \"AccessoryID\" = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, accessory.getAccessoryName());
            stm.setString(2, accessory.getAccessoryImage());
            stm.setString(3, accessory.getAccessoryImageicon());
            stm.setString(4, accessory.getAccessoryDescription());
            stm.setDouble(5, accessory.getPrice());
            stm.setInt(6, accessory.getAccessoryId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccessoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void deleteAccessory(String id) {
        try {
            String sql = "DELETE FROM \"Accessory\" WHERE \"AccessoryID\" = ?;";
            PreparedStatement stm = conn.prepareStatement(sql);
            try {
                stm.setInt(1, Integer.parseInt(id));
            } catch (NumberFormatException e) {
                stm.setString(1, id);
            }
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    public void insert(Accessory t) {
        addNewAccessory(t);
    }

    @Override
    public void update(Accessory t) {
        updateAccessory(t);
    }

    @Override
    public void delete(Accessory t) {
        deleteAccessory(String.valueOf(t.getAccessoryId()));
    }
}

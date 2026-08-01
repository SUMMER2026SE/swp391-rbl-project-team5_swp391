package com.smartride.dao;

import com.smartride.dto.TouristLocation;
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
import com.smartride.dto.LocationRecommendationDTO;
import java.util.Set;
import java.util.HashSet;
import java.util.HashMap;
import java.util.Map;

public class TouristLocationDAO implements Serializable, DAO<TouristLocation> {

    private static TouristLocationDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private TouristLocationDAO() {
    }

    public static TouristLocationDAO getInstance() {
        if (instance == null) {
            instance = new TouristLocationDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public List<TouristLocation> getAllTouristLocation() {
        List<TouristLocation> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"TouristLocation\";";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                String url = rs.getString("UrlArticle");
                if (url != null && url.contains("Đạo_Hải_Vân")) {
                    url = url.replace("Đạo_Hải_Vân", "Đèo_Hải_Vân");
                }
                list.add(new TouristLocation(
                    rs.getInt("LocationID"), 
                    rs.getString("LocationName"), 
                    rs.getString("LocationImage"), 
                    rs.getString("Description"), 
                    url, 
                    rs.getString("StaffID")
                ));
            }
        } catch (Exception ex) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<TouristLocation> getPagingTouristLocation(int index) {
        List<TouristLocation> list = new ArrayList<>();
        String sql = "SELECT * FROM \"TouristLocation\" ORDER BY \"LocationID\" OFFSET ? LIMIT 9";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 9);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String url = rs.getString("UrlArticle");
                if (url != null && url.contains("Đạo_Hải_Vân")) {
                    url = url.replace("Đạo_Hải_Vân", "Đèo_Hải_Vân");
                }
                list.add(new TouristLocation(
                    rs.getInt("LocationID"), 
                    rs.getString("LocationName"), 
                    rs.getString("LocationImage"), 
                    rs.getString("Description"), 
                    url, 
                    rs.getString("StaffID")
                ));
            }
        } catch (Exception ex) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalTouristLocation() {
        int total = 0;
        try (Connection connection = DBUtil.makeConnection();
                PreparedStatement ps = connection.prepareStatement(
                        "SELECT COUNT(*) FROM \"TouristLocation\"");
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total;
    }

    public Map<Integer, List<LocationRecommendationDTO>> getRecommendationsByLocations(
            List<TouristLocation> locations) {
        Map<Integer, List<LocationRecommendationDTO>> recommendations = new HashMap<>();
        if (locations == null || locations.isEmpty()) {
            return recommendations;
        }

        String placeholders = String.join(", ", java.util.Collections.nCopies(locations.size(), "?"));
        String sql = "SELECT r.\"LocationID\", r.\"MotorcycleID\", m.\"Model\", m.\"Image\", "
                + "r.\"Reason\", r.\"Priority\" "
                + "FROM \"LocationMotorcycleRecommendation\" r "
                + "JOIN \"Motorcycle\" m ON r.\"MotorcycleID\" = m.\"MotorcycleID\" "
                + "WHERE r.\"LocationID\" IN (" + placeholders + ") "
                + "ORDER BY r.\"LocationID\", r.\"Priority\" ASC";

        Map<Integer, Set<String>> seenModelsByLocation = new HashMap<>();
        try (Connection connection = DBUtil.makeConnection();
                PreparedStatement ps = connection.prepareStatement(sql)) {
            for (int i = 0; i < locations.size(); i++) {
                int locationId = locations.get(i).getLocationId();
                ps.setInt(i + 1, locationId);
                recommendations.put(locationId, new ArrayList<>());
                seenModelsByLocation.put(locationId, new HashSet<>());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int locationId = rs.getInt("LocationID");
                    String model = rs.getString("Model");
                    Set<String> seenModels = seenModelsByLocation.get(locationId);
                    if (seenModels != null && seenModels.add(model)) {
                        recommendations.get(locationId).add(new LocationRecommendationDTO(
                                rs.getString("MotorcycleID"),
                                model,
                                rs.getString("Image"),
                                rs.getString("Reason"),
                                rs.getInt("Priority")
                        ));
                    }
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return recommendations;
    }

    public List<LocationRecommendationDTO> getRecommendationsByLocation(int locationId) {
        List<LocationRecommendationDTO> list = new ArrayList<>();
        String sql = "SELECT r.\"MotorcycleID\", m.\"Model\", m.\"Image\", r.\"Reason\", r.\"Priority\" " +
                     "FROM \"LocationMotorcycleRecommendation\" r " +
                     "JOIN \"Motorcycle\" m ON r.\"MotorcycleID\" = m.\"MotorcycleID\" " +
                     "WHERE r.\"LocationID\" = ? " +
                     "ORDER BY r.\"Priority\" ASC";
        try (Connection conn = DBUtil.makeConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, locationId);
            try (ResultSet rs = ps.executeQuery()) {
                Set<String> seenModels = new HashSet<>();
                while (rs.next()) {
                    String model = rs.getString("Model");
                    if (!seenModels.contains(model)) {
                        seenModels.add(model);
                        list.add(new LocationRecommendationDTO(
                            rs.getString("MotorcycleID"),
                            model,
                            rs.getString("Image"),
                            rs.getString("Reason"),
                            rs.getInt("Priority")
                        ));
                    }
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public boolean addRecommendation(int locationId, String motorcycleId, String reason, int priority) {
        String sql = "INSERT INTO \"LocationMotorcycleRecommendation\" (\"LocationID\", \"MotorcycleID\", \"Reason\", \"Priority\") VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.makeConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, locationId);
            ps.setString(2, motorcycleId);
            ps.setString(3, reason);
            ps.setInt(4, priority);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean deleteRecommendation(int locationId, String motorcycleId) {
        String sql = "DELETE FROM \"LocationMotorcycleRecommendation\" WHERE \"LocationID\" = ? AND \"MotorcycleID\" = ?";
        try (Connection conn = DBUtil.makeConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, locationId);
            ps.setString(2, motorcycleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public TouristLocation getTouristLocationbyID(int id) {
        String sql = "SELECT * FROM \"TouristLocation\" WHERE \"LocationID\" = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                TouristLocation touristLocation = new TouristLocation();
                touristLocation.setLocationId(rs.getInt("LocationID"));
                touristLocation.setLocationName(rs.getString("LocationName"));
                touristLocation.setLocationImage(rs.getString("LocationImage"));
                touristLocation.setDescription(rs.getString("Description"));
                touristLocation.setUrlArticle(rs.getString("UrlArticle"));
                touristLocation.setStaffID(rs.getString("StaffID"));
                return touristLocation;
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return null;
    }

    public void addNewTouristLocation(TouristLocation touristLocation) {
        try {
            String sql = "INSERT INTO \"TouristLocation\" (\"LocationName\", \"LocationImage\", \"Description\", \"UrlArticle\", \"StaffID\") VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, touristLocation.getLocationName());
            stm.setString(2, touristLocation.getLocationImage());
            stm.setString(3, touristLocation.getDescription());
            stm.setString(4, touristLocation.getUrlArticle());
            stm.setString(5, touristLocation.getStaffID());
            stm.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(TouristLocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteTouristLocation(String id) {
        try {
            String sql = "DELETE FROM \"TouristLocation\" WHERE \"LocationID\" = ?;";
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

    public void updateTouristLocation(TouristLocation touristLocation) {
        try {
            String sql = "UPDATE \"TouristLocation\"\n"
                    + "   SET \"LocationName\" = ?\n"
                    + "      ,\"LocationImage\" = ?\n"
                    + "      ,\"Description\" = ?\n"
                    + "      ,\"UrlArticle\" = ?\n"
                    + "      ,\"StaffID\" = ?\n"
                    + " WHERE \"LocationID\" = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, touristLocation.getLocationName());
            stm.setString(2, touristLocation.getLocationImage());
            stm.setString(3, touristLocation.getDescription());
            stm.setString(4, touristLocation.getUrlArticle());
            stm.setString(5, touristLocation.getStaffID());
            stm.setInt(6, touristLocation.getLocationId());
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error updating TouristLocation: " + e.getMessage());
        }
    }

    @Override
    public List<TouristLocation> getAll() {
        return getAllTouristLocation();
    }

    @Override
    public void insert(TouristLocation t) {
        addNewTouristLocation(t);
    }

    @Override
    public void update(TouristLocation t) {
        updateTouristLocation(t);
    }

    @Override
    public void delete(TouristLocation t) {
        deleteTouristLocation(String.valueOf(t.getLocationId()));
    }
}

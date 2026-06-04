package com.smartride.dao;

import com.smartride.dto.Account;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.MotorcycleDetail;
import com.smartride.dto.PriceList;
import com.smartride.dto.SearchCriteria;
import com.smartride.dto.SearchCriteria.PriceRange;
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

public class MotorcycleDAO implements Serializable, DAO<Motorcycle> {

    private static MotorcycleDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private MotorcycleDAO() {
    }

    public static MotorcycleDAO getInstance() {
        if (instance == null) {
            instance = new MotorcycleDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(MotorcycleDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    @Override
    public List<Motorcycle> getAll() {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            // Tối ưu N+1 Query: Lấy toàn bộ Detail một lần và map theo MotorcycleID
            List<MotorcycleDetail> allDetails = MotorcycleDetailDAO.getInstance().getAllMotorcycleDetail();
            java.util.Map<String, List<MotorcycleDetail>> detailsMap = new java.util.HashMap<>();
            if (allDetails != null) {
                for (MotorcycleDetail md : allDetails) {
                    detailsMap.computeIfAbsent(md.getMotorcycleId(), k -> new ArrayList<>()).add(md);
                }
            }

            String sql = "SELECT \n"
                    + "    \"MotorcycleID\",\n"
                    + "    \"Model\",\n"
                    + "    \"Image\",\n"
                    + "    \"Displacement\",\n"
                    + "    \"Description\",\n"
                    + "    \"MinAge\",\n"
                    + "    \"BrandID\",\n"
                    + "    \"CategoryID\",\n"
                    + "    \"PriceListID\"\n"
                    + "FROM \n"
                    + "    \"Motorcycle\";";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Motorcycle motorcycle = new Motorcycle();
                String mId = rs.getString(1);
                motorcycle.setMotorcycleId(mId);
                motorcycle.setModel(rs.getString(2));
                motorcycle.setImage(rs.getString(3));
                motorcycle.setDisplacement(rs.getString(4));
                motorcycle.setDescription(rs.getString(5));
                motorcycle.setMinAge(rs.getInt(6));
                motorcycle.setBrandID(rs.getInt(7));
                motorcycle.setCategoryID(rs.getInt(8));
                motorcycle.setPriceListID(rs.getInt(9));
                
                motorcycle.setListMotorcycleDetails(detailsMap.getOrDefault(mId, new ArrayList<>()));
                list.add(motorcycle);
            }
        } catch (Exception ex) {
            Logger.getLogger(MotorcycleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public List<Motorcycle> getPagingMotorcycles(int index) {
        List<Motorcycle> list = new ArrayList<>();
        String sql = "SELECT * FROM \"Motorcycle\" ORDER BY \"MotorcycleID\" OFFSET ? LIMIT 9";
        try {
            // Tối ưu N+1 Query: Lấy toàn bộ Detail một lần và map theo MotorcycleID
            List<MotorcycleDetail> allDetails = MotorcycleDetailDAO.getInstance().getAllMotorcycleDetail();
            java.util.Map<String, List<MotorcycleDetail>> detailsMap = new java.util.HashMap<>();
            if (allDetails != null) {
                for (MotorcycleDetail md : allDetails) {
                    detailsMap.computeIfAbsent(md.getMotorcycleId(), k -> new ArrayList<>()).add(md);
                }
            }

            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 9);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Motorcycle motorcycle = new Motorcycle();
                String mId = rs.getString("MotorcycleID");
                motorcycle.setMotorcycleId(mId);
                motorcycle.setModel(rs.getString("Model"));
                motorcycle.setImage(rs.getString("Image"));
                motorcycle.setDisplacement(rs.getString("Displacement"));
                motorcycle.setDescription(rs.getString("Description"));
                motorcycle.setMinAge(rs.getInt("MinAge"));
                motorcycle.setBrandID(rs.getInt("BrandID"));
                motorcycle.setCategoryID(rs.getInt("CategoryID"));
                motorcycle.setPriceListID(rs.getInt("PriceListID"));
                motorcycle.setListMotorcycleDetails(detailsMap.getOrDefault(mId, new ArrayList<>()));
                list.add(motorcycle);
            }
        } catch (Exception ex) {
            Logger.getLogger(MotorcycleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalMotorcyclesCount() {
        String sql = "SELECT COUNT(*) FROM \"Motorcycle\"";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ex) {
            Logger.getLogger(MotorcycleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public LinkedHashMap<String, String> getAllAvailableMotorCycle() {
        PreparedStatement stm;
        ResultSet rs;
        LinkedHashMap<String, String> list = new LinkedHashMap<>();
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
                    + "    m.\"MotorcycleID\",\n"
                    + "    COUNT(md.\"MotorcycleDetailID\") AS \"AvailableCount\"\n"
                    + "FROM\n"
                    + "    \"Motorcycle\" m\n"
                    + "INNER JOIN\n"
                    + "    \"Motorcycle Detail\" md ON m.\"MotorcycleID\" = md.\"MotorcycleID\"\n"
                    + "LEFT JOIN\n"
                    + "    LatestStatus ls ON md.\"MotorcycleDetailID\" = ls.\"MotorcycleDetailID\" AND ls.\"RowNum\" = 1\n"
                    + "WHERE\n"
                    + "    (ls.\"StatusAction\" like 'Có sẵn' OR ls.\"StatusAction\" IS NULL)\n"
                    + "GROUP BY\n"
                    + "    m.\"MotorcycleID\"\n"
                    + "ORDER BY\n"
                    + "    m.\"MotorcycleID\";";

            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                String motorcycleID = rs.getString("MotorcycleID");
                String availableCount = rs.getString("AvailableCount");
                list.put(motorcycleID, availableCount);
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Lấy xe máy theo id ==> xem detail
    public Motorcycle getMotorcycleByid(String id) {
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT \n"
                    + "    \"MotorcycleID\",\n"
                    + "    \"Model\",\n"
                    + "    \"Image\",\n"
                    + "    \"Displacement\",\n"
                    + "    \"Description\",\n"
                    + "    \"MinAge\",\n"
                    + "    \"BrandID\",\n"
                    + "    \"CategoryID\",\n"
                    + "    \"PriceListID\"\n"
                    + "FROM \n"
                    + "    \"Motorcycle\" WHERE \"MotorcycleID\" = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                return new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public LinkedHashMap<Motorcycle, Integer> getListMotorcycleByBookingId(String id) {
        PreparedStatement stm;
        ResultSet rs;
        LinkedHashMap<Motorcycle, Integer> list = new LinkedHashMap<>();
        try {
            String sql = "SELECT\n"
                    + "    m.\"MotorcycleID\",\n"
                    + "    m.\"Model\",\n"
                    + "    m.\"Image\",\n"
                    + "    m.\"Displacement\",\n"
                    + "    m.\"Description\",\n"
                    + "    m.\"MinAge\",\n"
                    + "    m.\"BrandID\",\n"
                    + "    m.\"CategoryID\",\n"
                    + "    m.\"PriceListID\",\n"
                    + "    COUNT(bd.\"BookingDetailID\") AS \"Quantity\"\n"
                    + "FROM\n"
                    + "    \"Booking Detail\" bd\n"
                    + "JOIN\n"
                    + "    \"Motorcycle Detail\" md ON bd.\"MotorcycleDetailID\" = md.\"MotorcycleDetailID\"\n"
                    + "JOIN\n"
                    + "    \"Motorcycle\" m ON md.\"MotorcycleID\" = m.\"MotorcycleID\"\n"
                    + "WHERE\n"
                    + "    bd.\"BookingID\" = ?\n"
                    + "GROUP BY\n"
                    + "    m.\"MotorcycleID\",\n"
                    + "    m.\"Model\",\n"
                    + "    m.\"Image\",\n"
                    + "    m.\"Displacement\",\n"
                    + "    m.\"Description\",\n"
                    + "    m.\"MinAge\",\n"
                    + "    m.\"BrandID\",\n"
                    + "    m.\"CategoryID\",\n"
                    + "    m.\"PriceListID\";";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.put(new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getInt(9)),
                        rs.getInt(10));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void addMotorcycle(Motorcycle motor) {
        String sql = "INSERT INTO \"Motorcycle\"\n"
                + "           (\"MotorcycleID\"\n"
                + "           ,\"Model\"\n"
                + "           ,\"Image\"\n"
                + "           ,\"Displacement\"\n"
                + "           ,\"Description\"\n"
                + "           ,\"MinAge\"\n"
                + "           ,\"BrandID\"\n"
                + "           ,\"CategoryID\"\n"
                + "           ,\"PriceListID\")\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, motor.getMotorcycleId());
            ps.setString(2, motor.getModel());
            ps.setString(3, motor.getImage());
            ps.setString(4, motor.getDisplacement());
            ps.setString(5, motor.getDescription());
            ps.setInt(6, motor.getMinAge());
            ps.setInt(7, motor.getBrandID());
            ps.setInt(8, motor.getCategoryID());
            ps.setInt(9, motor.getPriceListID());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updateMotorcycle(Motorcycle motorbike) {
        PreparedStatement stm;
        try {
            String sql = "UPDATE \"Motorcycle\"\n"
                    + "   SET \"Model\" = ?\n"
                    + "      ,\"Image\" = ?\n"
                    + "      ,\"Displacement\" = ?\n"
                    + "      ,\"Description\" = ?\n"
                    + "      ,\"MinAge\" = ?\n"
                    + "      ,\"BrandID\" = ?\n"
                    + "      ,\"CategoryID\" = ?\n"
                    + "      ,\"PriceListID\" = ?\n"
                    + " WHERE \"MotorcycleID\" = ?";
            stm = conn.prepareStatement(sql);

            stm.setString(1, motorbike.getModel());
            stm.setString(2, motorbike.getImage());
            stm.setString(3, motorbike.getDisplacement());
            stm.setString(4, motorbike.getDescription());
            stm.setInt(5, motorbike.getMinAge());
            stm.setInt(6, motorbike.getBrandID());
            stm.setInt(7, motorbike.getCategoryID());
            stm.setInt(8, motorbike.getPriceListID());
            stm.setString(9, motorbike.getMotorcycleId());

            int rowsUpdated = stm.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Motorcycle updated successfully.");
            } else {
                System.out.println("No Motorcycle updated.");
            }
        } catch (Exception e) {
            System.out.println("Error updating Motorcycle: " + e.getMessage());
        }
    }

    //đếm số lượn motorcycles trong database
    public int getTotalMotorcycles() {
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "select COUNT(*) from \"Motorcycle\";";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<String> getListDisplacements() {
        List<String> listS = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT DISTINCT \"Displacement\" FROM \"Motorcycle\"";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                listS.add(rs.getString(1));
            }
        } catch (Exception e) {
        }
        return listS;
    }

    public List<Motorcycle> getMotorcycles() {
        PreparedStatement stm;
        ResultSet rs;
        List<Motorcycle> list = new ArrayList<>();
        try {
            String sql = "Select * from \"Motorcycle\"\n"
                    + "ORDER BY \"MotorcycleID\"\n";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9)));
            }

        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);

        }
        return list;
    }

    //Tìm kiếm xe theo tên phân trang
    public List<Motorcycle> getPagingMotorcyclesByName(String key, int index) {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"Motorcycle\" WHERE \"Model\" ILIKE ?\n"
                    + "ORDER BY \"MotorcycleID\" OFFSET ? LIMIT 9";

            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + key + "%");
            stm.setInt(2, (index - 1) * 9);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalMotorcyclesCountByName(String key) {
        String sql = "SELECT COUNT(*) FROM \"Motorcycle\" WHERE \"Model\" ILIKE ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + key + "%");
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ex) {
            Logger.getLogger(MotorcycleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Motorcycle> getPagingMotorcyclesByCriteria(SearchCriteria criteria, int index) {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        StringBuilder sql = new StringBuilder("SELECT DISTINCT m.* FROM \"Motorcycle\" m LEFT JOIN \"Demand_Detail\" d ON m.\"MotorcycleID\" = d.\"MotorcycleID\" WHERE 1=1");
        List<Object> params = new ArrayList<>();

        buildCriteriaSql(criteria, sql, params);

        sql.append(" ORDER BY m.\"MotorcycleID\" OFFSET ? LIMIT 9");
        params.add((index - 1) * 9);

        try {
            stm = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stm.setObject(i + 1, params.get(i));
            }
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalMotorcyclesCountByCriteria(SearchCriteria criteria) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT m.\"MotorcycleID\") FROM \"Motorcycle\" m LEFT JOIN \"Demand_Detail\" d ON m.\"MotorcycleID\" = d.\"MotorcycleID\" WHERE 1=1");
        List<Object> params = new ArrayList<>();

        buildCriteriaSql(criteria, sql, params);

        try {
            PreparedStatement stm = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stm.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    private void buildCriteriaSql(SearchCriteria criteria, StringBuilder sql, List<Object> params) {
        if (criteria.getKeyword() != null && !criteria.getKeyword().trim().isEmpty()) {
            sql.append(" AND m.\"Model\" ILIKE ?");
            params.add("%" + criteria.getKeyword().trim() + "%");
        }
        
        if (criteria.getPriceRanges() != null && !criteria.getPriceRanges().isEmpty()) {
            sql.append(" AND \"PriceListID\" IN (SELECT \"PriceListID\" FROM \"PriceList\" WHERE ");
            for (int i = 0; i < criteria.getPriceRanges().size(); i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("\"DailyPriceForDay\" BETWEEN ? AND ?");
                params.add(criteria.getPriceRanges().get(i).getMinPrice());
                params.add(criteria.getPriceRanges().get(i).getMaxPrice());
            }
            sql.append(")");
        }

        if (criteria.getBrandIDs() != null && !criteria.getBrandIDs().isEmpty()) {
            sql.append(" AND \"BrandID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getBrandIDs().size()))
                    .append(")");
            params.addAll(criteria.getBrandIDs());
        }

        if (criteria.getCategoryIDs() != null && !criteria.getCategoryIDs().isEmpty()) {
            sql.append(" AND \"CategoryID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getCategoryIDs().size()))
                    .append(")");
            params.addAll(criteria.getCategoryIDs());
        }

        if (criteria.getDisplacements() != null && !criteria.getDisplacements().isEmpty()) {
            sql.append(" AND \"Displacement\" IN (")
                    .append(generateParameterPlaceholders(criteria.getDisplacements().size()))
                    .append(")");
            params.addAll(criteria.getDisplacements());
        }

        if (criteria.getDemandIDs() != null && !criteria.getDemandIDs().isEmpty()) {
            sql.append(" AND d.\"DemandId\" IN (")
                    .append(generateParameterPlaceholders(criteria.getDemandIDs().size()))
                    .append(")");
            params.addAll(criteria.getDemandIDs());
        }

        if (criteria.getLocationIDs() != null && !criteria.getLocationIDs().isEmpty()) {
            sql.append(" AND m.\"MotorcycleID\" IN (SELECT \"MotorcycleID\" FROM \"LocationMotorcycleRecommendation\" WHERE \"LocationID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getLocationIDs().size()))
                    .append("))");
            params.addAll(criteria.getLocationIDs());
        }
    }

    //Thanh lọc (giá, hãng, loại, phân khối, nhu cầu) 
    public List<Motorcycle> searchAllMotorcyclesByCriteria(SearchCriteria criteria) {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        StringBuilder sql = new StringBuilder("SELECT DISTINCT m.* FROM \"Motorcycle\" m JOIN \"Demand_Detail\" d ON m.\"MotorcycleID\" = d.\"MotorcycleID\" WHERE 1=1");

        if (criteria.getPriceRanges() != null && !criteria.getPriceRanges().isEmpty()) {
            sql.append(" AND \"PriceListID\" IN (SELECT \"PriceListID\" FROM \"PriceList\" WHERE ");
            for (int i = 0; i < criteria.getPriceRanges().size(); i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("\"DailyPriceForDay\" BETWEEN ? AND ?");
            }
            sql.append(")");
        }

        if (criteria.getBrandIDs() != null && !criteria.getBrandIDs().isEmpty()) {
            sql.append(" AND \"BrandID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getBrandIDs().size()))
                    .append(")");
        }

        if (criteria.getCategoryIDs() != null && !criteria.getCategoryIDs().isEmpty()) {
            sql.append(" AND \"CategoryID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getCategoryIDs().size()))
                    .append(")");
        }

        if (criteria.getDisplacements() != null && !criteria.getDisplacements().isEmpty()) {
            sql.append(" AND \"Displacement\" IN (")
                    .append(generateParameterPlaceholders(criteria.getDisplacements().size()))
                    .append(")");
        }

        if (criteria.getDemandIDs() != null && !criteria.getDemandIDs().isEmpty()) {
            sql.append(" AND d.\"DemandId\" IN (")
                    .append(generateParameterPlaceholders(criteria.getDemandIDs().size()))
                    .append(")");
        }

        if (criteria.getLocationIDs() != null && !criteria.getLocationIDs().isEmpty()) {
            sql.append(" AND m.\"MotorcycleID\" IN (SELECT \"MotorcycleID\" FROM \"LocationMotorcycleRecommendation\" WHERE \"LocationID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getLocationIDs().size()))
                    .append("))");
        }

        sql.append("\nORDER BY \"MotorcycleID\"");

        try {
            stm = conn.prepareStatement(sql.toString());
            int parameterIndex = 1;

            if (criteria.getPriceRanges() != null) {
                for (PriceRange p : criteria.getPriceRanges()) {
                    stm.setDouble(parameterIndex++, p.getMinPrice());
                    stm.setDouble(parameterIndex++, p.getMaxPrice());
                }
            }

            if (criteria.getBrandIDs() != null) {
                for (int brandID : criteria.getBrandIDs()) {
                    stm.setInt(parameterIndex++, brandID);
                }
            }

            if (criteria.getCategoryIDs() != null) {
                for (int categoryID : criteria.getCategoryIDs()) {
                    stm.setInt(parameterIndex++, categoryID);
                }
            }

            if (criteria.getDisplacements() != null) {
                for (String displacement : criteria.getDisplacements()) {
                    stm.setString(parameterIndex++, displacement);
                }
            }

            if (criteria.getDemandIDs() != null) {
                for (int demandID : criteria.getDemandIDs()) {
                    stm.setInt(parameterIndex++, demandID);
                }
            }

            if (criteria.getLocationIDs() != null) {
                for (int locationID : criteria.getLocationIDs()) {
                    stm.setInt(parameterIndex++, locationID);
                }
            }

            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception ex) {
            Logger.getLogger(MotorcycleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    private String generateParameterPlaceholders(int count) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < count; i++) {
            if (i > 0) {
                builder.append(",");
            }
            builder.append("?");
        }
        return builder.toString();
    }

    public List<Motorcycle> getTop5MotorcycleTheMostRental() {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {

            String sql = "SELECT \n"
                    + "    m.\"MotorcycleID\",\n"
                    + "    m.\"Model\",m.\"Image\",\n"
                    + "m.\"Displacement\" , m.\"Description\", m.\"MinAge\", m.\"BrandID\", m.\"CategoryID\", m.\"PriceListID\",\n"
                    + "    COUNT(bd.\"BookingDetailID\") AS \"RentalCount\",\n"
                    + "    EXTRACT(MONTH FROM b.\"BookingDate\") AS \"RentalMonth\",\n"
                    + "    EXTRACT(YEAR FROM b.\"BookingDate\") AS \"RentalYear\"\n"
                    + "FROM \n"
                    + "    \"Motorcycle\" m\n"
                    + "INNER JOIN \n"
                    + "    \"Motorcycle Detail\" md ON m.\"MotorcycleID\" = md.\"MotorcycleID\"\n"
                    + "INNER JOIN \n"
                    + "    \"Booking Detail\" bd ON md.\"MotorcycleDetailID\" = bd.\"MotorcycleDetailID\"\n"
                    + "INNER JOIN \n"
                    + "    \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\"\n"
                    + "GROUP BY \n"
                    + "    m.\"MotorcycleID\", m.\"Model\",m.\"Image\",m.\"Displacement\", m.\"Description\", m.\"MinAge\", m.\"BrandID\", m.\"CategoryID\", m.\"PriceListID\", EXTRACT(MONTH FROM b.\"BookingDate\"), EXTRACT(YEAR FROM b.\"BookingDate\")\n"
                    + "ORDER BY \n"
                    + "    \"RentalCount\" DESC LIMIT 5";

            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    public void insert(Motorcycle t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Motorcycle t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Motorcycle t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Motorcycle> getInitialMotorcycles() {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT \n"
                    + "    \"MotorcycleID\",\n"
                    + "    \"Model\",\n"
                    + "    \"Image\",\n"
                    + "    \"Displacement\",\n"
                    + "    \"Description\",\n"
                    + "    \"MinAge\",\n"
                    + "    \"BrandID\",\n"
                    + "    \"CategoryID\",\n"
                    + "    \"PriceListID\"\n"
                    + "FROM \n"
                    + "    \"Motorcycle\" ORDER BY \"MotorcycleID\" LIMIT 6";
            //why không * đi
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Motorcycle motorcycle = new Motorcycle();
                motorcycle.setMotorcycleId(rs.getString(1));
                motorcycle.setModel(rs.getString(2));
                motorcycle.setImage(rs.getString(3));
                motorcycle.setDisplacement(rs.getString(4));
                motorcycle.setDescription(rs.getString(5));
                motorcycle.setMinAge(rs.getInt(6));
                motorcycle.setBrandID(rs.getInt(7));
                motorcycle.setCategoryID(rs.getInt(8));
                motorcycle.setPriceListID(rs.getInt(9));
                List<MotorcycleDetail> listMotorcycleDetails = MotorcycleDetailDAO.getInstance().getMotorcycleDetail(rs.getString(1));
                motorcycle.setListMotorcycleDetails(listMotorcycleDetails);
                list.add(motorcycle);
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Motorcycle> getNext3Motorcycles(int iAmount) {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT "
                    + "    \"MotorcycleID\",\n"
                    + "    \"Model\",\n"
                    + "    \"Image\",\n"
                    + "    \"Displacement\",\n"
                    + "    \"Description\",\n"
                    + "    \"MinAge\",\n"
                    + "    \"BrandID\",\n"
                    + "    \"CategoryID\",\n"
                    + "    \"PriceListID\"\n"
                    + "FROM \n"
                    + "    \"Motorcycle\" ORDER BY \"MotorcycleID\"\n"
                    + "LIMIT 3 OFFSET ?;";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, iAmount);
            rs = stm.executeQuery();
            while (rs.next()) {
                Motorcycle motorcycle = new Motorcycle();
                motorcycle.setMotorcycleId(rs.getString(1));
                motorcycle.setModel(rs.getString(2));
                motorcycle.setImage(rs.getString(3));
                motorcycle.setDisplacement(rs.getString(4));
                motorcycle.setDescription(rs.getString(5));
                motorcycle.setMinAge(rs.getInt(6));
                motorcycle.setBrandID(rs.getInt(7));
                motorcycle.setCategoryID(rs.getInt(8));
                motorcycle.setPriceListID(rs.getInt(9));
                List<MotorcycleDetail> listMotorcycleDetails = MotorcycleDetailDAO.getInstance().getMotorcycleDetail(rs.getString(1));
                motorcycle.setListMotorcycleDetails(listMotorcycleDetails);
                list.add(motorcycle);
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Motorcycle> searchNext3MotorcyclesByName(String key, int iAmount) {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "Select * from \"Motorcycle\" WHERE \"Model\" LIKE ?\n"
                    + "ORDER BY \"MotorcycleID\"\n"
                    + "LIMIT 3 OFFSET ?;";

            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + key + "%");
            stm.setInt(2, iAmount);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        MotorcycleDAO dao = getInstance();
        List<Motorcycle> listAllMotorcycles = dao.getAll();
        for (Motorcycle x : listAllMotorcycles) {
            System.out.println(x);
        }
    }

    public List<Motorcycle> searchNext3MotorcyclesByCriteria(SearchCriteria criteria, int iAmount) {
        List<Motorcycle> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        StringBuilder sql = new StringBuilder("SELECT DISTINCT m.* FROM \"Motorcycle\" m LEFT JOIN \"Demand_Detail\" d ON m.\"MotorcycleID\" = d.\"MotorcycleID\" WHERE 1=1");

        if (criteria.getPriceRanges() != null && !criteria.getPriceRanges().isEmpty()) {
            sql.append(" AND \"PriceListID\" IN (SELECT \"PriceListID\" FROM \"PriceList\" WHERE ");
            for (int i = 0; i < criteria.getPriceRanges().size(); i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("\"DailyPriceForDay\" BETWEEN ? AND ?");
            }
            sql.append(")");
        }

        if (criteria.getBrandIDs() != null && !criteria.getBrandIDs().isEmpty()) {
            sql.append(" AND \"BrandID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getBrandIDs().size()))
                    .append(")");
        }

        if (criteria.getCategoryIDs() != null && !criteria.getCategoryIDs().isEmpty()) {
            sql.append(" AND \"CategoryID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getCategoryIDs().size()))
                    .append(")");
        }

        if (criteria.getDisplacements() != null && !criteria.getDisplacements().isEmpty()) {
            sql.append(" AND \"Displacement\" IN (")
                    .append(generateParameterPlaceholders(criteria.getDisplacements().size()))
                    .append(")");
        }

        if (criteria.getDemandIDs() != null && !criteria.getDemandIDs().isEmpty()) {
            sql.append(" AND d.\"DemandId\" IN (")
                    .append(generateParameterPlaceholders(criteria.getDemandIDs().size()))
                    .append(")");
        }

        if (criteria.getLocationIDs() != null && !criteria.getLocationIDs().isEmpty()) {
            sql.append(" AND m.\"MotorcycleID\" IN (SELECT \"MotorcycleID\" FROM \"LocationMotorcycleRecommendation\" WHERE \"LocationID\" IN (")
                    .append(generateParameterPlaceholders(criteria.getLocationIDs().size()))
                    .append("))");
        }

        sql.append("\nORDER BY \"MotorcycleID\"");
        sql.append("\nLIMIT 3 OFFSET ?;");

        try {
            stm = conn.prepareStatement(sql.toString());
            int parameterIndex = 1;

            if (criteria.getPriceRanges() != null) {
                for (PriceRange p : criteria.getPriceRanges()) {
                    stm.setDouble(parameterIndex++, p.getMinPrice());
                    stm.setDouble(parameterIndex++, p.getMaxPrice());
                }
            }

            if (criteria.getBrandIDs() != null) {
                for (int brandID : criteria.getBrandIDs()) {
                    stm.setInt(parameterIndex++, brandID);
                }
            }

            if (criteria.getCategoryIDs() != null) {
                for (int categoryID : criteria.getCategoryIDs()) {
                    stm.setInt(parameterIndex++, categoryID);
                }
            }

            if (criteria.getDisplacements() != null) {
                for (String displacement : criteria.getDisplacements()) {
                    stm.setString(parameterIndex++, displacement);
                }
            }

            if (criteria.getDemandIDs() != null) {
                for (int demandID : criteria.getDemandIDs()) {
                    stm.setInt(parameterIndex++, demandID);
                }
            }

            if (criteria.getLocationIDs() != null) {
                for (int locationID : criteria.getLocationIDs()) {
                    stm.setInt(parameterIndex++, locationID);
                }
            }

            stm.setInt(parameterIndex, iAmount);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Motorcycle(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception ex) {
            Logger.getLogger(MotorcycleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String getNewMotorcycleID() {
        String sql = "SELECT \"MotorcycleID\" FROM \"Motorcycle\" ORDER BY \"MotorcycleID\" DESC LIMIT 1";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String lastID = rs.getString(1);
                if (lastID != null && lastID.startsWith("M")) {
                    int num = Integer.parseInt(lastID.substring(1));
                    return String.format("M%05d", num + 1);
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(MotorcycleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "M00001";
    }

}

// Minor update 0

// Minor update 1

// Minor update 26

// fix patch 0

// fix patch 18

// fix patch 19

// fix patch 28

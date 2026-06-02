package com.smartride.dao;

import com.smartride.dto.DashboardStatsData;
import com.smartride.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class DashboardDAO {

    private static DashboardDAO instance;

    private DashboardDAO() {}

    public static DashboardDAO getInstance() {
        if (instance == null) {
            instance = new DashboardDAO();
        }
        return instance;
    }

    private static class StatRaw {
        int orders;
        double revenue;
        int customers;
        int rentals;
    }

    public DashboardStatsData getDashboardData(String period, String startDate, String endDate) {
        try (Connection conn = DBUtil.makeConnection()) {
            StatRaw current = getStatsForPeriod(conn, period, startDate, endDate, false);
            StatRaw previous = getStatsForPeriod(conn, period, startDate, endDate, true);

            double orderTrend = calculateTrend(current.orders, previous.orders);
            double revenueTrend = calculateTrend(current.revenue, previous.revenue);
            double customerTrend = calculateTrend(current.customers, previous.customers);
            double rentalTrend = calculateTrend(current.rentals, previous.rentals);

            DashboardStatsData.Trends trends = new DashboardStatsData.Trends(orderTrend, revenueTrend, customerTrend, rentalTrend);
            DashboardStatsData.Stats stats = new DashboardStatsData.Stats(current.orders, current.revenue, current.customers, current.rentals, trends);
            
            DashboardStatsData.LineChart lineChart = getLineChart(conn, period, startDate, endDate);
            Map<String, Double> radarChart = getRadarChart(conn, period, startDate, endDate);
            Map<String, Integer> pieChart = getPieChart(conn, period, startDate, endDate);
            DashboardStatsData.ChartData chartData = new DashboardStatsData.ChartData(lineChart, radarChart, pieChart);
            
            List<DashboardStatsData.TopMotorcycle> topMotorcycles = getTopMotorcycles(conn, period, startDate, endDate);
            
            return new DashboardStatsData(stats, chartData, topMotorcycles);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    private double calculateTrend(double current, double previous) {
        if (previous == 0) {
            return current > 0 ? 100.0 : 0.0;
        }
        return ((current - previous) / previous) * 100.0;
    }

    private StatRaw getStatsForPeriod(Connection conn, String period, String startDate, String endDate, boolean isPrevious) {
        StatRaw raw = new StatRaw();
        String dateCondition = getDateCondition(period, startDate, endDate, isPrevious);
        String conditionWithAlias = dateCondition.isEmpty() ? "" : (" WHERE " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\""));
        String conditionRentals = " WHERE b.\"DeliveryStatus\" IN ('Đã giao', 'Đã trả')" + (dateCondition.isEmpty() ? "" : (" AND " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\"")));

        String sql = "SELECT "
                   + "(SELECT COUNT(*) FROM \"Booking\" b " + conditionWithAlias + ") AS orders, "
                   + "(SELECT COALESCE(SUM(p.\"PaymentAmount\"), 0) FROM \"Payment\" p JOIN \"Booking\" b ON p.\"BookingID\" = b.\"BookingID\" " + conditionWithAlias + ") AS revenue, "
                   + "(SELECT COUNT(DISTINCT b.\"CustomerID\") FROM \"Booking\" b " + conditionWithAlias + ") AS customers, "
                   + "(SELECT COUNT(*) FROM \"Booking\" b " + conditionRentals + ") AS rentals";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                raw.orders = rs.getInt("orders");
                raw.revenue = rs.getDouble("revenue");
                raw.customers = rs.getInt("customers");
                raw.rentals = rs.getInt("rentals");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return raw;
    }
    
    private LocalDate getEarliestBookingDate(Connection conn) {
        String sql = "SELECT MIN(\"BookingDate\") FROM \"Booking\"";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next() && rs.getTimestamp(1) != null) {
                return rs.getTimestamp(1).toLocalDateTime().toLocalDate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return LocalDate.now().minusDays(30); // Default fallback
    }

    private LocalDate[] getRange(Connection conn, String period, String startDate, String endDate) {
        LocalDate today = LocalDate.now();
        LocalDate start = today.minusDays(30);
        LocalDate end = today;
        
        if ("custom".equals(period) && startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            try {
                start = LocalDate.parse(startDate);
                end = LocalDate.parse(endDate);
            } catch (Exception e) {
                // Ignore
            }
        } else {
            switch (period) {
                case "today":
                    start = today;
                    end = today;
                    break;
                case "30days":
                    start = today.minusDays(30);
                    end = today;
                    break;
                case "90days":
                    start = today.minusDays(90);
                    end = today;
                    break;
                case "180days":
                    start = today.minusDays(180);
                    end = today;
                    break;
                case "7days":
                    start = today.minusDays(7);
                    end = today;
                    break;
                case "all":
                    start = getEarliestBookingDate(conn);
                    end = today;
                    break;
            }
        }
        return new LocalDate[]{start, end};
    }

    private DashboardStatsData.LineChart getLineChart(Connection conn, String period, String startDate, String endDate) {
        LocalDate[] range = getRange(conn, period, startDate, endDate);
        LocalDate start = range[0];
        LocalDate end = range[1];

        Map<String, Integer> orderMap = new LinkedHashMap<>();
        Map<String, Double> revenueMap = new LinkedHashMap<>();
        Map<String, Integer> customerMap = new LinkedHashMap<>();

        LocalDate curr = start;
        while (!curr.isAfter(end)) {
            String dateStr = curr.toString();
            orderMap.put(dateStr, 0);
            revenueMap.put(dateStr, 0.0);
            customerMap.put(dateStr, 0);
            curr = curr.plusDays(1);
        }

        String dateCondition = getDateCondition(period, startDate, endDate, false);
        String conditionWithAlias = dateCondition.isEmpty() ? "" : (" WHERE " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\""));

        String sql = "SELECT DATE(b.\"BookingDate\") as dt, COUNT(b.\"BookingID\") as orders, "
                   + "COALESCE(SUM(p.\"PaymentAmount\"), 0) as revenue, "
                   + "COUNT(DISTINCT b.\"CustomerID\") as customers "
                   + "FROM \"Booking\" b LEFT JOIN \"Payment\" p ON b.\"BookingID\" = p.\"BookingID\" "
                   + conditionWithAlias
                   + " GROUP BY DATE(b.\"BookingDate\") ORDER BY dt ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                java.sql.Date dt = rs.getDate("dt");
                if (dt != null) {
                    String dateStr = dt.toString();
                    if (orderMap.containsKey(dateStr)) {
                        orderMap.put(dateStr, rs.getInt("orders"));
                        revenueMap.put(dateStr, rs.getDouble("revenue"));
                        customerMap.put(dateStr, rs.getInt("customers"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        List<String> categories = new ArrayList<>();
        List<Integer> orders = new ArrayList<>();
        List<Double> revenue = new ArrayList<>();
        List<Integer> customers = new ArrayList<>();

        for (String dateStr : orderMap.keySet()) {
            categories.add(dateStr + "T00:00:00.000Z");
            orders.add(orderMap.get(dateStr));
            revenue.add(revenueMap.get(dateStr));
            customers.add(customerMap.get(dateStr));
        }

        return new DashboardStatsData.LineChart(categories, orders, revenue, customers);
    }
    
    private Map<String, Double> getRadarChart(Connection conn, String period, String startDate, String endDate) {
        Map<String, Double> data = new LinkedHashMap<>();
        
        // Initialize all brands in CSDL with 0.0 to make it look professional
        String sqlAllBrands = "SELECT \"BrandName\" FROM \"Brand\" ORDER BY \"BrandName\" ASC";
        try (PreparedStatement ps = conn.prepareStatement(sqlAllBrands);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("BrandName"), 0.0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String dateCondition = getDateCondition(period, startDate, endDate, false);
        String conditionWithAlias = dateCondition.isEmpty() ? "" : (" WHERE " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\""));
        
        String sql = "SELECT br.\"BrandName\", SUM(p.\"PaymentAmount\") as revenue "
                   + "FROM \"Payment\" p "
                   + "JOIN \"Booking\" b ON p.\"BookingID\" = b.\"BookingID\" "
                   + "JOIN \"Booking Detail\" bd ON b.\"BookingID\" = bd.\"BookingID\" "
                   + "JOIN \"Motorcycle Detail\" md ON bd.\"MotorcycleDetailID\" = md.\"MotorcycleDetailID\" "
                   + "JOIN \"Motorcycle\" m ON md.\"MotorcycleID\" = m.\"MotorcycleID\" "
                   + "JOIN \"Brand\" br ON m.\"BrandID\" = br.\"BrandID\" "
                   + conditionWithAlias
                   + " GROUP BY br.\"BrandName\"";
                   
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("BrandName"), rs.getDouble("revenue"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
    
    private Map<String, Integer> getPieChart(Connection conn, String period, String startDate, String endDate) {
        Map<String, Integer> data = new LinkedHashMap<>();
        
        // Initialize all categories in CSDL with 0 to make it look professional
        String sqlAllCats = "SELECT \"CategoryName\" FROM \"Category\" ORDER BY \"CategoryName\" ASC";
        try (PreparedStatement ps = conn.prepareStatement(sqlAllCats);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("CategoryName"), 0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String dateCondition = getDateCondition(period, startDate, endDate, false);
        String conditionWithAlias = dateCondition.isEmpty() ? "" : (" WHERE " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\""));
        String conditionWithDelivery = conditionWithAlias.isEmpty() ? " WHERE b.\"DeliveryStatus\" IN ('Đã giao', 'Đã trả') " : conditionWithAlias + " AND b.\"DeliveryStatus\" IN ('Đã giao', 'Đã trả') ";
        
        String sql = "SELECT c.\"CategoryName\", COUNT(md.\"MotorcycleID\") as rentCount "
                   + "FROM \"Booking Detail\" bd "
                   + "JOIN \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\" "
                   + "JOIN \"Motorcycle Detail\" md ON bd.\"MotorcycleDetailID\" = md.\"MotorcycleDetailID\" "
                   + "JOIN \"Motorcycle\" m ON md.\"MotorcycleID\" = m.\"MotorcycleID\" "
                   + "JOIN \"Category\" c ON m.\"CategoryID\" = c.\"CategoryID\" "
                   + conditionWithDelivery
                   + " GROUP BY c.\"CategoryName\"";
                   
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("CategoryName"), rs.getInt("rentCount"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    private List<DashboardStatsData.TopMotorcycle> getTopMotorcycles(Connection conn, String period, String startDate, String endDate) {
        List<DashboardStatsData.TopMotorcycle> list = new ArrayList<>();
        String dateCondition = getDateCondition(period, startDate, endDate, false);
        String conditionWithAlias = dateCondition.isEmpty() ? "" : (" WHERE " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\""));
        String conditionWithDelivery = conditionWithAlias.isEmpty() ? " WHERE b.\"DeliveryStatus\" IN ('Đã giao', 'Đã trả') " : conditionWithAlias + " AND b.\"DeliveryStatus\" IN ('Đã giao', 'Đã trả') ";
        
        String sql = "SELECT m.\"Image\", m.\"Model\", p.\"DailyPriceForDay\", p.\"DailyPriceForWeek\", p.\"DailyPriceForMonth\", COUNT(md.\"MotorcycleID\") as rentCount "
                   + "FROM \"Motorcycle\" m "
                   + "JOIN \"Motorcycle Detail\" md ON m.\"MotorcycleID\" = md.\"MotorcycleID\" "
                   + "JOIN \"Booking Detail\" bd ON md.\"MotorcycleDetailID\" = bd.\"MotorcycleDetailID\" "
                   + "JOIN \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\" "
                   + "JOIN \"PriceList\" p ON m.\"PriceListID\" = p.\"PriceListID\" "
                   + conditionWithDelivery
                   + " GROUP BY m.\"Image\", m.\"Model\", p.\"DailyPriceForDay\", p.\"DailyPriceForWeek\", p.\"DailyPriceForMonth\" "
                   + " ORDER BY rentCount DESC";
                   
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new DashboardStatsData.TopMotorcycle(
                    rs.getString("Image"),
                    rs.getString("Model"),
                    rs.getDouble("DailyPriceForDay"),
                    rs.getDouble("DailyPriceForWeek"),
                    rs.getDouble("DailyPriceForMonth"),
                    rs.getInt("rentCount")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private String getDateCondition(String period, String startDate, String endDate, boolean isPrevious) {
        if ("custom".equals(period) && startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            try {
                LocalDate start = LocalDate.parse(startDate);
                LocalDate end = LocalDate.parse(endDate);
                if (isPrevious) {
                    long days = ChronoUnit.DAYS.between(start, end) + 1;
                    return "\"BookingDate\" >= '" + start.minusDays(days) + "' AND \"BookingDate\" <= '" + start.minusDays(1) + " 23:59:59'";
                }
                return "\"BookingDate\" >= '" + start + "' AND \"BookingDate\" <= '" + end + " 23:59:59'";
            } catch (Exception e) {
                // Ignore parse errors, fallback to all
            }
        }
        
        switch (period) {
            case "today":
                if (isPrevious) return "\"BookingDate\" >= current_date - interval '1 day' AND \"BookingDate\" < current_date";
                return "\"BookingDate\" >= current_date";
            case "30days":
                if (isPrevious) return "\"BookingDate\" >= current_date - interval '60 days' AND \"BookingDate\" < current_date - interval '30 days'";
                return "\"BookingDate\" >= current_date - interval '30 days'";
            case "90days":
                if (isPrevious) return "\"BookingDate\" >= current_date - interval '180 days' AND \"BookingDate\" < current_date - interval '90 days'";
                return "\"BookingDate\" >= current_date - interval '90 days'";
            case "180days":
                if (isPrevious) return "\"BookingDate\" >= current_date - interval '360 days' AND \"BookingDate\" < current_date - interval '180 days'";
                return "\"BookingDate\" >= current_date - interval '180 days'";
            case "7days":
                if (isPrevious) return "\"BookingDate\" >= current_date - interval '14 days' AND \"BookingDate\" < current_date - interval '7 days'";
                return "\"BookingDate\" >= current_date - interval '7 days'";
            default: // all
                return "";
        }
    }

    private int getInt(Connection conn, String sql) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private double getDouble(Connection conn, String sql) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        }
        return 0.0;
    }
}

// Minor update 18

// Minor update 20

// fix patch 13

// fix patch 14

// fix patch 24

// fix patch 32

// fix patch 45

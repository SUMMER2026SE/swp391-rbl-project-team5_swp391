package com.smartride.dao;

import com.smartride.dto.DashboardStatsData;
import com.smartride.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.DayOfWeek;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
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

    private String getPaymentDateCondition(String period, String startDate, String endDate, boolean isPrevious) {
        if ("custom".equals(period) && startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            try {
                LocalDate start = LocalDate.parse(startDate);
                LocalDate end = LocalDate.parse(endDate);
                if (isPrevious) {
                    long days = ChronoUnit.DAYS.between(start, end) + 1;
                    return "p.\"PaymentDate\" >= '" + start.minusDays(days) + "' AND p.\"PaymentDate\" <= '" + start.minusDays(1) + " 23:59:59'";
                }
                return "p.\"PaymentDate\" >= '" + start + "' AND p.\"PaymentDate\" <= '" + end + " 23:59:59'";
            } catch (Exception e) {
            }
        }
        
        switch (period) {
            case "today":
                if (isPrevious) return "p.\"PaymentDate\" >= current_date - interval '1 day' AND p.\"PaymentDate\" < current_date";
                return "p.\"PaymentDate\" >= current_date";
            case "30days":
                if (isPrevious) return "p.\"PaymentDate\" >= current_date - interval '60 days' AND p.\"PaymentDate\" < current_date - interval '30 days'";
                return "p.\"PaymentDate\" >= current_date - interval '30 days'";
            case "90days":
                if (isPrevious) return "p.\"PaymentDate\" >= current_date - interval '180 days' AND p.\"PaymentDate\" < current_date - interval '90 days'";
                return "p.\"PaymentDate\" >= current_date - interval '90 days'";
            case "180days":
                if (isPrevious) return "p.\"PaymentDate\" >= current_date - interval '360 days' AND p.\"PaymentDate\" < current_date - interval '180 days'";
                return "p.\"PaymentDate\" >= current_date - interval '180 days'";
            case "7days":
                if (isPrevious) return "p.\"PaymentDate\" >= current_date - interval '14 days' AND p.\"PaymentDate\" < current_date - interval '7 days'";
                return "p.\"PaymentDate\" >= current_date - interval '7 days'";
            default:
                return "";
        }
    }

    private StatRaw getStatsForPeriod(Connection conn, String period, String startDate, String endDate, boolean isPrevious) {
        StatRaw raw = new StatRaw();
        String dateCondition = getDateCondition(period, startDate, endDate, isPrevious);
        String conditionWithAlias = dateCondition.isEmpty() ? "" : (" WHERE " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\""));
        String conditionRentals = " WHERE b.\"DeliveryStatus\" IN ('Đã giao', 'Đã trả')" + (dateCondition.isEmpty() ? "" : (" AND " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\"")));

        String paymentDateCondition = getPaymentDateCondition(period, startDate, endDate, isPrevious);
        String paymentConditionWithAlias = paymentDateCondition.isEmpty() ? "" : (" WHERE " + paymentDateCondition);

        String sql = "SELECT "
                   + "(SELECT COUNT(*) FROM \"Booking\" b " + conditionWithAlias + ") AS orders, "
                   + "(SELECT COALESCE(SUM(p.\"PaymentAmount\"), 0) FROM \"Payment\" p JOIN \"Booking\" b ON p.\"BookingID\" = b.\"BookingID\" " + paymentConditionWithAlias + ") AS revenue, "
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
        long diffDays = ChronoUnit.DAYS.between(start, end);

        Map<String, Integer> orderMap = new LinkedHashMap<>();
        Map<String, Double> revenueMap = new LinkedHashMap<>();
        Map<String, Integer> customerMap = new LinkedHashMap<>();

        if (diffDays == 0) {
            LocalDateTime currDt = start.atStartOfDay();
            LocalDateTime endDt = end.atTime(23, 59, 59);
            while (!currDt.isAfter(endDt)) {
                String key = currDt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:00:00"));
                orderMap.put(key, 0); revenueMap.put(key, 0.0); customerMap.put(key, 0);
                currDt = currDt.plusHours(4);
            }
        } else if (diffDays > 31) {
            LocalDate curr = start.withDayOfMonth(1);
            while (!curr.isAfter(end)) {
                orderMap.put(curr.toString(), 0); revenueMap.put(curr.toString(), 0.0); customerMap.put(curr.toString(), 0);
                curr = curr.plusMonths(1);
            }
        } else if (diffDays > 7) {
            LocalDate curr = start.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
            while (!curr.isAfter(end)) {
                orderMap.put(curr.toString(), 0); revenueMap.put(curr.toString(), 0.0); customerMap.put(curr.toString(), 0);
                curr = curr.plusWeeks(1);
            }
        } else {
            LocalDate curr = start;
            while (!curr.isAfter(end)) {
                orderMap.put(curr.toString(), 0); revenueMap.put(curr.toString(), 0.0); customerMap.put(curr.toString(), 0);
                curr = curr.plusDays(1);
            }
        }

        String dateCondition = getDateCondition(period, startDate, endDate, false);
        String conditionWithAlias = dateCondition.isEmpty() ? "" : (" WHERE " + dateCondition.replace("\"BookingDate\"", "b.\"BookingDate\""));

        String dtSelect = "DATE(b.\"BookingDate\")";
        if (diffDays == 0) {
            dtSelect = "TO_CHAR(b.\"BookingDate\", 'YYYY-MM-DD\"T\"HH24:00:00')";
        } else if (diffDays > 31) {
            dtSelect = "DATE(DATE_TRUNC('month', b.\"BookingDate\"))";
        } else if (diffDays > 7) {
            dtSelect = "DATE(DATE_TRUNC('week', b.\"BookingDate\"))";
        }

        String sql = "SELECT " + dtSelect + " as dt, COUNT(b.\"BookingID\") as orders, "
                   + "COALESCE(SUM(p.\"PaymentAmount\"), 0) as revenue, "
                   + "COUNT(DISTINCT b.\"CustomerID\") as customers "
                   + "FROM \"Booking\" b LEFT JOIN \"Payment\" p ON b.\"BookingID\" = p.\"BookingID\" "
                   + conditionWithAlias
                   + " GROUP BY " + dtSelect;

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String key;
                if (diffDays == 0) {
                    String rawDt = rs.getString("dt");
                    if (rawDt == null) continue;
                    LocalDateTime dt = LocalDateTime.parse(rawDt);
                    int bucketHour = (dt.getHour() / 4) * 4;
                    key = dt.withHour(bucketHour).format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:00:00"));
                } else {
                    java.sql.Date dt = rs.getDate("dt");
                    if (dt == null) continue;
                    if (diffDays > 31) key = dt.toLocalDate().withDayOfMonth(1).toString();
                    else if (diffDays > 7) key = dt.toLocalDate().with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY)).toString();
                    else key = dt.toString();
                }

                if (orderMap.containsKey(key)) {
                    orderMap.put(key, orderMap.get(key) + rs.getInt("orders"));
                    revenueMap.put(key, revenueMap.get(key) + rs.getDouble("revenue"));
                    customerMap.put(key, customerMap.get(key) + rs.getInt("customers"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        List<String> categories = new ArrayList<>();
        List<Integer> orders = new ArrayList<>();
        List<Double> revenue = new ArrayList<>();
        List<Integer> customers = new ArrayList<>();

        for (String key : orderMap.keySet()) {
            String dateStr = key.contains("T") ? key : key + "T00:00:00.000Z";
            if(dateStr.endsWith("00:00")) dateStr += ".000Z"; // Fallback for diffDays == 0
            categories.add(dateStr);
            orders.add(orderMap.get(key));
            revenue.add(revenueMap.get(key));
            customers.add(customerMap.get(key));
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

        String paymentDateCondition = getPaymentDateCondition(period, startDate, endDate, false);
        String paymentConditionWithAlias = paymentDateCondition.isEmpty() ? "" : (" WHERE " + paymentDateCondition);
        
        String sql = "SELECT br.\"BrandName\", SUM(p.\"PaymentAmount\") as revenue "
                   + "FROM \"Payment\" p "
                   + "JOIN \"Booking\" b ON p.\"BookingID\" = b.\"BookingID\" "
                   + "JOIN \"Booking Detail\" bd ON b.\"BookingID\" = bd.\"BookingID\" "
                   + "JOIN \"Motorcycle Detail\" md ON bd.\"MotorcycleDetailID\" = md.\"MotorcycleDetailID\" "
                   + "JOIN \"Motorcycle\" m ON md.\"MotorcycleID\" = m.\"MotorcycleID\" "
                   + "JOIN \"Brand\" br ON m.\"BrandID\" = br.\"BrandID\" "
                   + paymentConditionWithAlias
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
        
        String sql = "SELECT c.\"CategoryName\", COUNT(md.\"MotorcycleID\") as rentCount "
                   + "FROM \"Booking Detail\" bd "
                   + "JOIN \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\" "
                   + "JOIN \"Motorcycle Detail\" md ON bd.\"MotorcycleDetailID\" = md.\"MotorcycleDetailID\" "
                   + "JOIN \"Motorcycle\" m ON md.\"MotorcycleID\" = m.\"MotorcycleID\" "
                   + "JOIN \"Category\" c ON m.\"CategoryID\" = c.\"CategoryID\" "
                   + conditionWithAlias
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
        
        String sql = "SELECT m.\"Image\", m.\"Model\", p.\"DailyPriceForDay\", p.\"DailyPriceForWeek\", p.\"DailyPriceForMonth\", COUNT(md.\"MotorcycleID\") as rentCount "
                   + "FROM \"Motorcycle\" m "
                   + "JOIN \"Motorcycle Detail\" md ON m.\"MotorcycleID\" = md.\"MotorcycleID\" "
                   + "JOIN \"Booking Detail\" bd ON md.\"MotorcycleDetailID\" = bd.\"MotorcycleDetailID\" "
                   + "JOIN \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\" "
                   + "JOIN \"PriceList\" p ON m.\"PriceListID\" = p.\"PriceListID\" "
                   + conditionWithAlias
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

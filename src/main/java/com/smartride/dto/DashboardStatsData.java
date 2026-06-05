package com.smartride.dto;

import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class DashboardStatsData {
    private Stats stats;
    private ChartData charts;
    private List<TopMotorcycle> topMotorcycles;

    public DashboardStatsData(Stats stats, ChartData charts, List<TopMotorcycle> topMotorcycles) {
        this.stats = stats;
        this.charts = charts;
        this.topMotorcycles = topMotorcycles;
    }

    public Stats getStats() { return stats; }
    public ChartData getCharts() { return charts; }
    public List<TopMotorcycle> getTopMotorcycles() { return topMotorcycles; }

    public static class Stats {
        private String orders;
        private String revenue;
        private String customers;
        private String rentals;
        private Trends trends;

        public Stats(int orders, double revenue, int customers, int rentals, Trends trends) {
            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            this.orders = String.valueOf(orders);
            this.revenue = format.format(revenue).replace("₫", "VNĐ");
            this.customers = String.valueOf(customers);
            this.rentals = String.valueOf(rentals);
            this.trends = trends;
        }

        public String getOrders() { return orders; }
        public String getRevenue() { return revenue; }
        public String getCustomers() { return customers; }
        public String getRentals() { return rentals; }
        public Trends getTrends() { return trends; }
    }

    public static class Trends {
        private String o;
        private String r;
        private String c;
        private String rt;

        public Trends(double orderTrend, double revenueTrend, double customerTrend, double rentalTrend) {
            this.o = formatTrend(orderTrend);
            this.r = formatTrend(revenueTrend);
            this.c = formatTrend(customerTrend);
            this.rt = formatTrend(rentalTrend);
        }

        public String getO() { return o; }
        public String getR() { return r; }
        public String getC() { return c; }
        public String getRt() { return rt; }

        private String formatTrend(double val) {
            if (val > 0) {
                return "<span class=\"text-success small pt-1 fw-bold\">" + String.format("%.1f", val) + "%</span> <span class=\"text-muted small pt-2 ps-1\">Tăng</span>";
            } else if (val < 0) {
                return "<span class=\"text-danger small pt-1 fw-bold\">" + String.format("%.1f", Math.abs(val)) + "%</span> <span class=\"text-muted small pt-2 ps-1\">Giảm</span>";
            } else {
                return "<span class=\"text-secondary small pt-1 fw-bold\">0%</span> <span class=\"text-muted small pt-2 ps-1\">Bằng</span>";
            }
        }
    }

    public static class ChartData {
        private LineChart lineChart;
        private Map<String, Double> radarChart; // Brand Name -> Revenue
        private Map<String, Integer> pieChart; // Category Name -> Count

        public ChartData(LineChart lineChart, Map<String, Double> radarChart, Map<String, Integer> pieChart) {
            this.lineChart = lineChart;
            this.radarChart = radarChart;
            this.pieChart = pieChart;
        }
    }

    public static class LineChart {
        private List<String> categories;
        private List<Integer> orders;
        private List<Double> revenue;
        private List<Integer> customers;

        public LineChart(List<String> categories, List<Integer> orders, List<Double> revenue, List<Integer> customers) {
            this.categories = categories;
            this.orders = orders;
            this.revenue = revenue;
            this.customers = customers;
        }
    }

    public static class TopMotorcycle {
        private String image;
        private String model;
        private String priceDay;
        private String priceWeek;
        private String priceMonth;
        private int rentCount;

        public TopMotorcycle(String image, String model, double priceDay, double priceWeek, double priceMonth, int rentCount) {
            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            this.image = image;
            this.model = model;
            this.priceDay = format.format(priceDay * 1000).replace("₫", "VNĐ");
            this.priceWeek = format.format(priceWeek * 1000).replace("₫", "VNĐ");
            this.priceMonth = format.format(priceMonth * 1000).replace("₫", "VNĐ");
            this.rentCount = rentCount;
        }

        public String getImage() { return image; }
        public String getModel() { return model; }
        public String getPriceDay() { return priceDay; }
        public String getPriceWeek() { return priceWeek; }
        public String getPriceMonth() { return priceMonth; }
        public int getRentCount() { return rentCount; }
    }
}

// Minor update 19

// fix patch 16

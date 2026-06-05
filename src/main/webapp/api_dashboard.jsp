<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.format.*, java.time.temporal.*, com.google.gson.*" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%!
    // Sử dụng DBUtil đã được tích hợp Connection Pool siêu tốc
    private static Connection getFastConnection() {
        return com.smartride.util.DBUtil.makeConnection();
    }

    private String getDateCondition(String period, String startDate, String endDate, boolean isPrevious) {
        LocalDate today = LocalDate.now();
        LocalDate start = today;
        LocalDate end = today;

        if ("custom".equals(period) && startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            try {
                start = LocalDate.parse(startDate);
                end = LocalDate.parse(endDate);
            } catch (Exception e) {}
            if (isPrevious) {
                long days = ChronoUnit.DAYS.between(start, end) + 1;
                start = start.minusDays(days);
                end = end.minusDays(days);
            }
        } else {
            switch (period) {
                case "today": start = today; end = today; if (isPrevious) { start = today.minusDays(1); end = today.minusDays(1); } break;
                case "30days": start = today.minusDays(30); end = today; if (isPrevious) { start = today.minusDays(60); end = today.minusDays(31); } break;
                case "90days": start = today.minusDays(90); end = today; if (isPrevious) { start = today.minusDays(180); end = today.minusDays(91); } break;
                case "180days": start = today.minusDays(180); end = today; if (isPrevious) { start = today.minusDays(360); end = today.minusDays(181); } break;
                case "all": return "";
                default: start = today.minusDays(30); end = today;
            }
        }
        return "\"BookingDate\" >= '" + start + " 00:00:00' AND \"BookingDate\" <= '" + end + " 23:59:59'";
    }

    private LocalDate[] getRange(String period, String startDate, String endDate) {
        LocalDate today = LocalDate.now();
        LocalDate start = today.minusDays(30);
        LocalDate end = today;
        if ("custom".equals(period) && startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            try { start = LocalDate.parse(startDate); end = LocalDate.parse(endDate); } catch (Exception e) {}
        } else {
            switch (period) {
                case "today": start = today; end = today; break;
                case "30days": start = today.minusDays(30); end = today; break;
                case "90days": start = today.minusDays(90); end = today; break;
                case "180days": start = today.minusDays(180); end = today; break;
                case "all": start = LocalDate.of(2020, 1, 1); end = today; break;
            }
        }
        return new LocalDate[]{start, end};
    }
%>
<%
    String period = request.getParameter("period");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    if (period == null) period = "30days";

    Connection conn = getFastConnection();
    if (conn == null) {
        out.print("{\"error\":\"Database connection failed\"}");
        return;
    }

    Gson gson = new Gson();
    Map<String, Object> responseMap = new HashMap<>();

    // 1. Stats (One massive fast query instead of 6 slow queries)
    final int[] currentOrdersArr = {0};
    final int[] currentCustomersArr = {0};
    final double[] currentRevenueArr = {0};
    final int[] prevOrdersArr = {0};
    final int[] prevCustomersArr = {0};
    final double[] prevRevenueArr = {0};

    String dateCond = getDateCondition(period, startDate, endDate, false);
    String prevDateCond = getDateCondition(period, startDate, endDate, true);
    
    String c1 = dateCond.isEmpty() ? "" : (" WHERE " + dateCond);
    String c1Alias = dateCond.isEmpty() ? "" : (" WHERE " + dateCond.replace("\"BookingDate\"", "b.\"BookingDate\""));
    String p1 = prevDateCond.isEmpty() ? "" : (" WHERE " + prevDateCond);
    String p1Alias = prevDateCond.isEmpty() ? "" : (" WHERE " + prevDateCond.replace("\"BookingDate\"", "b.\"BookingDate\""));

    String massiveSql = "SELECT " +
        "(SELECT COUNT(DISTINCT bd.\"BookingID\") FROM \"Booking Detail\" bd JOIN \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\"" + c1Alias + ") as co, " +
        "(SELECT COALESCE(SUM(p.\"PaymentAmount\"), 0) FROM \"Payment\" p JOIN \"Booking\" b ON p.\"BookingID\" = b.\"BookingID\"" + c1Alias + ") as cr, " +
        "(SELECT COUNT(DISTINCT \"CustomerID\") FROM \"Booking\"" + c1 + ") as cc, " +
        "(SELECT COUNT(DISTINCT bd.\"BookingID\") FROM \"Booking Detail\" bd JOIN \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\"" + p1Alias + ") as po, " +
        "(SELECT COALESCE(SUM(p.\"PaymentAmount\"), 0) FROM \"Payment\" p JOIN \"Booking\" b ON p.\"BookingID\" = b.\"BookingID\"" + p1Alias + ") as pr, " +
        "(SELECT COUNT(DISTINCT \"CustomerID\") FROM \"Booking\"" + p1 + ") as pc";

    try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(massiveSql)) {
        if (rs.next()) {
            currentOrdersArr[0] = rs.getInt("co");
            currentRevenueArr[0] = rs.getDouble("cr");
            currentCustomersArr[0] = rs.getInt("cc");
            prevOrdersArr[0] = rs.getInt("po");
            prevRevenueArr[0] = rs.getDouble("pr");
            prevCustomersArr[0] = rs.getInt("pc");
        }
    } catch(Exception e) { e.printStackTrace(); }

    int currentOrders = currentOrdersArr[0];
    double currentRevenue = currentRevenueArr[0];
    int currentCustomers = currentCustomersArr[0];
    int prevOrders = prevOrdersArr[0];
    double prevRevenue = prevRevenueArr[0];
    int prevCustomers = prevCustomersArr[0];

    double trO = prevOrders == 0 ? (currentOrders > 0 ? 100 : 0) : ((currentOrders - prevOrders) * 100.0 / prevOrders);
    double trR = prevRevenue == 0 ? (currentRevenue > 0 ? 100 : 0) : ((currentRevenue - prevRevenue) * 100.0 / prevRevenue);
    double trC = prevCustomers == 0 ? (currentCustomers > 0 ? 100 : 0) : ((currentCustomers - prevCustomers) * 100.0 / prevCustomers);

    Map<String, Object> stats = new HashMap<>();
    stats.put("orders", currentOrders);
    stats.put("revenue", new java.text.DecimalFormat("#,###").format(currentRevenue) + " VNĐ");
    stats.put("customers", currentCustomers);
    
    Map<String, String> trends = new HashMap<>();
    trends.put("o", String.format("<span class=\"text-%s small pt-1 fw-bold\">%.1f%%</span> <span class=\"text-muted small pt-2 ps-1\">%s</span>", trO >= 0 ? "success" : "danger", Math.abs(trO), trO >= 0 ? "Tăng" : "Giảm"));
    trends.put("r", String.format("<span class=\"text-%s small pt-1 fw-bold\">%.1f%%</span> <span class=\"text-muted small pt-2 ps-1\">%s</span>", trR >= 0 ? "success" : "danger", Math.abs(trR), trR >= 0 ? "Tăng" : "Giảm"));
    trends.put("c", String.format("<span class=\"text-%s small pt-1 fw-bold\">%.1f%%</span> <span class=\"text-muted small pt-2 ps-1\">%s</span>", trC >= 0 ? "success" : "danger", Math.abs(trC), trC >= 0 ? "Tăng" : "Giảm"));
    stats.put("trends", trends);
    responseMap.put("stats", stats);

    // 2. Line Chart
    LocalDate[] range = getRange(period, startDate, endDate);
    long diffDays = ChronoUnit.DAYS.between(range[0], range[1]);
    Map<String, Integer> oMap = new LinkedHashMap<>();
    Map<String, Double> rMap = new LinkedHashMap<>();
    Map<String, Integer> cMap = new LinkedHashMap<>();
    
    if (diffDays == 0) {
        LocalDateTime currDt = range[0].atStartOfDay();
        LocalDateTime endDt = range[1].atTime(23, 59, 59);
        while (!currDt.isAfter(endDt)) {
            oMap.put(currDt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:00:00")), 0);
            rMap.put(currDt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:00:00")), 0.0);
            cMap.put(currDt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:00:00")), 0);
            currDt = currDt.plusHours(4);
        }
    } else if (diffDays > 31) {
        LocalDate curr = range[0].withDayOfMonth(1);
        while (!curr.isAfter(range[1])) {
            oMap.put(curr.toString(), 0); rMap.put(curr.toString(), 0.0); cMap.put(curr.toString(), 0);
            curr = curr.plusMonths(1);
        }
    } else if (diffDays > 7) {
        LocalDate curr = range[0].with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        while (!curr.isAfter(range[1])) {
            oMap.put(curr.toString(), 0); rMap.put(curr.toString(), 0.0); cMap.put(curr.toString(), 0);
            curr = curr.plusWeeks(1);
        }
    } else {
        LocalDate curr = range[0];
        while (!curr.isAfter(range[1])) {
            oMap.put(curr.toString(), 0); rMap.put(curr.toString(), 0.0); cMap.put(curr.toString(), 0);
            curr = curr.plusDays(1);
        }
    }

    try (Statement stmt = conn.createStatement()) {
        String dtSelect = "DATE(b.\"BookingDate\")";
        if (diffDays == 0) dtSelect = "TO_CHAR(b.\"BookingDate\", 'YYYY-MM-DD\"T\"HH24:00:00')";
        else if (diffDays > 31) dtSelect = "DATE(DATE_TRUNC('month', b.\"BookingDate\"))";
        else if (diffDays > 7) dtSelect = "DATE(DATE_TRUNC('week', b.\"BookingDate\"))";
        
        String sql = "SELECT " + dtSelect + " as dt, COUNT(b.\"BookingID\") as o, COALESCE(SUM(p.\"PaymentAmount\"), 0) as r, COUNT(DISTINCT b.\"CustomerID\") as c "
                   + "FROM \"Booking\" b LEFT JOIN \"Payment\" p ON b.\"BookingID\" = p.\"BookingID\" "
                   + c1Alias + " GROUP BY " + dtSelect;
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()) {
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
            if (oMap.containsKey(key)) {
                oMap.put(key, oMap.get(key) + rs.getInt("o"));
                rMap.put(key, rMap.get(key) + rs.getDouble("r"));
                cMap.put(key, cMap.get(key) + rs.getInt("c"));
            }
        }
    } catch(Exception e) { e.printStackTrace(); }

    List<String> cats = new ArrayList<>();
    List<Integer> ords = new ArrayList<>();
    List<Double> revs = new ArrayList<>();
    List<Integer> cuss = new ArrayList<>();
    for (String d : oMap.keySet()) {
        String dateStr = d.contains("T") ? d : d + "T00:00:00";
        cats.add(dateStr); ords.add(oMap.get(d)); revs.add(rMap.get(d)); cuss.add(cMap.get(d));
    }
    
    Map<String, Object> lineChart = new HashMap<>();
    lineChart.put("categories", cats); lineChart.put("orders", ords); lineChart.put("revenue", revs); lineChart.put("customers", cuss);

    // 3. Radar Chart (Brands)
    Map<String, Double> radar = new LinkedHashMap<>();
    try (Statement stmt = conn.createStatement()) {
        ResultSet rs = stmt.executeQuery("SELECT \"BrandName\" FROM \"Brand\" ORDER BY \"BrandName\"");
        while(rs.next()) radar.put(rs.getString("BrandName"), 0.0);
        
        String sql = "SELECT br.\"BrandName\", SUM(p.\"PaymentAmount\") as r FROM \"Payment\" p JOIN \"Booking\" b ON p.\"BookingID\"=b.\"BookingID\" "
                   + "JOIN \"Booking Detail\" bd ON b.\"BookingID\"=bd.\"BookingID\" JOIN \"Motorcycle Detail\" md ON bd.\"MotorcycleDetailID\"=md.\"MotorcycleDetailID\" "
                   + "JOIN \"Motorcycle\" m ON md.\"MotorcycleID\"=m.\"MotorcycleID\" JOIN \"Brand\" br ON m.\"BrandID\"=br.\"BrandID\" "
                   + c1Alias + " GROUP BY br.\"BrandName\"";
        rs = stmt.executeQuery(sql);
        while(rs.next()) radar.put(rs.getString("BrandName"), rs.getDouble("r"));
    } catch(Exception e) { e.printStackTrace(); }

    // 4. Pie Chart
    Map<String, Integer> pie = new LinkedHashMap<>();
    try (Statement stmt = conn.createStatement()) {
        ResultSet rsCat = stmt.executeQuery("SELECT \"CategoryName\" FROM \"Category\" ORDER BY \"CategoryName\"");
        while(rsCat.next()) pie.put(rsCat.getString("CategoryName"), 0);
        
        String sql = "SELECT c.\"CategoryName\", COUNT(md.\"MotorcycleID\") as rentCount "
                   + "FROM \"Booking Detail\" bd "
                   + "JOIN \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\" "
                   + "JOIN \"Motorcycle Detail\" md ON bd.\"MotorcycleDetailID\" = md.\"MotorcycleDetailID\" "
                   + "JOIN \"Motorcycle\" m ON md.\"MotorcycleID\" = m.\"MotorcycleID\" "
                   + "JOIN \"Category\" c ON m.\"CategoryID\" = c.\"CategoryID\" "
                   + c1Alias + " GROUP BY c.\"CategoryName\"";
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()) pie.put(rs.getString("CategoryName"), rs.getInt("rentCount"));
    } catch(Exception e) { e.printStackTrace(); }

    // 5. Top Motorcycles
    List<Map<String, Object>> topMotos = new ArrayList<>();
    try (Statement stmt = conn.createStatement()) {
        String sql = "SELECT m.\"Image\", m.\"Model\", COALESCE(p.\"DailyPriceForDay\", 0) as \"DailyPriceForDay\", COALESCE(p.\"DailyPriceForWeek\", 0) as \"DailyPriceForWeek\", COALESCE(p.\"DailyPriceForMonth\", 0) as \"DailyPriceForMonth\", COUNT(md.\"MotorcycleID\") as rentCount "
                   + "FROM \"Motorcycle\" m "
                   + "JOIN \"Motorcycle Detail\" md ON m.\"MotorcycleID\" = md.\"MotorcycleID\" "
                   + "JOIN \"Booking Detail\" bd ON md.\"MotorcycleDetailID\" = bd.\"MotorcycleDetailID\" "
                   + "JOIN \"Booking\" b ON bd.\"BookingID\" = b.\"BookingID\" "
                   + "LEFT JOIN \"PriceList\" p ON m.\"PriceListID\" = p.\"PriceListID\" "
                   + c1Alias + " GROUP BY m.\"Image\", m.\"Model\", p.\"DailyPriceForDay\", p.\"DailyPriceForWeek\", p.\"DailyPriceForMonth\" "
                   + "ORDER BY rentCount DESC";
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()) {
            Map<String, Object> t = new HashMap<>();
            t.put("image", rs.getString("Image"));
            t.put("model", rs.getString("Model"));
            t.put("dailyPriceForDay", rs.getDouble("DailyPriceForDay"));
            t.put("dailyPriceForWeek", rs.getDouble("DailyPriceForWeek"));
            t.put("dailyPriceForMonth", rs.getDouble("DailyPriceForMonth"));
            t.put("rentCount", rs.getInt("rentCount"));
            topMotos.add(t);
        }
    } catch(Exception e) { e.printStackTrace(); }

    // Close connection to return it to the pool
    conn.close();
    
    responseMap.put("topMotorcycles", topMotos);

    Map<String, Object> charts = new HashMap<>();
    charts.put("lineChart", lineChart); charts.put("radarChart", radar); charts.put("pieChart", pie);
    responseMap.put("charts", charts);

    out.print(gson.toJson(responseMap));
%>

<!-- Minor update 21 -->

<!-- Minor update 22 -->

<!-- Minor update 25 -->

<!-- fix patch 1 -->

<!-- fix patch 6 -->

<!-- fix patch 11 -->

<!-- fix patch 36 -->

<!-- fix patch 38 -->

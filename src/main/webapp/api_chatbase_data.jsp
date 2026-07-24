<%@ page import="java.sql.*, com.smartride.util.DBUtil, java.time.LocalDate" %>
<%@ page contentType="text/plain;charset=UTF-8" language="java" %>
<%
    // Set headers to allow Chatbase crawling
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
    
    out.println("TÀI LIỆU KIẾN THỨC VỀ GIÁ VÀ KHUYẾN MÃI THUÊ XE MÁY (SMARTRIDE)\n");
    out.println("Lưu ý cho AI: Hãy sử dụng CHÍNH XÁC bảng giá và các chương trình khuyến mãi dưới đây để trả lời khách hàng. Không tự bịa ra khuyến mãi đã hết hạn.\n");
    
    try (Connection conn = DBUtil.makeConnection()) {
        if (conn == null) {
            out.println("Lỗi kết nối cơ sở dữ liệu.");
            return;
        }

        // 1. Get Active Events (Promotions)
        out.println("================ CHƯƠNG TRÌNH KHUYẾN MÃI ĐANG DIỄN RA ================");
        String sqlEvent = "SELECT \"EventTitle\", \"StartDate\", \"EndDate\", \"Content\", \"Discount\" FROM \"Event\" WHERE \"EndDate\" >= CURRENT_DATE";
        boolean hasEvent = false;
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlEvent)) {
            while (rs.next()) {
                hasEvent = true;
                double discount = rs.getDouble("Discount");
                int discountPercent = (int) (discount * 100);
                out.println("- Sự kiện: " + rs.getString("EventTitle"));
                out.println("  + Nội dung: " + rs.getString("Content"));
                out.println("  + Mức giảm giá: " + discountPercent + "%");
                out.println("  + Thời gian áp dụng: Từ " + rs.getDate("StartDate") + " đến " + rs.getDate("EndDate"));
                out.println();
            }
        }
        if (!hasEvent) {
            out.println("Hiện tại hệ thống KHÔNG CÓ chương trình khuyến mãi nào đang diễn ra. Hãy báo với khách là tạm thời chưa có khuyến mãi mới.\n");
        }

        // 2. Get Motorbikes and their Prices
        out.println("================ BẢNG GIÁ THUÊ XE HÔM NAY ================");
        out.println("Lưu ý cho AI: Nếu có sự kiện khuyến mãi đang diễn ra ở trên, hãy tự động tính toán (Trừ đi % giảm giá) rồi báo giá cuối cùng cho khách.\n");
        
        String sqlMoto = "SELECT m.\"Model\", p.\"DailyPriceForDay\", p.\"DailyPriceForWeek\", p.\"DailyPriceForMonth\", c.\"CategoryName\" " +
                         "FROM \"Motorcycle\" m " +
                         "JOIN \"PriceList\" p ON m.\"PriceListID\" = p.\"PriceListID\" " +
                         "JOIN \"Category\" c ON m.\"CategoryID\" = c.\"CategoryID\" " +
                         "ORDER BY c.\"CategoryName\", m.\"Model\"";
        
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlMoto)) {
            String currentCat = "";
            while (rs.next()) {
                String cat = rs.getString("CategoryName");
                if (!cat.equals(currentCat)) {
                    out.println("\n--- Nhóm: " + cat + " ---");
                    currentCat = cat;
                }
                double priceDay = rs.getDouble("DailyPriceForDay");
                double priceWeek = rs.getDouble("DailyPriceForWeek");
                double priceMonth = rs.getDouble("DailyPriceForMonth");
                
                out.println(String.format("Xe: %s | Giá 1 ngày: %,.0f VNĐ | Giá tuần: %,.0f VNĐ/ngày | Giá tháng: %,.0f VNĐ/ngày", 
                            rs.getString("Model"), priceDay, priceWeek, priceMonth));
            }
        }

    } catch (Exception e) {
        out.println("Lỗi khi tải dữ liệu: " + e.getMessage());
    }
%>

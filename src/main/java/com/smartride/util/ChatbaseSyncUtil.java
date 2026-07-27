package com.smartride.util;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class ChatbaseSyncUtil {

    // Thay thế bằng API Key thật và Chatbot ID của bạn lấy từ Chatbase.co
    private static final String CHATBASE_API_KEY = "YOUR_CHATBASE_SECRET_KEY";
    private static final String CHATBOT_ID = "qUNf-UR7ycIWmYS6ZiWCL";

    /**
     * Hàm này được gọi mỗi khi Thêm/Sửa/Xóa Khuyến Mãi hoặc Xe
     * Nó sẽ thu thập lại dữ liệu mới nhất từ DB và gửi lên Chatbase.
     */
    public static void syncDataToChatbaseAsync() {
        new Thread(() -> {
            try {
                String latestData = generateTrainingDataFromDB();
                pushToChatbaseAPI(latestData);
            } catch (Exception e) {
                System.out.println("Lỗi khi đồng bộ lên Chatbase: " + e.getMessage());
            }
        }).start();
    }

    private static String generateTrainingDataFromDB() {
        StringBuilder sb = new StringBuilder();
        sb.append("TÀI LIỆU KIẾN THỨC VỀ GIÁ VÀ KHUYẾN MÃI THUÊ XE MÁY (SMARTRIDE)\n");
        sb.append("Lưu ý cho AI: Hãy sử dụng CHÍNH XÁC bảng giá và các chương trình khuyến mãi dưới đây để trả lời khách hàng.\n");

        try (Connection conn = DBUtil.makeConnection()) {
            if (conn != null) {
                sb.append("================ CHƯƠNG TRÌNH KHUYẾN MÃI ĐANG DIỄN RA ================\n");
                String sqlEvent = "SELECT \"EventTitle\", \"StartDate\", \"EndDate\", \"Content\", \"Discount\" FROM \"Event\" WHERE \"EndDate\" >= CURRENT_DATE";
                boolean hasEvent = false;
                try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlEvent)) {
                    while (rs.next()) {
                        hasEvent = true;
                        int discountPercent = (int) (rs.getDouble("Discount") * 100);
                        sb.append("- Sự kiện: ").append(rs.getString("EventTitle")).append("\n");
                        sb.append("  + Nội dung: ").append(rs.getString("Content")).append("\n");
                        sb.append("  + Mức giảm: ").append(discountPercent).append("%\n");
                        sb.append("  + Thời hạn: Từ ").append(rs.getDate("StartDate")).append(" đến ").append(rs.getDate("EndDate")).append("\n\n");
                    }
                }
                if (!hasEvent) {
                    sb.append("Hiện tại hệ thống KHÔNG CÓ chương trình khuyến mãi nào đang diễn ra.\n\n");
                }

                sb.append("================ BẢNG GIÁ THUÊ XE HÔM NAY ================\n");
                String sqlMoto = "SELECT m.\"Model\", p.\"DailyPriceForDay\" FROM \"Motorcycle\" m JOIN \"PriceList\" p ON m.\"PriceListID\" = p.\"PriceListID\"";
                try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlMoto)) {
                    while (rs.next()) {
                        sb.append(String.format("Xe: %s | Giá 1 ngày: %,.0f VNĐ\n", rs.getString("Model"), rs.getDouble("DailyPriceForDay")));
                    }
                }
            }
        } catch (Exception e) {
            sb.append("Lỗi đọc Database: ").append(e.getMessage());
        }
        return sb.toString();
    }

    private static void pushToChatbaseAPI(String textData) throws Exception {
        if ("YOUR_CHATBASE_SECRET_KEY".equals(CHATBASE_API_KEY)) {
            System.out.println("Vui lòng cập nhật CHATBASE_API_KEY trong ChatbaseSyncUtil.java để sử dụng tính năng đồng bộ API.");
            return;
        }

        URL url = new URL("https://www.chatbase.co/api/v1/chatbot/update");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + CHATBASE_API_KEY);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        // Escape text for JSON
        String escapedText = textData.replace("\"", "\\\"").replace("\n", "\\n");
        String jsonInputString = "{\"chatbotId\": \"" + CHATBOT_ID + "\", \"instructions\": \"" + escapedText + "\"}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int responseCode = conn.getResponseCode();
        System.out.println("Đồng bộ Chatbase hoàn tất. Mã HTTP: " + responseCode);
    }
}

// Minor update 23

// Minor update 24

// fix patch 15

// fix patch 31

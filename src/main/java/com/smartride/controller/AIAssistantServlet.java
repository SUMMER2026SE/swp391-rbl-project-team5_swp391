package com.smartride.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AIAssistantServlet", urlPatterns = {"/aiAssistant"})
public class AIAssistantServlet extends HttpServlet {

    // Lấy API Key từ biến môi trường (Environment Variable)
    private static final String GEMINI_API_KEY = System.getenv("GEMINI_API_KEY");
    private static final String GEMINI_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String text = request.getParameter("text");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        if (text == null || text.trim().isEmpty()) {
            out.print("{\"message\": \"Vui lòng nhập lịch trình của bạn!\", \"categoryId\": null}");
            out.flush();
            return;
        }

        if (GEMINI_API_KEY == null || GEMINI_API_KEY.trim().isEmpty()) {
            out.print("{\"message\": \"[LỖI]: Hệ thống chưa được cấu hình biến môi trường GEMINI_API_KEY trên máy chủ. Vui lòng thiết lập để AI hoạt động!\", \"categoryId\": null}");
            out.flush();
            return;
        }

        try {
            String prompt = "Bạn là chuyên gia tư vấn thuê xe máy tại Đà Nẵng của hệ thống SmartRide. "
                    + "Khách hàng nói: '" + text + "'. "
                    + "Hãy đọc hiểu địa hình và đưa ra lời khuyên ngắn gọn, thân thiện (dưới 4 câu) xem họ nên chọn "
                    + "Xe Số (ID: 1), Xe Ga (ID: 2) hay Xe Côn (ID: 3). "
                    + "Ở cuối câu trả lời của bạn, PHẢI bắt buộc đính kèm chuỗi [ID:x] với x là số 1, 2 hoặc 3 tương ứng.";

            JsonObject content = new JsonObject();
            JsonObject parts = new JsonObject();
            parts.addProperty("text", prompt);
            
            com.google.gson.JsonArray partsArray = new com.google.gson.JsonArray();
            partsArray.add(parts);
            
            JsonObject roleContent = new JsonObject();
            roleContent.add("parts", partsArray);
            
            com.google.gson.JsonArray contentsArray = new com.google.gson.JsonArray();
            contentsArray.add(roleContent);
            
            content.add("contents", contentsArray);

            HttpClient client = HttpClient.newHttpClient();
            HttpRequest httpRequest = HttpRequest.newBuilder()
                    .uri(URI.create(GEMINI_URL + GEMINI_API_KEY))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(gson.toJson(content)))
                    .build();

            HttpResponse<String> httpResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());

            if (httpResponse.statusCode() == 200) {
                JsonObject jsonResponse = JsonParser.parseString(httpResponse.body()).getAsJsonObject();
                String aiText = jsonResponse.getAsJsonArray("candidates")
                        .get(0).getAsJsonObject()
                        .getAsJsonObject("content")
                        .getAsJsonArray("parts")
                        .get(0).getAsJsonObject()
                        .get("text").getAsString();
                
                String categoryId = null;
                if (aiText.contains("[ID:1]")) categoryId = "1";
                else if (aiText.contains("[ID:2]")) categoryId = "2";
                else if (aiText.contains("[ID:3]")) categoryId = "3";
                
                String cleanMessage = aiText.replaceAll("\\[ID:[123]\\]", "").trim();
                cleanMessage = cleanMessage.replaceAll("\\*\\*(.*?)\\*\\*", "<b>$1</b>").replaceAll("\n", "<br>");
                
                JsonObject result = new JsonObject();
                result.addProperty("message", cleanMessage);
                if (categoryId != null) {
                    result.addProperty("categoryId", categoryId);
                }
                out.print(gson.toJson(result));
                
            } else {
                System.err.println("Gemini API Error: " + httpResponse.statusCode() + " - " + httpResponse.body());
                String errorMsg = httpResponse.body().replaceAll("\"", "'").replaceAll("\n", " ").replaceAll("\r", " ");
                out.print("{\"message\": \"[LỖI API " + httpResponse.statusCode() + "]: " + errorMsg + "\", \"categoryId\": null}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"message\": \"Đã xảy ra lỗi trong quá trình phân tích. Vui lòng thử lại!\", \"categoryId\": null}");
        }
        
        out.flush();
    }
}

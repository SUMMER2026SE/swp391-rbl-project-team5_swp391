package com.smartride.controller;

import com.google.gson.Gson;
import com.smartride.dao.BookingDAO;
import com.smartride.util.SupabaseStorageUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HandoverAPI", urlPatterns = {"/api/handover-upload"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100) // 100MB
public class HandoverAPI extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> json = new HashMap<>();

        try {
            String bookingId = request.getParameter("bookingId");
            if (bookingId == null || bookingId.isEmpty()) {
                json.put("status", "error");
                json.put("message", "Missing bookingId");
                out.print(new Gson().toJson(json));
                return;
            }

            List<String> savedImages = new ArrayList<>();

            for (Part part : request.getParts()) {
                if (part.getName().startsWith("photo") && part.getSize() > 0) {
                    String fileName = getFileName(part);
                    String uniqueFileName = bookingId + "_" + System.currentTimeMillis() + "_" + fileName;
                    
                    // Upload to Supabase Storage
                    String publicUrl = SupabaseStorageUtil.uploadFile("handoverImg", uniqueFileName, part.getInputStream(), part.getContentType());
                    if (publicUrl != null) {
                        savedImages.add(publicUrl);
                    }
                }
            }

            if (savedImages.isEmpty()) {
                json.put("status", "error");
                json.put("message", "Vui lòng chụp ít nhất 1 bức ảnh tình trạng xe.");
                out.print(new Gson().toJson(json));
                return;
            }

            String jsonImages = new Gson().toJson(savedImages);
            
            // Save image URLs to DB and update status
            BookingDAO.getInstance().updateDeliveryStatusWithImage("Đã giao", bookingId, jsonImages);

            json.put("status", "success");
            json.put("message", "Handover completed successfully");

        } catch (Exception ex) {
            json.put("status", "error");
            json.put("message", "Error uploading files: " + ex.getMessage());
        }

        out.print(new Gson().toJson(json));
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "unknown.jpg";
    }
}

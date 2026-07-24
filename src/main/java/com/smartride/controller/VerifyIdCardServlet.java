package com.smartride.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import com.smartride.util.IdCardVerifier;

/**
 * Servlet gọi FPT.AI Vision API để OCR ảnh CCCD/CMND và so sánh với DB.
 * POST /verifyIdCard?imagePath=xxx&storedId=xxx&storedName=xxx
 */
@WebServlet(name = "VerifyIdCardServlet", urlPatterns = {"/verifyIdCard"})
public class VerifyIdCardServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Check session
        if (request.getSession(false) == null || request.getSession(false).getAttribute("account") == null) {
            out.write("{\"success\":false,\"message\":\"Chưa đăng nhập\"}");
            return;
        }

        String imagePath = request.getParameter("imagePath");
        String storedId  = request.getParameter("storedId");
        String storedName = request.getParameter("storedName");
        String webRoot = getServletContext().getRealPath("/");

        IdCardVerifier.VerifyResult vr = IdCardVerifier.verify(imagePath, webRoot, storedId, storedName);

        if (!vr.configured) {
            out.write("{\"success\":false,\"needKey\":true,\"message\":\"" + escapeJson(vr.errorMsg) + "\"}");
            return;
        }

        if (!vr.success) {
            out.write("{\"success\":false,\"message\":\"" + escapeJson(vr.errorMsg) + "\"}");
            return;
        }

        String status;
        String statusColor;
        String statusIcon;
        if (vr.idMatch && vr.nameMatch && vr.doeValid) {
            status = "HỢP LỆ - Thông tin khớp với ảnh CCCD";
            statusColor = "#059669";
            statusIcon = "fa-check-circle";
        } else if (!vr.doeValid) {
            status = "CCCD HẾT HẠN - Giấy tờ không còn hiệu lực";
            statusColor = "#dc2626";
            statusIcon = "fa-calendar-times";
        } else if (vr.idMatch || vr.nameMatch) {
            status = "CẦN KIỂM TRA - Một số thông tin không khớp hoàn toàn";
            statusColor = "#d97706";
            statusIcon = "fa-exclamation-circle";
        } else {
            status = "KHÔNG KHẬP - Số CCCD hoặc họ tên không trùng";
            statusColor = "#dc2626";
            statusIcon = "fa-times-circle";
        }

        // Build fieldErrors JSON array
        StringBuilder feArr = new StringBuilder("[");
        for (int i = 0; i < vr.fieldErrors.size(); i++) {
            feArr.append("\"").append(escapeJson(vr.fieldErrors.get(i))).append("\"");
            if (i < vr.fieldErrors.size() - 1) feArr.append(",");
        }
        feArr.append("]");

        String result = "{"
            + "\"success\":true,"
            + "\"ocrId\":\"" + escapeJson(vr.ocrId) + "\","
            + "\"ocrName\":\"" + escapeJson(vr.ocrName) + "\","
            + "\"ocrDob\":\"" + escapeJson(vr.ocrDob) + "\","
            + "\"ocrDoe\":\"" + escapeJson(vr.ocrDoe) + "\","
            + "\"ocrSex\":\"" + escapeJson(vr.ocrSex) + "\","
            + "\"type\":\"" + escapeJson(vr.type) + "\","
            + "\"idMatch\":" + vr.idMatch + ","
            + "\"nameMatch\":" + vr.nameMatch + ","
            + "\"doeValid\":" + vr.doeValid + ","
            + "\"fieldErrors\":" + feArr + ","
            + "\"status\":\"" + escapeJson(status) + "\","
            + "\"statusColor\":\"" + statusColor + "\","
            + "\"statusIcon\":\"" + statusIcon + "\""
            + "}";


        out.write(result);
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }
}

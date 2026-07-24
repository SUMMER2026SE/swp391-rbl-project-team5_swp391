package com.smartride.controller;

import com.smartride.dao.EventDAO;
import com.smartride.dao.NotificationDAO;
import com.smartride.dao.VoucherDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Event;
import com.smartride.dto.Voucher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "PublishNotificationServlet", urlPatterns = {"/api/publish-notification"})
public class PublishNotificationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            out.print("{\"status\":\"error\", \"message\":\"Unauthorized\"}");
            out.flush();
            return;
        }
        
        Account account = (Account) session.getAttribute("account");
        if (account.getRoleID() == 1) { // Customer không được phép
            out.print("{\"status\":\"error\", \"message\":\"Forbidden\"}");
            out.flush();
            return;
        }

        String type = request.getParameter("type");
        String idParam = request.getParameter("id");
        
        try {
            int id = Integer.parseInt(idParam);
            NotificationDAO notifDAO = NotificationDAO.getInstance();
            boolean success = false;
            
            if ("voucher".equals(type)) {
                Voucher voucher = VoucherDAO.getInstance().getVoucherById(id);
                if (voucher != null) {
                    String title = "🎁 Tặng bạn Voucher Giảm Giá!";
                    String message = "Khuyến mãi hấp dẫn! Nhập mã " + voucher.getCode() + " để được giảm " + String.format("%,.0f", voucher.getDiscountAmount()) + "VNĐ. Đặt xe ngay để sử dụng!";
                    String link = "motorcycles"; // Dẫn đến trang đặt xe
                    success = notifDAO.insertBroadcastNotification(title, message, link);
                }
            } else if ("event".equals(type)) {
                Event event = EventDAO.getInstance().getEventbyID(id);
                if (event != null) {
                    String title = "🎉 Sự Kiện Mới: " + event.getEventTitle();
                    String message = "Sự kiện diễn ra từ " + event.getStartDate() + " đến " + event.getEndDate() + ". Giảm ngay " + String.format("%,.0f", event.getDiscount()) + "VNĐ. Xem ngay!";
                    String link = "motorcycles";
                    success = notifDAO.insertBroadcastNotification(title, message, link);
                }
            }

            if (success) {
                out.print("{\"status\":\"success\"}");
            } else {
                out.print("{\"status\":\"error\", \"message\":\"Failed to publish or item not found\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
        out.flush();
    }
}

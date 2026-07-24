package com.smartride.controller;

import com.google.gson.Gson;
import com.smartride.dao.NotificationDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Notification;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "NotificationServlet", urlPatterns = {"/notification"})
public class NotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            out.print("{\"status\":\"unauthorized\"}");
            out.flush();
            return;
        }

        Account account = (Account) session.getAttribute("account");
        NotificationDAO dao = NotificationDAO.getInstance();
        
        String action = request.getParameter("action");
        
        if ("get".equals(action)) {
            List<Notification> notifs = dao.getNotificationsForAccount(account.getAccountId(), account.getRoleID());
            long unreadCount = notifs.stream().filter(n -> !n.isRead()).count();
            
            Gson gson = new Gson();
            String jsonList = gson.toJson(notifs);
            out.print("{\"status\":\"success\", \"unreadCount\":" + unreadCount + ", \"data\":" + jsonList + "}");
        } else {
            out.print("{\"status\":\"error\"}");
        }
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            out.print("{\"status\":\"unauthorized\"}");
            out.flush();
            return;
        }

        Account account = (Account) session.getAttribute("account");
        String action = request.getParameter("action");
        NotificationDAO dao = NotificationDAO.getInstance();

        if ("markRead".equals(action)) {
            String notifIdStr = request.getParameter("id");
            if (notifIdStr != null) {
                dao.markAsRead(Integer.parseInt(notifIdStr));
            }
            out.print("{\"status\":\"success\"}");
        } else if ("markAllRead".equals(action)) {
            dao.markAllAsRead(account.getAccountId());
            out.print("{\"status\":\"success\"}");
        } else if ("triggerLateVoucher".equals(action)) {
            String bookingId = request.getParameter("bookingId");
            String title = "Đền bù mã giảm giá do sự cố giao xe trễ hẹn - " + bookingId;
            boolean exist = dao.checkNotificationExists(account.getAccountId(), title);
            if (!exist) {
                String message = "Rất xin lỗi vì sự cố giao xe trễ hẹn quá 45 phút! Hệ thống gửi tặng bạn mã giảm giá 50,000đ: LATE50K. Mong bạn thông cảm.";
                dao.insertNotification(account.getAccountId(), title, message, "bookingHistoryDetail?bookingId=" + bookingId);
            }
            out.print("{\"status\":\"success\"}");
        }
        out.flush();
    }
}

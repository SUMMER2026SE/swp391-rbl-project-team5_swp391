package com.smartride.controller;

import com.google.gson.Gson;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.NotificationDAO;
import com.smartride.dao.SOSRequestDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "SOSServlet", urlPatterns = {"/api/sos"})
public class SOSServlet extends HttpServlet {

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

        try {
            String bookingId = request.getParameter("bookingId");
            double lat = Double.parseDouble(request.getParameter("lat"));
            double lng = Double.parseDouble(request.getParameter("lng"));
            String note = request.getParameter("note");

            Booking booking = BookingDAO.getInstance().getBookingById(bookingId);
            if (booking == null || booking.getCustomerID() != account.getAccountId()) {
                out.print("{\"status\":\"error\", \"message\":\"Forbidden\"}");
                out.flush();
                return;
            }

            boolean saved = SOSRequestDAO.getInstance().createSOSRequest(bookingId, lat, lng, note);
            if (saved) {
                // Send notification to Staff
                String title = "[🚨 SOS KHẨN CẤP] Xe gặp sự cố!";
                String message = "Khách hàng " + account.getFirstName() + " báo hỏng xe. Ghi chú: " + note;
                String origin = "16.073860,108.149867"; // SmartRide Shop Coordinates
                String link = "https://www.google.com/maps/dir/?api=1&origin=" + origin + "&destination=" + lat + "," + lng;
                NotificationDAO.getInstance().insertStaffNotification(title, message, link);
                
                out.print("{\"status\":\"success\"}");
            } else {
                out.print("{\"status\":\"error\", \"message\":\"DB Error\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"Invalid data\"}");
        }
        out.flush();
    }
}

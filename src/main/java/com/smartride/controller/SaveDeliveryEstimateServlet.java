package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.NotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/save-delivery-estimate")
public class SaveDeliveryEstimateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String bookingId = request.getParameter("bookingId");
            int minutes = Integer.parseInt(request.getParameter("minutes"));
            
            if (bookingId == null || bookingId.isEmpty()) {
                out.print("{\"status\":\"error\",\"message\":\"Missing bookingId\"}");
                return;
            }
            
            // Save to DB
            BookingDAO.getInstance().saveDeliveryEstimate(bookingId, minutes);
            
            // Send notification to customer
            com.smartride.dto.Booking booking = BookingDAO.getInstance().getBookingById(bookingId);
            if (booking != null) {
                // Get accountID from customerID
                com.smartride.dto.Customer cus = com.smartride.dao.CustomerDAO.getInstance().getCustomerbyID(booking.getCustomerID());
                if (cus != null) {
                    String title = "🏍 Xe đang trên đường đến!";
                    String message = "Đơn #" + bookingId + " đang được giao. Dự kiến đến sau ~" + minutes + " phút. Nhấn để xem chi tiết.";
                    String link = "bookingHistoryDetail?bookingId=" + bookingId;
                    NotificationDAO.getInstance().insertNotification(cus.getAccountId(), title, message, link);
                }
            }
            
            out.print("{\"status\":\"success\"}");
        } catch (Exception e) {
            out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}

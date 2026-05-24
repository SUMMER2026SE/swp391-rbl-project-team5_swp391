package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dto.Booking;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CheckPaymentStatusServlet", urlPatterns = {"/check-payment-status"})
public class CheckPaymentStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        if (bookingId == null || bookingId.isEmpty()) {
            out.print("{\"status\":\"error\"}");
            out.flush();
            return;
        }

        // Kiểm tra trong in-memory map trước (để xử lý webhook ngay lập tức)
        if (SepayWebhookServlet.paidOrders != null && SepayWebhookServlet.paidOrders.containsKey(bookingId)) {
            out.print("{\"status\":\"paid\"}");
        } else {
            // Dự phòng: Kiểm tra trong database
            BookingDAO dao = BookingDAO.getInstance();
            Booking booking = dao.getBookingById(bookingId);
            
            if (booking != null && "Đã thanh toán".equals(booking.getStatusBooking())) {
                out.print("{\"status\":\"paid\"}");
            } else {
                out.print("{\"status\":\"pending\"}");
            }
        }
        out.flush();
    }
}

// Minor update 11

// Minor update 29

// fix patch 41

// fix patch 42

// fix patch 52

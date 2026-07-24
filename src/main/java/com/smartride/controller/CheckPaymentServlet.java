package com.smartride.controller;

import com.google.gson.Gson;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.PaymentDAO;
import com.smartride.dto.Booking;
import com.smartride.dto.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CheckPaymentServlet", urlPatterns = {"/api/check-payment"})
public class CheckPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> json = new HashMap<>();

        String bookingId = request.getParameter("bookingId");
        if (bookingId == null || bookingId.isEmpty()) {
            json.put("status", "error");
            json.put("message", "Missing bookingId");
            out.print(new Gson().toJson(json));
            return;
        }

        try {
            // Check real-time map from SePay webhook
            Boolean isPaidRealtime = SepayWebhookServlet.paidOrders.get(bookingId);
            if (isPaidRealtime != null && isPaidRealtime) {
                json.put("status", "success");
                json.put("paid", true);
                // Remove it once consumed if needed, or leave it. We'll remove it to free memory.
                SepayWebhookServlet.paidOrders.remove(bookingId);
                out.print(new Gson().toJson(json));
                return;
            }
            
            // Fallback: check database (if manual payment or old payment)
            Booking booking = BookingDAO.getInstance().getBookingById(bookingId);
            if (booking != null) {
                // If we have a Payment object associated with this booking that is fully paid
                Payment pay = PaymentDAO.getInstance().getPayMentbyBookingId(bookingId);
                
                // Assuming paymentAmount > 0 and status is not 'Chờ'
                if (pay != null && pay.getPaymentStatus() != null && !pay.getPaymentStatus().contains("Chờ")) {
                    json.put("status", "success");
                    json.put("paid", true);
                    out.print(new Gson().toJson(json));
                    return;
                }
            }

            json.put("status", "success");
            json.put("paid", false);

        } catch (Exception e) {
            json.put("status", "error");
            json.put("message", e.getMessage());
        }

        out.print(new Gson().toJson(json));
    }
}

package com.smartride.controller;

import com.smartride.dao.PaymentDAO;
import com.smartride.dto.Payment;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CheckPaymentDebugServlet", urlPatterns = {"/check-payment-debug"})
public class CheckPaymentDebugServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();
        result.put("bookingId", bookingId);

        if (bookingId == null || bookingId.trim().isEmpty()) {
            result.put("error", "Missing bookingId parameter");
            response.getWriter().write(new Gson().toJson(result));
            return;
        }

        List<Payment> paymentList = PaymentDAO.getInstance().getListByBookingId(bookingId);
        result.put("paymentCount", paymentList.size());

        List<Map<String, Object>> payments = new ArrayList<>();
        double totalSuccess = 0;
        for (Payment p : paymentList) {
            Map<String, Object> pm = new HashMap<>();
            pm.put("paymentId", p.getPaymentId());
            pm.put("bookingId", p.getBookingId());
            pm.put("paymentMethod", p.getPaymentMethod());
            pm.put("paymentDate", p.getPaymentDate());
            pm.put("paymentAmount", p.getPaymentAmount());
            pm.put("paymentStatus", p.getPaymentStatus());
            payments.add(pm);
            if ("Thành công".equals(p.getPaymentStatus())) {
                totalSuccess += p.getPaymentAmount();
            }
        }
        result.put("payments", payments);
        result.put("totalSuccessAmount", totalSuccess);
        result.put("diagnosis", paymentList.isEmpty()
            ? "No payment found in DB - insert likely failed. Check Render logs for [PaymentDAO] addPayment error"
            : "Payment found in DB. The JSP should display it correctly.");

        response.getWriter().write(new Gson().toJson(result));
    }
}

package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.FeedbackDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.Feedback;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BookingHistoryServlet", urlPatterns = {"/bookingHistory"})
public class BookingHistoryServlet extends HttpServlet {

    BookingDAO bookingDAO = BookingDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Account acc = (Account) session.getAttribute("account");
        String statusBooking = request.getParameter("status");
        if (statusBooking == null) {
            statusBooking = "all";
        }
        String deliveryStatus = null;
        if ("confirmed".equals(statusBooking)) {
            deliveryStatus = request.getParameter("deliveryStatus");
        }
        if (deliveryStatus == null) {
            deliveryStatus = "all";
        }
        bookingDAO.markOverdueBookings();
        List<Booking> listB = bookingDAO.getBookingWithDetails(statusBooking, deliveryStatus, acc.getAccountId());
        Map<String, Feedback> feedbackMap = new HashMap<>();
        Map<String, com.smartride.dto.Payment> paymentMap = new HashMap<>();
        for (Booking booking : listB) {
            String bookingId = booking.getBookingID();
            Feedback fb = FeedbackDAO.getInstance().getFeedbackByBookingId(bookingId);
            feedbackMap.put(bookingId, fb);
            com.smartride.dto.Payment payment = com.smartride.dao.PaymentDAO.getInstance().getPayMentbyBookingId(bookingId);
            paymentMap.put(bookingId, payment);
        }
        request.setAttribute("deliveryStatus", deliveryStatus);
        request.setAttribute("listB", listB);
        request.setAttribute("status", statusBooking);
        request.setAttribute("feedbackMap", feedbackMap);
        request.setAttribute("paymentMap", paymentMap);
//        PrintWriter out = response.getWriter();
//        out.print("Feedback: " + fb);

        request.getRequestDispatcher("bookingHistory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}

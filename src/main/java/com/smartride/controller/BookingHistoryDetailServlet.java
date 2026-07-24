package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.ExtensionDAO;
import com.smartride.dao.PaymentDAO;
import com.smartride.dto.Booking;
import com.smartride.dto.Extension;
import com.smartride.dto.Payment;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;

@WebServlet(name = "BookingHistoryDetailServlet", urlPatterns = {"/bookingHistoryDetail"})
public class BookingHistoryDetailServlet extends HttpServlet {

    BookingDAO bookingDAO = BookingDAO.getInstance();
    ExtensionDAO extensionDAO = ExtensionDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        Booking booking = bookingDAO.getBookingById(bookingId);
        Map<String, Integer> motorcycleDetails = bookingDAO.getMotorcycleDetailsByBookingID(bookingId);
        java.util.List<Map<String, Object>> motorcycleList = bookingDAO.getMotorcycleListForBooking(bookingId);
        java.util.List<String> motorcyclePlates = bookingDAO.getMotorcyclePlatesByBookingID(bookingId);
        Extension extension = extensionDAO.getExtensionByBookingID(bookingId);
        Payment payment = PaymentDAO.getInstance().getPayMentbyBookingId(bookingId);
        request.setAttribute("payment", payment);
        request.setAttribute("extension", extension);
        request.setAttribute("booking", booking);
        request.setAttribute("motorcycleDetails", motorcycleDetails);
        request.setAttribute("motorcycleList", motorcycleList);
        request.setAttribute("motorcyclePlates", motorcyclePlates);
        request.setAttribute("statusBooking", booking.getStatusBooking());
        com.smartride.dto.Cancellation cancellation = com.smartride.dao.CancellationDAO.getInstance().getCancellationByBookingId(bookingId);
        request.setAttribute("cancellation", cancellation);

        request.getRequestDispatcher("bookingHistoryDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String paymentDateText = request.getParameter("paymentTime");
        String amountStr = request.getParameter("amount");
        
        try {
            long amount = Long.parseLong(amountStr);
            // Convert paymentDate yyyyMMddHHmmss to yyyy-MM-dd HH:mm:ss
            java.time.format.DateTimeFormatter inputFormatter = java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
            java.time.LocalDateTime dateTime = java.time.LocalDateTime.parse(paymentDateText, inputFormatter);
            java.time.format.DateTimeFormatter outputFormatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedPaymentDate = dateTime.format(outputFormatter);
            
            PaymentDAO.getInstance().addPayment(bookingId, "Ngân hàng", formattedPaymentDate, (int)amount, "Thành công");
            
            // Check if fully paid and update status
            com.smartride.dto.Payment totalPayment = PaymentDAO.getInstance().getPayMentbyBookingId(bookingId);
            Booking booking = BookingDAO.getInstance().getBookingById(bookingId);
            if (totalPayment != null && booking != null) {
                double totalPaid = totalPayment.getPaymentAmount();
                double bookingTotal = 0;
                for (com.smartride.dto.BookingDetail detail : booking.getListBookingDetails()) {
                    bookingTotal += detail.getTotalPrice();
                }
                bookingTotal += booking.getDeliveryFee();
                com.smartride.dto.Extension ext = com.smartride.dao.ExtensionDAO.getInstance().getExtensionByBookingID(bookingId);
                if (ext != null) bookingTotal += ext.getExtensionFee();
                
                if (totalPaid >= bookingTotal && "Đã xác nhận".equals(booking.getStatusBooking())) {
                    BookingDAO.getInstance().updateBookingStatus(bookingId, "Đã thanh toán");
                }
            }
            
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"status\":\"success\"}");
        } catch (NumberFormatException | java.time.format.DateTimeParseException | java.io.IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}

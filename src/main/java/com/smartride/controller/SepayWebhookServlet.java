package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.BookingDetailDAO;
import com.smartride.dao.MotorcycleStatusDAO;
import com.smartride.dao.PaymentDAO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SepayWebhookServlet", urlPatterns = {"/sepay-webhook"})
public class SepayWebhookServlet extends HttpServlet {

    public static java.util.Map<String, Boolean> paidOrders = new java.util.concurrent.ConcurrentHashMap<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        String bookingId = request.getParameter("bookingId");
        String amountStr = request.getParameter("amount");
        
        if (bookingId == null && amountStr == null) {
            StringBuilder buffer = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            String payload = buffer.toString();
            
            Matcher mContent = Pattern.compile("\"content\"\\s*:\\s*\"([^\"]+)\"").matcher(payload);
            if (mContent.find()) {
                String fullContent = mContent.group(1);
                Matcher mDH = Pattern.compile("BK\\d+").matcher(fullContent);
                if (mDH.find()) {
                    bookingId = mDH.group(0);
                }
            }
            
            Matcher mAmount = Pattern.compile("\"transferAmount\"\\s*:\\s*(\\d+)").matcher(payload);
            if (mAmount.find()) {
                amountStr = mAmount.group(1);
            }
        }
        
        if (bookingId == null || bookingId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int amount = (amountStr != null) ? Integer.parseInt(amountStr) : 0;
            
            // Lưu vào map tĩnh để frontend polling có thể lấy ngay lập tức!
            paidOrders.put(bookingId, true);
            
            BookingDAO daoB = BookingDAO.getInstance();
            com.smartride.dto.Booking existingBooking = daoB.getBookingById(bookingId);
            
            if (existingBooking != null) {
                // Tự động chuyển trạng thái thành Chờ xác nhận để nhân viên vào duyệt thay vì Chờ thanh toán
                daoB.updateBookingStatus(bookingId, "Chờ xác nhận");

                PaymentDAO daoP = PaymentDAO.getInstance();
                LocalDateTime currentDateTime = LocalDateTime.now();
                DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String paymentDateText = currentDateTime.format(outputFormatter);
                daoP.addPayment(bookingId, "SePay VietQR", paymentDateText, amount, "Giao dịch thành công");
                
                MotorcycleStatusDAO daoMS = MotorcycleStatusDAO.getInstance();
                BookingDetailDAO daoBD = BookingDetailDAO.getInstance();
                List<com.smartride.dto.BookingDetail> listBD = daoBD.getListBookingDetails(bookingId);
                for(com.smartride.dto.BookingDetail bd : listBD) {
                    int mcId = bd.getMotorcycleDetailID();
                    if(mcId > 0) {
                        daoMS.insertMotorcycleStatus(mcId, "STAFF00001", "Đã thanh toán cọc", paymentDateText, "Xác nhận tự động qua SePay");
                    }
                }
            }
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\":true}");
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

// Minor update 10

// Minor update 14

// Minor update 34

// fix patch 3

// fix patch 8

// fix patch 48

// fix patch 50

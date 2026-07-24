package com.smartride.controller;

import com.google.gson.Gson;
import com.smartride.dao.AccountDAO;
import com.smartride.dao.ChatMessageDAO;
import com.smartride.dao.NotificationDAO;
import com.smartride.dao.BookingDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.ChatMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ChatApiServlet", urlPatterns = {"/api/chat"})
public class ChatApiServlet extends HttpServlet {

    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String bookingId = request.getParameter("bookingId");
        
        try (PrintWriter out = response.getWriter()) {
            if (bookingId == null || bookingId.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print(gson.toJson(Map.of("error", "Missing bookingId")));
                return;
            }
            
            List<ChatMessage> messages = ChatMessageDAO.getInstance().getMessagesByBookingId(bookingId);
            out.print(gson.toJson(messages));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        if (account == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().print(gson.toJson(Map.of("error", "Unauthorized")));
            return;
        }

        try {
            // Read JSON from request body
            BufferedReader reader = request.getReader();
            ChatMessage inputMsg = gson.fromJson(reader, ChatMessage.class);
            
            if (inputMsg == null || inputMsg.getBookingId() == null || inputMsg.getMessage() == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print(gson.toJson(Map.of("error", "Invalid data")));
                return;
            }
            
            String senderRole = (account.getRoleID() == 1) ? "CUSTOMER" : "STAFF";
            
            // Insert into DB
            ChatMessageDAO.getInstance().insertMessage(
                inputMsg.getBookingId(), 
                account.getAccountId(), 
                senderRole, 
                inputMsg.getMessage()
            );
            
            // Notification logic
            Booking booking = BookingDAO.getInstance().getBookingById(inputMsg.getBookingId());
            if (booking != null) {
                String title = "Tin nhắn mới đơn hàng " + inputMsg.getBookingId();
                String message = (senderRole.equals("STAFF") ? "Nhân viên: " : "Khách hàng: ") + inputMsg.getMessage();
                
                if (senderRole.equals("STAFF")) {
                    // Staff sent message to Customer
                    com.smartride.dto.Customer customer = com.smartride.dao.CustomerDAO.getInstance().getCustomerbyID(booking.getCustomerID());
                    if(customer != null) {
                        String link = "bookingHistoryDetail.jsp?bookingId=" + inputMsg.getBookingId() + "&openChat=true";
                        NotificationDAO.getInstance().insertNotification(
                            customer.getAccountId(), 
                            title, message, link
                        );
                    }
                } else {
                    // Customer sent message to Staff
                    // Notify ALL staffs and admins (roles 2 and 3)
                    String link = "manageSmartRide.jsp?iframeSrc=manageBooking&openChat=true&bookingId=" + inputMsg.getBookingId();
                    
                    java.util.List<com.smartride.dto.Account> staffs = com.smartride.dao.AccountDAO.getInstance().getListAccountByRole(2);
                    java.util.List<com.smartride.dto.Account> admins = com.smartride.dao.AccountDAO.getInstance().getListAccountByRole(3);
                    
                    for(com.smartride.dto.Account stf : staffs) {
                        NotificationDAO.getInstance().insertNotification(
                            stf.getAccountId(), 
                            title, message, link
                        );
                    }
                    for(com.smartride.dto.Account adm : admins) {
                        NotificationDAO.getInstance().insertNotification(
                            adm.getAccountId(), 
                            title, message, link
                        );
                    }
                }
            }
            
            response.getWriter().print(gson.toJson(Map.of("status", "success")));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print(gson.toJson(Map.of("error", e.getMessage())));
        }
    }
}

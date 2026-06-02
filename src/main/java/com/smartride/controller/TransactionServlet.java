package com.smartride.controller;

import com.smartride.dao.PaymentDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "TransactionServlet", urlPatterns = {"/transaction"})
public class TransactionServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TransactionServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TransactionServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        List<Payment> payment = PaymentDAO.getInstance().getAllPaymentsByCustomer(acc.getAccountId());
        
        // Populate synthetic pending transactions for bookings without any payments
        List<com.smartride.dto.Booking> bookings = com.smartride.dao.BookingDAO.getInstance().getBookingWithDetails("all", "all", acc.getAccountId());
        if (bookings != null) {
            for (com.smartride.dto.Booking b : bookings) {
                if (!"Đã hủy".equals(b.getStatusBooking())) {
                    boolean hasPayment = false;
                    for (Payment p : payment) {
                        if (p.getBookingId().equals(b.getBookingID())) {
                            hasPayment = true;
                            break;
                        }
                    }
                    if (!hasPayment) {
                        Payment pending = new Payment();
                        pending.setBookingId(b.getBookingID());
                        
                        // Try converting YYYY-MM-DD HH:MM:SS to DD-MM-YYYY HH:MM:SS for display
                        String bDate = b.getBookingDate();
                        if (bDate != null && bDate.length() >= 10 && bDate.indexOf("-") == 4) {
                            bDate = bDate.substring(8, 10) + "-" + bDate.substring(5, 7) + "-" + bDate.substring(0, 4) + (bDate.length() > 10 ? bDate.substring(10) : "");
                        }
                        pending.setPaymentDate(bDate);
                        
                        double total = 0;
                        if (b.getListBookingDetails() != null) {
                            for (com.smartride.dto.BookingDetail bd : b.getListBookingDetails()) {
                                total += bd.getTotalPrice();
                            }
                        }
                        pending.setPaymentAmount(total); 
                        
                        if ("Chờ thanh toán".equals(b.getStatusBooking())) {
                            pending.setPaymentMethod("Mã QR (Chưa quét)");
                            pending.setPaymentStatus("Đang chờ thanh toán");
                        } else {
                            pending.setPaymentMethod("Tiền mặt");
                            pending.setPaymentStatus("Chưa thanh toán");
                        }
                        
                        // Insert at the beginning so pending transactions show up at the top
                        payment.add(0, pending);
                    }
                }
            }
        }
        
        request.setAttribute("transaction", payment);
        request.getRequestDispatcher("transaction.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

// Minor update 8

// Minor update 28

// fix patch 7

// fix patch 44

// fix patch 53

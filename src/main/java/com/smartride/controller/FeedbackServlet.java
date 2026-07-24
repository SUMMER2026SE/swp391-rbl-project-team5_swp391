package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.CustomerDAO;
import com.smartride.dao.FeedbackDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.Customer;
import com.smartride.dto.Feedback;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@WebServlet(name = "FeedbackServlet", urlPatterns = {"/feedback"})
public class FeedbackServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Feedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Feedback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if ("getByMotorcycle".equals(action)) {
                String mid = request.getParameter("motorcycleId");
                List<Feedback> listFb = FeedbackDAO.getInstance().getFeedbacksByMotorcycleId(mid);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                com.google.gson.Gson gson = new com.google.gson.Gson();
                PrintWriter out = response.getWriter();
                out.print(gson.toJson(listFb));
                out.flush();
                return;
            }
            if ("checkEligible".equals(action)) {
                String mid = request.getParameter("motorcycleId");
                HttpSession session = request.getSession(false);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                if (session == null || session.getAttribute("account") == null) {
                    out.print("{\"eligible\": false}");
                } else {
                    com.smartride.dto.Account acc = (com.smartride.dto.Account) session.getAttribute("account");
                    String bookingId = BookingDAO.getInstance().getCompletedBookingIdForMotorcycle(acc.getAccountId(), mid);
                    if (bookingId != null) {
                        out.print("{\"eligible\": true, \"bookingId\": \"" + bookingId + "\"}");
                    } else {
                        out.print("{\"eligible\": false}");
                    }
                }
                out.flush();
                return;
            }

            String bookingId = request.getParameter("bookingId");
            HttpSession session = request.getSession();
            if (bookingId != null) {
                session.setAttribute("bookingId", bookingId);
            } else {
                bookingId = (String) session.getAttribute("bookingId");
            }
            
            // SECURITY CHECK: Ensure user is logged in
            Account acc = (Account) session.getAttribute("account");
            if (acc == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            Booking booking = BookingDAO.getInstance().getBookingById(bookingId);
            Customer cus = CustomerDAO.getInstance().getCustomerbyAccountID(acc.getAccountId());
            
            // SECURITY CHECK: Ensure booking exists, belongs to the user, and is "Đã trả"
            if (booking == null || cus == null || booking.getCustomerID() != cus.getCustomerId() || !"Đã trả".equals(booking.getDeliveryStatus())) {
                session.setAttribute("errorMsg", "Bạn chỉ có thể đánh giá những xe đã hoàn tất quá trình thuê và đã trả xe.");
                response.sendRedirect("bookingHistory");
                return;
            }

            Feedback fb = FeedbackDAO.getInstance().getFeedbackByBookingId(bookingId);
            List<Map<String, Object>> motorcycleBook = BookingDAO.getInstance().getMotorcyclesByBookingID(bookingId);
            
            request.setAttribute("booking", booking);
            request.setAttribute("motorcycleBook", motorcycleBook);
            request.setAttribute("fb", fb);

            request.getRequestDispatcher("feedback.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String bookingId = request.getParameter("bookingId");
            String product = request.getParameter("product");
            String service = request.getParameter("service");
            String delivery = request.getParameter("delivery");
            String content = request.getParameter("content");

            Account acc = (Account) session.getAttribute("account");
            if (acc == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            Customer cus = CustomerDAO.getInstance().getCustomerbyAccountID(acc.getAccountId());
            Booking booking = BookingDAO.getInstance().getBookingById(bookingId);
            
            // SECURITY CHECK: Ensure booking belongs to the user and is "Đã trả"
            if (booking == null || cus == null || booking.getCustomerID() != cus.getCustomerId() || !"Đã trả".equals(booking.getDeliveryStatus())) {
                session.setAttribute("errorMsg", "Bạn không có quyền đánh giá đơn hàng này hoặc xe chưa được trả.");
                response.sendRedirect("bookingHistory");
                return;
            }
            
            Feedback fb = FeedbackDAO.getInstance().getFeedbackByBookingId(bookingId);

            int productRating = product != null && !product.isEmpty() ? Integer.parseInt(product) : 0;
            int serviceRating = service != null && !service.isEmpty() ? Integer.parseInt(service) : 0;
            int deliveryRating = delivery != null && !delivery.isEmpty() ? Integer.parseInt(delivery) : 0;

            if (productRating > 0 && serviceRating > 0 && deliveryRating > 0 && content != null && !content.isEmpty()) {
                if (fb != null) {
                    FeedbackDAO.getInstance().updateFeedback(content, productRating, serviceRating, deliveryRating, cus.getCustomerId(), bookingId);
                    session.setAttribute("feedbackUpdate", "Note: Cập nhật đánh giá thành công!");
                } else {
                    FeedbackDAO.getInstance().insertFeedback(content, productRating, serviceRating, deliveryRating, cus.getCustomerId(), bookingId);
                    session.setAttribute("feedbackResult", "Note: Ghi nhận phản hồi thành công! Vui lòng đợi trong giây lát...");
                }
            } else {
                session.setAttribute("feedbackFail", "Ghi nhận phản hồi thất bại. Vui lòng điền tất cả thông tin...");
            }

            List<Map<String, Object>> motorcycleBook = BookingDAO.getInstance().getMotorcyclesByBookingID(bookingId);

            session.setAttribute("booking", booking);
            request.setAttribute("motorcycleBook", motorcycleBook);
            
            // Refresh fb after update/insert
            fb = FeedbackDAO.getInstance().getFeedbackByBookingId(bookingId);
            request.setAttribute("fb", fb);

            request.getRequestDispatcher("feedback.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
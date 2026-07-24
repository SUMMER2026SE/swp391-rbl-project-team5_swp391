package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.CancellationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CancelBookingServlet", urlPatterns = {"/cancelbooking"})
public class CancelBookingServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CancelBookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CancelBookingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String cancelReason = request.getParameter("cancelreason");
        String bankInfo = request.getParameter("bankinfo");
        HttpSession session = request.getSession();

        if (cancelReason != null && !cancelReason.trim().isEmpty()) {
            String finalReason = cancelReason.trim();
            if (bankInfo != null && !bankInfo.trim().isEmpty()) {
                finalReason += " | STK hoàn tiền: " + bankInfo.trim();
            }
            boolean isInserted = CancellationDAO.getInstance().insertCancellation(finalReason, bookingId, null);
            BookingDAO.getInstance().updateBookingStatus(bookingId, "Đã hủy");
            if (isInserted) {
                com.smartride.dto.Account account = (com.smartride.dto.Account) session.getAttribute("account");
                if (account != null) {
                    String chatMsg = "Khách hàng gửi yêu cầu HỦY ĐƠN. Lý do: " + finalReason;
                    com.smartride.dao.ChatMessageDAO.getInstance().insertMessage(bookingId, account.getAccountId(), "CUSTOMER", chatMsg);
                    
                    String title = "Đơn hàng " + bookingId + " vừa bị hủy";
                    String link = "manageSmartRide.jsp?iframeSrc=manageBooking&openChat=true&bookingId=" + bookingId;
                    java.util.List<com.smartride.dto.Account> staffs = com.smartride.dao.AccountDAO.getInstance().getListAccountByRole(2);
                    java.util.List<com.smartride.dto.Account> admins = com.smartride.dao.AccountDAO.getInstance().getListAccountByRole(3);
                    
                    for(com.smartride.dto.Account stf : staffs) {
                        com.smartride.dao.NotificationDAO.getInstance().insertNotification(stf.getAccountId(), title, chatMsg, link);
                    }
                    for(com.smartride.dto.Account adm : admins) {
                        com.smartride.dao.NotificationDAO.getInstance().insertNotification(adm.getAccountId(), title, chatMsg, link);
                    }
                }
                session.setAttribute("cancelSuccess", "Hủy đơn thành công");
            } else {
                session.setAttribute("cancelFail", "Hủy đơn thất bại... Vui lòng thử lại");
            }
        } else {
            session.setAttribute("cancelFail", "Hủy đơn thất bại! Vui lòng nhập lý do hủy đơn ...");
        }
        response.sendRedirect("bookingHistoryDetail?bookingId=" + bookingId);
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

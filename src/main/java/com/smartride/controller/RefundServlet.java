package com.smartride.controller;

import com.smartride.dao.NotificationDAO;
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

@WebServlet(name = "RefundServlet", urlPatterns = {"/refundRequest"})
public class RefundServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        if (bookingId == null || bookingId.isEmpty()) {
            response.sendRedirect("home");
            return;
        }
        
        Payment payment = PaymentDAO.getInstance().getPayMentbyBookingId(bookingId);
        if (payment != null) {
            String amountStr = String.format("%,.0f", payment.getPaymentAmount()) + " VNĐ";
            request.setAttribute("refundAmount", amountStr);
        }
        
        request.setAttribute("bookingId", bookingId);
        request.getRequestDispatcher("refundRequest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String bookingId = request.getParameter("bookingId");
        String bankName = request.getParameter("bankName");
        String bankAccount = request.getParameter("bankAccount");
        String accountName = request.getParameter("accountName");

        if (bookingId != null && bankName != null && bankAccount != null && accountName != null) {
            Payment payment = PaymentDAO.getInstance().getPayMentbyBookingId(bookingId);
            String amountStr = "";
            if (payment != null) {
                amountStr = String.format("%,.0f", payment.getPaymentAmount()) + " VNĐ";
            }
            
            // Send notification to Staff
            String title = "Yêu cầu hoàn tiền " + amountStr + " cho đơn " + bookingId;
            String message = "Khách hàng " + account.getFirstName() + " " + account.getLastName() + " (" + account.getPhoneNumber() + ") đã cung cấp thông tin hoàn tiền:<br/>"
                    + "- Số tiền hoàn: <strong>" + amountStr + "</strong><br/>"
                    + "- Ngân hàng: " + bankName + "<br/>"
                    + "- Số TK: " + bankAccount + "<br/>"
                    + "- Tên TK: " + accountName;
            String link = "manageBooking.jsp";

            // Insert staff notification (Role 2, 3)
            NotificationDAO.getInstance().insertStaffNotification(title, message, link);
            
            // Send notification back to customer
            String cusMessage = "Cảm ơn bạn đã cung cấp thông tin STK. Kế toán sẽ tiến hành hoàn tiền <strong>" + amountStr + "</strong> vào TK " + bankAccount + " (" + bankName + ") trong thời gian sớm nhất.";
            NotificationDAO.getInstance().insertNotification(account.getAccountId(), "Thông tin hoàn tiền " + amountStr + " đã được ghi nhận", cusMessage, "bookingHistory");

            request.setAttribute("message", "Đã gửi yêu cầu hoàn tiền thành công!");
            request.getRequestDispatcher("refundRequest.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}

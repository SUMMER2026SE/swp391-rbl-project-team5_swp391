package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Staff xác nhận khách đã trả xe thực tế.
 * POST /confirmReturn?bookingID=XXX
 * Response JSON: { "success": true, "overdueDays": 2, "lateFee": 300000 }
 */
@WebServlet(name = "ConfirmReturnServlet", urlPatterns = {"/confirmReturn"})
public class ConfirmReturnServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        String bookingID = request.getParameter("bookingID");
        String previewOnly = request.getParameter("previewOnly");

        if (bookingID == null || bookingID.trim().isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Thiếu bookingID\"}");
            return;
        }

        try {
            BookingDAO bookingDAO = BookingDAO.getInstance();

            // Tính phí phạt
            double[] result = bookingDAO.getOverdueDaysAndLateFee(bookingID);
            int overdueDays = (int) result[0];
            double lateFee = result[1];

            // Nếu chỉ preview (modal lần đầu mở) → không commit DB
            if ("true".equals(previewOnly)) {
                String json = String.format(
                    "{\"overdueDays\":%d,\"lateFee\":%.0f}",
                    overdueDays, lateFee
                );
                response.getWriter().write(json);
                return;
            }

            // 2. Xác nhận trả xe (đổi DeliveryStatus → 'Đã trả', ghi ActualReturnDate)
            boolean success = bookingDAO.confirmReturn(bookingID);

            if (!success) {
                response.getWriter().write("{\"success\":false,\"message\":\"Không thể cập nhật trạng thái booking\"}");
                return;
            }

            // 3. Nếu có phí phạt → insert bản ghi Payment "Phí trễ hạn"
            if (lateFee > 0) {
                String paymentDate = LocalDateTime.now()
                        .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                PaymentDAO.getInstance().addLateFeePayment(bookingID, "Phí trễ hạn", paymentDate, (int) lateFee);
            }

            // 4. Trả JSON về cho frontend
            String json = String.format(
                "{\"success\":true,\"overdueDays\":%d,\"lateFee\":%.0f}",
                overdueDays, lateFee
            );
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Lỗi server: " + e.getMessage() + "\"}");
        }
    }
}

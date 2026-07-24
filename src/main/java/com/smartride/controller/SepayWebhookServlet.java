package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.BookingDetailDAO;
import com.smartride.dao.MotorcycleStatusDAO;
import com.smartride.dao.PaymentDAO;
import com.smartride.dao.AccountDAO;
import com.smartride.dao.NotificationDAO;
import com.smartride.dto.Account;
import com.smartride.constant.SendEmail;

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
                PaymentDAO daoP = PaymentDAO.getInstance();
                LocalDateTime currentDateTime = LocalDateTime.now();
                DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String paymentDateText = currentDateTime.format(outputFormatter);
                daoP.addPayment(bookingId, "SePay VietQR", paymentDateText, amount, "Thành công");
                
                // Calculate total paid - sum all payments for this booking
                java.util.List<com.smartride.dto.Payment> allPayments = daoP.getListByBookingId(bookingId);
                double totalPaid = 0;
                for (com.smartride.dto.Payment p : allPayments) {
                    if ("Thành công".equals(p.getPaymentStatus())) {
                        totalPaid += p.getPaymentAmount();
                    }
                }
                
                double bookingTotal = 0;
                for (com.smartride.dto.BookingDetail detail : existingBooking.getListBookingDetails()) {
                    bookingTotal += detail.getTotalPrice();
                }
                bookingTotal += existingBooking.getDeliveryFee();
                com.smartride.dto.Extension ext = com.smartride.dao.ExtensionDAO.getInstance().getExtensionByBookingID(bookingId);
                if (ext != null) bookingTotal += ext.getExtensionFee();
                
                boolean fullyPaid = (bookingTotal > 0 && totalPaid >= bookingTotal);
                String currentStatus = existingBooking.getStatusBooking();
                String currentDelivery = existingBooking.getDeliveryStatus();
                
                if ("Chờ thanh toán".equals(currentStatus)) {
                    daoB.updateBookingStatus(bookingId, "Chờ xác nhận");
                } else if (fullyPaid && ("Đã xác nhận".equals(currentStatus) || "Đang thuê".equals(currentStatus))) {
                    // Nếu xe đã giao cho khách thì chuyển thẳng sang Đang thuê, ngược lại là Đã thanh toán
                    if ("Đã giao".equals(currentDelivery)) {
                        daoB.updateBookingStatus(bookingId, "Đang thuê");
                    } else {
                        daoB.updateBookingStatus(bookingId, "Đã thanh toán");
                    }
                }

                MotorcycleStatusDAO daoMS = MotorcycleStatusDAO.getInstance();
                BookingDetailDAO daoBD = BookingDetailDAO.getInstance();
                List<com.smartride.dto.BookingDetail> listBD = daoBD.getListBookingDetails(bookingId);
                String mcStatusMsg = fullyPaid ? "Đã thanh toán toàn bộ" : "Đã thanh toán cọc";
                for(com.smartride.dto.BookingDetail bd : listBD) {
                    int mcId = bd.getMotorcycleDetailID();
                    if(mcId > 0) {
                        daoMS.insertMotorcycleStatus(mcId, "STAFF00001", mcStatusMsg, paymentDateText, "Xác nhận tự động qua SePay");
                    }
                }
                
                // Gửi Email và chuông thông báo (Notification)
                try {
                    Account acc = AccountDAO.getInstance().getAccountbyBookingID(bookingId);
                    if (acc != null && acc.getEmail() != null) {
                        // 1. Thêm Notification vào chuông
                        String notiTitle = "Thanh toán thành công";
                        String notiMsg = fullyPaid
                            ? "Đơn hàng " + bookingId + " đã thanh toán toàn bộ thành công."
                            : "Đơn hàng " + bookingId + " đã thanh toán cọc thành công.";
                        String notiLink = "bookingHistoryDetail?bookingId=" + bookingId;
                        NotificationDAO.getInstance().insertNotification(acc.getAccountId(), notiTitle, notiMsg, notiLink);
                        
                        // 2. Gửi Email thông báo có link Hợp Đồng
                        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
                        String contractLink = baseUrl + "/bookingHistoryDetail?bookingId=" + bookingId + "&autoContract=1";
                        String amountStrEmail = String.format("%,d", amount).replace(',', '.');
                        
                        String emailContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 30px; border: 1px solid #e2e8f0; border-radius: 12px; background-color: #ffffff;'>"
                                + "<div style='text-align: center; margin-bottom: 20px;'>"
                                + "<h1 style='color: #b59349; margin: 0;'>SmartRide</h1>"
                                + "<p style='color: #64748b; font-size: 14px; margin-top: 5px;'>Xác nhận đặt xe & Hợp đồng điện tử</p>"
                                + "</div>"
                                + "<div style='background-color: #f8fafc; padding: 20px; border-radius: 8px; border-left: 4px solid #2eca6a; margin-bottom: 25px;'>"
                                + "<h2 style='color: #0f172a; margin-top: 0; font-size: 18px;'>Thanh toán cọc thành công!</h2>"
                                + "<p style='color: #334155; line-height: 1.6; margin-bottom: 10px;'>Chào bạn <strong>" + acc.getUserName() + "</strong>,</p>"
                                + "<p style='color: #334155; line-height: 1.6; margin-bottom: 0;'>Chúng tôi đã nhận được khoản thanh toán cọc <strong>" + amountStrEmail + " VNĐ</strong> cho mã đơn hàng <strong style='color: #b59349;'>" + bookingId + "</strong>.</p>"
                                + "</div>"
                                + "<p style='color: #334155; line-height: 1.6;'>Xe của bạn đã được cửa hàng giữ và sẵn sàng để giao theo đúng thời gian đã đặt. Kèm theo đây là Hợp đồng thuê xe điện tử chứng nhận giao dịch của bạn.</p>"
                                + "<div style='text-align: center; margin: 35px 0;'>"
                                + "<a href='" + contractLink + "' style='background-color: #b59349; color: #ffffff; padding: 14px 28px; text-decoration: none; border-radius: 8px; font-weight: bold; display: inline-block;'>XEM HỢP ĐỒNG ĐIỆN TỬ</a>"
                                + "</div>"
                                + "<p style='color: #64748b; font-size: 13px; border-top: 1px solid #e2e8f0; padding-top: 15px;'>Nếu bạn có bất kỳ thắc mắc nào, vui lòng liên hệ hotline 0905.123.456 để được hỗ trợ nhanh nhất.</p>"
                                + "<p style='color: #64748b; font-size: 13px;'>Trân trọng,<br>Đội ngũ SmartRide Đà Nẵng</p>"
                                + "</div>";
                        SendEmail.sendVerificationEmail(acc.getEmail(), emailContent);
                    }
                } catch (Exception ex) {
                    System.out.println("Lỗi gửi email/thông báo SePay: " + ex.getMessage());
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

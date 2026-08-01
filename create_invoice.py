import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\invoice.jsp'

content = '''<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.smartride.dao.BookingDAO"%>
<%@page import="com.smartride.dao.PaymentDAO"%>
<%@page import="com.smartride.dto.Booking"%>
<%@page import="com.smartride.dto.Account"%>
<%@page import="com.smartride.dto.Customer"%>
<%@page import="com.smartride.dao.AccountDAO"%>
<%@page import="com.smartride.dao.CustomerDAO"%>
<%@page import="com.smartride.dto.Payment"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%
    String bookingId = request.getParameter("bookingId");
    if (bookingId == null || bookingId.isEmpty()) {
        out.println("Không tìm thấy biên lai!");
        return;
    }
    
    BookingDAO dao = BookingDAO.getInstance();
    Booking booking = dao.getBookingById(bookingId);
    if (booking == null) {
        out.println("Biên lai không tồn tại!");
        return;
    }
    
    CustomerDAO daoCus = CustomerDAO.getInstance();
    Customer customer = daoCus.getCustomerbyID(booking.getCustomerID());
    AccountDAO daoAcc = AccountDAO.getInstance();
    Account account = null;
    if (customer != null) {
        account = daoAcc.getAccountbyID(customer.getAccountId());
    }
    
    PaymentDAO daoPay = PaymentDAO.getInstance();
    Payment payment = daoPay.getPayMentbyBookingId(bookingId);
    double paidAmount = payment != null ? payment.getPaymentAmount() : 0;
    
    double bookingTotal = 0;
    for (com.smartride.dto.BookingDetail detail : booking.getListBookingDetails()) {
        bookingTotal += detail.getTotalPrice();
    }
    bookingTotal += booking.getDeliveryFee();
    com.smartride.dto.Extension ext = com.smartride.dao.ExtensionDAO.getInstance().getExtensionByBookingID(bookingId);
    if (ext != null) bookingTotal += ext.getExtensionFee();
    
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Biên Lai - <%= bookingId %></title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', sans-serif; margin: 0; padding: 30px; background: #fff; color: #333; font-size: 14px; }
        .invoice-container { max-width: 700px; margin: 0 auto; border: 1px solid #e2e8f0; border-radius: 12px; padding: 40px; position: relative; overflow: hidden; }
        .header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 30px; border-bottom: 2px solid #f1f5f9; padding-bottom: 20px; }
        .logo-box h1 { margin: 0; color: #b59349; font-size: 28px; font-weight: 900; letter-spacing: 1px; }
        .logo-box p { margin: 5px 0 0; color: #64748b; font-size: 13px; }
        .invoice-title h2 { margin: 0; color: #0f172a; font-size: 24px; text-transform: uppercase; font-weight: 900; letter-spacing: 2px; text-align: right; }
        .invoice-title p { margin: 5px 0 0; color: #64748b; text-align: right; }
        .info-section { display: flex; justify-content: space-between; margin-bottom: 40px; }
        .info-block h3 { margin: 0 0 10px; font-size: 13px; color: #94a3b8; text-transform: uppercase; letter-spacing: 1px; }
        .info-block p { margin: 3px 0; font-weight: 500; color: #1e293b; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th { background: #f8fafc; color: #475569; font-weight: 700; text-align: left; padding: 12px 15px; font-size: 13px; text-transform: uppercase; border-bottom: 2px solid #e2e8f0; }
        td { padding: 15px; border-bottom: 1px solid #f1f5f9; color: #1e293b; }
        .text-right { text-align: right; }
        .summary-box { float: right; width: 350px; background: #f8fafc; border-radius: 8px; padding: 20px; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 10px; color: #475569; }
        .summary-row.total { border-top: 2px solid #e2e8f0; padding-top: 15px; margin-top: 5px; font-size: 18px; font-weight: 900; color: #0f172a; }
        .paid-stamp { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%) rotate(-15deg); border: 8px solid #2eca6a; color: #2eca6a; font-size: 60px; font-weight: 900; letter-spacing: 5px; padding: 10px 30px; border-radius: 15px; opacity: 0.15; pointer-events: none; text-transform: uppercase; }
        .footer { clear: both; margin-top: 60px; text-align: center; color: #64748b; font-size: 13px; border-top: 1px solid #f1f5f9; padding-top: 20px; }
    </style>
</head>
<body>
    <div class="invoice-container">
        <div class="paid-stamp">ĐÃ THANH TOÁN</div>
        
        <div class="header">
            <div class="logo-box">
                <h1>SMARTRIDE</h1>
                <p>123 Đường Điện Biên Phủ, Đà Nẵng</p>
                <p>Hotline: 0905.123.456</p>
            </div>
            <div class="invoice-title">
                <h2>Biên Lai</h2>
                <p>Mã Hóa Đơn: #<%= bookingId %></p>
                <p>Ngày: <%= payment != null && payment.getPaymentDate() != null ? payment.getPaymentDate() : booking.getStartDate() %></p>
            </div>
        </div>
        
        <div class="info-section">
            <div class="info-block">
                <h3>Khách Hàng</h3>
                <p><%= account != null ? account.getUserName() : "Khách Hàng" %></p>
                <p><%= account != null ? account.getPhone() : "" %></p>
                <p><%= account != null ? account.getEmail() : "" %></p>
            </div>
            <div class="info-block" style="text-align: right;">
                <h3>Chi Tiết Thuê</h3>
                <p>Nhận xe: <%= booking.getStartDate() %></p>
                <p>Trả xe: <%= booking.getEndDate() %></p>
            </div>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Hạng Mục</th>
                    <th class="text-right">Số Tiền (VNĐ)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Dịch vụ thuê xe máy & Phụ kiện (Mã đơn: <%= bookingId %>)</td>
                    <td class="text-right"><%= currencyFormat.format(bookingTotal) %> ₫</td>
                </tr>
            </tbody>
        </table>
        
        <div class="summary-box">
            <div class="summary-row">
                <span>Tổng cộng:</span>
                <span><%= currencyFormat.format(bookingTotal) %> ₫</span>
            </div>
            <div class="summary-row">
                <span>Đã thanh toán:</span>
                <span style="color: #2eca6a; font-weight: 700;"><%= currencyFormat.format(paidAmount) %> ₫</span>
            </div>
            <div class="summary-row total">
                <span>CÒN LẠI:</span>
                <span><%= currencyFormat.format(Math.max(0, bookingTotal - paidAmount)) %> ₫</span>
            </div>
        </div>
        
        <div class="footer">
            <p>Cảm ơn quý khách đã sử dụng dịch vụ của SmartRide!</p>
            <p>Biên lai này là chứng từ hợp lệ xác nhận giao dịch thành công.</p>
        </div>
    </div>
</body>
</html>
'''

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('invoice.jsp created successfully')

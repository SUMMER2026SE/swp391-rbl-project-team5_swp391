<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yêu Cầu Hoàn Tiền - SmartRide</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                background-color: #f8fafc;
                font-family: 'Inter', sans-serif;
            }
            .refund-container {
                max-width: 500px;
                margin: 50px auto;
                background: white;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            }
            .refund-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .refund-header i {
                font-size: 48px;
                color: #b59349;
                margin-bottom: 15px;
            }
            .btn-gold {
                background-color: #b59349;
                color: white;
                font-weight: 600;
                border: none;
                padding: 12px;
                border-radius: 8px;
            }
            .btn-gold:hover {
                background-color: #a38241;
                color: white;
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/customer/navbar.jsp" />

        <div class="container">
            <div class="refund-container">
                <div class="refund-header">
                    <i class="fas fa-hand-holding-usd"></i>
                    <h3 class="fw-bold">Yêu Cầu Hoàn Tiền</h3>
                    <p class="text-muted mb-1">Đơn thuê xe <strong>${bookingId}</strong></p>
                    <c:if test="${not empty refundAmount}">
                        <p class="text-danger fw-bold fs-5 mb-0">Số tiền hoàn: ${refundAmount}</p>
                    </c:if>
                </div>

                <%
                    String message = (String) request.getAttribute("message");
                    if (message != null) {
                %>
                <div class="alert alert-success text-center">
                    <i class="fas fa-check-circle me-2"></i> <%= message %>
                    <br><br>
                    <a href="home" class="btn btn-outline-success btn-sm">Về trang chủ</a>
                </div>
                <%
                    } else {
                %>
                <form action="refundRequest" method="POST">
                    <input type="hidden" name="bookingId" value="${bookingId}">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Ngân hàng thụ hưởng</label>
                        <select class="form-select" name="bankName" required>
                            <option value="">-- Chọn ngân hàng --</option>
                            <option value="Vietcombank">Vietcombank</option>
                            <option value="Techcombank">Techcombank</option>
                            <option value="MBBank">MBBank (Quân Đội)</option>
                            <option value="BIDV">BIDV</option>
                            <option value="VietinBank">VietinBank</option>
                            <option value="Agribank">Agribank</option>
                            <option value="ACB">ACB</option>
                            <option value="TPBank">TPBank</option>
                            <option value="VPBank">VPBank</option>
                            <option value="Khác">Ngân hàng khác</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Số tài khoản</label>
                        <input type="text" class="form-control" name="bankAccount" placeholder="Nhập số tài khoản" required pattern="[0-9]+">
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Tên chủ tài khoản</label>
                        <input type="text" class="form-control" name="accountName" placeholder="VIET HOA KHONG DAU" required style="text-transform: uppercase;">
                    </div>

                    <button type="submit" class="btn btn-gold w-100">Gửi Yêu Cầu Hoàn Tiền</button>
                </form>
                <% } %>
            </div>
        </div>

        <jsp:include page="includes/customer/footer.jsp" />
    </body>
</html>

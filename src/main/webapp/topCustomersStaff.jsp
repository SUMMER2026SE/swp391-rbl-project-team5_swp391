<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Top Khách Hàng - Quản Lý</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
    
    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="staffAssets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="staffAssets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="staffAssets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="staffAssets/css/style.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background-color: #f8f9fa;
        }
        
        .top-customer-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            background: #fff;
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        
        .top-customer-card:hover {
            transform: translateY(-5px);
        }

        .medal-icon {
            font-size: 2rem;
        }
        
        .medal-1 { color: #FFD700; } /* Gold */
        .medal-2 { color: #C0C0C0; } /* Silver */
        .medal-3 { color: #CD7F32; } /* Bronze */
        .medal-other { color: #6c757d; font-size: 1.5rem; font-weight: bold; }

        .table-custom {
            margin-bottom: 0;
        }
        
        .table-custom thead th {
            background-color: #f1f4f9;
            color: #444;
            border-bottom: none;
            padding: 15px;
            font-weight: 600;
        }
        
        .table-custom tbody td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f4f9;
        }

        .customer-name {
            font-weight: 600;
            color: #012970;
            margin-bottom: 0;
        }
        
        .customer-email {
            font-size: 0.85rem;
            color: #899bbd;
        }
        
        .total-spent {
            font-weight: 700;
            color: #198754;
            font-size: 1.1rem;
        }
        
        .total-bookings {
            display: inline-block;
            padding: 5px 12px;
            background-color: #e0f8e9;
            color: #198754;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .page-title h1 {
            font-size: 24px;
            font-weight: 700;
            color: #012970;
        }
    </style>
</head>

<body>

    <!-- ======= Header ======= -->
    <jsp:include page="/includes/staff/header-staff.jsp" />
    <jsp:include page="/includes/staff/sidebar.jsp" />
    
    <main id="main" class="main">

        <div class="pagetitle mb-4">
            <h1 class="page-title">Top Khách Hàng VIP</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="homeStaff">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Top Khách Hàng</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->

        <section class="section dashboard">
            <div class="row">

                <div class="col-12">
                    <div class="top-customer-card p-0">
                        <div class="card-body p-0">
                            <h5 class="card-title px-4 pt-4 pb-2 m-0" style="font-family: 'Be Vietnam Pro', sans-serif;">
                                Bảng Xếp Hạng Chi Tiêu <span class="badge bg-primary ms-2">Top 20</span>
                            </h5>
                            
                            <div class="table-responsive">
                                <table class="table table-custom table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="text-center" style="width: 80px;">Xếp Hạng</th>
                                            <th scope="col">Khách Hàng</th>
                                            <th scope="col">Số Điện Thoại</th>
                                            <th scope="col" class="text-center">Số Chuyến</th>
                                            <th scope="col" class="text-end pe-4">Tổng Chi Tiêu</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="customer" items="${topCustomers}" varStatus="status">
                                            <tr>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${status.count == 1}">
                                                            <i class="bi bi-trophy-fill medal-icon medal-1"></i>
                                                        </c:when>
                                                        <c:when test="${status.count == 2}">
                                                            <i class="bi bi-trophy-fill medal-icon medal-2"></i>
                                                        </c:when>
                                                        <c:when test="${status.count == 3}">
                                                            <i class="bi bi-trophy-fill medal-icon medal-3"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="medal-other">#${status.count}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <p class="customer-name">${customer.FullName}</p>
                                                    <span class="customer-email">${customer.Email}</span>
                                                </td>
                                                <td>${customer.Phone}</td>
                                                <td class="text-center">
                                                    <span class="total-bookings">${customer.TotalBookings} chuyến</span>
                                                </td>
                                                <td class="text-end pe-4">
                                                    <span class="total-spent">
                                                        <fmt:formatNumber value="${customer.TotalSpent}" pattern="#,##0" /> VNĐ
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty topCustomers}">
                                            <tr>
                                                <td colspan="5" class="text-center py-5 text-muted">
                                                    <i class="bi bi-inbox fs-1 d-block mb-3"></i>
                                                    Chưa có dữ liệu khách hàng.
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

    </main><!-- End #main -->

    <!-- Vendor JS Files -->
    <script src="staffAssets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="staffAssets/js/main.js"></script>

</body>
</html>

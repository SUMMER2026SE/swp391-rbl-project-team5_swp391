<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="utf-8">
        <title>Các giao dịch gần đây</title>
        <!-- Tailwind CSS -->
        <link href="https://www.loopple.com/css/vendor/tailwind.min.css" rel="stylesheet">
        <link href="https://www.loopple.com/css/tailwind/app.css?v=1.0.0" rel="stylesheet">
        <style>
            .red { color: red; }
            .orange { color: orange; }
            .green { color: green; }
            .text-error { font-style: italic; }
            
            /* Simplified Sidebar */
            .sidebar-item {
                padding: 0.75rem 1rem !important;
                margin: 0.2rem 1rem !important;
                display: flex !important;
                align-items: center !important;
                border-radius: 0.5rem !important;
                transition: all 0.2s ease !important;
                color: #1e293b !important; /* Dark Slate-800 for absolute contrast */
                font-weight: 700 !important; /* Bold, highly readable */
                font-size: 0.95rem !important; /* Slightly larger */
                text-decoration: none !important;
            }
            .sidebar-item:hover {
                background-color: #f1f5f9 !important;
                color: #0f172a !important; /* Slate-900 */
            }
            .sidebar-item.active {
                background-color: #fdf8eb !important; /* very light gold */
                color: #854d0e !important; /* Deep Golden Amber for maximum readability */
                font-weight: 800 !important;
            }
            .icon-box {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                margin-right: 1rem !important;
                width: 32px !important;
                height: 32px !important;
                border-radius: 0.5rem !important;
                background-color: #e2e8f0 !important; /* Deeper gray for contrast */
                color: #334155 !important; /* Slate-700 */
                transition: all 0.2s ease !important;
            }
            .sidebar-item.active .icon-box {
                background-color: #b59349 !important;
                color: #ffffff !important;
            }
            .nav-text {
                font-size: 0.95rem !important;
            }
            .sidebar-heading {
                padding-left: 1.5rem !important;
                font-weight: 800 !important;
                text-transform: uppercase !important;
                font-size: 0.8rem !important; /* Slightly larger */
                color: #475569 !important; /* Slate-600 */
                margin-top: 1.5rem !important;
                margin-bottom: 0.5rem !important;
                letter-spacing: 0.05em !important;
            }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style type="text/css">
            .widget-author {
                margin-bottom: 58px;
            }

            .author-card {
                position: relative;
                padding-bottom: 48px;
                background-color: #fff;
                box-shadow: 0 12px 20px 1px rgba(64, 64, 64, .09);
            }

            .author-card .author-card-cover {
                position: relative;
                width: 100%;
                height: 100px;
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
            }

            .author-card .author-card-cover::after {
                display: block;
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                content: '';
                opacity: 0.5;
            }

            .author-card .author-card-cover>.btn {
                position: absolute;
                top: 12px;
                right: 12px;
                padding: 0 10px;
            }

            .author-card .author-card-profile {
                display: table;
                position: relative;
                margin-top: -22px;
                padding-right: 15px;
                padding-bottom: 16px;
                padding-left: 20px;
                z-index: 5;
            }

            .author-card .author-card-profile .author-card-avatar,
            .author-card .author-card-profile .author-card-details {
                display: table-cell;
                vertical-align: middle;
            }

            .author-card .author-card-profile .author-card-avatar {
                width: 85px;
                border-radius: 50%;
                box-shadow: 0 8px 20px 0 rgba(0, 0, 0, .15);
                overflow: hidden;
            }

            .author-card .author-card-profile .author-card-avatar>img {
                display: block;
                width: 100%;
            }

            .author-card .author-card-profile .author-card-details {
                padding-top: 20px;
                padding-left: 15px;
            }

            .author-card .author-card-profile .author-card-name {
                margin-bottom: 2px;
                font-size: 14px;
                font-weight: bold;
            }

            .author-card .author-card-profile .author-card-position {
                display: block;
                color: #8c8c8c;
                font-size: 12px;
                font-weight: 600;
            }

            .author-card .author-card-info {
                margin-bottom: 0;
                padding: 0 25px;
                font-size: 13px;
            }

            .author-card .author-card-social-bar-wrap {
                position: absolute;
                bottom: -18px;
                left: 0;
                width: 100%;
            }

            .author-card .author-card-social-bar-wrap .author-card-social-bar {
                display: table;
                margin: auto;
                background-color: #fff;
                box-shadow: 0 12px 20px 1px rgba(64, 64, 64, .11);
            }

            .btn-style-1.btn-white {
                background-color: #fff;
            }

            .list-group-item i {
                display: inline-block;
                margin-top: -1px;
                margin-right: 8px;
                font-size: 1.2em;
                vertical-align: middle;
            }

            .mr-1,
            .mx-1 {
                margin-right: .25rem !important;
            }

            .list-group-item.active:not(.disabled) {
                border-color: #e7e7e7;
                background: #fff;
                color: #ac32e4;
                cursor: default;
                pointer-events: none;
            }

            .list-group-flush:last-child .list-group-item:last-child {
                border-bottom: 0;
            }

            .list-group-flush .list-group-item {
                border-right: 0 !important;
                border-left: 0 !important;
            }

            .list-group-flush .list-group-item {
                border-right: 0;
                border-left: 0;
                border-radius: 0;
            }

            .list-group-item.active {
                z-index: 2;
                color: #fff;
                background-color: #007bff;
                border-color: #007bff;
            }

            .list-group-item:last-child {
                margin-bottom: 0;
                border-bottom-right-radius: .25rem;
                border-bottom-left-radius: .25rem;
            }

            a.list-group-item,
            .list-group-item-action {
                color: #404040;
                font-weight: 600;
            }

            .list-group-item {
                padding-top: 16px;
                padding-bottom: 16px;
                -webkit-transition: all .3s;
                transition: all .3s;
                border: 1px solid #e7e7e7 !important;
                border-radius: 0 !important;
                color: #404040;
                font-size: 12px;
                font-weight: 600;
                letter-spacing: .08em;
                text-transform: uppercase;
                text-decoration: none;
            }

            .list-group-item {
                position: relative;
                display: block;
                padding: .75rem 1.25rem;
                margin-bottom: -1px;
                background-color: #fff;
                border: 1px solid rgba(0, 0, 0, 0.125);
            }

            .list-group-item.active:not(.disabled)::before {
                background-color: #ac32e4;
            }

            .list-group-item::before {
                display: block;
                position: absolute;
                top: 0;
                left: 0;
                width: 3px;
                height: 100%;
                background-color: transparent;
                content: '';
            }

            .input-with-button {
                position: relative;
                display: flex;
                align-items: center;
            }

            .input-with-button input {
                padding-right: 80px;
            }

            .input-with-button button {
                position: absolute;
                right: 10px;
                padding: 5px 10px;
                font-size: 12px;
                height: calc(100% - 10px);
                top: 5px;
            }
            .tabs-container {
                background-color: #f8f9fa; /* Màu nền của thanh chọn */
                border: 1px solid #ddd; /* Đường viền của thanh chọn */
            }

            .tab {
                padding: 10px 20px;
                cursor: pointer;
                background-color: #ffffff; /* Màu nền của từng tab */
                border-right: 1px solid #ddd; /* Đường viền giữa các tab */
                text-align: center;
                flex: 1; /* Đảm bảo các tab có kích thước đều nhau */
            }

            .tab:last-child {
                border-right: none; /* Loại bỏ đường viền phải của tab cuối cùng */
            }

            .tab:hover {
                background-color: #e9ecef; /* Màu nền khi hover */
            }

            .tab.active {
                background-color: #007bff; /* Màu nền của tab đang hoạt động */
                color: #ffffff; /* Màu chữ của tab đang hoạt động */
            }

            .booking-history h1 {
                margin-bottom: 1rem;
            }

            .filters {
                margin-bottom: 1rem;
            }

            .filters .filter-btn {
                padding: 0.5rem 1rem;
                margin-right: 0.5rem;
                background: linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
                color: #fff;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }

            .filters .filter-btn:hover {
                background: linear-gradient(243.4deg, rgb(0, 132, 255) 13%, rgb(8, 126, 120) 98%) !important;
            }

            .confirmed-filters {
                display: none;
                margin-bottom: 1rem;
            }

            .confirmed-filters label {
                margin-right: 0.5rem;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table thead th {
                background-color: #007BFF;
                color: #fff;
                padding: 0.75rem;
                text-align: left;
            }

            table tbody tr {
                background-color: #fff;
                border-bottom: 1px solid #ccc;
            }

            table tbody tr:nth-child(even) {
                background-color: #f4f4f9;
            }

            table tbody td {
                padding: 0.75rem;
            }

            .detail-btn {
                padding: 0.5rem 1rem;
                background-color: #28a745;
                color: #fff;
                border: none;
                cursor: pointer;
            }

            .detail-btn:hover {
                background-color: #218838;
            }
            .col-table {
                background: #fff;
                color: #000;
            }
            .filter-btn.active {
                opacity: 0.7; /* hoặc bất kỳ thuộc tính CSS nào bạn muốn áp dụng */
                border: 1px solid #333; /* ví dụ cho border */
            }
            .status-success {
                color: green;
            }

            .status-failure {
                color: red;
            }

            .status-pending {
                color: orange;
            }

        /* Simplified Sidebar */
        .sidebar-item {
            padding: 0.75rem 1rem !important;
            margin: 0.2rem 1rem !important;
            display: flex !important;
            align-items: center !important;
            border-radius: 0.5rem !important;
            transition: all 0.2s ease !important;
            color: #1e293b !important; /* Dark Slate-800 for absolute contrast */
            font-weight: 700 !important; /* Bold, highly readable */
            font-size: 0.95rem !important; /* Slightly larger */
            text-decoration: none !important;
        }
        .sidebar-item:hover {
            background-color: #f1f5f9 !important;
            color: #0f172a !important; /* Slate-900 */
        }
        .sidebar-item.active {
            background-color: #fdf8eb !important; /* very light gold */
            color: #854d0e !important; /* Deep Golden Amber for maximum readability */
            font-weight: 800 !important;
        }
        .icon-box {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            margin-right: 1rem !important;
            width: 32px !important;
            height: 32px !important;
            border-radius: 0.5rem !important;
            background-color: #e2e8f0 !important; /* Deeper gray for contrast */
            color: #334155 !important; /* Slate-700 */
            transition: all 0.2s ease !important;
        }
        .sidebar-item.active .icon-box {
            background-color: #b59349 !important;
            color: #ffffff !important;
        }
        .nav-text {
            font-size: 0.95rem !important;
        }
        .sidebar-heading {
            padding-left: 1.5rem !important;
            font-weight: 800 !important;
            text-transform: uppercase !important;
            font-size: 0.8rem !important; /* Slightly larger */
            color: #475569 !important; /* Slate-600 */
            margin-top: 1.5rem !important;
            margin-bottom: 0.5rem !important;
            letter-spacing: 0.05em !important;
        }

        </style>
    </head>
    <jsp:include page="/includes/customer/header.jsp" />
    <jsp:include page="/includes/customer/navbar.jsp" />
    <body class="  font-body " data-framework="tailwind">
        <!-- CSS Links -->
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <link href="https://demos.creative-tim.com/soft-ui-dashboard-tailwind/assets/css/nucleo-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/Loopple/loopple-public-assets@main/soft-ui-dashboard-tailwind/css/soft-ui-dashboard-tailwind.css">
        <div class="builder-container builder-container-preview font-body">
            <aside class="max-w-62.5 ease-nav-brand z-990 absolute inset-y-0 my-4 ml-4 block w-full -translate-x-full flex-wrap items-center justify-between overflow-y-auto rounded-2xl border-0 p-0 antialiased shadow-none transition-transform duration-200 xl:left-0 xl:translate-x-0 xl:bg-transparent text-slate-500"
                   id="sidenav-main">
                <hr class="h-px mt-0 bg-transparent bg-gradient-horizontal-dark">
                <div style="margin-top: 6rem" class="items-center block w-auto max-h-screen overflow-auto grow basis-full">
                    <ul class="flex flex-col pl-0 mb-0">
                        <li class="w-full">
                            <div class="sidebar-heading">Quản lý thuê xe</div>
                        </li>
                        <li class="w-full"> 
                            <a class="sidebar-item active" href="transaction">
                                <div class="icon-box">
                                    <i class="fas fa-credit-card text-xs"></i>
                                </div> 
                                <span class="nav-text">Giao dịch gần đây</span>
                            </a> 
                        </li>
                        <li class="w-full"> 
                            <a class="sidebar-item" href="bookingHistory?status=all">
                                <div class="icon-box">
                                    <i class="fas fa-history text-xs"></i>
                                </div> 
                                <span class="nav-text">Lịch sử thuê xe</span>
                            </a> 
                        </li>
                        <li class="w-full">
                            <div class="sidebar-heading">Quản lý tài khoản</div>
                        </li>
                        <li class="w-full"> 
                            <a class="sidebar-item" href="profileCustomer.jsp">
                                <div class="icon-box">
                                    <i class="fas fa-user-circle text-xs"></i>
                                </div> 
                                <span class="nav-text">Thông tin cá nhân</span>
                            </a> 
                        </li>
                        <li class="w-full"> 
                            <a class="sidebar-item" href="settingsProfile.jsp">
                                <div class="icon-box">
                                    <i class="fas fa-shield-alt text-xs"></i>
                                </div> 
                                <span class="nav-text">Mật khẩu và bảo mật</span>
                            </a> 
                        </li>
                    </ul>
                </div>
            </aside>

            <div class="ease-soft-in-out xl:ml-68.5 relative h-full max-h-screen rounded-xl transition-all duration-200" id="panel">
                <div class="w-full px-6 py-6 mx-auto drop-zone loopple-min-height-78vh text-slate-500">
                    <div class="relative flex flex-col flex-auto min-w-0 p-4 mx-6 mt-32 overflow-hidden break-words border-0 shadow-blur rounded-2xl bg-white/80 bg-clip-border mb-4">
                                    
                                    <h3 class="text-xl font-bold text-slate-800 mb-6 flex items-center">
                                        <i class="fas fa-credit-card mr-2 text-amber-500"></i> Giao dịch gần đây
                                    </h3>
                                    
                                    <div class="table-responsive w-full overflow-x-auto rounded-xl border border-slate-100">
                                        <table class="table min-w-full align-middle mb-0" id="booking-table">
                                            <thead class="bg-slate-50 border-b border-slate-100">
                                                <tr class="bg-slate-50">
                                                    <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Mã đơn</th>
                                                    <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Phương thức</th>
                                                    <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Ngày thanh toán</th>
                                                    <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Thành tiền</th>
                                                    <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Trạng thái</th>
                                                </tr>
                                            </thead>
                                            <tbody class="divide-y divide-slate-100">
                                                <c:if test="${empty transaction}">
                                                    <tr>
                                                        <td colspan="5" class="text-center italic py-8 text-slate-400">Không có thông tin giao dịch nào ở đây</td>
                                                    </tr>
                                                </c:if>
                                                <c:forEach items="${transaction}" var="trans">
                                                    <tr class="hover:bg-slate-50 transition-colors duration-150">
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-amber-600">
                                                            #${trans.bookingId}
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600 font-medium">
                                                            <span class="inline-flex items-center gap-1.5">
                                                                <i class="fas fa-wallet text-slate-400"></i>
                                                                <span>${trans.paymentMethod}</span>
                                                            </span>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
                                                            ${trans.paymentDate}
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-slate-800">
                                                            <fmt:formatNumber value="${trans.paymentAmount}" pattern="#,### ₫" />
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                            <c:choose>
                                                                <c:when test="${trans.paymentStatus == 'Giao dịch thành công'}">
                                                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #dcfce7; color: #16a34a; border: 1px solid #bbf7d0;">
                                                                        <span class="w-1.5 h-1.5 rounded-full" style="background-color: #22c55e;"></span>
                                                                        Giao dịch thành công
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${trans.paymentStatus == 'Giao dịch thất bại'}">
                                                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-bold animate-pulse" style="background-color: #ffe4e6; color: #e11d48; border: 1px solid #fecdd3;">
                                                                        <span class="w-1.5 h-1.5 rounded-full" style="background-color: #f43f5e;"></span>
                                                                        Giao dịch thất bại
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-bold animate-pulse" style="background-color: #fef3c7; color: #b45309; border: 1px solid #fde68a;">
                                                                        <span class="w-1.5 h-1.5 rounded-full" style="background-color: #f59e0b;"></span>
                                                                        ${trans.paymentStatus}
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
    </body>
</html>

<!-- Minor update 12 -->

<!-- Minor update 13 -->

<!-- Minor update 30 -->

<!-- fix patch 2 -->

<!-- fix patch 17 -->

<!-- fix patch 26 -->

<!-- fix patch 35 -->

<!-- fix patch 49 -->

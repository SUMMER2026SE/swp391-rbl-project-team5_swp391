<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Lịch sử thuê xe</title>
        <!-- Tailwind CSS -->
        <link href="https://www.loopple.com/css/vendor/tailwind.min.css" rel="stylesheet">
        <link href="https://www.loopple.com/css/tailwind/app.css?v=1.0.0" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebarProfile.css?v=2" rel="stylesheet">
        <style>
            .red { color: red; }
            .orange { color: orange; }
            .green { color: green; }
            .text-error { font-style: italic; }
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
             .list-group-item.active:not(.disabled) {
            border-color: #e7e7e7;
            background: #fff;
            color: #ac32e4;
            pointer-events: none;
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
                color: #b59349 !important;
                border-bottom-color: #b59349 !important;
                font-weight: 700 !important;
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
            <jsp:include page="/includes/customer/sidebarProfile.jsp">
                <jsp:param name="activePage" value="bookingHistory"/>
            </jsp:include>
            <div class="ease-soft-in-out xl:ml-68.5 relative h-full max-h-screen rounded-xl transition-all duration-200" id="panel">
                <div class="w-full px-6 py-6 mx-auto drop-zone loopple-min-height-78vh text-slate-500">
                    <div class="relative flex flex-col flex-auto min-w-0 p-4 mx-6 mt-32 overflow-hidden break-words border-0 shadow-blur rounded-2xl bg-white/80 bg-clip-border mb-4">
                                            
                                            
                                            <c:if test="${not empty sessionScope.errorMsg}">
                                                <div class="mb-6 p-4 rounded-xl bg-red-50 border border-red-200 flex items-start">
                                                    <i class="fas fa-exclamation-circle text-red-500 mt-0.5 mr-3"></i>
                                                    <div class="flex-1 text-sm text-red-700 font-medium">
                                                        ${sessionScope.errorMsg}
                                                    </div>
                                                </div>
                                                <c:remove var="errorMsg" scope="session"/>
                                            </c:if>

                                            <h3 class="text-xl font-bold text-slate-800 mb-6 flex items-center">
                                                <i class="fas fa-history mr-2 text-amber-500"></i> Lịch sử thuê xe
                                            </h3>

                                            <div class="filters flex gap-6 mb-6 border-b border-slate-200">
                                                <a href="bookingHistory?status=all" style="text-decoration:none" class="filter-btn pb-2 font-semibold transition-all duration-200 border-b-2 ${empty param.status || param.status eq 'all' ? 'text-slate-800 border-amber-500 font-bold' : 'text-slate-500 border-transparent hover:text-slate-800 hover:border-slate-300'}">Tất cả</a>
                                                <a href="bookingHistory?status=pending" style="text-decoration:none" class="filter-btn pb-2 font-semibold transition-all duration-200 border-b-2 ${param.status eq 'pending' ? 'text-slate-800 border-amber-500 font-bold' : 'text-slate-500 border-transparent hover:text-slate-800 hover:border-slate-300'}">Chờ xác nhận</a>
                                                <a href="bookingHistory?status=confirmed" style="text-decoration:none" class="filter-btn pb-2 font-semibold transition-all duration-200 border-b-2 ${param.status eq 'confirmed' ? 'text-slate-800 border-amber-500 font-bold' : 'text-slate-500 border-transparent hover:text-slate-800 hover:border-slate-300'}">Đã xác nhận</a>
                                                <a href="bookingHistory?status=cancelled" style="text-decoration:none" class="filter-btn pb-2 font-semibold transition-all duration-200 border-b-2 ${param.status eq 'cancelled' ? 'text-slate-800 border-amber-500 font-bold' : 'text-slate-500 border-transparent hover:text-slate-800 hover:border-slate-300'}">Đã hủy</a>
                                            </div>

                                            <c:if test="${param.status eq 'confirmed'}">
                                            <div class="confirmed-filters mb-6 bg-slate-50 p-4 rounded-xl border border-slate-100 flex items-center gap-3" id="confirmed-filters">
                                                <label for="confirmed-status" class="text-sm font-semibold text-slate-600">Trạng thái giao nhận:</label>
                                                <select id="confirmed-status" onchange="window.location.href='bookingHistory?status=confirmed&deliveryStatus='+this.value" class="ml-2 border border-slate-200 rounded-lg p-2 text-sm bg-white focus:outline-none focus:ring-2 focus:ring-amber-500 w-48">
                                                    <option value="all" <c:if test="${empty deliveryStatus || 'all' eq deliveryStatus}">selected</c:if>>Tất cả trạng thái</option>
                                                    <option value="notDelivered" <c:if test="${'notDelivered' eq deliveryStatus}">selected</c:if>>Chưa giao</option>
                                                    <option value="delivered" <c:if test="${'delivered' eq deliveryStatus}">selected</c:if>>Đã giao</option>
                                                    <option value="returned" <c:if test="${'returned' eq deliveryStatus}">selected</c:if>>Đã trả</option>
                                                </select>
                                            </div>
                                            </c:if>
                                            <div class="table-responsive w-full overflow-x-auto rounded-xl border border-slate-100">
                                                <table class="table min-w-full align-middle mb-0" id="booking-table">
                                                    <thead class="bg-slate-50 border-b border-slate-100">
                                                        <tr class="bg-slate-50">
                                                            <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Mã đơn</th>
                                                            <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Thời gian thuê</th>
                                                            <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Số lượng xe</th>
                                                            <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Trạng thái</th>
                                                            <th scope="col" class="px-6 py-3.5 text-left text-xs font-bold text-slate-500 uppercase tracking-wider">Tổng giá</th>
                                                            <th scope="col" class="px-6 py-3.5 text-center text-xs font-bold text-slate-500 uppercase tracking-wider">Hành động</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="divide-y divide-slate-100">
                                                    <c:if test="${empty listB}">
                                                        <tr>
                                                            <td colspan="6" class="text-center italic py-8 text-slate-400">Không có thông tin Booking nào ở đây</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach items="${listB}" var="o">
                                                        <c:set var="status" value="${o.statusBooking == 'Chờ xác nhận' ? 'pending' : (o.statusBooking == 'Đã xác nhận' ? 'confirmed' : 'cancelled')}" />
                                                        <c:set var="delivery" value="${o.deliveryStatus == 'Đã trả' ? 'returned' : ((o.deliveryStatus == 'Đã giao' || o.deliveryStatus == 'Quá hạn') ? 'delivered' : 'notDelivered')}" />
                                                        
                                                        <tr class="${status} ${delivery} hover:bg-slate-50 transition-colors duration-150 border-b border-gray-200">
                                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-amber-600">
                                                                #${o.bookingID}
                                                            </td>
                                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-slate-700">
                                                                <c:set var="startDate" value="${o.startDate}" />
                                                                <c:set var="startYear" value="${fn:substring(startDate, 0, 4)}" />
                                                                <c:set var="startMonth" value="${fn:substring(startDate, 5, 7)}" />
                                                                <c:set var="startDay" value="${fn:substring(startDate, 8, 10)}" />
                                                                
                                                                <c:set var="endDate" value="${o.endDate}" />
                                                                <c:set var="endYear" value="${fn:substring(endDate, 0, 4)}" />
                                                                <c:set var="endMonth" value="${fn:substring(endDate, 5, 7)}" />
                                                                <c:set var="endDay" value="${fn:substring(endDate, 8, 10)}" />
                                                                
                                                                <span class="inline-flex items-center gap-1.5 bg-slate-50 px-2.5 py-1 rounded-lg border border-slate-100">
                                                                    <i class="far fa-calendar-alt text-slate-400 text-xs"></i>
                                                                    <span>${startDay}-${startMonth}-${startYear}</span>
                                                                    <i class="fas fa-long-arrow-alt-right text-amber-500 text-xs mx-1"></i>
                                                                    <span>${endDay}-${endMonth}-${endYear}</span>
                                                                </span>
                                                            </td>
                                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600 font-medium">
                                                                <span class="inline-flex items-center gap-1">
                                                                    <i class="fas fa-motorcycle text-slate-400"></i>
                                                                    <span>${fn:length(o.listBookingDetails)} xe</span>
                                                                </span>
                                                            </td>
                                                            <td class="px-6 py-4 whitespace-nowrap">
                                                                    <c:choose>
                                                                        <c:when test="${o.statusBooking == 'Đã hủy'}">
                                                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #fff1f2; color: #be123c; border: 1px solid #ffe4e6;">
                                                                                <i class="fas fa-times-circle"></i> Đã hủy
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${o.deliveryStatus == 'Quá hạn'}">
                                                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #fef2f2; color: #dc2626; border: 1px solid #fca5a5;">
                                                                                <i class="fas fa-exclamation-triangle animate-pulse" style="color: #ef4444;"></i> Quá hạn
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${o.deliveryStatus == 'Đã trả'}">
                                                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #ecfdf5; color: #047857; border: 1px solid #d1fae5;">
                                                                                <i class="fas fa-check-circle" style="color: #10b981;"></i> Hoàn tất
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${o.deliveryStatus == 'Đã giao'}">
                                                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #eff6ff; color: #1d4ed8; border: 1px solid #dbeafe;">
                                                                                <span class="w-1.5 h-1.5 rounded-full animate-pulse" style="background-color: #3b82f6;"></span> Đang thuê
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${o.statusBooking == 'Đã xác nhận'}">
                                                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #ecfdf5; color: #047857; border: 1px solid #d1fae5;">
                                                                                <i class="fas fa-calendar-check" style="color: #10b981;"></i> Sắp nhận xe
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${o.statusBooking == 'Chờ xác nhận'}">
                                                                            <c:choose>
                                                                                <c:when test="${not empty paymentMap[o.bookingID]}">
                                                                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #dcfce7; color: #15803d; border: 1px solid #bbf7d0;">
                                                                                        <i class="fas fa-check-circle"></i> Đã cọc <fmt:formatNumber value="${paymentMap[o.bookingID].paymentAmount}" pattern="#,##0" />đ
                                                                                    </span>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #fffbeb; color: #b45309; border: 1px solid #fef3c7;">
                                                                                        <span class="w-1.5 h-1.5 rounded-full animate-pulse" style="background-color: #f59e0b;"></span> Chờ duyệt
                                                                                    </span>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:when>
                                                                        <c:when test="${o.statusBooking == 'Chờ thanh toán'}">
                                                                            <span id="status-badge-${o.bookingID}" class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold" style="background-color: #f3f4f6; color: #4b5563; border: 1px solid #e5e7eb;">
                                                                                <i class="fas fa-wallet" style="color: #6b7280;"></i> Chờ thanh toán
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold bg-gray-50 text-gray-700 border border-gray-200">
                                                                                ${o.statusBooking}
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                            </td>
                                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-slate-800">
                                                                <c:set var="total" value="0"/>
                                                                <c:forEach items="${o.listBookingDetails}" var="detail">
                                                                    <c:set var="total" value="${total + detail.totalPrice}"/>
                                                                </c:forEach>
                                                                <fmt:formatNumber value="${total}" pattern="#,##0" /> VNĐ
                                                            </td>
                                                            <td class="px-6 py-4 whitespace-nowrap text-center">
                                                                <div class="inline-flex items-center justify-center gap-2">
                                                                    <c:choose>
                                                                        <c:when test="${o.statusBooking == 'Chờ thanh toán'}">
                                                                            <a href="bookingHistoryDetail?bookingId=${o.bookingID}" class="px-3 py-1.5 rounded-lg font-bold text-xs transition-all duration-200 text-decoration-none shadow-sm flex items-center h-[28px] payment-countdown-btn" data-booking-date="${o.bookingDate}" data-booking-id="${o.bookingID}" style="background-color: #f59e0b; color: #ffffff;" title="Thanh toán ngay">
                                                                                <i class="fas fa-qrcode mr-1.5"></i> Thanh toán (<span class="countdown-timer">10:00</span>)
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="bookingHistoryDetail?bookingId=${o.bookingID}" class="px-3 py-1.5 rounded-lg font-bold text-xs transition-all duration-200 text-decoration-none shadow-sm flex items-center h-[28px]" style="background-color: #1e293b; color: #ffffff;" title="${o.deliveryStatus == 'Da giao' ? 'Chi tiết / Gia hạn' : 'Chi tiết'}" onmouseover="this.style.backgroundColor='#0f172a'" onmouseout="this.style.backgroundColor='#1e293b'">
                                                                                <i class="fas fa-file-invoice mr-1.5"></i> ${o.deliveryStatus == 'Da giao' ? 'Chi tiết / Gia hạn' : 'Chi tiết'}
                                                                            </a>
                                                                            <c:if test="${o.statusBooking == 'Đã xác nhận' && o.deliveryStatus == 'Đã giao'}">
                                                                                <a href="bookingHistoryDetail?bookingId=${o.bookingID}&openSos=true" class="px-3 py-1.5 rounded-lg font-bold text-xs transition-all duration-200 text-decoration-none shadow-sm flex items-center h-[28px] animate-pulse" style="background-color: #dc2626; color: #ffffff;" title="Cứu hộ khẩn cấp">
                                                                                    <i class="fas fa-exclamation-triangle mr-1.5"></i> SOS
                                                                                </a>
                                                                            </c:if>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    
                                                                    <input type="hidden" name="bookingId" value="${o.bookingID}" />
                                                                    <c:set var="feedback" value="${feedbackMap[o.bookingID]}"/>
                                                                    <c:choose>
                                                                        <c:when test="${not empty feedback}">
                                                                            <c:if test="${o.statusBooking == 'Đã xác nhận' && o.deliveryStatus == 'Đã trả'}">
                                                                                <a href="feedback?bookingId=${o.bookingID}" class="px-2.5 py-1 rounded-lg bg-emerald-50 hover:bg-emerald-100 text-emerald-700 font-bold text-xs transition-all duration-200 text-decoration-none shadow-sm border border-emerald-100" title="Xem đánh giá">
                                                                                    <i class="fas fa-star text-[10px] mr-1"></i> Xem ĐG
                                                                                </a>
                                                                            </c:if>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <c:if test="${o.statusBooking == 'Đã xác nhận' && o.deliveryStatus == 'Đã trả'}">
                                                                                <a href="feedback?bookingId=${o.bookingID}" class="px-2.5 py-1 rounded-lg bg-rose-50 hover:bg-rose-100 text-rose-700 font-bold text-xs transition-all duration-200 text-decoration-none shadow-sm border border-rose-100 animate-pulse" title="Viết đánh giá">
                                                                                    <i class="fas fa-pen text-[10px] mr-1"></i> Viết ĐG
                                                                                </a>
                                                                            </c:if>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                            </div>
                        </div>
                    </div>
                </div>

        <script src="https://demos.creative-tim.com/soft-ui-dashboard-tailwind/assets/js/plugins/chartjs.min.js"></script>
        
        <script>
        document.addEventListener("DOMContentLoaded", function() {
            function parseDateCustom(dateStr) {
                // e.g. "2026-06-17 13:47:29" or "2026-06-17 13:47:29.0"
                if (!dateStr) return new Date();
                var parts = dateStr.split(" ");
                if (parts.length < 2) return new Date();
                var dateParts = parts[0].split("-");
                var timeParts = parts[1].split(".")[0].split(":");
                return new Date(dateParts[0], dateParts[1] - 1, dateParts[2], timeParts[0], timeParts[1], timeParts[2]);
            }

            var countdownBtns = document.querySelectorAll('.payment-countdown-btn');
            setInterval(function() {
                var now = new Date();
                countdownBtns.forEach(function(btn) {
                    var dateStr = btn.getAttribute('data-booking-date');
                    if(!dateStr) return;
                    var bookingDate = parseDateCustom(dateStr);
                    var expireDate = new Date(bookingDate.getTime() + 10 * 60000);
                    var diff = expireDate - now;
                    var timerSpan = btn.querySelector('.countdown-timer');
                    var statusBadge = document.getElementById('status-badge-' + btn.getAttribute('data-booking-id'));
                    
                    if (diff <= 0) {
                        // Expired
                        if (!btn.classList.contains('expired-handled')) {
                            btn.classList.add('expired-handled');
                            btn.style.display = 'none';
                            
                            if (statusBadge) {
                                statusBadge.innerHTML = '<span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold bg-gray-50 text-gray-700 border border-gray-200">Đã hủy</span>';
                            }
                            btn.insertAdjacentHTML('afterend', '<span class="text-xs text-red-500 font-bold" style="background: #fee2e2; padding: 4px 8px; border-radius: 8px;">Đã hết hạn</span>');
                            
                            // Call API to cancel
                            fetch('cancelBookingAPI.jsp?bookingId=' + btn.getAttribute('data-booking-id'))
                                .catch(e => console.error(e));
                        }
                    } else {
                        var m = Math.floor(diff / 60000);
                        var s = Math.floor((diff % 60000) / 1000);
                        if (timerSpan) {
                            timerSpan.textContent = m + ":" + (s < 10 ? "0" : "") + s;
                        }
                    }
                });
            }, 1000);
        });
        </script>
        <script src="https://demos.creative-tim.com/soft-ui-dashboard-tailwind/assets/js/plugins/perfect-scrollbar.min.js"
        async=""></script>
        <script async="" defer="" src="https://buttons.github.io/buttons.js"></script>
        <script
            src="https://cdn.jsdelivr.net/gh/Loopple/loopple-public-assets@main/soft-ui-dashboard-tailwind/js/soft-ui-dashboard-tailwind.js"
        async=""></script>
            </div> <!-- #panel -->
        </div> <!-- .builder-container -->
    </body>
</html>


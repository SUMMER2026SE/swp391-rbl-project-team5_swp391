<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.smartride.dao.EventDAO" %>
<%@ page import="com.smartride.dto.Event" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Event activeEvent = EventDAO.getInstance().getActiveEvent();
    request.setAttribute("activeEvent", activeEvent);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Bảng Giá Thuê Xe - SmartRide</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        
        <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
        <link rel="stylesheet" href="css/animate.css">

        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">

        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/ionicons.min.css">

        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="css/jquery.timepicker.css">


        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/icomoon.css">
        <link rel="stylesheet" href="css/style.css">
        <style>
            body {
                background-color: #fbfaf8 !important;
                color: #2b2824 !important;
            }
            .ftco-section {
                background-color: #fbfaf8 !important;
                padding: 120px 0 80px 0 !important;
            }
            .section-title {
                text-align: center;
                padding-bottom: 30px;
                position: relative;
            }
            .section-title h2 {
                color: #1a1816 !important;
                font-weight: 800;
                letter-spacing: 2px;
                text-align: center;
                margin-top: 15px;
                text-transform: uppercase;
                position: relative;
                z-index: 2;
            }
            .section-title .background-text {
                position: absolute;
                top: 50%;
                left: 50%;
                font-weight: 800;
                font-size: 56px;
                text-transform: uppercase;
                text-align: center;
                letter-spacing: 4px;
                position: absolute;
                top: -10px;
                left: 0;
                right: 0;
                z-index: 1;
            }
            /* --- FILTER TABS --- */
            .filter-tabs {
                display: flex;
                justify-content: center;
                gap: 12px;
                margin-bottom: 45px;
                flex-wrap: wrap;
            }
            .filter-tab {
                padding: 12px 28px;
                background-color: #ffffff;
                color: #555;
                border-radius: 30px;
                font-weight: 700;
                font-size: 14px;
                text-decoration: none !important;
                transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
                border: 1px solid #eae6df;
                box-shadow: 0 2px 8px rgba(0,0,0,0.02);
            }
            .filter-tab:hover {
                background-color: #fcfbf9;
                color: #82662c;
                border-color: #d4af37;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.1);
            }
            .filter-tab.active {
                background-color: #82662c;
                color: #fff;
                border-color: #82662c;
                box-shadow: 0 5px 15px rgba(130, 102, 44, 0.3);
            }
            
            /* --- CARD GRID --- */
            .motorcycle-grid {
                display: flex;
                flex-direction: column;
                gap: 30px;
                margin-bottom: 40px;
            }
            .motor-card {
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 5px 25px rgba(0,0,0,0.04);
                display: flex;
                overflow: hidden;
                border: 1px solid #f0f0f0;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                padding: 25px;
            }
            .motor-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.08);
            }
            
            /* --- CARD LEFT: IMAGE --- */
            .motor-img-wrapper {
                flex: 0 0 32%;
                position: relative;
                background: #fbfaf8;
                border-radius: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }
            .motor-img-wrapper img {
                max-width: 100%;
                max-height: 220px;
                object-fit: contain;
                transition: transform 0.4s ease;
            }
            .motor-card:hover .motor-img-wrapper img {
                transform: scale(1.08);
            }
            .category-badge-top {
                position: absolute;
                top: 15px;
                left: 15px;
                background: #fdf8e2;
                color: #b59349;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border: 1px solid #f4e8b8;
                display: flex;
                align-items: center;
                gap: 6px;
                z-index: 10;
            }
            
            /* --- CARD RIGHT: CONTENT --- */
            .motor-content {
                flex: 1;
                padding-left: 35px;
                display: flex;
                flex-direction: column;
            }
            .motor-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 20px;
            }
            .motor-title h3 {
                font-size: 26px;
                font-weight: 800;
                color: #1a1816;
                margin: 0 0 8px 0;
            }
            .motor-desc {
                font-size: 14px;
                color: #777;
                line-height: 1.6;
                margin: 0;
                max-width: 85%;
            }
            .motor-main-price {
                text-align: right;
                display: flex;
                flex-direction: column;
                align-items: flex-end;
            }
            .motor-main-price .price-val-amount {
                font-size: 28px;
                font-weight: 900;
                color: #b59349;
                line-height: 1;
                letter-spacing: -0.5px;
            }
            .motor-main-price .price-val-currency {
                font-size: 18px;
                font-weight: 800;
                color: #b59349;
                margin-top: 4px;
                line-height: 1;
            }
            .motor-main-price .price-sub {
                font-size: 13px;
                color: #888;
                font-style: italic;
                margin-top: 6px;
            }
            
            /* --- PRICING BOXES --- */
            .pricing-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 15px;
                margin-bottom: 25px;
            }
            .price-box {
                border-radius: 12px;
                padding: 15px;
                position: relative;
                transition: all 0.3s ease;
            }
            .box-daily {
                background: #fbfaf9;
                border: 1px dashed #eae6df;
            }
            .box-weekly {
                background: #fcfbf5;
                border: 1px solid #ebe4cd;
            }
            .box-monthly {
                background: #fdf5f2;
                border: 1px solid #f0d5c9;
            }
            .price-box:hover {
                border-color: #b59349;
                border-style: solid;
            }
            .price-box-title {
                font-size: 11px;
                color: #555;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 8px;
            }
            .price-box-val .big-money {
                font-size: 22px;
                font-weight: 900;
                color: #1a1816;
            }
            .price-box-val .per-day {
                font-size: 13px;
                color: #888;
                font-weight: 500;
            }
            .price-box-total {
                font-size: 11px;
                color: #888;
                margin-top: 5px;
            }
            .discount-tag {
                position: absolute;
                top: -10px;
                right: -8px;
                background: #82662c;
                color: #fff;
                font-size: 11px;
                font-weight: 800;
                padding: 4px 10px;
                border-radius: 8px;
                box-shadow: 0 3px 8px rgba(130, 102, 44, 0.4);
                z-index: 10;
            }
            
            /* --- ACTION BUTTONS --- */
            .motor-actions {
                display: flex;
                gap: 15px;
                margin-top: auto;
            }
            .btn-book-now {
                flex: 1;
                background: #82662c;
                color: #fff !important;
                text-align: center;
                padding: 14px;
                border-radius: 30px;
                font-weight: 700;
                text-transform: uppercase;
                font-size: 14px;
                letter-spacing: 1px;
                text-decoration: none !important;
                transition: all 0.3s ease;
            }
            .btn-book-now:hover {
                background: #6b5321;
                box-shadow: 0 5px 15px rgba(130, 102, 44, 0.3);
                transform: translateY(-2px);
            }
            .btn-details {
                flex: 0 0 auto;
                background: #fff;
                color: #333 !important;
                text-align: center;
                padding: 14px 30px;
                border-radius: 30px;
                font-weight: 600;
                font-size: 14px;
                border: 1px solid #ccc;
                text-decoration: none !important;
                transition: all 0.3s ease;
            }
            .btn-details:hover {
                border-color: #82662c;
                color: #82662c !important;
            }
            
            /* Responsive */
            @media (max-width: 991px) {
                .motor-card {
                    flex-direction: column;
                }
                .motor-img-wrapper {
                    flex: none;
                    width: 100%;
                }
                .motor-content {
                    padding-left: 0;
                    padding-top: 20px;
                }
            }
            @media (max-width: 767px) {
                .pricing-grid {
                    grid-template-columns: 1fr;
                }
                .motor-header {
                    flex-direction: column;
                }
                .motor-main-price {
                    text-align: left;
                    margin-top: 10px;
                }
            }
            
            .pagination-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                margin-bottom: 40px;
            }
            .pagination {
                display: flex;
                list-style: none;
                padding: 0;
            }
            .pagination li {
                margin: 0 5px;
            }
            .pagination li a {
                display: block;
                padding: 10px 18px;
                text-decoration: none;
                background-color: #ffffff !important;
                border: 1px solid #eae6df !important;
                color: #2b2824 !important;
                transition: all 0.3s ease !important;
                border-radius: 5px;
            }
            .pagination li.active a {
                background-color: #b59349 !important;
                color: #ffffff !important;
                border-color: #b59349 !important;
                font-weight: bold;
            }
            .pagination li a:hover:not(.active) {
                background-color: rgba(212, 175, 55, 0.1) !important;
                color: #d4af37 !important;
                border-color: #d4af37 !important;
            }

        </style>
    </head>
    <body>

        <jsp:include page="/includes/customer/navbar.jsp" />
        <section class="ftco-section ftco-cart">
            <!-- Section Title -->
            <div class="container section-title" data-aos="fade-up">
                <span>Bảng giá xe máy<br></span>
                <h2>Bảng giá xe máy</h2>
            </div><!-- End Section Title -->
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Khám phá... subtitle -->
                        <p class="text-center" style="color: #777; margin-top: -15px; margin-bottom: 30px;">
                            Khám phá đội xe cao cấp của chúng tôi với mức giá minh bạch, linh hoạt theo nhu cầu của bạn.
                        </p>
                        
                        <!-- FILTER TABS -->
                        <div class="filter-tabs" data-aos="fade-up" data-aos-delay="100">
                            <a href="pricing?category=0${not empty searchKeyword ? '&search='.concat(searchKeyword) : ''}" class="filter-tab ${currentCategory == 0 ? 'active' : ''}">Tất cả xe</a>
                            <c:forEach items="${listC}" var="cat">
                                <c:if test="${cat.categoryName.toLowerCase().contains('ga') or cat.categoryName.toLowerCase().contains('côn') or cat.categoryName.toLowerCase().contains('số') or cat.categoryName.toLowerCase().contains('điện')}">
                                    <a href="pricing?category=${cat.categoryID}${not empty searchKeyword ? '&search='.concat(searchKeyword) : ''}" class="filter-tab ${currentCategory == cat.categoryID ? 'active' : ''}">${cat.categoryName}</a>
                                </c:if>
                            </c:forEach>
                        </div>

                        <!-- SMART FILTER BAR -->
                        <form action="pricing" method="GET" class="smart-filter-bar mb-5" style="display: flex; gap: 15px; flex-wrap: wrap; justify-content: center; max-width: 800px; margin: 0 auto; align-items: center;" data-aos="fade-up" data-aos-delay="150">
                            <input type="hidden" name="category" value="${currentCategory}">
                            <!-- Search -->
                            <div class="search-box" style="flex: 1; min-width: 250px; display: flex; gap: 10px;">
                                <div style="position: relative; flex: 1;">
                                    <i class="fas fa-search" style="position: absolute; left: 20px; top: 50%; transform: translateY(-50%); color: #b59349;"></i>
                                    <input type="text" name="search" value="${searchKeyword}" placeholder="Nhập tên xe (VD: Air Blade...)" style="width: 100%; padding: 14px 20px 14px 45px; border: 1px solid #e2e8f0; border-radius: 30px; outline: none; font-size: 15px; transition: all 0.3s; box-shadow: 0 4px 15px rgba(0,0,0,0.03);">
                                </div>
                                <button type="submit" style="background-color: #b59349; color: white; border: none; padding: 10px 25px; border-radius: 30px; font-weight: bold; cursor: pointer; transition: 0.3s; box-shadow: 0 4px 15px rgba(181, 147, 73, 0.3);">Tìm</button>
                            </div>
                            

                        </div>

                        <!-- CARD LIST -->
                        <div class="motorcycle-grid" data-aos="fade-up" data-aos-delay="200">
                            <c:forEach items="${listM}" var="m">
                                <c:forEach items="${listP}" var="p">
                                    <c:if test="${p.priceListId == m.priceListID}">
                                        
                                        <!-- Determine Category Name -->
                                        <c:set var="catName" value="Xe Máy"/>
                                        <c:forEach items="${listC}" var="cat">
                                            <c:if test="${cat.categoryID == m.categoryID}">
                                                <c:set var="catName" value="${cat.categoryName}"/>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <!-- Calculate discounts percentage -->
                                        <c:set var="discountWeek" value="${100 - (p.dailyPriceForWeek / p.dailyPriceForDay * 100)}" />
                                        <c:set var="discountMonth" value="${100 - (p.dailyPriceForMonth / p.dailyPriceForDay * 100)}" />
                                        
                                        <div class="motor-card position-relative" data-price="${p.dailyPriceForDay}" data-id="${m.motorcycleId}">
                                            <!-- Nút yêu thích (đã bỏ nút thêm giỏ) -->
                                            
                                            <!-- LEFT IMAGE -->
                                            <div class="motor-img-wrapper">
                                                <div class="category-badge-top">
                                                    <i class="ion-ios-settings"></i> ${catName}
                                                </div>
                                                <img src="${empty m.image ? 'images/default.jpg' : (m.image.startsWith('http') ? m.image : 'images/'.concat(m.image))}" alt="${m.model}">
                                            </div>
                                            
                                            <!-- RIGHT CONTENT -->
                                            <div class="motor-content">
                                                <div class="motor-header">
                                                    <div class="motor-title">
                                                        <h3>${m.model}</h3>
                                                        <p class="motor-desc">${empty m.description ? 'Mẫu xe tuyệt vời cho những chuyến đi dài, được bảo dưỡng định kỳ và vận hành cực kỳ êm ái.' : m.description}</p>
                                                    </div>
                                                    <div class="motor-main-price">
                                                        <c:choose>
                                                            <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                                <div style="font-size: 18px; color: #999; text-decoration: line-through; margin-bottom: -5px;">
                                                                    <fmt:formatNumber value="${p.dailyPriceForDay}" type="number" groupingUsed="true" />
                                                                </div>
                                                                <div class="price-val-amount" style="color: #dc2626;"><fmt:formatNumber value="${p.dailyPriceForDay * (1 - activeEvent.discount)}" type="number" groupingUsed="true" /></div>
                                                                <div class="price-val-currency" style="color: #dc2626;">VNĐ</div>
                                                                <div class="price-sub">
                                                                    <span style="color: #dc2626; font-size: 12px; font-weight: bold; background: #fee2e2; padding: 2px 6px; border-radius: 4px; margin-right: 5px;">-<fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%</span>
                                                                    mỗi ngày
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="price-val-amount"><fmt:formatNumber value="${p.dailyPriceForDay}" type="number" groupingUsed="true" /></div>
                                                                <div class="price-val-currency">VNĐ</div>
                                                                <div class="price-sub">mỗi ngày</div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                
                                                <!-- PRICING BOXES -->
                                                <div class="pricing-grid">
                                                    <!-- BOX 1: Ngày -->
                                                    <div class="price-box box-daily">
                                                        <c:if test="${not empty activeEvent and activeEvent.discount > 0}">
                                                            <div class="discount-tag" style="background: #fee2e2; color: #dc2626;">SỰ KIỆN -<fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%</div>
                                                        </c:if>
                                                        <div class="price-box-title">Theo Ngày</div>
                                                        <div class="price-box-val">
                                                            <c:choose>
                                                                <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                                    <div style="font-size: 14px; color: #999; text-decoration: line-through; margin-bottom: 2px;">
                                                                        <fmt:formatNumber value="${p.dailyPriceForDay / 1000}" maxFractionDigits="0" />k
                                                                    </div>
                                                                    <span class="big-money" style="color: #dc2626;"><fmt:formatNumber value="${(p.dailyPriceForDay * (1 - activeEvent.discount)) / 1000}" maxFractionDigits="0" />k</span> <span class="per-day">/ngày</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="big-money"><fmt:formatNumber value="${p.dailyPriceForDay / 1000}" maxFractionDigits="0" />k</span> <span class="per-day">/ngày</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- BOX 2: Tuần -->
                                                    <div class="price-box box-weekly">
                                                        <c:if test="${discountWeek >= 1}">
                                                            <div class="discount-tag">GIẢM <fmt:formatNumber value="${discountWeek}" maxFractionDigits="0"/>%</div>
                                                        </c:if>
                                                        <c:if test="${not empty activeEvent and activeEvent.discount > 0}">
                                                            <div class="discount-tag" style="background: #fee2e2; color: #dc2626; top: 15px;">SỰ KIỆN -<fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%</div>
                                                        </c:if>
                                                        <div class="price-box-title">Theo Tuần</div>
                                                        <div class="price-box-val">
                                                            <c:choose>
                                                                <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                                    <div style="font-size: 14px; color: #999; text-decoration: line-through; margin-bottom: 2px;">
                                                                        <fmt:formatNumber value="${p.dailyPriceForWeek / 1000}" maxFractionDigits="0" />k
                                                                    </div>
                                                                    <span class="big-money" style="color: #dc2626;"><fmt:formatNumber value="${(p.dailyPriceForWeek * (1 - activeEvent.discount)) / 1000}" maxFractionDigits="0" />k</span> <span class="per-day">/ngày</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="big-money"><fmt:formatNumber value="${p.dailyPriceForWeek / 1000}" maxFractionDigits="0" />k</span> <span class="per-day">/ngày</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <c:choose>
                                                            <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                                <div class="price-box-total">Tổng: <span style="text-decoration: line-through; color: #999;"><fmt:formatNumber value="${p.dailyPriceForWeek * 7}" type="number" groupingUsed="true" /></span> <span style="color: #dc2626; font-weight: bold;"><fmt:formatNumber value="${(p.dailyPriceForWeek * (1 - activeEvent.discount)) * 7}" type="number" groupingUsed="true" /></span> VNĐ</div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="price-box-total">Tổng: <fmt:formatNumber value="${p.dailyPriceForWeek * 7}" type="number" groupingUsed="true" /> VNĐ</div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    
                                                    <!-- BOX 3: Tháng -->
                                                    <div class="price-box box-monthly">
                                                        <c:if test="${discountMonth >= 1}">
                                                            <div class="discount-tag">GIẢM <fmt:formatNumber value="${discountMonth}" maxFractionDigits="0"/>%</div>
                                                        </c:if>
                                                        <c:if test="${not empty activeEvent and activeEvent.discount > 0}">
                                                            <div class="discount-tag" style="background: #fee2e2; color: #dc2626; top: 15px;">SỰ KIỆN -<fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%</div>
                                                        </c:if>
                                                        <div class="price-box-title">Theo Tháng</div>
                                                        <div class="price-box-val">
                                                            <c:choose>
                                                                <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                                    <div style="font-size: 14px; color: #999; text-decoration: line-through; margin-bottom: 2px;">
                                                                        <fmt:formatNumber value="${p.dailyPriceForMonth / 1000}" maxFractionDigits="0" />k
                                                                    </div>
                                                                    <span class="big-money" style="color: #dc2626;"><fmt:formatNumber value="${(p.dailyPriceForMonth * (1 - activeEvent.discount)) / 1000}" maxFractionDigits="0" />k</span> <span class="per-day">/ngày</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="big-money"><fmt:formatNumber value="${p.dailyPriceForMonth / 1000}" maxFractionDigits="0" />k</span> <span class="per-day">/ngày</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <c:choose>
                                                            <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                                <div class="price-box-total">Tổng: <span style="text-decoration: line-through; color: #999;"><fmt:formatNumber value="${p.dailyPriceForMonth * 30}" type="number" groupingUsed="true" /></span> <span style="color: #dc2626; font-weight: bold;"><fmt:formatNumber value="${(p.dailyPriceForMonth * (1 - activeEvent.discount)) * 30}" type="number" groupingUsed="true" /></span> VNĐ</div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="price-box-total">Tổng: <fmt:formatNumber value="${p.dailyPriceForMonth * 30}" type="number" groupingUsed="true" /> VNĐ</div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                
                                                <!-- BUTTONS -->
                                                <div class="motor-actions">
                                                    <a href="booking?motorcycleid=${m.motorcycleId}" class="btn-book-now">Thuê Ngay</a>
                                                    <a href="motorcycleDetail?id=${m.motorcycleId}" class="btn-details">Xem chi tiết</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </div>
                        
                        <!-- PAGINATION -->
                        <c:if test="${endP > 1}">
                            <div class="pagination-container">
                                <ul class="pagination">
                                    <c:if test="${tag > 1}">
                                        <li><a href="pricing?index=${tag - 1}&category=${currentCategory}${not empty searchKeyword ? '&search='.concat(searchKeyword) : ''}">&laquo;</a></li>
                                    </c:if>
                                    <c:forEach begin="1" end="${endP}" var="i">
                                        <li class="${tag == i ? 'active' : ''}"><a href="pricing?index=${i}&category=${currentCategory}${not empty searchKeyword ? '&search='.concat(searchKeyword) : ''}">${i}</a></li>
                                    </c:forEach>
                                    <c:if test="${tag < endP}">
                                        <li><a href="pricing?index=${tag + 1}&category=${currentCategory}${not empty searchKeyword ? '&search='.concat(searchKeyword) : ''}">&raquo;</a></li>
                                    </c:if>
                                </ul>
                            </div>
                        </c:if>
                        
                    </div>
                </div>
            </div>
        </section>


        <jsp:include page="/includes/customer/footer.jsp" />



        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


        <script src="js/jquery.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/jquery.waypoints.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/jquery.animateNumber.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.timepicker.min.js"></script>
        <script src="js/scrollax.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>

        <script>
            function toggleFavQuick(motorcycleId, btnElement, event) {
                event.preventDefault();
                event.stopPropagation();
                
                var icon = btnElement.querySelector('i');
                var isFav = btnElement.classList.contains('added');
                var action = isFav ? 'remove' : 'add';
                
                fetch('favorite?action=' + action + '&motorcycleId=' + motorcycleId, { method: 'POST' })
                .then(res => res.json())
                .then(data => {
                    if(data.status === 'success') {
                        if(action === 'add') {
                            btnElement.classList.add('added');
                            btnElement.style.background = '#b59349';
                            icon.style.color = 'white';
                            window.postMessage('fav_updated', '*');
                        } else {
                            btnElement.classList.remove('added');
                            btnElement.style.background = '';
                            icon.style.color = '#b59349';
                        }
                        window.postMessage('fav_updated', '*');
                    } else if(data.status === 'unauthorized') {
                        window.location.href = 'login.jsp';
                    }
                });
            }
            
            document.addEventListener("DOMContentLoaded", function() {
                var buttons = document.querySelectorAll("button[onclick^='toggleFavQuick']");
                buttons.forEach(function(btn) {
                    var match = btn.getAttribute('onclick').match(/'([^']+)'/);
                    if(match && match[1]) {
                        var mId = match[1];
                        fetch('favorite?action=check&motorcycleId=' + mId, { method: 'POST' })
                        .then(res => res.json())
                        .then(data => {
                            if(data.status === 'success' && data.isFavorite) {
                                var icon = btn.querySelector('i');
                                btn.classList.add('added');
                                btn.style.background = '#b59349';
                                icon.style.color = 'white';
                            }
                        });
                    }
                });
            });
        </script>
    </body>
</html>

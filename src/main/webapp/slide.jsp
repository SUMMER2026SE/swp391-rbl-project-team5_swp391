<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.smartride.dao.MotorcycleDAO" %>
<%@ page import="com.smartride.dao.PriceListDAO" %>
<%@ page import="com.smartride.dto.Motorcycle" %>
<%@ page import="com.smartride.dto.PriceList" %>
<%@ page import="com.smartride.dao.EventDAO" %>
<%@ page import="com.smartride.dto.Event" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Luôn lấy toàn bộ danh sách xe cho slider trang chủ
    List<Motorcycle> sliderListM = MotorcycleDAO.getInstance().getMotorcycles();
    request.setAttribute("sliderListM", sliderListM);

    if (session.getAttribute("listP") == null) {
        List<PriceList> listP = PriceListDAO.getInstance().getAllPriceList();
        session.setAttribute("listP", listP);
    }
    Event activeEvent = EventDAO.getInstance().getActiveEvent();
    request.setAttribute("activeEvent", activeEvent);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Motorcycle Slider</title>
        <!-- Swiper CSS -->
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
        <!-- Modern Google Font & Icons -->
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        
        <style>
            @keyframes heartPop {
                0%   { transform: scale(1); }
                40%  { transform: scale(1.35); }
                70%  { transform: scale(0.9); }
                100% { transform: scale(1); }
            }
            .fav-btn-card.favorited i {
                animation: heartPop 0.4s ease;
            }
            .fav-btn-card.favorited {
                background: rgba(254,226,226,0.95) !important;
                box-shadow: 0 2px 12px rgba(239,68,68,0.3) !important;
            }
            body {
                background: transparent !important;
                margin: 0;
                padding: 0;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                overflow: hidden;
            }
            .centered-slide-carousel {
                padding: 40px 15px 60px 15px !important;
            }
            
            .swiper-slide {
                border-radius: 24px !important;
                background: linear-gradient(145deg, #ffffff, #f8f9fa) !important;
                border: 1px solid rgba(181, 147, 73, 0.2) !important;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.06) !important;
                transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1) !important;
                overflow: visible;
                box-sizing: border-box;
                padding: 30px 25px;
                display: flex;
                flex-direction: column;
                position: relative;
                height: auto;
            }

            .swiper-slide:hover {
                transform: translateY(-10px);
                box-shadow: 0 25px 50px rgba(181, 147, 73, 0.15) !important;
                border-color: rgba(181, 147, 73, 0.5) !important;
            }

            .swiper-slide.best-choice {
                background: linear-gradient(145deg, #fffcf8, #fdf6e9) !important;
                border: 2px solid #b59349 !important;
                box-shadow: 0 20px 45px rgba(181, 147, 73, 0.2) !important;
                z-index: 2;
                transform: scale(1.02);
            }
            .swiper-slide.best-choice:hover {
                transform: scale(1.02) translateY(-10px);
                box-shadow: 0 30px 60px rgba(181, 147, 73, 0.3) !important;
            }

            .best-badge {
                position: absolute;
                top: -18px;
                left: 50%;
                transform: translateX(-50%);
                background: linear-gradient(135deg, #d4af37, #b59349);
                color: #fff;
                font-size: 10px;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                padding: 6px 14px;
                border-radius: 20px;
                display: flex;
                align-items: center;
                gap: 6px;
                box-shadow: 0 5px 15px rgba(181, 147, 73, 0.4);
                z-index: 10;
                white-space: nowrap;
            }

            .card-title {
                text-align: center;
                font-family: 'Times New Roman', serif;
                font-size: 18px;
                font-weight: 800;
                color: #1a1a1a;
                margin: 15px 0 8px 0;
                letter-spacing: 0.5px;
            }
            .best-choice .card-title {
                color: #b59349;
            }
            
            .card-tags {
                display: flex;
                justify-content: center;
                gap: 6px;
                margin-bottom: 15px;
            }
            .card-tag {
                background: #f0f0f0;
                color: #555;
                font-size: 10px;
                font-weight: 700;
                padding: 3px 8px;
                border-radius: 20px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .best-choice .card-tag {
                background: rgba(181, 147, 73, 0.1);
                color: #b59349;
            }

            .card-img-wrapper {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 110px;
                margin-bottom: 15px;
                position: relative;
            }
            
            .card-img-wrapper::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 80%;
                height: 25px;
                background: radial-gradient(ellipse at center, rgba(0,0,0,0.15) 0%, rgba(0,0,0,0) 70%);
                border-radius: 50%;
                z-index: 1;
            }
            .best-choice .card-img-wrapper::after {
                background: radial-gradient(ellipse at center, rgba(181, 147, 73, 0.3) 0%, rgba(0,0,0,0) 70%);
            }
            
            .card-img {
                max-width: 95%;
                max-height: 100%;
                object-fit: contain;
                position: relative;
                z-index: 2;
                transition: transform 0.6s cubic-bezier(0.165, 0.84, 0.44, 1);
            }
            .swiper-slide:hover .card-img {
                transform: scale(1.1) rotate(2deg);
            }
            
            .features-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 6px;
                margin-bottom: 15px;
                padding: 8px 0;
                border-top: 1px dashed rgba(0,0,0,0.1);
                border-bottom: 1px dashed rgba(0,0,0,0.1);
            }
            .best-choice .features-grid {
                border-color: rgba(181, 147, 73, 0.3);
            }
            
            .feature-item {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 11px;
                color: #666;
                font-weight: 500;
            }
            .feature-item i {
                color: #c4a14b;
                font-size: 16px;
            }
            
            .price-wrap {
                margin-top: auto;
                margin-bottom: 20px;
                text-align: center;
                background: #fdfdfd;
                padding: 15px;
                border-radius: 12px;
                border: 1px solid #f0f0f0;
            }
            .best-choice .price-wrap {
                background: #fff;
                border-color: rgba(181, 147, 73, 0.2);
            }
            
            .price-val {
                font-size: 22px;
                font-weight: 800;
                color: #1a1a1a;
            }
            .best-choice .price-val {
                color: #b59349;
            }
            .price-unit {
                font-size: 13px;
                font-weight: 600;
                color: #888;
            }

            .action-row {
                display: flex;
                gap: 15px;
            }
            .btn-book {
                flex: 1;
                background: linear-gradient(135deg, #c4a14b, #b59349);
                color: #ffffff;
                font-weight: 800;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 1px;
                text-decoration: none;
                border: none;
                border-radius: 50px;
                padding: 10px 10px;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 5px;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 8px 20px rgba(181, 147, 73, 0.3);
            }
            .btn-book:hover {
                background: linear-gradient(135deg, #b59349, #82662c);
                color: #ffffff;
                transform: translateY(-3px);
                box-shadow: 0 12px 25px rgba(181, 147, 73, 0.4);
            }
            .btn-msg {
                background: #ffffff;
                color: #1a1a1a;
                border: 2px solid #eaeaea;
                border-radius: 50px;
                padding: 0 15px;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 12px;
                font-weight: 700;
                text-transform: uppercase;
                cursor: pointer;
                transition: all 0.3s;
                text-decoration: none;
            }
            .btn-msg:hover {
                background: #1a1a1a;
                border-color: #1a1a1a;
                color: #ffffff;
            }

            .best-choice .btn-book {
                background: linear-gradient(135deg, #1a1a1a, #333);
                box-shadow: 0 8px 20px rgba(26, 26, 26, 0.3);
            }
            .best-choice .btn-book:hover {
                background: linear-gradient(135deg, #000000, #1a1a1a);
                box-shadow: 0 12px 25px rgba(26, 26, 26, 0.4);
                color: #c4a14b;
            }
            .best-choice .btn-msg {
                background: #ffffff;
                border-color: #1a1a1a;
                color: #1a1a1a;
            }
            .best-choice .btn-msg:hover {
                background: #1a1a1a;
                color: #ffffff;
            }
            
            .view-all-wrapper {
                text-align: center;
                margin-top: 20px;
            }
            .btn-view-all {
                background: transparent;
                color: #c4a14b;
                font-weight: 700;
                font-size: 15px;
                padding: 12px 30px;
                border-radius: 30px;
                border: 2px solid #c4a14b;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s;
            }
            .btn-view-all:hover {
                background: #c4a14b;
                color: #ffffff;
            }

            .swiper-button-next, .swiper-button-prev {
                color: #1a1a1a !important;
                background: #ffffff !important;
                border: 1px solid rgba(0,0,0,0.05);
                width: 44px !important;
                height: 44px !important;
                border-radius: 50%;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                transition: all 0.3s ease;
            }
            .swiper-button-next:hover, .swiper-button-prev:hover {
                background: #c4a14b !important;
                border-color: #c4a14b !important;
                color: #ffffff !important;
                transform: scale(1.05);
            }
            .swiper-button-next::after, .swiper-button-prev::after {
                font-size: 18px !important;
                font-weight: 700;
            }
        </style>
    </head>
    <body>
        <div class="swiper-container-wrapper">
            <div class="swiper centered-slide-carousel">
                <div class="swiper-wrapper">
                    <c:forEach items="${requestScope.sliderListM}" var="m" varStatus="status">
                        <!-- Make the 2nd item (index 1) the Best Choice -->
                        <c:set var="isBest" value="${status.index == 1}" />
                        
                        <div class="swiper-slide ${isBest ? 'best-choice' : ''}" style="position: relative;">
                            <!-- Favorite Button -->
                            <button onclick="toggleFavQuick('${m.motorcycleId}', this, event)" class="fav-btn-card" style="position:absolute;top:12px;right:12px;border-radius:50%;width:36px;height:36px;display:flex;align-items:center;justify-content:center;z-index:10;border:none;padding:0;background:rgba(255,255,255,0.92);backdrop-filter:blur(4px);box-shadow:0 2px 10px rgba(0,0,0,0.12);cursor:pointer;transition:transform 0.2s,box-shadow 0.2s;" onmouseover="this.style.transform='scale(1.15)';this.style.boxShadow='0 4px 16px rgba(239,68,68,0.25)';" onmouseout="this.style.transform='scale(1)';this.style.boxShadow='0 2px 10px rgba(0,0,0,0.12)';">
                                <i class="fa-regular fa-heart" style="color:#94a3b8;font-size:15px;line-height:1;"></i>
                            </button>
                            <c:if test="${isBest}">
                                <div class="best-badge">
                                    <i class="ri-star-fill"></i> Lựa chọn tốt nhất
                                </div>
                            </c:if>

                            <h3 class="card-title">${m.model}</h3>
                            <div class="card-tags">
                                <span class="card-tag">Mới 100%</span>
                                <span class="card-tag">Chính chủ</span>
                            </div>
                            
                            <a href="motorcycleDetail?id=${m.motorcycleId}" target="_top" class="card-img-wrapper">
                                <img class="card-img"
                                     src="${empty m.image ? 'images/default.jpg' : (m.image.startsWith('http') ? m.image : 'images/'.concat(m.image))}"
                                     alt="${m.model}" />
                            </a>
                            
                            <div class="features-grid">
                                <div class="feature-item"><i class="ri-checkbox-circle-fill"></i> Mũ bảo hiểm x2</div>
                                <div class="feature-item"><i class="ri-smartphone-line"></i> Giá đỡ ĐT</div>
                                <div class="feature-item"><i class="ri-tools-fill"></i> Vá xe mini</div>
                                <div class="feature-item"><i class="ri-drop-fill"></i> Áo mưa dự phòng</div>
                            </div>

                            <c:forEach items="${sessionScope.listP}" var="p">
                                <c:if test="${m.priceListID == p.priceListId}">
                                    <div class="price-wrap">
                                        <c:choose>
                                            <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                <div style="font-size: 14px; color: #999; text-decoration: line-through; display: inline-block;">
                                                    <fmt:formatNumber value="${p.dailyPriceForDay}" pattern="#,###"/>đ
                                                </div>
                                                <div style="display: inline-block; color: #dc2626; font-size: 11px; font-weight: bold; background: #fee2e2; padding: 2px 5px; border-radius: 4px; margin-left: 4px; transform: translateY(-2px);">
                                                    -<fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%
                                                </div>
                                                <br>
                                                <span class="price-val"><fmt:formatNumber value="${(p.dailyPriceForDay * (1 - activeEvent.discount))}" pattern="#,###"/></span>
                                                <span class="price-unit">đ/ngày</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="price-val"><fmt:formatNumber value="${p.dailyPriceForDay}" pattern="#,###"/></span>
                                                <span class="price-unit">đ/ngày</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:if>
                            </c:forEach>

                            <div class="action-row">
                                <a href="booking?motorcycleid=${m.motorcycleId}" target="_top" class="btn-book" onclick="redirectToBooking(event,'${m.motorcycleId}')">
                                    <i class="ri-key-2-line"></i> THUÊ NGAY
                                </a>
                                <a href="motorcycleDetail?id=${m.motorcycleId}" target="_top" class="btn-msg" title="Xem chi tiết">
                                    Chi tiết
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- Navigation -->
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
            </div>
            
            <div class="view-all-wrapper">
                <a href="motorcycle" target="_top" class="btn-view-all">
                    Bảng giá chi tiết <i class="ri-arrow-right-s-line"></i>
                </a>
            </div>
        </div>

        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script>
            var swiper = new Swiper('.centered-slide-carousel', {
                slidesPerView: 5,
                spaceBetween: 20,
                centeredSlides: false,
                loop: true,
                autoplay: {
                    delay: 3500,
                    disableOnInteraction: false,
                    pauseOnMouseEnter: false
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                breakpoints: {
                    320: {
                        slidesPerView: 1,
                        spaceBetween: 15
                    },
                    640: {
                        slidesPerView: 1.5,
                        spaceBetween: 20
                    },
                    768: {
                        slidesPerView: 2.5,
                        spaceBetween: 20
                    },
                    1024: {
                        slidesPerView: 4,
                        spaceBetween: 20
                    },
                    1280: {
                        slidesPerView: 5,
                        spaceBetween: 20
                    }
                }
            });

            function redirectToBooking(event, motorcycleId) {
                event.preventDefault(); 
                window.top.location.href = 'booking?motorcycleid=' + motorcycleId;
            }
        </script>
        <script>
            function toggleFavQuick(motorcycleId, btnElement, event) {
                event.preventDefault();
                event.stopPropagation();
                
                var icon = btnElement.querySelector('i');
                var isFav = btnElement.classList.contains('favorited');
                var action = isFav ? 'remove' : 'add';
                
                fetch('favorite?action=' + action + '&motorcycleId=' + motorcycleId, { method: 'POST' })
                .then(res => res.json())
                .then(data => {
                    if(data.status === 'success') {
                        if(action === 'add') {
                            btnElement.classList.add('favorited');
                            icon.className = 'fa-solid fa-heart';
                            icon.style.color = '#ef4444';
                            icon.style.animation = 'none';
                            icon.offsetHeight;
                            icon.style.animation = 'heartPop 0.4s ease';
                        } else {
                            btnElement.classList.remove('favorited');
                            icon.className = 'fa-regular fa-heart';
                            icon.style.color = '#94a3b8';
                            icon.style.animation = 'none';
                        }
                        window.parent.postMessage('fav_updated', '*');
                        window.parent.postMessage('fav_updated', '*');
                    } else if(data.status === 'unauthorized') {
                        window.top.location.href = 'login.jsp';
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
                                btn.classList.add('favorited');
                                icon.className = 'fa-solid fa-heart';
                                icon.style.color = '#ef4444';
                            }
                        });
                    }
                });
            });
        </script>
    </body>
</html>

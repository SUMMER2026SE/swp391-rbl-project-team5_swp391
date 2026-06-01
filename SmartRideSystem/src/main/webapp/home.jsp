<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <jsp:include page="/includes/customer/header.jsp" />

        <style>
            .rental {
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                width: auto !important;
                min-width: 220px !important;
                padding: 14px 35px !important;
                background-color: #b59349 !important;
                border: 2px solid #b59349 !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 15px !important;
                font-weight: 700 !important;
                text-transform: uppercase !important;
                letter-spacing: 1.5px !important;
                color: #ffffff !important;
                text-decoration: none !important;
                border-radius: 8px !important;
                box-shadow: 0 4px 15px rgba(181, 147, 73, 0.3) !important;
                transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1) !important;
                position: relative !important;
                overflow: hidden !important;
                cursor: pointer !important;
                animation: pulse 2s infinite !important;
            }
            .rental::after {
                content: '' !important;
                position: absolute !important;
                top: 0 !important;
                left: -100% !important;
                width: 100% !important;
                height: 100% !important;
                background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.3),
                    transparent
                ) !important;
                transition: all 0.6s ease !important;
            }
            .rental:hover::after {
                left: 100% !important;
            }
            .rental:hover {
                background-color: #1a1816 !important;
                border-color: #b59349 !important;
                color: #b59349 !important;
                transform: translateY(-4px) scale(1.03) !important;
                box-shadow: 0 10px 25px rgba(181, 147, 73, 0.4) !important;
            }
            .rental:active {
                transform: translateY(-1px) scale(0.97) !important;
                box-shadow: 0 5px 12px rgba(181, 147, 73, 0.2) !important;
                transition: all 0.1s ease !important;
            }

            .sitename {
                color: #b59349 !important;
            }
            .gradient-button {
                background: #b59349;
                color: white !important;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
                margin-bottom: 4%;
            }

            .gradient-button:hover {
                background: #a38241;
                color: white !important;
            }
            .call-to-action a:hover{
                color: white;
            }

            /* Custom Hero Layout */
            #hero {
                min-height: 100vh;
                display: flex;
                align-items: center;
                position: relative;
                background: url('https://images.unsplash.com/photo-1558981806-ec527fa84c39?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') no-repeat center center/cover !important;
                padding: 140px 0 60px 0;
            }
            .hero-overlay {
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, rgba(15,12,10,0.78) 0%, rgba(20,18,16,0.55) 60%, rgba(20,18,16,0.30) 100%);
                z-index: 2;
            }
            #hero .container { position: relative; z-index: 3; }

            /* Booking widget select/input */
            .booking-select, .booking-input {
                width: 100%;
                padding: 10px 12px;
                border: 1.5px solid #eee;
                border-radius: 8px;
                font-size: 14px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                color: #2b2824;
                outline: none;
                cursor: pointer;
                background: #fff;
                transition: border-color 0.2s;
            }
            .booking-select:focus, .booking-input:focus {
                border-color: #b59349;
                box-shadow: 0 0 0 3px rgba(181,147,73,0.12);
            }
            .booking-select { appearance: none; padding-right: 32px; }


            @media (max-width: 992px) {
                #heroBookingForm .booking-grid {
                    grid-template-columns: 1fr 1fr !important;
                }
                #heroBookingForm .booking-btn-col {
                    grid-column: 1 / -1;
                }
                #heroBookingForm .booking-btn-col button {
                    width: 100%;
                }
            }
            @media (max-width: 576px) {
                #hero { padding-top: 120px; }
                #heroBookingForm .booking-grid {
                    grid-template-columns: 1fr !important;
                }
                #hero h1 { font-size: 2.2rem !important; }
            }

            .hero-text-card {
                background: transparent !important;
                border: none !important;
                border-radius: 0 !important;
                padding: 0 !important;
                box-shadow: none !important;
                margin-bottom: 40px !important;
            }
            .hero-text-card h2 {
                color: #ffffff;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 800;
                font-size: 3.4rem;
                line-height: 1.25;
                margin-bottom: 20px;
                margin-top: 0;
                letter-spacing: -0.5px;
            }
            .hero-text-card h2 span {
                color: #b59349;
            }
            .hero-text-card .hero-desc {
                color: #eae6df !important;
                font-size: 1.15rem !important;
                margin-bottom: 30px !important;
                line-height: 1.7 !important;
                max-width: 520px;
            }
            .stats-item {
                background: transparent !important;
                border: none !important;
                border-radius: 0 !important;
                padding: 10px 0 10px 20px !important;
                box-shadow: none !important;
                text-align: left !important;
                border-left: 2px solid #b59349 !important;
                transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
            }
            .stats-item:hover {
                transform: translateX(5px);
                border-left-width: 4px !important;
            }
            .stats-item span {
                color: #1a1816 !important;
                font-size: 2.3rem !important;
                font-weight: 800 !important;
                line-height: 1 !important;
                display: block !important;
                margin-bottom: 6px !important;
            }
            .stats-item p {
                color: #b59349 !important;
                margin: 0 !important;
                font-size: 0.95rem !important;
                font-weight: 700 !important;
                text-transform: uppercase !important;
                letter-spacing: 0.5px !important;
            }

            .sidebar {
                height: 60%;
                width: 250px;
                background: linear-gradient(135deg, #111111, #222222);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                transform: translateX(300px);
                transition: transform 0.4s cubic-bezier(0.23, 1, 0.32, 1);
                position: fixed;
                top: 148px;
                bottom: 0px;
                right: 0;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                border-left: 2px solid #d4af37;
            }
            .sidebar-content {
                text-align: center;
                padding-left: 20px;
            }

            .sidebar-content p {
                margin-bottom: 20px;
                font-size: 1.1em;
                text-align: left;
            }

            .sidebar-content button {
                background: #d4af37;
                border: none;
                color: black;
                padding: 10px 20px;
                font-size: 1em;
                border-radius: 25px;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.3s ease;
                font-weight: 600;
            }

            .sidebar-content button:hover {
                background: #ffffff;
                transform: scale(1.05);
            }
            .sidebar-action {
                background: #d4af37;
                color: black;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                cursor: pointer;
                position: fixed;
                top: 50%;
                right: 10px;
                transform: translateY(-50%);
                transition: left 0.4s cubic-bezier(0.23, 1, 0.32, 1), background 0.3s ease;
                z-index: 1001;
            }

            .sidebar-action:hover {
                background-color: #ffffff;
            }

            .sidebar-action span {
                font-size: 24px;
                transition: transform 0.3s ease;
            }

            .sidebar-action .notification-dot {
                width: 10px;
                height: 10px;
                background-color: red;
                border-radius: 50%;
                position: absolute;
                top: 5px;
                right: 5px;
                box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);
            }
            .sidebar.open {
                transform: translateX(0);
            }

            .sidebar-action.open {
                right: 255px;
            }

            .sidebar-action.open span {
                transform: rotate(180deg);
            }
            
            @keyframes pulse {
                0% {
                    box-shadow: 0 0 0 0 rgba(212, 175, 55, 0.7);
                }
                70% {
                    box-shadow: 0 0 0 15px rgba(212, 175, 55, 0);
                }
                100% {
                    box-shadow: 0 0 0 0 rgba(212, 175, 55, 0);
                }
            }

            /* Enhanced dark overlays for call-to-action and testimonials for 100% text legibility */
            #call-to-action:before {
                background: rgba(0, 0, 0, 0.65) !important;
            }
            #call-to-action h3 {
                color: #ffffff !important;
                font-weight: 700 !important;
                font-family: 'Poppins', sans-serif !important;
            }
            #call-to-action p {
                color: rgba(255, 255, 255, 0.9) !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
            }
            #call-to-action .cta-btn {
                border: 2px solid #b59349 !important;
                color: #ffffff !important;
                background: #b59349 !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 600 !important;
                border-radius: 6px !important;
                transition: all 0.3s ease !important;
                box-shadow: 0 4px 15px rgba(181, 147, 73, 0.3) !important;
            }
            #call-to-action .cta-btn:hover {
                background: #a38241 !important;
                border-color: #a38241 !important;
                color: #ffffff !important;
                transform: translateY(-2px) !important;
            }

            .testimonials:before {
                background: rgba(0, 0, 0, 0.65) !important;
            }
            .testimonial-item h3 {
                color: #ffffff !important;
                font-weight: 700 !important;
                font-family: 'Poppins', sans-serif !important;
            }
            .testimonial-item h4 {
                color: rgba(255, 255, 255, 0.8) !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
            }
            .testimonial-item p {
                color: rgba(255, 255, 255, 0.95) !important;
                font-style: italic !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
            }
            /* ── Home FAQ ── */
            .home-faq-item {
                border-bottom: 1px dashed #ddd;
                padding: 18px 0;
                cursor: pointer;
            }
            .home-faq-q {
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 12px;
                font-size: 14.5px;
                font-weight: 500;
                color: #2b2824;
                line-height: 1.5;
                transition: color 0.2s;
            }
            .home-faq-item:hover .home-faq-q,
            .home-faq-item.open .home-faq-q { color: #b59349; }
            .home-faq-q i {
                flex-shrink: 0;
                font-size: 12px;
                color: #aaa;
                transition: transform 0.3s, color 0.2s;
            }
            .home-faq-item.open .home-faq-q i {
                transform: rotate(180deg);
                color: #b59349;
            }
            .home-faq-a {
                max-height: 0;
                overflow: hidden;
                font-size: 13.5px;
                color: #666;
                line-height: 1.7;
                transition: max-height 0.4s cubic-bezier(0.4,0,0.2,1), padding 0.3s;
            }
            .home-faq-item.open .home-faq-a {
                max-height: 200px;
                padding-top: 10px;
            }
            @media (max-width: 768px) {
                #faq-preview .container > div[style*="grid"] {
                    grid-template-columns: 1fr !important;
                }
            }
        </style>
    </head>

    <body class="index-page">

        <jsp:include page="/includes/customer/navbar.jsp" />

        <main class="main">

            <!-- Hero Section -->
            <section id="hero" class="hero section">
                <div class="hero-overlay"></div>
                <div class="container" style="position:relative; z-index:3;">
                    <!-- Left-aligned hero text -->
                    <div class="row">
                        <div class="col-lg-7" data-aos="fade-up">
                            <p style="color:rgba(255,255,255,0.75); font-size:1rem; font-weight:500; margin-bottom:4px; letter-spacing:1px;">Dịch vụ</p>
                            <h1 style="font-family:'Plus Jakarta Sans',sans-serif; font-weight:800; font-size:3.2rem; line-height:1.15; color:#fff; margin-bottom:16px;">
                                Thuê <span style="color:#b59349;">Xe Máy</span><br>Chuyên Nghiệp
                            </h1>
                            <p style="color:rgba(255,255,255,0.7); font-size:1rem; max-width:520px; line-height:1.7; margin-bottom:32px;">
                                Thấu hiểu cảm giác của người đi thuê xe máy – SmartRide cung cấp dịch vụ thuê xe uy tín, tiện lợi, tiên phong trở thành đơn vị số 1 tại Đà Nẵng.
                            </p>
                        </div>
                    </div>

                    <!-- Booking Widget Card -->
                    <div data-aos="fade-up" data-aos-delay="150">
                        <form id="heroBookingForm"
                              style="background:#fff; border-radius:16px; padding:24px 28px 20px; box-shadow:0 20px 60px rgba(0,0,0,0.25); max-width:960px;"
                              onsubmit="return heroFormSubmit(event)">

                            <!-- Datalist: Đà Nẵng addresses -->
                            <datalist id="dnLocations">
                                <option value="Ga Đà Nẵng – 791 Hải Phòng, Tam Thuận, Thanh Khê">
                                <option value="Sân bay Quốc tế Đà Nẵng – 132 Phan Đình Phùng, Chính Gián">
                                <option value="Bến xe Trung tâm – 33 Tôn Đức Thắng, Hải Châu">
                                <option value="Chợ Hàn – 119 Trần Phú, Hải Châu">
                                <option value="Vincom Plaza – 910A Ngô Quyền, Sơn Trà">
                                <option value="Cầu Rồng – Trần Hưng Đạo, Hải Châu">
                                <option value="Ngũ Hành Sơn – Huyền Trân Công Chúa, Ngũ Hành Sơn">
                                <option value="Bán đảo Sơn Trà – Hoàng Sa, Sơn Trà">
                                <option value="Đại học Bách Khoa – 54 Nguyễn Lương Bằng, Liên Chiểu">
                                <option value="Bệnh viện Đà Nẵng – 124 Hải Phòng, Hải Châu">
                                <option value="TTTM Lotte Mart – 6 Nại Nam, Hải Châu">
                                <option value="Phố đi bộ Bạch Đằng – Bạch Đằng, Hải Châu">
                            </datalist>

                            <div class="booking-grid" style="display:grid; grid-template-columns:1fr 1fr 1fr 1fr auto; gap:12px; align-items:end;">
                                <!-- Pickup Location -->
                                <div>
                                    <label style="font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:1px; color:#888; margin-bottom:6px; display:block;">
                                        <i class="fas fa-map-marker-alt" style="color:#b59349;"></i> Địa điểm nhận xe
                                    </label>
                                    <input type="text" name="location" id="heroPickupLoc"
                                           list="dnLocations"
                                           placeholder="Tìm hoặc nhập địa chỉ..."
                                           class="booking-input"
                                           autocomplete="off" />
                                </div>
                                <!-- Pickup Date -->
                                <div>
                                    <label style="font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:1px; color:#888; margin-bottom:6px; display:block;">
                                        <i class="fas fa-calendar-alt" style="color:#b59349;"></i> Ngày nhận xe
                                    </label>
                                    <input type="datetime-local" name="startDate" id="heroStartDate" class="booking-input" />
                                </div>
                                <!-- Return Location -->
                                <div>
                                    <label style="font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:1px; color:#888; margin-bottom:6px; display:block;">
                                        <i class="fas fa-map-marker-alt" style="color:#b59349;"></i> Địa điểm trả xe
                                    </label>
                                    <input type="text" name="returnLocation" id="heroReturnLoc"
                                           list="dnLocations"
                                           placeholder="Tìm hoặc nhập địa chỉ..."
                                           class="booking-input"
                                           autocomplete="off" />
                                </div>
                                <!-- Return Date -->
                                <div>
                                    <label style="font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:1px; color:#888; margin-bottom:6px; display:block;">
                                        <i class="fas fa-calendar-alt" style="color:#b59349;"></i> Ngày trả xe
                                    </label>
                                    <input type="datetime-local" name="endDate" id="heroEndDate" class="booking-input" />
                                </div>
                                <!-- CTA Button -->
                                <div class="booking-btn-col">
                                    <button type="submit"
                                            style="background:#b59349; color:#fff; border:none; padding:11px 28px; border-radius:8px; font-weight:700; font-size:14px; font-family:'Plus Jakarta Sans',sans-serif; letter-spacing:0.5px; cursor:pointer; white-space:nowrap; transition:all 0.3s; box-shadow:0 4px 15px rgba(181,147,73,0.4);"
                                            onmouseover="this.style.background='#a38241'" onmouseout="this.style.background='#b59349'">
                                        Đặt xe ngay
                                    </button>
                                </div>
                            </div>
                            <!-- Same location checkbox & Error Message -->
                            <div style="margin-top:12px; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:10px;">
                                <label style="display:inline-flex; align-items:center; gap:8px; font-size:13px; color:#666; cursor:pointer;">
                                    <input type="checkbox" id="sameLocationCheck"
                                           style="accent-color:#b59349; width:15px; height:15px; cursor:pointer;"
                                           onchange="toggleReturnLocation(this)" />
                                    Nhận, trả xe cùng địa điểm
                                </label>
                                <div id="heroErrorMsg" style="color: #dc3545; font-size: 13.5px; font-weight: 600; display: none; background: #fff8f8; padding: 4px 12px; border-radius: 4px; border: 1px solid #ffcdcd;">
                                    <i class="fas fa-exclamation-circle" style="margin-right:4px;"></i> <span></span>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>

                <c:if test="${not empty sessionScope.account}">
                    <div class="follow-container">
                        <div class="sidebar" id="sidebar">
                            <div class="sidebar-content">
                                <c:choose>
                                    <c:when test="${not empty requestScope.book && statusBooking != 'Đã hủy'}">
                                        <p>Cảm ơn bạn đã sử dụng dịch vụ của <span><strong>SmartRide</strong></span>, hãy bấm vào đây để theo dõi nhanh đơn hàng của mình nhé!</p>
                                        <a href="bookingHistoryDetail?bookingId=${requestScope.book.bookingID}">
                                            <button>Theo dõi đơn hàng</button>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <p>Chào mừng bạn đến với <span><strong>SmartRide</strong></span>! Khám phá và quản lý lịch sử đặt xe của bạn tại đây.</p>
                                        <a href="bookingHistory?status=all">
                                            <button>Quản lý đơn hàng</button>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div onclick="SidebarAction()" class="sidebar-action" id="sidebarAction">
                            <span class="arrow-icon"><i class="bi bi-play-fill"></i></span>
                            <div class="notification-dot"></div>
                        </div>
                    </div>
                </c:if>
            </section><!-- /Hero Section -->

            <!-- SMART ASSISTANT BANNER (HOME) -->
            <section style="background-color: #fafafa; padding: 60px 0;">
                <div class="container">
                    <div style="background: linear-gradient(135deg, #1a1816 0%, #362f27 100%); border-radius: 24px; padding: 40px; color: white; box-shadow: 0 20px 40px rgba(0,0,0,0.15); position: relative; overflow: hidden;" data-aos="fade-up">
                        <!-- Decorative circle -->
                        <div style="position: absolute; top: -50px; right: -50px; width: 200px; height: 200px; background: radial-gradient(circle, rgba(181,147,73,0.3) 0%, rgba(255,255,255,0) 70%); border-radius: 50%;"></div>
                        
                        <div class="row align-items-center position-relative" style="z-index: 1;">
                            <div class="col-lg-6 mb-4 mb-lg-0">
                                <h3 style="font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800; font-size: 2rem; margin-bottom: 15px; color: #b59349;">
                                    <i class="bi bi-stars"></i> Trợ Lý SmartRide
                                </h3>
                                <p style="font-size: 1.1rem; color: #e0e0e0; margin-bottom: 0;">Bạn dự định khám phá những địa điểm tuyệt đẹp nào tại Đà Nẵng? Hệ thống sẽ gợi ý cho bạn chiếc xe hoàn hảo nhất!</p>
                            </div>
                            <div class="col-lg-6">
                                <form action="searchCriteria" method="get" onsubmit="return handleSmartSearch(event, this)">
                                    <div class="d-flex gap-2">
                                        <div class="flex-grow-1 position-relative">
                                            <i class="bi bi-geo-alt position-absolute" style="left: 15px; top: 50%; transform: translateY(-50%); color: #b59349; font-size: 1.2rem; pointer-events: none;"></i>
                                            <select name="locations" class="form-select form-select-lg" style="border-radius: 12px; border: none; background: #ffffff; color: #1a1816; font-weight: 500; font-family: 'Plus Jakarta Sans', sans-serif; box-shadow: 0 5px 15px rgba(0,0,0,0.1); cursor: pointer; padding-left: 45px; height: 56px;" required>
                                                <option value="" selected disabled>-- Chọn điểm đến của bạn --</option>
                                                <c:forEach items="${listLocations}" var="loc">
                                                    <option value="${loc.locationId}">${loc.locationName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn" style="background: #b59349; color: white; border-radius: 12px; font-weight: 700; padding: 0 30px; height: 56px; white-space: nowrap; font-family: 'Plus Jakarta Sans', sans-serif; box-shadow: 0 5px 15px rgba(181,147,73,0.4); transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)';" onmouseout="this.style.transform='translateY(0)';">
                                            Tìm xe <i class="bi bi-magic ms-1"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <script>
            function handleSmartSearch(e, form) {
                e.preventDefault();
                
                const btn = form.querySelector('button');
                btn.disabled = true;
                btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang xử lý...';
                
                setTimeout(() => {
                    form.submit();
                }, 1000);
            }
            </script>

            <!-- Featured Services Section (Premium Light Theme) -->
            <style>
                .featured-premium-section {
                    background: linear-gradient(135deg, #fdfcfb 0%, #f4f0e6 100%);
                    padding: 100px 0;
                    position: relative;
                    overflow: hidden;
                    color: #1a1a1a;
                }
                .featured-bg-glow {
                    position: absolute;
                    top: -10%; left: -10%;
                    width: 40%; height: 40%;
                    background: radial-gradient(circle, rgba(196, 161, 75, 0.12) 0%, rgba(196, 161, 75, 0) 70%);
                    border-radius: 50%;
                    z-index: 1;
                }
                .featured-bg-glow-2 {
                    position: absolute;
                    bottom: -10%; right: -10%;
                    width: 50%; height: 50%;
                    background: radial-gradient(circle, rgba(196, 161, 75, 0.08) 0%, rgba(196, 161, 75, 0) 70%);
                    border-radius: 50%;
                    z-index: 1;
                }
                .featured-card-premium {
                    background: #ffffff;
                    border: 1px solid rgba(196, 161, 75, 0.15);
                    box-shadow: 0 10px 40px rgba(0,0,0,0.03);
                    padding: 45px 35px;
                    border-radius: 20px;
                    height: 100%;
                    transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                    position: relative;
                    z-index: 2;
                    overflow: hidden;
                }
                .featured-card-premium::before {
                    content: '';
                    position: absolute;
                    top: 0; left: 0; right: 0; bottom: 0;
                    border-radius: 20px;
                    padding: 2px;
                    background: linear-gradient(135deg, rgba(196, 161, 75, 0.4), rgba(196, 161, 75, 0));
                    -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                    -webkit-mask-composite: xor;
                    mask-composite: exclude;
                    opacity: 0;
                    transition: opacity 0.4s ease;
                }
                .featured-card-premium:hover {
                    transform: translateY(-10px);
                    box-shadow: 0 20px 40px rgba(196, 161, 75, 0.15);
                    border-color: rgba(196, 161, 75, 0.3);
                }
                .featured-card-premium:hover::before {
                    opacity: 1;
                }
                .featured-icon-box {
                    width: 70px;
                    height: 70px;
                    border-radius: 16px;
                    background: rgba(196, 161, 75, 0.08);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    margin-bottom: 30px;
                    border: 1px solid rgba(196, 161, 75, 0.15);
                    transition: all 0.4s ease;
                }
                .featured-card-premium:hover .featured-icon-box {
                    background: linear-gradient(135deg, #c4a14b, #b59349);
                    transform: scale(1.1) rotate(5deg);
                    box-shadow: 0 10px 20px rgba(196, 161, 75, 0.3);
                }
                .featured-card-premium:hover .featured-icon-box i {
                    color: #ffffff !important;
                }
                .featured-card-premium h4 {
                    font-family: 'Times New Roman', serif;
                    font-size: 24px;
                    font-weight: 700;
                    color: #1a1a1a;
                    margin-bottom: 15px;
                    letter-spacing: 0.5px;
                }
                .featured-card-premium p {
                    color: #666666;
                    font-size: 15px;
                    line-height: 1.8;
                    margin: 0;
                    font-family: 'Plus Jakarta Sans', sans-serif;
                }
            </style>
            <section id="featured-services" class="featured-premium-section section">
                <div class="featured-bg-glow"></div>
                <div class="featured-bg-glow-2"></div>
                <div class="container" style="position: relative; z-index: 2;">
                    
                    <div class="text-center" style="margin-bottom: 70px;" data-aos="fade-up">
                        <div style="display: inline-flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                            <div style="height: 1px; width: 40px; background: rgba(196, 161, 75, 0.5);"></div>
                            <span style="color: #c4a14b; font-size: 13px; font-weight: 800; letter-spacing: 4px; text-transform: uppercase; font-family: 'Plus Jakarta Sans', sans-serif;">Dịch vụ nổi bật</span>
                            <div style="height: 1px; width: 40px; background: rgba(196, 161, 75, 0.5);"></div>
                        </div>
                        <h2 style="font-family: 'Times New Roman', serif; font-size: 46px; font-weight: 800; color: #1a1a1a; margin: 0 0 25px 0; text-transform: uppercase; letter-spacing: 1px;">
                            VÌ SAO CHỌN CHÚNG TÔI
                        </h2>
                        <p style="color: #666666; max-width: 750px; margin: 0 auto; font-size: 16px; line-height: 1.9;">
                            Sắc màu hành trình, chọn chúng tôi để khởi đầu một trải nghiệm thuê xe máy hoàn hảo và đáng nhớ nhất tại Đà Nẵng. Chất lượng, an toàn và dịch vụ tận tâm là cam kết hàng đầu.
                        </p>
                    </div>

                    <div class="row gy-4 justify-content-center">
                        <!-- Item 1 -->
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                            <div class="featured-card-premium">
                                <div class="featured-icon-box">
                                    <i class="fa-solid fa-motorcycle" style="color: #c4a14b; font-size: 30px; transition: color 0.4s ease;"></i>
                                </div>
                                <h4>Lựa chọn đa dạng</h4>
                                <p>Hàng trăm loại xe đa dạng ở nhiều địa điểm tại Đà Nẵng, phù hợp với mọi mục đích của bạn.</p>
                            </div>
                        </div>
                        <!-- Item 2 -->
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                            <div class="featured-card-premium">
                                <div class="featured-icon-box">
                                    <i class="fa-solid fa-location-dot" style="color: #c4a14b; font-size: 30px; transition: color 0.4s ease;"></i>
                                </div>
                                <h4>Thuận lợi</h4>
                                <p>Dễ dàng tìm kiếm, so sánh và đặt xe máy bạn muốn chỉ với vài cú nhấp chuột.</p>
                            </div>
                        </div>
                        <!-- Item 3 -->
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                            <div class="featured-card-premium">
                                <div class="featured-icon-box">
                                    <i class="fa-solid fa-tags" style="color: #c4a14b; font-size: 30px; transition: color 0.4s ease;"></i>
                                </div>
                                <h4>Giá cả cạnh tranh</h4>
                                <p>Giá thuê được niêm yết công khai và rẻ hơn tới 10% so với giá truyền thống.</p>
                            </div>
                        </div>
                        <!-- Item 4 -->
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                            <div class="featured-card-premium">
                                <div class="featured-icon-box">
                                    <i class="fa-solid fa-shield-halved" style="color: #c4a14b; font-size: 30px; transition: color 0.4s ease;"></i>
                                </div>
                                <h4>Đáng tin cậy</h4>
                                <p>Tất cả các xe đều có tuổi thọ dưới 3 năm và được bảo dưỡng định kỳ cực kỳ khắt khe.</p>
                            </div>
                        </div>
                        <!-- Item 5 -->
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                            <div class="featured-card-premium">
                                <div class="featured-icon-box">
                                    <i class="fa-solid fa-headset" style="color: #c4a14b; font-size: 30px; transition: color 0.4s ease;"></i>
                                </div>
                                <h4>Dịch vụ hỗ trợ 24/7</h4>
                                <p>Có đội ngũ nhân viên kỹ thuật hỗ trợ khách hàng trong suốt quá trình thuê xe, kể cả nửa đêm.</p>
                            </div>
                        </div>
                        <!-- Item 6 -->
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                            <div class="featured-card-premium">
                                <div class="featured-icon-box">
                                    <i class="fa-regular fa-clock" style="color: #c4a14b; font-size: 30px; transition: color 0.4s ease;"></i>
                                </div>
                                <h4>Thời gian linh hoạt</h4>
                                <p>Bạn có thể đặt xe máy trong bất kỳ khoảng thời gian nào và gia hạn trực tuyến rất nhanh chóng.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section><!-- /Featured Services Section -->


            <hr style="border: 0; height: 1px; background: #eaeaea; margin: 0; padding: 0;">
            <div class="container-fluid" style="background: linear-gradient(to bottom, #fcfcfc, #ffffff); padding: 90px 0 30px 0; position: relative; overflow: hidden;">
                <!-- Decorative background elements -->
                <div style="position: absolute; top: -50px; left: -50px; width: 300px; height: 300px; background: radial-gradient(circle, rgba(196, 161, 75, 0.05) 0%, rgba(255,255,255,0) 70%); border-radius: 50%;"></div>
                <div style="position: absolute; bottom: 0; right: -100px; width: 400px; height: 400px; background: radial-gradient(circle, rgba(196, 161, 75, 0.03) 0%, rgba(255,255,255,0) 70%); border-radius: 50%;"></div>

                <div class="container text-center" data-aos="fade-up" style="position: relative; z-index: 2;">
                    <div style="display: inline-flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                        <div style="height: 1px; width: 40px; background: #c4a14b;"></div>
                        <span style="color: #c4a14b; font-size: 13px; font-weight: 800; letter-spacing: 4px; text-transform: uppercase; font-family: 'Plus Jakarta Sans', sans-serif;">Bộ sưu tập xe</span>
                        <div style="height: 1px; width: 40px; background: #c4a14b;"></div>
                    </div>
                    
                    <h2 style="font-family: 'Times New Roman', serif; font-size: 46px; font-weight: 800; color: #1a1a1a; margin: 0 0 25px 0; text-transform: uppercase; letter-spacing: 1px;">
                        DANH MỤC XE MÁY
                    </h2>
                    
                    <div style="position: relative; max-width: 850px; margin: 0 auto;">
                        <i class="fa-solid fa-quote-left" style="color: rgba(196, 161, 75, 0.15); font-size: 32px; position: absolute; left: 0; top: -10px;"></i>
                        <p style="font-size: 16px; color: #555; margin: 0 auto; line-height: 1.9; padding: 0 45px; position: relative; z-index: 2;">
                            Toàn bộ xe máy tại <strong style="color: #b59349; font-weight: 700;">SmartRide</strong> đều là xe mới 100%, được mua mới và đăng ký chính chủ. Sau mỗi hợp đồng thuê, xe sẽ được kiểm tra toàn diện và bảo dưỡng định kỳ, đảm bảo tiêu chuẩn an toàn kỹ thuật cao nhất trước khi bàn giao.
                        </p>
                        <i class="fa-solid fa-quote-right" style="color: rgba(196, 161, 75, 0.15); font-size: 32px; position: absolute; right: 0; bottom: -10px;"></i>
                    </div>

                    <!-- Quick feature badges -->
                    <div style="display: flex; justify-content: center; gap: 25px; margin-top: 40px; flex-wrap: wrap;">
                        <div style="display: flex; align-items: center; gap: 12px; background: #fff; padding: 10px 25px; border-radius: 50px; box-shadow: 0 5px 20px rgba(0,0,0,0.04); border: 1px solid rgba(196, 161, 75, 0.1); transition: transform 0.3s;" onmouseover="this.style.transform='translateY(-3px)'" onmouseout="this.style.transform='translateY(0)'">
                            <div style="width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, rgba(196, 161, 75, 0.15), rgba(196, 161, 75, 0.05)); display: flex; align-items: center; justify-content: center; color: #b59349; font-size: 16px;">
                                <i class="fa-solid fa-motorcycle"></i>
                            </div>
                            <span style="font-weight: 700; font-size: 14.5px; color: #222;">Đa dạng dòng xe</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 12px; background: #fff; padding: 10px 25px; border-radius: 50px; box-shadow: 0 5px 20px rgba(0,0,0,0.04); border: 1px solid rgba(196, 161, 75, 0.1); transition: transform 0.3s;" onmouseover="this.style.transform='translateY(-3px)'" onmouseout="this.style.transform='translateY(0)'">
                            <div style="width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, rgba(196, 161, 75, 0.15), rgba(196, 161, 75, 0.05)); display: flex; align-items: center; justify-content: center; color: #b59349; font-size: 16px;">
                                <i class="fa-solid fa-shield-halved"></i>
                            </div>
                            <span style="font-weight: 700; font-size: 14.5px; color: #222;">Bảo dưỡng định kỳ</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 12px; background: #fff; padding: 10px 25px; border-radius: 50px; box-shadow: 0 5px 20px rgba(0,0,0,0.04); border: 1px solid rgba(196, 161, 75, 0.1); transition: transform 0.3s;" onmouseover="this.style.transform='translateY(-3px)'" onmouseout="this.style.transform='translateY(0)'">
                            <div style="width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, rgba(196, 161, 75, 0.15), rgba(196, 161, 75, 0.05)); display: flex; align-items: center; justify-content: center; color: #b59349; font-size: 16px;">
                                <i class="fa-solid fa-headset"></i>
                            </div>
                            <span style="font-weight: 700; font-size: 14.5px; color: #222;">Hỗ trợ 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
            <iframe src="slide.jsp" style="width: 100%; height: 720px; padding: 0; margin: 0; border: none; overflow: hidden;" scrolling="no"></iframe>

            <!-- Link to Pricing Page -->
            <div style="background-color: #fcfcfc; padding: 40px 0 60px 0; text-align: center;">
                <div class="container" data-aos="fade-up">
                    <a href="pricing" style="display:inline-flex; align-items:center; gap:12px; background:linear-gradient(135deg, #b59349, #a38241); color:#fff; font-family:'Plus Jakarta Sans',sans-serif; font-weight:700; font-size:16px; text-transform:uppercase; letter-spacing:1px; padding:16px 45px; border-radius:50px; text-decoration:none; box-shadow:0 10px 30px rgba(181, 147, 73, 0.3); transition:all 0.3s ease;">
                        Xem Chi Tiết Bảng Giá <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>

            <!-- Call To Action Section -->
            <section id="call-to-action" class="call-to-action section">

                <img src="assets/img/cta-bg.jpg" alt>

                <div class="container">
                    <div class="row justify-content-center" data-aos="zoom-in"
                         data-aos-delay="100">
                        <div class="col-xl-10">
                            <div class="text-center">
                                <h3>Khám phá tự do với chuyến đi của bạn.</h3>
                                <p>Khám phá vào một cuộc phiêu lưu mới cùng với
                                    chúng tôi. Đặt xe của bạn ngay hôm nay và tận hưởng sự tự do
                                    không giới hạn trên mọi con đường.</p>
                                <a class="cta-btn" href="motorcycle">THUÊ XE NGAY</a>
                            </div>
                        </div>
                    </div>
                </div>

            </section><!-- /Call To Action Section -->

            <!-- About Section -->
            <hr style="border: 0; height: 1px; background: #eaeaea; margin: 0; padding: 0;">
            <style>
                .about-section-premium {
                    padding: 100px 0;
                    background: linear-gradient(to bottom, #ffffff, #fdfcf9);
                    position: relative;
                }
                .about-card-premium {
                    background: #ffffff;
                    padding: 50px 40px;
                    border-radius: 24px;
                    box-shadow: 0 10px 40px rgba(0,0,0,0.03);
                    border: 1px solid rgba(196, 161, 75, 0.1);
                    height: 100%;
                    transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                    position: relative;
                    overflow: hidden;
                    z-index: 1;
                }
                .about-card-premium::before {
                    content: '';
                    position: absolute;
                    top: 0; left: 0; right: 0;
                    height: 4px;
                    background: linear-gradient(90deg, #c4a14b, #b59349);
                    transform: scaleX(0);
                    transform-origin: left;
                    transition: transform 0.4s ease;
                    z-index: 2;
                }
                .about-card-premium:hover {
                    transform: translateY(-10px);
                    box-shadow: 0 20px 50px rgba(181, 147, 73, 0.12);
                    border-color: rgba(181, 147, 73, 0.3);
                }
                .about-card-premium:hover::before {
                    transform: scaleX(1);
                }
                .about-icon-wrapper {
                    width: 70px;
                    height: 70px;
                    background: linear-gradient(135deg, rgba(196, 161, 75, 0.15), rgba(196, 161, 75, 0.05));
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin-bottom: 30px;
                    transition: all 0.4s ease;
                }
                .about-card-premium:hover .about-icon-wrapper {
                    background: linear-gradient(135deg, #c4a14b, #b59349);
                }
                .about-card-premium:hover .about-icon-wrapper i {
                    color: #ffffff !important;
                    transform: scale(1.1);
                }
                .about-card-premium h4 {
                    font-family: 'Times New Roman', serif;
                    font-size: 24px;
                    font-weight: 800;
                    color: #1a1a1a;
                    margin-bottom: 20px;
                }
                .about-card-premium p {
                    color: #555;
                    font-size: 15px;
                    line-height: 1.8;
                    margin: 0;
                }
            </style>
            <section id="about" class="about-section-premium section">
                <div class="container" style="position: relative; z-index: 2;">
                    
                    <!-- Elegant Header -->
                    <div class="text-center" style="margin-bottom: 70px;" data-aos="fade-up">
                        <div style="display: inline-flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                            <div style="height: 1px; width: 40px; background: #c4a14b;"></div>
                            <span style="color: #c4a14b; font-size: 13px; font-weight: 800; letter-spacing: 4px; text-transform: uppercase; font-family: 'Plus Jakarta Sans', sans-serif;">Cam kết của chúng tôi</span>
                            <div style="height: 1px; width: 40px; background: #c4a14b;"></div>
                        </div>
                        <h2 style="font-family: 'Times New Roman', serif; font-size: 46px; font-weight: 800; color: #1a1a1a; margin: 0 0 25px 0; text-transform: uppercase; letter-spacing: 1px;">
                            Về SmartRide
                        </h2>
                        <div style="position: relative; max-width: 800px; margin: 0 auto;">
                            <i class="fa-solid fa-quote-left" style="color: rgba(196, 161, 75, 0.15); font-size: 32px; position: absolute; left: 0; top: -10px;"></i>
                            <p style="font-size: 16px; color: #555; margin: 0 auto; line-height: 1.9; padding: 0 45px; position: relative; z-index: 2;">
                                Chúng tôi là đối tác lý tưởng của bạn trong mọi chuyến đi bằng xe máy tại Đà Nẵng. Với sứ mệnh mang đến sự thuận tiện và trải nghiệm đáng nhớ, chúng tôi cung cấp dịch vụ cho thuê xe máy với đội ngũ phương tiện đa dạng và chất lượng hàng đầu.
                            </p>
                            <i class="fa-solid fa-quote-right" style="color: rgba(196, 161, 75, 0.15); font-size: 32px; position: absolute; right: 0; bottom: -10px;"></i>
                        </div>
                    </div>

                    <!-- Cards Row -->
                    <div class="row gy-4 justify-content-center mb-5 pb-4" data-aos="fade-up" data-aos-delay="100">
                        <!-- Card 1 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="about-card-premium">
                                <div class="about-icon-wrapper">
                                    <i class="fa-solid fa-motorcycle" style="color: #b59349; font-size: 28px; transition: all 0.3s ease;"></i>
                                </div>
                                <h4>Đa dạng sản phẩm</h4>
                                <p>Từ các loại xe máy tiện dụng đến những mẫu xe cao cấp, chúng tôi luôn có sự lựa chọn phù hợp với nhu cầu của bạn để mang lại trải nghiệm tối ưu nhất.</p>
                            </div>
                        </div>
                        <!-- Card 2 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="about-card-premium">
                                <div class="about-icon-wrapper">
                                    <i class="fa-solid fa-user-tie" style="color: #b59349; font-size: 28px; transition: all 0.3s ease;"></i>
                                </div>
                                <h4>Dịch vụ chuyên nghiệp</h4>
                                <p>Đội ngũ nhân viên tận tâm sẵn sàng phục vụ, từ việc tư vấn lộ trình cho đến hỗ trợ kỹ thuật 24/7, đảm bảo chuyến đi của bạn luôn suôn sẻ và an toàn.</p>
                            </div>
                        </div>
                        <!-- Card 3 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="about-card-premium">
                                <div class="about-icon-wrapper">
                                    <i class="fa-solid fa-medal" style="color: #b59349; font-size: 28px; transition: all 0.3s ease;"></i>
                                </div>
                                <h4>Chất lượng cao cấp</h4>
                                <p>Tất cả xe đều được bảo dưỡng định kỳ và kiểm tra kỹ lưỡng trước khi bàn giao. Bạn hoàn toàn có thể yên tâm về sự an toàn và tin cậy trên mọi cung đường.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Tourist Locations (Inspired by User Reference) -->
                    <style>
                        .loc-card-wrap { text-decoration: none; display: block; }
                        .loc-card { position: relative; border-radius: 12px; overflow: hidden; height: 380px; box-shadow: 0 8px 25px rgba(0,0,0,0.06); transition: all 0.4s ease; }
                        .loc-card img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.7s ease; }
                        .loc-card-wrap:hover .loc-card img { transform: scale(1.08); }
                        .loc-card-wrap:hover .loc-card { box-shadow: 0 15px 35px rgba(0,0,0,0.12); transform: translateY(-5px); }
                        .loc-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.85) 0%, rgba(0,0,0,0.2) 50%, rgba(0,0,0,0) 100%); display: flex; flex-direction: column; justify-content: flex-end; padding: 25px 20px; color: #fff; }
                        .loc-title { font-family: 'Plus Jakarta Sans', sans-serif; font-size: 20px; font-weight: 800; margin-bottom: 6px; text-shadow: 0 2px 5px rgba(0,0,0,0.5); color: #fff; letter-spacing: 0.5px; }
                        .loc-desc { font-size: 13.5px; color: rgba(255,255,255,0.85); margin: 0; font-weight: 500; }
                    </style>
                    <div class="mb-5 pb-5" data-aos="fade-up" data-aos-delay="200">
                        <div class="d-flex justify-content-between align-items-end mb-4">
                            <h2 style="font-family: 'Plus Jakarta Sans', sans-serif; font-size: 24px; font-weight: 800; color: #1a1a1a; margin: 0; text-transform: uppercase;">ĐỊA ĐIỂM DU LỊCH</h2>
                            <a href="touristLocation" style="color: #c4a14b; font-weight: 700; font-size: 14px; text-decoration: none; text-transform: uppercase; letter-spacing: 1px;">Xem Tất Cả <i class="fa-solid fa-arrow-right ms-1"></i></a>
                        </div>
                        <div class="row row-cols-1 row-cols-md-3 row-cols-lg-5 g-3">
                            <c:forEach items="${listLocations}" var="loc" begin="0" end="4">
                                <div class="col">
                                    <a href="touristLocation" class="loc-card-wrap">
                                        <div class="loc-card">
                                            <img src="${empty loc.locationImage ? 'images/default.jpg' : (loc.locationImage.startsWith('http') ? loc.locationImage : 'images/'.concat(loc.locationImage))}?t=<%= System.currentTimeMillis() %>" onerror="this.src='assets/img/about.jpg'" alt="${loc.locationName}">
                                            <div class="loc-overlay">
                                                <h4 class="loc-title">${loc.locationName}</h4>
                                                <p class="loc-desc" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: 0;">${loc.description}</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Sleek Premium Full-width Horizontal Stats Row -->
                    <style>
                        .stats-premium-wrap {
                            background: linear-gradient(135deg, #111111 0%, #1a1a1a 100%);
                            border-radius: 20px;
                            padding: 60px 40px;
                            box-shadow: 0 30px 60px rgba(0,0,0,0.15);
                            position: relative;
                            overflow: hidden;
                            margin: 60px 0;
                            border: 1px solid rgba(196, 161, 75, 0.15);
                        }
                        .stats-glow {
                            position: absolute;
                            top: 50%; left: 50%;
                            transform: translate(-50%, -50%);
                            width: 100%; height: 100%;
                            background: radial-gradient(circle, rgba(196, 161, 75, 0.1) 0%, rgba(196, 161, 75, 0) 60%);
                            pointer-events: none;
                        }
                        .stat-item-premium {
                            text-align: center;
                            position: relative;
                            z-index: 2;
                        }
                        .stat-icon-wrap {
                            width: 65px; height: 65px;
                            background: rgba(196, 161, 75, 0.1);
                            border-radius: 50%;
                            display: flex; justify-content: center; align-items: center;
                            margin: 0 auto 20px;
                            border: 1px solid rgba(196, 161, 75, 0.2);
                        }
                        .stat-number {
                            font-size: 3.5rem;
                            font-weight: 700;
                            font-family: 'Times New Roman', serif;
                            background: linear-gradient(to right, #ffffff, #c4a14b);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            line-height: 1;
                            margin-bottom: 10px;
                        }
                        .stat-number span {
                            font-size: 2rem;
                            color: #c4a14b;
                            -webkit-text-fill-color: #c4a14b;
                            vertical-align: top;
                        }
                        .stat-label {
                            font-size: 0.85rem;
                            font-weight: 800;
                            color: #a0a0a0;
                            text-transform: uppercase;
                            letter-spacing: 3px;
                            font-family: 'Plus Jakarta Sans', sans-serif;
                        }
                        .stat-divider {
                            position: absolute;
                            right: 0; top: 15%; height: 70%; width: 1px;
                            background: linear-gradient(to bottom, rgba(196,161,75,0), rgba(196,161,75,0.3), rgba(196,161,75,0));
                        }
                    </style>
                    <div class="stats-premium-wrap" data-aos="fade-up" data-aos-delay="150">
                        <div class="stats-glow"></div>
                        <div class="row position-relative z-2">
                            <div class="col-lg-3 col-md-6 mb-5 mb-lg-0 position-relative">
                                <div class="stat-item-premium">
                                    <div class="stat-icon-wrap"><i class="fa-solid fa-users" style="font-size: 26px; color: #c4a14b;"></i></div>
                                    <div class="stat-number">2,324<span>+</span></div>
                                    <div class="stat-label">Khách Hàng</div>
                                </div>
                                <div class="d-none d-lg-block stat-divider"></div>
                            </div>
                            <div class="col-lg-3 col-md-6 mb-5 mb-lg-0 position-relative">
                                <div class="stat-item-premium">
                                    <div class="stat-icon-wrap"><i class="fa-solid fa-calendar-check" style="font-size: 26px; color: #c4a14b;"></i></div>
                                    <div class="stat-number">20<span>+</span></div>
                                    <div class="stat-label">Năm Hoạt Động</div>
                                </div>
                                <div class="d-none d-lg-block stat-divider"></div>
                            </div>
                            <div class="col-lg-3 col-md-6 mb-5 mb-md-0 position-relative">
                                <div class="stat-item-premium">
                                    <div class="stat-icon-wrap"><i class="fa-solid fa-handshake" style="font-size: 26px; color: #c4a14b;"></i></div>
                                    <div class="stat-number">55<span>+</span></div>
                                    <div class="stat-label">Đối Tác</div>
                                </div>
                                <div class="d-none d-lg-block stat-divider"></div>
                            </div>
                            <div class="col-lg-3 col-md-6 position-relative">
                                <div class="stat-item-premium">
                                    <div class="stat-icon-wrap"><i class="fa-solid fa-user-tie" style="font-size: 26px; color: #c4a14b;"></i></div>
                                    <div class="stat-number">150<span>+</span></div>
                                    <div class="stat-label">Nhân Viên</div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </section><!-- /About Section -->

            <!-- Services Section -->

            <!-- ══ FAQ Premium Section ══ -->
            <style>
                .faq-premium-section {
                    padding: 100px 0;
                    background: linear-gradient(to bottom, #ffffff, #fcfcfc);
                    position: relative;
                }
                .faq-bg-pattern {
                    position: absolute; top: 0; left: 0; width: 100%; height: 100%;
                    background-image: radial-gradient(#c4a14b 1px, transparent 1px);
                    background-size: 40px 40px; opacity: 0.03; pointer-events: none;
                }
                .faq-premium-container {
                    max-width: 1100px;
                    margin: 0 auto;
                    position: relative; z-index: 2;
                }
                .faq-item-premium {
                    background: #ffffff;
                    border: 1px solid rgba(0,0,0,0.05);
                    border-radius: 12px;
                    margin-bottom: 15px;
                    box-shadow: 0 4px 15px rgba(0,0,0,0.02);
                    transition: all 0.3s ease;
                    overflow: hidden;
                    height: 100%;
                }
                .faq-item-premium:hover {
                    box-shadow: 0 10px 30px rgba(0,0,0,0.06);
                    border-color: rgba(196, 161, 75, 0.3);
                }
                .faq-q-premium {
                    padding: 22px 30px;
                    cursor: pointer;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    font-family: 'Plus Jakarta Sans', sans-serif;
                    font-weight: 700;
                    font-size: 16px;
                    color: #1a1a1a;
                    transition: all 0.3s ease;
                }
                .faq-item-premium.open .faq-q-premium {
                    color: #b59349;
                    background: rgba(196, 161, 75, 0.02);
                }
                .faq-icon-wrapper {
                    width: 30px; height: 30px;
                    border-radius: 50%;
                    background: #f5f5f5;
                    display: flex; justify-content: center; align-items: center;
                    transition: all 0.3s ease;
                    flex-shrink: 0;
                    margin-left: 15px;
                }
                .faq-item-premium.open .faq-icon-wrapper {
                    background: #b59349;
                    transform: rotate(180deg);
                }
                .faq-icon-wrapper i {
                    color: #888; font-size: 12px; transition: color 0.3s ease;
                }
                .faq-item-premium.open .faq-icon-wrapper i {
                    color: #fff;
                }
                .faq-a-premium {
                    max-height: 0;
                    opacity: 0;
                    overflow: hidden;
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                    padding: 0 30px;
                    color: #666;
                    font-size: 15px;
                    line-height: 1.7;
                    border-top: 1px solid transparent;
                }
                .faq-item-premium.open .faq-a-premium {
                    max-height: 300px;
                    opacity: 1;
                    padding: 0 30px 25px 30px;
                    border-top-color: rgba(0,0,0,0.03);
                    margin-top: 15px;
                }
            </style>
            <section id="faq-preview" class="faq-premium-section">
                <div class="faq-bg-pattern"></div>
                <div class="container faq-premium-container">
                    <!-- Header -->
                    <div style="text-align:center; margin-bottom: 60px;" data-aos="fade-up">
                        <div style="display: inline-flex; align-items: center; gap: 12px; margin-bottom: 15px;">
                            <div style="height: 1px; width: 30px; background: rgba(196, 161, 75, 0.5);"></div>
                            <span style="font-family:'Plus Jakarta Sans',sans-serif; font-size:13px; font-weight:800; letter-spacing:4px; text-transform:uppercase; color:#c4a14b;">Giải đáp thắc mắc</span>
                            <div style="height: 1px; width: 30px; background: rgba(196, 161, 75, 0.5);"></div>
                        </div>
                        <h2 style="font-family:'Times New Roman', serif; font-weight:800; font-size:46px; color:#1a1a1a; margin:0; text-transform:uppercase;">Câu Hỏi Thường Gặp</h2>
                        <p style="color:#666; font-size:16px; margin-top:20px; max-width: 600px; margin-left: auto; margin-right: auto;">Tìm câu trả lời nhanh cho những thắc mắc phổ biến nhất khi bạn thuê xe máy tại SmartRide</p>
                    </div>

                    <!-- 2-column FAQ grid -->
                    <div class="row g-3" data-aos="fade-up" data-aos-delay="100">
                        <c:forEach items="${listFAQ}" var="faq" begin="0" end="9">
                            <div class="col-lg-6">
                                <div class="faq-item-premium" onclick="this.classList.toggle('open')">
                                    <div class="faq-q-premium">
                                        <span>${faq.question}</span>
                                        <div class="faq-icon-wrapper"><i class="fas fa-chevron-down"></i></div>
                                    </div>
                                    <div class="faq-a-premium">${faq.answer}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- View all link -->
                    <div style="text-align:center; margin-top:50px;" data-aos="fade-up" data-aos-delay="200">
                        <a href="FAQ" style="display:inline-flex; align-items:center; gap:10px; background:linear-gradient(135deg, #c4a14b, #a58032); color:#fff; font-weight:700; font-size:15px; padding:15px 35px; border-radius:50px; text-decoration:none; box-shadow:0 10px 20px rgba(196,161,75,0.3); transition:all 0.3s;" onmouseover="this.style.transform='translateY(-3px)'; this.style.boxShadow='0 15px 25px rgba(196,161,75,0.4)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 10px 20px rgba(196,161,75,0.3)';">
                            XEM TẤT CẢ CÂU HỎI <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </section>

            <!-- Testimonials Section -->
            <section id="testimonials" class="testimonials section">

                <img src="assets/img/testimonials-bg.jpg" class="testimonials-bg" alt>

                <div class="container" data-aos="fade-up" data-aos-delay="100">

                    <div class="swiper init-swiper">
                        <script type="application/json" class="swiper-config">
                            {
                            "loop": true,
                            "speed": 600,
                            "autoplay": {
                            "delay": 5000
                            },
                            "slidesPerView": "auto",
                            "pagination": {
                            "el": ".swiper-pagination",
                            "type": "bullets",
                            "clickable": true
                            }
                            }
                        </script>
                        <div class="swiper-wrapper">
                            <c:forEach items="${listF}" var="feedback">
                                <div class="swiper-slide">
                                    <div class="testimonial-item">
                                        <img src="${feedback.customerImage}" class="testimonial-img" alt>
                                        <h3>${feedback.customerName}</h3>
                                        <h4>Rental Customer</h4>
                                        <c:forEach begin="1" end="${(feedback.productRate + feedback.serviceRate + feedback.deliveryRate) / 3}" var="star">
                                            <span style="color: #F7D000;" class="ion-ios-star"></span>
                                        </c:forEach>
                                        <c:forEach begin="${(feedback.productRate + feedback.serviceRate + feedback.deliveryRate) / 3 + 1}" end="5" var="emptyStar">
                                            <span class="ion-ios-star-outline"></span>
                                        </c:forEach>
                                        <p>
                                            <i class="bi bi-quote quote-icon-left"></i>
                                            <span>${feedback.content}</span>
                                            <i class="bi bi-quote quote-icon-right"></i>
                                        </p>
                                    </div>
                                </div><!-- End testimonial item -->
                            </c:forEach>


                        </div>
                        <div class="swiper-pagination"></div>
                    </div>

                </div>

            </section><!-- /Testimonials Section -->
            
        </main>

        <jsp:include page="/includes/customer/footer.jsp" />

        <!-- Scroll Top -->
        <a href="#" id="scroll-top"
           class="scroll-top d-flex align-items-center justify-content-center"
           style="background: #b59349;"><i
                class="bi bi-arrow-up-short"></i></a>

        <!-- Preloader -->
        <div id="preloader"></div>


        <script>
            window.embeddedChatbotConfig = {
                chatbotId: "qUNf-UR7ycIWmYS6ZiWCL",
                domain: "www.chatbase.co"
            }
            function SidebarAction() {
                const sidebar = document.getElementById('sidebar');
                const sidebarToggle = document.getElementById('sidebarAction');
                sidebar.classList.toggle('open');
                sidebarToggle.classList.toggle('open');
                if (sidebarToggle.classList.contains('open')) {
                    const notificationDot = document.querySelector('.notification-dot');
                    if (notificationDot) notificationDot.style.display = 'none';
                }
            }

            function showHeroError(msg) {
                var errDiv = document.getElementById('heroErrorMsg');
                if (errDiv) {
                    errDiv.style.display = 'block';
                    errDiv.querySelector('span').innerText = msg;
                } else {
                    alert(msg);
                }
            }

            // Hero form submit: save params → go to motorbikes (Xe Máy selection)
            function heroFormSubmit(e) {
                e.preventDefault();
                var startDate = document.getElementById('heroStartDate').value;
                var endDate   = document.getElementById('heroEndDate').value;
                var pickup    = document.getElementById('heroPickupLoc').value;
                var returnL   = document.getElementById('heroReturnLoc').value;

                // Hide previous errors
                var errDiv = document.getElementById('heroErrorMsg');
                if (errDiv) errDiv.style.display = 'none';

                if (!pickup.trim() || !returnL.trim() || !startDate || !endDate) {
                    showHeroError("Vui lòng nhập đầy đủ địa điểm và thời gian!");
                    return false;
                }

                var start = new Date(startDate);
                var end = new Date(endDate);
                
                var startHour = start.getHours();
                var startMinute = start.getMinutes();
                var endHour = end.getHours();
                var endMinute = end.getMinutes();

                if (startHour < 7 || startHour > 23 || (startHour === 23 && startMinute > 0) ||
                    endHour < 7 || endHour > 23 || (endHour === 23 && endMinute > 0)) {
                    showHeroError("Chỉ nhận/trả xe trong giờ hoạt động (07:00 - 23:00)!");
                    return false;
                }

                var minTime = new Date();
                minTime.setHours(minTime.getHours() + 1); // Require at least 1 hour advance booking
                minTime.setMinutes(minTime.getMinutes() - 5); // 5 min grace period for filling out the form

                if (start < minTime) {
                    showHeroError("Vui lòng đặt xe trước 1 tiếng");
                    return false;
                }

                if (end <= start) {
                    showHeroError("Thời gian trả xe phải sau thời gian nhận xe!");
                    return false;
                }

                // Store in sessionStorage for booking page to read
                try {
                    sessionStorage.setItem('hs_startDate',  startDate);
                    sessionStorage.setItem('hs_endDate',    endDate);
                    sessionStorage.setItem('hs_pickup',     pickup);
                    sessionStorage.setItem('hs_returnLoc',  returnL);
                } catch(ex) {}
                // Navigate directly to booking page (step 2 = XE MÁY)
                window.location.href = 'booking';
                return false;
            }

            // Booking widget helpers
            function toggleReturnLocation(cb) {
                var returnLoc = document.getElementById('heroReturnLoc');
                var pickupLoc = document.getElementById('heroPickupLoc');
                if (cb.checked) {
                    returnLoc.value = pickupLoc ? pickupLoc.value : '';
                    returnLoc.disabled = true;
                    returnLoc.style.opacity = '0.5';
                    if (pickupLoc) pickupLoc.oninput = function() { returnLoc.value = this.value; };
                } else {
                    returnLoc.disabled = false;
                    returnLoc.style.opacity = '1';
                    if (pickupLoc) pickupLoc.oninput = null;
                }
            }

            // Set default dates: now -> now+2days
            (function() {
                function pad(n) { return String(n).padStart(2,'0'); }
                function fmt(d) {
                    return d.getFullYear() + '-' + pad(d.getMonth()+1) + '-' + pad(d.getDate())
                         + 'T' + pad(d.getHours()) + ':' + pad(d.getMinutes());
                }
                var now = new Date(); now.setMinutes(0,0,0);
                var end = new Date(now); end.setDate(end.getDate()+2);
                var s = document.getElementById('heroStartDate');
                var e = document.getElementById('heroEndDate');
                if(s) s.value = fmt(now);
                if(e) e.value = fmt(end);
            })();

        </script>
        


        <!-- Vendor JS Files -->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>
        <script src="assets/vendor/aos/aos.js"></script>
        <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
        <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

        <!-- Main JS File -->
        <script src="assets/js/main.js"></script>

    </body>

</html>

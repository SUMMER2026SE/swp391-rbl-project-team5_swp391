<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/includes/customer/header.jsp"/>

<!-- Top Loading Bar -->
<jsp:include page="/includes/loading.jsp" />

<!-- Fonts -->
<link href="https://fonts.googleapis.com" rel="preconnect">
<link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>
    /* Default Action Icons (White on transparent header) */
    .nav-action-icon {
        color: rgba(255,255,255,0.8);
    }
    .nav-action-icon:hover {
        color: #ffffff;
    }
    
    /* Action Icons when scrolled (Gold on white header) or on subpages */
    body.index-page.scrolled .nav-action-icon,
    body.index-page.scrolled .header .nav-action-icon,
    body:not(.index-page) .nav-action-icon,
    body:not(.index-page) .header .nav-action-icon {
        color: #b59349;
    }
    body.index-page.scrolled .nav-action-icon:hover,
    body.index-page.scrolled .header .nav-action-icon:hover,
    body:not(.index-page) .nav-action-icon:hover,
    body:not(.index-page) .header .nav-action-icon:hover {
        color: #927535;
    }
</style>

<header id="header" class="header fixed-top d-flex flex-column align-items-stretch" style="padding: 0 !important; transition: all 0.4s ease-in-out !important;">
    <!-- Top Announcement Bar -->
    <div class="top-announcement-bar d-flex align-items-center justify-content-center" style="background: #1a1816 !important; height: 32px; border-bottom: 1px solid rgba(181, 147, 73, 0.12); width: 100%; z-index: 10;">
        <span style="color: #eae6df; font-size: 11px; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; font-family: 'Plus Jakarta Sans', sans-serif;">
            Trải nghiệm dịch vụ tốt nhất cùng <span style="color: #b59349;">SmartRide</span>
        </span>
    </div>

    <!-- Main Navigation Bar Container -->
    <div class="container-fluid container-xl position-relative d-flex align-items-center" style="height: 75px;">

        <a href="home" class="logo d-flex align-items-center me-auto" style="text-decoration: none; padding: 4px 0; transition: all 0.3s ease; gap: 10px;">
            <img src="${pageContext.request.contextPath}/images/newlogo_transparent.png" alt="SmartRide Logo" class="logo-icon" />
            <span class="logo-brand-name">SmartRide</span>
        </a>

        <nav id="navmenu" class="navmenu">
            <ul>
                <li><a href="home">Trang Chủ<br></a></li>
                <li><a href="about.jsp">Về Chúng Tôi</a></li>
                <li><a href="motorcycle">Xe Máy</a></li>
                <li><a href="pricing">Bảng Giá</a></li>
                <li class="dropdown"><a style="cursor: pointer"><span>Dịch Vụ</span> <i
                            class="bi bi-chevron-down toggle-dropdown"></i></a>
                    <ul>
                        <li><a href="FAQ">FAQs</a></li>
                        <li><a href="event">Sự Kiện</a></li>
                        <li><a href="touristLocation">Địa Điểm Du Lịch</a></li>
                         <li><a href="policies.jsp">Chính Sách & Điều Khoản</a></li> 
                    </ul>
                </li>
                <li><a href="contact.jsp">Liên Hệ</a></li>
            </ul>
            <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
        </nav>
        <c:if test="${sessionScope.account == null}">
            <a class="btn login" href="login.jsp" style="color: white;">Đăng Nhập</a>
        </c:if>
        <c:if test="${sessionScope.account != null}">
            <!-- Action Icons (Cart & Notifications) -->
            <div class="d-flex align-items-center ms-4 me-4" style="gap: 20px;">
                <a href="favorites.jsp" class="nav-action-icon position-relative" title="Giỏ hàng" style="font-size: 1.4rem; transition: all 0.3s;" onmouseover="this.style.transform='scale(1.1)';" onmouseout="this.style.transform='scale(1)';">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span id="cart-badge" class="position-absolute translate-middle badge rounded-pill bg-danger shadow-sm" style="font-size: 0.65rem; top: 2px; left: 90%; display: none; padding: 0.35em 0.55em; border: 2px solid white;">0</span>
                </a>
                
                <div class="nav-action-icon position-relative notif-dropdown-trigger" style="font-size: 1.4rem; transition: all 0.3s; cursor: pointer;" onmouseover="this.style.transform='scale(1.1)';" onmouseout="this.style.transform='scale(1)';">
                    <i class="fas fa-bell"></i>
                    <span id="notif-badge" class="position-absolute translate-middle badge rounded-pill bg-danger shadow-sm" style="font-size: 0.65rem; top: 2px; left: 90%; display: none; padding: 0.35em 0.55em; border: 2px solid white;">0</span>
                    
                    <!-- Notification Dropdown -->
                    <div id="notif-dropdown" class="notif-dropdown shadow-lg rounded-3" style="display: none; position: absolute; top: 150%; right: -10px; width: 320px; background: white; z-index: 1000; border: 1px solid #e2e8f0;">
                        <div class="p-3 border-bottom d-flex justify-content-between align-items-center" style="background: #f8fafc; border-radius: 8px 8px 0 0;">
                            <h6 class="m-0 fw-bold text-dark">Thông báo mới</h6>
                            <span class="text-primary text-decoration-none" style="font-size: 0.8rem; cursor: pointer;" onclick="markAllNotifAsRead()">Đánh dấu đã đọc</span>
                        </div>
                        <div id="notif-list" class="notif-list" style="max-height: 350px; overflow-y: auto;">
                            <!-- Items injected by JS -->
                        </div>
                        <div class="p-2 border-top text-center" style="background: #f8fafc; border-radius: 0 0 8px 8px;">
                            <a href="#" class="text-muted" style="font-size: 0.85rem; text-decoration: none;" data-bs-toggle="modal" data-bs-target="#allNotificationsModal">Xem tất cả</a>
                        </div>
                    </div>
                </div>
                
                <c:if test="${sessionScope.account.roleID == 2 or sessionScope.account.roleID == 3}">
                    <a href="manageSmartRide.jsp?iframeSrc=homeStaff" class="nav-action-icon position-relative d-flex align-items-center text-decoration-none" title="Trang Quản Trị" style="color: #ffffff; transition: all 0.3s; background-color: #b59349; padding: 6px 14px; border-radius: 20px; font-size: 14px; font-weight: 600;" onmouseover="this.style.transform='scale(1.05)'; this.style.backgroundColor='#9b7a37';" onmouseout="this.style.transform='scale(1)'; this.style.backgroundColor='#b59349';">
                        <i class="fas fa-user-shield me-2"></i> Quản lý
                    </a>
                </c:if>
            </div>

            <div class="user-menu-wrap">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.image}">
                        <a class="mini-photo-wrapper"><img class="mini-photo" style="object-fit: cover; cursor: pointer" src="${sessionScope.account.image}?${now.time}" width="36" height="36"/></a>
                    </c:when>
                    <c:otherwise>
                        <a class="mini-photo-wrapper"><img class="mini-photo" style="object-fit: cover; cursor: pointer"  src="images/avarta.jpg" width="36" height="36"/></a>
                    </c:otherwise>
                </c:choose>





                <div class="menu-container">
                    <div class="user-menu">
                        <div style="background-color: #ffffff !important; padding-top: 5px;">
                            <div class="profile-highlight">
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.image}">
                                    <img src="${sessionScope.account.image}?${now.time}" alt="profile-img" width="36" height="36">
                                </c:when>
                                <c:otherwise>
                                    <img src="images/avarta.jpg" alt="profile-img" width="36" height="36">
                                </c:otherwise>
                            </c:choose>


                            <div class="details">
                                <div class="sitename" id="profile-name">SmartRide</div>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.account.firstName or not empty sessionScope.account.lastName}">
                                        <div id="profile-footer" style="text-transform: capitalize;">Xin chào ${sessionScope.account.lastName} ${sessionScope.account.firstName}</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div id="profile-footer">Xin chào ${sessionScope.account.email}</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <!--                        <li class="user-menu__item">
                                                    <a class="user-menu-link" href="#">
                                                        <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1604623/trophy.png" alt="trophy_icon" width=20 height=20>
                                                        <div>Achievements</div>
                                                    </a>
                                                </li>-->
                        <div class="user-menu__item">
                            <a class="user-menu-link" href="profileCustomer.jsp">
                                <i class="fas fa-user-circle" style="font-size: 18px; color: #b59349; width: 24px; text-align: center;"></i>
                                <div>Thông tin cá nhân</div>
                            </a>
                        </div>
                        <c:if test="${sessionScope.account != null && (sessionScope.account.roleID == 2 || sessionScope.account.roleID == 3)}">
                        <div class="user-menu__item">
                            <a class="user-menu-link" href="manageSmartRide.jsp?iframeSrc=homeStaff">
                                <i class="fas fa-user-shield" style="font-size: 18px; color: #b59349; width: 24px; text-align: center;"></i>
                                <div>Trang Quản Trị</div>
                            </a>
                        </div>
                        </c:if>
                        <div class="user-menu__item">
                            <a class="user-menu-link" href="bookingHistory?status=all">
                                <i class="fas fa-file-invoice" style="font-size: 18px; color: #b59349; width: 24px; text-align: center;"></i>
                                <div>Quản lý đặt hàng</div>
                            </a>
                        </div>
                        </div>
                        <div class="user-menu-footer" style="padding: 12px 20px; margin-bottom: 0 !important; display: flex; flex-direction: column;">
                            <a href="logout" style="display: flex; align-items: center; justify-content: center; gap: 8px; background-color: #b59349; color: #ffffff !important; font-weight: 600; font-size: 0.875rem; padding: 10px 0; border-radius: 9999px; text-decoration: none; transition: all 0.2s; box-shadow: 0 4px 6px -1px rgba(181, 147, 73, 0.2); margin-bottom: 0 !important;">
                                <i class="fas fa-sign-out-alt"></i> Đăng xuất
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

</header>

<!-- All Notifications Modal -->
<div class="modal fade" id="allNotificationsModal" tabindex="-1" aria-labelledby="allNotificationsModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background: #f8fafc;">
                <h5 class="modal-title fw-bold text-dark" id="allNotificationsModalLabel">Tất cả thông báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0" id="all-notif-list">
                <!-- Items injected by JS -->
            </div>
            <div class="modal-footer justify-content-center border-top">
                <button type="button" class="btn btn-secondary" style="background-color: #6c757d; color: white; border: none;" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<style>

    * {
        box-sizing: border-box;
        /*        margin: 0;
                padding: 0;*/
    }

    /* Clean Logo styling & elegant hover */
    .logo {
        background: transparent !important;
        border: none !important;
        box-shadow: none !important;
        padding: 0 !important;
    }
    
    /* Logo icon - just the motorcycle graphic */
    .logo img.logo-icon,
    #header .logo img.logo-icon,
    .header .logo img.logo-icon {
        height: 52px !important;
        max-height: 52px !important;
        min-height: 52px !important;
        width: auto !important;
        transition: filter 0.4s ease-in-out, transform 0.3s ease !important;
    }

    /* Brand name text next to logo - like motogo.vn */
    .logo-brand-name {
        font-family: 'Poppins', 'Plus Jakarta Sans', sans-serif !important;
        font-size: 22px !important;
        font-weight: 800 !important;
        letter-spacing: -0.5px !important;
        background: linear-gradient(135deg, #b59349 0%, #d4a843 50%, #8c6f32 100%) !important;
        -webkit-background-clip: text !important;
        -webkit-text-fill-color: transparent !important;
        background-clip: text !important;
        transition: all 0.4s ease !important;
        line-height: 1 !important;
    }

    
    .logo:hover img {
        transform: scale(1.05);
    }

    /* At top of index page (dark hero) → white icon + white brand text */
    body.index-page:not(.scrolled) .header .logo img.logo-icon {
        filter: brightness(0) invert(1) !important;
    }
    body.index-page:not(.scrolled) .logo-brand-name {
        background: none !important;
        -webkit-text-fill-color: #ffffff !important;
        color: #ffffff !important;
    }

    /* Scrolled / other pages → colored icon + gold gradient brand text */
    body.index-page.scrolled .header .logo img.logo-icon,
    body:not(.index-page) .header .logo img.logo-icon {
        filter: none !important;
    }
    body.index-page.scrolled .logo-brand-name,
    body:not(.index-page) .logo-brand-name {
        background: linear-gradient(135deg, #b59349 0%, #d4a843 50%, #8c6f32 100%) !important;
        -webkit-background-clip: text !important;
        -webkit-text-fill-color: transparent !important;
        background-clip: text !important;
    }

    /* Default solid glassmorphic navbar for scrolled states & subpages */
    #header {
        background: rgba(255, 255, 255, 0.95) !important;
        border-bottom: 1px solid rgba(181, 147, 73, 0.1) !important;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.03) !important;
        backdrop-filter: blur(10px);
        transition: transform 0.35s cubic-bezier(0.165, 0.84, 0.44, 1), background-color 0.4s ease-in-out, border-bottom 0.4s ease-in-out, box-shadow 0.4s ease-in-out !important;
    }

    /* Shift header up by 32px to hide announcement bar smoothly when scrolling down */
    body.scrolled #header {
        transform: translateY(-32px) !important;
    }

    /* Fade out top bar when scrolled to prevent overlapping visibility */
    .top-announcement-bar {
        transition: opacity 0.3s ease, visibility 0.3s ease !important;
    }
    body.scrolled .top-announcement-bar {
        opacity: 0 !important;
        visibility: hidden !important;
        pointer-events: none !important;
    }

    /* Transparent navbar only at the top of the Home page */
    body.index-page:not(.scrolled) #header {
        background: transparent !important;
        border-bottom: none !important;
        box-shadow: none !important;
    }

    /* White text for navbar on index page before scrolling */
    body.index-page:not(.scrolled) .navmenu > ul > li > a, 
    body.index-page:not(.scrolled) .navmenu > ul > li > a:focus {
        color: #ffffff !important;
    }
    
    body.index-page:not(.scrolled) .login {
        color: #ffffff !important;
        border-color: #ffffff !important;
    }
    
    body.index-page:not(.scrolled) .login:hover {
        background: #ffffff !important;
        color: #1a1816 !important;
    }
    
    body.index-page:not(.scrolled) .navmenu .dropdown ul a {
        color: #2b2824 !important;
    }

    body {
        background-color: #fbfaf8 !important;
        color: #2b2824 !important;
        font-family: 'Plus Jakarta Sans', sans-serif !important;
    }

    /* Spread out the navigation bar items evenly with a modern flex gap */
    .navmenu > ul {
        display: flex !important;
        gap: 28px !important; /* Generous gap to distribute and spread out links beautifully */
        align-items: center !important;
    }

    /* Cinematic bright navbar text with matte gold hover */
    .navmenu a, .navmenu a:focus {
        color: #1a1816 !important;
        font-family: 'Plus Jakarta Sans', sans-serif !important;
        font-weight: 600 !important; /* Semi-bold weight for striking elegance */
        font-size: 15px !important;
        letter-spacing: 0.5px !important; /* Professional letter spacing */
        transition: all 0.3s ease !important;
        position: relative !important;
        padding: 10px 2px !important; /* Compact link padding relying on gap for spacing */
        background: transparent !important;
    }
    
    .navmenu a::after {
        content: "" !important;
        position: absolute !important;
        width: 0 !important;
        height: 2px !important;
        bottom: -2px !important;
        left: 0 !important;
        background-color: #b59349 !important;
        transition: width 0.3s ease-in-out !important;
    }
    
    .navmenu a.active::after,
    .navmenu a:hover::after {
        width: 100% !important;
    }

    /* Completely eliminate the ugly yellow/beige background rectangle on hover and force transparent text color transition */
    .navmenu li:hover>a,
    .navmenu a:hover, 
    .navmenu a.active,
    .navmenu .active, 
    .navmenu .active:focus {
        background: transparent !important;
        background-image: none !important;
        background-clip: unset !important;
        -webkit-background-clip: unset !important;
        color: #b59349 !important;
    }
    .navmenu .dropdown ul {
        display: flex !important;
        flex-direction: column !important;
        align-items: stretch !important;
        gap: 0 !important;
        background-color: #ffffff !important;
        border: 1px solid rgba(181, 147, 73, 0.15) !important;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05) !important;
        padding: 8px 0 !important;
        min-width: 200px !important;
    }
    .navmenu .dropdown ul li {
        display: block !important;
        width: 100% !important;
        float: none !important;
        margin: 0 !important;
        padding: 0 !important;
    }
    .navmenu .dropdown ul a {
        display: block !important;
        width: 100% !important;
        color: #2b2824 !important;
        background-color: transparent !important;
        padding: 10px 20px !important;
        font-size: 14px !important;
        font-weight: 500 !important;
        text-align: left !important;
        transition: all 0.2s ease !important;
    }
    .navmenu .dropdown ul a::after {
        display: none !important;
    }
    .navmenu .dropdown ul a:hover {
        color: #b59349 !important;
        background-color: #f5f2eb !important;
    }

    ul {
        list-style: none;
    }
    ol, ul {
        padding-left: 0rem !important;
    }

    /* User Menu */
    .user-menu-wrap {
        margin-left: 60px;
        position: relative;
    }

    .menu-container {
        visibility: hidden;
        opacity: 0;
        z-index: 9999 !important;
        position: absolute;
        right: 0;
        top: 100%;
        margin-top: 10px;
    }

    .menu-container.active {
        visibility: visible;
        opacity: 1;
        transition: all .2s ease-in-out;
    }

    .user-menu {
        width: 280px !important;
        background-color: #fcfaf5 !important;
        color: #2b2824 !important;
        border-radius: 8px;
        border: 1px solid #eae6df !important;
        padding-top: 0px !important;
        padding-bottom: 0px !important;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08) !important;
        font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif !important;
        overflow: hidden;
    }

    .user-menu .profile-highlight {
        display: flex;
        border-bottom: 1px solid #eae6df !important;
        padding: 12px 16px;
        margin-bottom: 6px;
    }

    .user-menu .profile-highlight img {
        width: 48px;
        height: 48px;
        border-radius: 25px;
        object-fit: cover;
    }

    .user-menu .profile-highlight .details {
        display: flex;
        flex-direction: column;
        margin: auto 12px;
        overflow: hidden;
    }

    .user-menu .profile-highlight #profile-name {
        font-weight: 600;
        font-size: 16px;
        color: #b59349 !important;
        word-break: break-word;
    }

    .user-menu .profile-highlight #profile-footer {
        font-weight: 300;
        font-size: 14px;
        margin-top: 4px;
        color: #666666 !important;
        word-break: break-word;
    }

    .user-menu .user-menu-footer {
        border-top: 1px solid #eae6df !important;
        padding-top: 6px;
        margin-top: 6px;
        background-color: #fcfaf5 !important;
        border-bottom-left-radius: 8px;
        border-bottom-right-radius: 8px;
    }

    .user-menu .user-menu-footer .user-menu-link {
        font-size: 13px;
    }

    .user-menu .user-menu-link {
        display: flex;
        text-decoration: none;
        color: #2b2824 !important;
        font-weight: 400;
        font-size: 14px;
        padding: 12px 16px;
    }

    .user-menu .user-menu-link div {
        margin: auto 10px;
    }

    .user-menu .user-menu-link:hover {
        background-color: #f5f2eb !important;
        color: #b59349 !important;
    }

    .menu-container:before {
        position: absolute;
        top: -16px;
        right: 10px;
        display: inline-block;
        content: "";
        border: 8px solid transparent;
        border-bottom-color: #eae6df !important;
    }

    .menu-container:after {
        position: absolute;
        top: -14px;
        right: 11px;
        display: inline-block;
        content: "";
        border: 7px solid transparent;
        border-bottom-color: #ffffff !important;
    }
    .mini-photo {
        width: 45px;
        height: 45px;
        border-radius: 50% !important;
        box-shadow: #b59349 0 0 5px !important;
    }

    /*cu*/
    .rental {
        width: 50%;
        padding: 2.5% 0%;
        background: #b59349 !important;
        font-size: 24px;
        font-weight: 800;
        color: white !important;
        transition: transform .2s;
        border: none;
    }
    .rental:hover {
        background: #a38241 !important;
        color: white !important;
    }
    .rentalbutton:hover {
        transform: scale(1.1);
        margin-left: 5%;
    }

    .login {
        background: transparent !important;
        border: 1px solid #b59349 !important;
        margin-left: 3%;
        color: #b59349 !important;
        transition: all 0.3s;
    }
    .login:hover {
        background: #b59349 !important;
        color: white !important;
    }
    .sitename {
        color: #b59349 !important;
    }
    .gradient-button {
        background: #b59349 !important;
        color: white !important; /* Màu chữ */
        padding: 10px 20px; /* Đệm cho nút */
        border-radius: 5px; /* Bo góc */
        text-decoration: none; /* Xóa gạch chân */
        display: inline-block; /* Hiển thị như một khối nội dòng */
        transition: background 0.3s; /* Hiệu ứng chuyển đổi nền khi di chuột */
        margin-bottom: 4%;
    }

    .gradient-button:hover {
        background: #a38241 !important;
        color: white !important;
    }


</style>

<script>

    
    // Auto-detect current page and apply .active class with gold underline transition
    document.addEventListener("DOMContentLoaded", function() {
        const path = window.location.pathname;
        const page = path.split("/").pop().toLowerCase();
        const navLinks = document.querySelectorAll(".navmenu a");
        
        let activeFound = false;
        navLinks.forEach(link => {
            const href = link.getAttribute("href");
            if (href) {
                const hrefLower = href.toLowerCase();
                // Check if page matches href exactly, or starts with it (for query params/servlets), or default home
                if (page === hrefLower || 
                    (hrefLower !== "home" && page.startsWith(hrefLower.split(".")[0])) ||
                    (hrefLower === "home" && (page === "" || page === "home" || page === "index.jsp"))) {
                    link.classList.add("active");
                    activeFound = true;
                }
            }
        });
        
        // If a nested dropdown item is active, highlight the parent dropdown menu
        if (activeFound) {
            const activeDropdownItem = document.querySelector(".navmenu .dropdown ul a.active");
            if (activeDropdownItem) {
                const parentDropdown = activeDropdownItem.closest(".dropdown").querySelector("a");
                if (parentDropdown) {
                    parentDropdown.classList.add("active");
                }
            }
        }
        
        // Universal scroll listener for navbar header styling across all pages
        window.addEventListener('scroll', function() {
            if (window.scrollY > 100) {
                document.body.classList.add('scrolled');
            } else {
                document.body.classList.remove('scrolled');
            }
        });


    });

    const miniPhoto = document.querySelector('.mini-photo-wrapper');
    const menuContainer = document.querySelector('.menu-container');
    
    if (miniPhoto && menuContainer) {
        miniPhoto.addEventListener('click', function (e) {
            e.stopPropagation();
            menuContainer.classList.toggle('active');
        });
        
        // Đóng dropdown khi click ra ngoài
        document.addEventListener('click', function (e) {
            if (menuContainer.classList.contains('active') && !menuContainer.contains(e.target) && !miniPhoto.contains(e.target)) {
                menuContainer.classList.remove('active');
            }
        });
    }

</script>

<!-- Notification and Favorites Scripts -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var notifTrigger = document.querySelector('.notif-dropdown-trigger');
        var notifDropdown = document.getElementById('notif-dropdown');
        
        if (notifTrigger && notifDropdown) {
            notifTrigger.addEventListener('click', function(e) {
                if(e.target.closest('#notif-dropdown') && !e.target.closest('.border-bottom')) return; // ignore clicks inside dropdown except header
                notifDropdown.style.display = notifDropdown.style.display === 'none' ? 'block' : 'none';
            });
            
            // Close when clicking outside
            document.addEventListener('click', function(e) {
                if (!notifTrigger.contains(e.target)) {
                    notifDropdown.style.display = 'none';
                }
            });
            
            // Initial fetch
            fetchNotifications();
            // Poll every 3s for REALTIME effect
            setInterval(fetchNotifications, 3000);
        }
    });

    let lastUnreadCount = -1;

    function fetchNotifications() {
        fetch('notification?action=get')
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                updateNotificationUI(data.unreadCount, data.data);
            }
        }).catch(err => console.error("Error fetching notifications", err));
    }

    function showToast(title, message) {
        // Create toast container if not exists
        let container = document.getElementById('toast-container');
        if (!container) {
            container = document.createElement('div');
            container.id = 'toast-container';
            container.style.cssText = 'position: fixed; bottom: 20px; right: 20px; z-index: 9999; display: flex; flex-direction: column; gap: 10px;';
            document.body.appendChild(container);
        }
        
        let toast = document.createElement('div');
        toast.style.cssText = 'background: white; border-left: 4px solid #198754; box-shadow: 0 10px 25px rgba(0,0,0,0.1); border-radius: 8px; padding: 15px 20px; min-width: 300px; transform: translateX(120%); transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275); display: flex; align-items: start; gap: 12px; cursor: pointer;';
        toast.innerHTML = 
            '<div style="background: #e8f5e9; color: #198754; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">' +
                '<i class="fas fa-bell"></i>' +
            '</div>' +
            '<div>' +
                '<div style="font-weight: bold; color: #333; font-size: 14px; margin-bottom: 4px;">' + title + '</div>' +
                '<div style="color: #666; font-size: 12px; line-height: 1.4;">' + message + '</div>' +
            '</div>';
        
        container.appendChild(toast);
        
        // Trượt ra
        setTimeout(() => toast.style.transform = 'translateX(0)', 100);
        
        // Tự động đóng sau 5s
        setTimeout(() => {
            toast.style.transform = 'translateX(120%)';
            setTimeout(() => toast.remove(), 300);
        }, 5000);
    }

    function updateNotificationUI(unreadCount, items) {
        if (lastUnreadCount !== -1 && unreadCount > lastUnreadCount && items && items.length > 0) {
            // Co thong bao moi
            showToast(items[0].title, items[0].message);
            // Hieu ung rung chuong
            var icon = document.querySelector('.fa-bell');
            if(icon) {
                icon.style.transform = 'rotate(15deg)';
                setTimeout(()=>icon.style.transform = 'rotate(-15deg)', 100);
                setTimeout(()=>icon.style.transform = 'rotate(10deg)', 200);
                setTimeout(()=>icon.style.transform = 'rotate(-10deg)', 300);
                setTimeout(()=>icon.style.transform = 'rotate(0)', 400);
            }
        }
        lastUnreadCount = unreadCount;

        var badge = document.getElementById('notif-badge');
        if (unreadCount > 0) {
            badge.textContent = unreadCount > 9 ? '9+' : unreadCount;
            badge.style.display = 'block';
        } else {
            badge.style.display = 'none';
        }
        
        var list = document.getElementById('notif-list');
        var allList = document.getElementById('all-notif-list');
        if (!items || items.length === 0) {
            var emptyHtml = '<div class="p-3 text-center text-muted"><small>Không có thông báo nào</small></div>';
            list.innerHTML = emptyHtml;
            if (allList) allList.innerHTML = emptyHtml;
            return;
        }
        
        var html = '';
        items.forEach(function(item) {
            var bgClass = item.isRead ? 'bg-white' : 'bg-light';
            var link = item.link ? item.link : '#';
            
            // Auto-correct old links that point to the list page but have a booking ID in the title
            if (link === 'history' || link === 'bookingHistory' || link.includes('status=')) {
                var match = item.title.match(/BK\d{8}/);
                if (match) {
                    link = 'bookingHistoryDetail?bookingId=' + match[0];
                }
            }

            html += '<a href="' + link + '" class="d-block p-3 border-bottom text-decoration-none ' + bgClass + '" onclick="markNotifAsRead(' + item.notificationId + ')">';
            html += '<div class="fw-bold text-dark" style="font-size:0.9rem;">' + item.title + '</div>';
            html += '<div class="text-muted mt-1" style="font-size:0.8rem; line-height:1.4;">' + item.message + '</div>';
            html += '</a>';
        });
        list.innerHTML = html;
        if (allList) allList.innerHTML = html;
    }

    function markNotifAsRead(id) {
        fetch('notification?action=markRead&id=' + id, { method: 'POST' })
        .then(() => fetchNotifications()); // refresh
    }

    function markAllNotifAsRead() {
        fetch('notification?action=markAllRead', { method: 'POST' })
        .then(() => fetchNotifications()); // refresh
    }
    
    function updateCartBadge() {
        fetch('favorite?action=count', { method: 'POST' })
        .then(res => res.json())
        .then(data => {
            var cartBadge = document.getElementById('cart-badge');
            if(cartBadge && data.status === 'success') {
                if(data.totalFavorites > 0) {
                    cartBadge.textContent = data.totalFavorites > 99 ? '99+' : data.totalFavorites;
                    cartBadge.style.display = 'block';
                } else {
                    cartBadge.style.display = 'none';
                }
            }
        });
    }
    
    // Listen for cart update messages from iframe or child elements
    window.addEventListener('message', function(event) {
        if (event.data === 'fav_updated') {
            updateCartBadge();
        }
    });
    
    // Init cart badge on load
    document.addEventListener("DOMContentLoaded", function() {
        updateCartBadge();
    });
</script>

<!--
<script
    src="https://www.chatbase.co/embed.min.js"
    chatbotId="qUNf-UR7ycIWmYS6ZiWCL"
    domain="www.chatbase.co"
    defer>
</script>
-->


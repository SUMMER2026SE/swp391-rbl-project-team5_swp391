<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty param.iframe}">
<!-- ======= Sidebar ======= -->
<style>
/* Premium Sidebar Redesign - Ultra Modern */
.sidebar {
    background: #0f1115 !important; /* Deeper, richer dark */
    box-shadow: 4px 0 25px rgba(0, 0, 0, 0.4) !important;
    border-right: 1px solid rgba(255, 255, 255, 0.03) !important;
}

.sidebar-nav {
    padding: 0 !important;
}

/* Nav Link General */
.sidebar-nav .nav-item {
    margin-bottom: 6px !important;
}

.sidebar-nav .nav-link {
    background: transparent !important;
    color: #94a3b8 !important; /* Soft gray */
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
    font-family: 'Be Vietnam Pro', sans-serif !important;
    font-weight: 500 !important;
    font-size: 0.95rem !important;
    border: none !important;
    border-radius: 12px !important;
    margin: 0 16px !important;
    padding: 12px 18px !important;
    display: flex !important;
    align-items: center !important;
}

.sidebar-nav .nav-link i {
    color: #64748b !important;
    font-size: 1.15rem !important;
    margin-right: 16px !important;
    transition: all 0.3s ease !important;
}

/* Hover State */
.sidebar-nav .nav-link.collapsed:hover {
    background: rgba(255, 255, 255, 0.04) !important;
    color: #ffffff !important;
    transform: translateX(4px) !important;
}
.sidebar-nav .nav-link.collapsed:hover i {
    color: #f1c40f !important; /* Gold icon on hover */
}

/* Active State (Solid Gold Gradient) */
.sidebar-nav .nav-link.active-page {
    background: linear-gradient(135deg, #d4af37 0%, #f1c40f 100%) !important;
    color: #0f1115 !important; /* Dark text for contrast against gold */
    box-shadow: 0 6px 16px rgba(212, 175, 55, 0.25) !important;
    font-weight: 700 !important;
}
.sidebar-nav .nav-link.active-page i {
    color: #0f1115 !important; /* Dark icon to match text */
}

/* Expanded State for Dropdowns */
.sidebar-nav .nav-link:not(.collapsed):not(.active-page) {
    background: rgba(255, 255, 255, 0.05) !important;
    color: #ffffff !important;
}
.sidebar-nav .nav-link:not(.collapsed):not(.active-page) i {
    color: #f1c40f !important;
}

/* Submenu container */
.sidebar-nav .nav-content {
    padding: 10px 0 10px 48px !important;
    margin: 0 !important;
    list-style: none !important;
}

/* Submenu Links */
.sidebar-nav .nav-content a {
    color: #64748b !important;
    transition: all 0.3s ease !important;
    font-size: 0.85rem !important;
    font-weight: 500 !important;
    padding: 10px 16px !important;
    border-radius: 8px !important;
    display: flex !important;
    align-items: center !important;
    position: relative !important;
    margin-right: 16px !important;
}

/* Override NiceAdmin's default dash with a clean dot */
.sidebar-nav .nav-content a i {
    display: none !important; /* Hide original icon if any */
}
.sidebar-nav .nav-content a::before {
    content: '' !important;
    width: 6px !important;
    height: 6px !important;
    background-color: #475569 !important;
    border-radius: 50% !important;
    margin-right: 12px !important;
    transition: all 0.3s ease !important;
}

/* Submenu Hover */
.sidebar-nav .nav-content a:hover, .sidebar-nav .nav-content a.active {
    color: #d4af37 !important;
    background: rgba(212, 175, 55, 0.05) !important;
    transform: translateX(3px) !important;
}
.sidebar-nav .nav-content a:hover::before, .sidebar-nav .nav-content a.active::before {
    background-color: #f1c40f !important;
    box-shadow: 0 0 10px rgba(241, 196, 15, 0.7) !important;
}

/* Heading */
.sidebar-nav .nav-heading {
    color: #475569 !important; 
    font-size: 0.7rem !important;
    text-transform: uppercase !important;
    letter-spacing: 2px !important;
    font-weight: 800 !important;
    margin: 24px 0 12px 24px !important;
}
</style>
<aside id="sidebar" class="sidebar">

    <!-- Brand Logo Area -->
    <div class="sidebar-brand">
        <a onclick="CallSideBar('homeStaff', this)" style="cursor: pointer; text-decoration: none; display: flex; flex-direction: column; align-items: center; padding: 24px 10px 15px 10px;">
            <img src="${pageContext.request.contextPath}/images/newlogo_transparent.png" alt="SmartRide" style="height: 45px; width: auto; margin-bottom: 8px; object-fit: contain; filter: brightness(0) invert(1); opacity: 0.95;" />
            <span style="font-family: 'Playfair Display', serif; font-size: 19px; font-weight: 800; color: #ffffff; letter-spacing: 1.5px;">SMARTRIDE</span>
            <c:choose>
                <c:when test="${account.roleID == 3}">
                    <span style="background: rgba(192, 157, 98, 0.15); border: 1px solid rgba(192, 157, 98, 0.3); color: #C09D62; padding: 3px 10px; border-radius: 6px; font-size: 10px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; margin-top: 6px; font-family: 'Inter', sans-serif;">Quản Trị Viên</span>
                </c:when>
                <c:otherwise>
                    <span style="background: rgba(56, 189, 248, 0.15); border: 1px solid rgba(56, 189, 248, 0.3); color: #38bdf8; padding: 3px 10px; border-radius: 6px; font-size: 10px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; margin-top: 6px; font-family: 'Inter', sans-serif;">Nhân Viên</span>
                </c:otherwise>
            </c:choose>
        </a>
    </div>
    <div style="border-bottom: 1px solid #2d2e33; margin: 0 20px 10px 20px;"></div>

    <% 
        String currentPage = request.getRequestURI();
        request.setAttribute("currentPage", currentPage);
    %>

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link ${param.iframeSrc == 'homeStaff' ? 'active-page' : 'collapsed'}" style="cursor: pointer;" onclick="CallSideBar('homeStaff', this)">
                <i class="bi bi-grid"></i>
                <span>Tổng quan</span>
            </a>
        </li>
        
        <c:if test="${account.roleID  == 3}">
             <li class="nav-item">
                <a class="nav-link ${param.iframeSrc == 'manageStaff' ? 'active-page' : 'collapsed'}" style="cursor: pointer;" onclick="CallSideBar('manageStaff', this)">
                    <i class="bi bi-people"></i>
                    <span>Quản lý nhân viên</span>
                </a>
            </li>
        </c:if>

        <li class="nav-item">
            <a class="nav-link ${param.iframeSrc == 'manageCustomer' ? 'active-page' : 'collapsed'}" style="cursor: pointer;" onclick="CallSideBar('manageCustomer', this)">
                <i class="bi bi-person-lines-fill"></i>
                <span>Quản lý khách hàng</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link ${param.iframeSrc == 'manageVoucher' ? 'active-page' : 'collapsed'}" style="cursor: pointer;" onclick="CallSideBar('manageVoucher', this)">
                <i class="bi bi-ticket-perforated"></i>
                <span>Quản lý Khuyến mãi</span>
            </a>
        </li>

        <c:set var="isMotorMenu" value="${param.iframeSrc == 'motorManage' || param.iframeSrc == 'pricingManage' || param.iframeSrc == 'accessoriesStaffServlet' || param.iframeSrc == 'manageBooking'}" />
        <li class="nav-item">
            <a class="nav-link ${isMotorMenu ? 'active-page' : 'collapsed'}" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-bicycle"></i><span>Quản lý Xe Máy</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="forms-nav" class="nav-content collapse ${isMotorMenu ? 'show' : ''}">
                <li>
                    <a style="cursor: pointer;" onclick="CallSideBar('motorManage', this)" class="${param.iframeSrc == 'motorManage' ? 'active-submenu' : ''}">
                        <span>Thông tin xe máy</span>
                    </a>
                </li>
                <li>
                    <a style="cursor: pointer;" onclick="CallSideBar('manageBooking', this)" class="${param.iframeSrc == 'manageBooking' ? 'active-submenu' : ''}">
                        <span>Quản lí thuê xe</span>
                    </a>
                </li>
                <li>
                    <a style="cursor: pointer;" onclick="CallSideBar('pricingManage', this)" class="${param.iframeSrc == 'pricingManage' ? 'active-submenu' : ''}">
                        <span>Quản lí bảng giá</span>
                    </a>
                </li>
                 <li>
                    <a style="cursor: pointer;" onclick="CallSideBar('accessoriesStaffServlet', this)" class="${param.iframeSrc == 'accessoriesStaffServlet' ? 'active-submenu' : ''}">
                        <span>Quản lí phụ kiện</span>
                    </a>
                </li>
            </ul>
        </li>

        <c:set var="isOtherMenu" value="${param.iframeSrc == 'feedbackManage' || param.iframeSrc == 'eventStaffServlet' || param.iframeSrc == 'TourismLocationServletStaff'}" />
        <li class="nav-item">
            <a class="nav-link ${isOtherMenu ? 'active-page' : 'collapsed'}" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-box"></i><span>Dịch vụ khác</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="tables-nav" class="nav-content collapse ${isOtherMenu ? 'show' : ''}">
                <li>
                    <a style="cursor: pointer" onclick="CallSideBar('feedbackManage', this)" class="${param.iframeSrc == 'feedbackManage' ? 'active-submenu' : ''}">
                        <span>Quản lí Đánh giá</span>
                    </a>
                </li>
                <li>
                    <a style="cursor: pointer" onclick="CallSideBar('eventStaffServlet', this)" class="${param.iframeSrc == 'eventStaffServlet' ? 'active-submenu' : ''}">
                        <span>Quản lí sự kiện</span>
                    </a>
                </li>
                <li>
                    <a style="cursor: pointer" onclick="CallSideBar('TourismLocationServletStaff', this)" class="${param.iframeSrc == 'TourismLocationServletStaff' ? 'active-submenu' : ''}">
                        <span>Quản lí địa điểm du lịch</span>
                    </a>
                </li>
            </ul>
        </li>

        <li class="nav-heading">Trang</li>

        <li class="nav-item">
            <a class="nav-link ${param.iframeSrc == 'profileStaff.jsp' ? 'active-page' : 'collapsed'}" style="cursor: pointer;" onclick="CallSideBar('profileStaff.jsp', this)">
                <i class="bi bi-person"></i>
                <span>Thông tin cá nhân</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link ${param.iframeSrc == 'faqsStaff' ? 'active-page' : 'collapsed'}" style="cursor: pointer;" onclick="CallSideBar('faqsStaff', this)">
                <i class="bi bi-question-circle"></i>
                <span>F.A.Q</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" onclick="CallSideBar('contactManage', this)" style="cursor: pointer;">
                <i class="bi bi-envelope"></i>
                <span>Liên hệ</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" style="cursor: pointer;" href="logout" style="color: #b59349;">
               <i class="bi bi-box-arrow-in-right" style="color: #b59349;"></i>
                <span>Đăng xuất</span>
            </a>
        </li>

    </ul>

</aside><!-- End Sidebar-->
</c:if>
<c:if test="${not empty param.iframe}">
<style>
    #main { margin-left: 0 !important; margin-top: 0 !important; padding: 20px !important; }
</style>
</c:if>

<script>
    function CallSideBar(iframeSrc, element) {
        // Highlight active submenu item
        if (element) {
            $('.nav-content a').removeClass('active-submenu');
            $('.sidebar-nav .nav-link').removeClass('active-page').addClass('collapsed');
            
            if ($(element).hasClass('nav-link')) {
                $(element).removeClass('collapsed').addClass('active-page');
            } else {
                $(element).addClass('active-submenu');
                $(element).closest('.nav-item').find('.nav-link').removeClass('collapsed').addClass('active-page');
            }
        }

        var iframe = document.querySelector('iframe');
        if (iframe && window.location.pathname.includes('manageSmartRide.jsp')) {
            // Hiện lại Loading Spinner trước khi tải
            var loader = document.getElementById('iframeLoader');
            if (loader) loader.style.display = 'flex';
            
            var sep = iframeSrc.includes('?') ? '&' : '?';
            iframe.src = iframeSrc + sep + 'iframe=true';
            
            // Cập nhật URL trên thanh địa chỉ mà không tải lại trang
            var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + '?iframeSrc=' + iframeSrc;
            window.history.pushState({}, '', newUrl);
        } else {
            window.location.href = "manageSmartRide.jsp?iframeSrc=" + iframeSrc;
        }
    }

    // Logic giữ nguyên trạng thái mở của Menu và vị trí cuộn
    document.addEventListener("DOMContentLoaded", function() {
        // 1. Phục hồi trạng thái đóng/mở của các menu con
        $('#sidebar-nav .collapse').each(function() {
            var state = localStorage.getItem("menuState_" + this.id);
            if (state === "true") {
                $(this).addClass('show');
                $('[data-bs-target="#' + this.id + '"]').removeClass('collapsed');
            } else if (state === "false") {
                $(this).removeClass('show');
                $('[data-bs-target="#' + this.id + '"]').addClass('collapsed');
            }
        });

        // 2. Lắng nghe sự kiện đóng/mở để lưu lại trạng thái
        $('#sidebar-nav .collapse').on('shown.bs.collapse', function () {
            localStorage.setItem("menuState_" + this.id, "true");
        });
        $('#sidebar-nav .collapse').on('hidden.bs.collapse', function () {
            localStorage.setItem("menuState_" + this.id, "false");
        });

        // 3. Giữ nguyên vị trí cuộn (scroll) của sidebar
        var sidebar = document.querySelector('.sidebar');
        if (sidebar) {
            var scrollPos = localStorage.getItem('sidebarScrollPos');
            if (scrollPos) {
                sidebar.scrollTop = parseInt(scrollPos, 10);
            }
            sidebar.addEventListener('scroll', function() {
                localStorage.setItem('sidebarScrollPos', sidebar.scrollTop);
            });
        }
    });
</script>

<style>
    .sidebar-nav .nav-content a.active-submenu,
    .sidebar-nav .nav-content a.active-submenu span,
    .sidebar-nav .nav-content a.active-submenu i {
        color: #f1c40f !important;
        font-weight: bold !important;
    }
    .sidebar-nav .nav-content a.active-submenu::before {
        background-color: #f1c40f !important;
    }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

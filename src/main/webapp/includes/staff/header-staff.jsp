<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${empty param.iframe}">
<!-- Top Loading Bar -->
<jsp:include page="/includes/loading.jsp" />
</c:if>

<!-- Favicons -->
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
<script>
    (function() {
        var link = document.querySelector("link[rel~='icon']");
        if (!link) {
            link = document.createElement('link');
            link.rel = 'icon';
            link.type = 'image/png';
            link.href = '${pageContext.request.contextPath}/images/newlogo_transparent.png';
            document.head.appendChild(link);
        }
    })();
</script>
<!-- Google Fonts: Inter + Be Vietnam Pro -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="staffAssets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="staffAssets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="staffAssets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="staffAssets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="staffAssets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="staffAssets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="staffAssets/vendor/simple-datatables/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Template Main CSS File -->
<link href="staffAssets/css/style.css?v=<%= System.currentTimeMillis() %>" rel="stylesheet">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty param.iframe}">
<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
        <a href="homeStaff" class="logo d-flex align-items-center d-xl-none" style="text-decoration: none;">
            <img src="${pageContext.request.contextPath}/images/newlogo_transparent.png" alt="SmartRide Logo" style="max-height: 40px; margin-right: 10px;">
            <span class="d-none d-lg-block fw-bold" style="color: #b59349; font-family: 'Playfair Display', serif; font-size: 24px;">SmartRide</span>
        </a>
        <div class="toggle-sidebar-btn d-flex align-items-center justify-content-center" style="cursor: pointer; margin-left: 20px; width: 44px; height: 44px; border-radius: 50%; background: transparent; transition: background-color 0.2s ease;" onmouseover="this.style.backgroundColor='#f1f5f9';" onmouseout="this.style.backgroundColor='transparent';">
            <i class="bi bi-list" style="font-size: 32px; color: #0f172a; line-height: 0; margin-top: 2px;"></i>
        </div>
    </div>

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">
        <ul class="d-flex align-items-center">

            <!-- Notification Dropdown -->
            <li class="nav-item dropdown pe-3" style="position: relative; margin-top:5px; margin-right: 15px;">
                <a class="nav-link nav-icon px-2" href="#" data-bs-toggle="dropdown" style="position: relative; color: #1e293b;">
                    <i class="bi bi-bell" style="font-size: 24px;"></i>
                    <span class="badge bg-danger badge-number" id="staffNotifBadge" style="position: absolute; top: 0px; right: 0px; font-size: 10px; border-radius: 50%; padding: 3px 6px; display: none;">0</span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications" id="staffNotifDropdown" style="width: 320px; max-height: 400px; overflow-y: auto; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border-radius: 12px; border: 1px solid #e2e8f0; padding: 0;">
                    <li class="dropdown-header d-flex justify-content-between align-items-center p-3 border-bottom bg-light">
                        <span class="fw-bold" style="color: #0f172a;">Thông báo</span>
                        <a href="javascript:void(0)" onclick="markAllStaffNotifsAsRead()" style="font-size: 12px; color: #3b82f6; text-decoration: none;">Đánh dấu đã đọc</a>
                    </li>
                    <div id="staffNotifList">
                        <!-- Notifications will be loaded here via JS -->
                    </div>
                </ul>
            </li><!-- End Notification Nav -->

            <li class="nav-item dropdown pe-3">

                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    
                    <c:choose>
                        <c:when test="${account.image != null}">
                            <img src="${account.image}" alt="Profile" class="rounded-circle" style="object-fit: cover; cursor: pointer">                           
                        </c:when>
                        <c:otherwise>
                            <img src="images/avarta.jpg" alt="Profile" class="rounded-circle" style="object-fit: cover; cursor: pointer">                           
                        </c:otherwise>
                    </c:choose>
                        
                    <span class="d-none d-md-block dropdown-toggle ps-2">${account.lastName}</span>
                </a><!-- End Profile Image Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <h6>${account.firstName} ${account.lastName}</h6>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="manageSmartRide.jsp?iframeSrc=profileStaff.jsp">
                            <i class="bi bi-person"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li style="padding: 0.5rem 1rem; margin-bottom: 0.5rem;">
                        <a class="dropdown-item d-flex align-items-center justify-content-center gap-2" href="logout" style="background-color: #b59349; color: #ffffff !important; font-weight: 600; font-size: 0.875rem; border-radius: 9999px; padding: 0.5rem 1rem; text-align: center; box-shadow: 0 4px 6px -1px rgba(181, 147, 73, 0.2);">
                            <i class="bi bi-box-arrow-right" style="margin: 0; font-size: 1rem;"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </li>
                </ul><!-- End Profile Dropdown Items -->
            </li><!-- End Profile Nav -->
        </ul>
    </nav><!-- End Icons Navigation -->

</header><!-- End Header -->

<!-- Notification Script for Staff -->
<script>
    function fetchStaffNotifications() {
        $.ajax({
            url: '${pageContext.request.contextPath}/notification',
            type: 'GET',
            data: { action: 'get' },
            success: function(response) {
                if(response.status === 'success') {
                    updateStaffNotifUI(response.unreadCount, response.data);
                }
            }
        });
    }

    function updateStaffNotifUI(unreadCount, items) {
        var badge = document.getElementById('staffNotifBadge');
        if (unreadCount > 0) {
            badge.innerText = unreadCount;
            badge.style.display = 'block';
        } else {
            badge.style.display = 'none';
        }

        var list = document.getElementById('staffNotifList');
        if (!items || items.length === 0) {
            list.innerHTML = '<div class="p-4 text-center text-muted" style="font-size: 13px;">Không có thông báo nào</div>';
            return;
        }

        var html = '';
        var hasSOS = false;
        items.forEach(function(item) {
            var isSOS = item.title.includes("SOS") || item.title.includes("KHẨN CẤP");
            if(isSOS && !item.read) hasSOS = true;
            
            var bgClass = item.read ? 'bg-white' : (isSOS ? 'bg-danger bg-opacity-10' : 'bg-primary bg-opacity-10');
            var titleColor = isSOS ? 'text-danger' : 'text-dark';
            var icon = isSOS ? '<i class="fas fa-exclamation-triangle text-danger me-3 fs-4"></i>' : '<i class="fas fa-bell text-primary me-3 fs-4"></i>';
            
            var link = item.link ? item.link : '#';
            var clickHandler = item.link ? "markStaffNotifAsRead(" + item.notificationId + ", '" + item.link + "')" : "markStaffNotifAsRead(" + item.notificationId + ", null)";
            
            html += '<a href="javascript:void(0)" onclick="' + clickHandler + '" class="d-flex align-items-start p-3 border-bottom text-decoration-none ' + bgClass + '">';
            html += icon;
            html += '<div style="flex-grow:1;">';
            html += '<h6 class="mb-1 fw-bold ' + titleColor + '" style="font-size: 14px;">' + item.title + '</h6>';
            html += '<p class="mb-1 text-muted" style="font-size: 12px; line-height: 1.4;">' + item.message + '</p>';
            html += '</div>';
            html += '</a>';
        });
        list.innerHTML = html;
        
        // Cảnh báo đỏ liên tục nếu có SOS chưa đọc
        var bellIcon = document.querySelector('.bi-bell');
        if(hasSOS) {
            badge.classList.add('animate__animated', 'animate__flash', 'animate__infinite');
            bellIcon.style.color = '#dc2626';
        } else {
            badge.classList.remove('animate__animated', 'animate__flash', 'animate__infinite');
            bellIcon.style.color = '';
        }
    }

    function markStaffNotifAsRead(id, link) {
        $.ajax({
            url: '${pageContext.request.contextPath}/notification',
            type: 'POST',
            data: { action: 'markRead', id: id },
            success: function() {
                fetchStaffNotifications();
                if(link) {
                    window.open(link, '_blank');
                }
            }
        });
    }

    function markAllStaffNotifsAsRead() {
        $.ajax({
            url: '${pageContext.request.contextPath}/notification',
            type: 'POST',
            data: { action: 'markAllRead' },
            success: function() {
                fetchStaffNotifications();
            }
        });
    }

    $(document).ready(function() {
        fetchStaffNotifications();
        setInterval(fetchStaffNotifications, 10000); // Polling every 10 seconds for emergencies
    });
</script>
</c:if>

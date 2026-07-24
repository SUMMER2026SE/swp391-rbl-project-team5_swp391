<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Liên Hệ - SmartRide</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --gold: #b59349;
            --gold-light: #d4af37;
            --dark: #1a1816;
            --bg: #f0f2f5;
            --card-shadow: 0 4px 24px rgba(0,0,0,0.06);
        }
        
        body, html {
            background-color: var(--bg);
            margin: 0;
            font-family: 'Be Vietnam Pro', sans-serif;
            color: #334155;
        }

        .main-container {
            padding: 30px;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header */
        .page-header {
            margin-bottom: 24px;
        }
        .page-title {
            color: #1a1816;
            font-weight: 800;
            font-size: 24px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }
        .breadcrumb-custom {
            display: flex;
            gap: 8px;
            font-size: 14px;
            color: #64748b;
        }
        .breadcrumb-custom a {
            color: var(--gold);
            text-decoration: none;
            font-weight: 600;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: #fff;
            border-radius: 14px;
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: var(--card-shadow);
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }
        .stat-icon.total { background: rgba(181, 147, 73, 0.15); color: var(--gold); }
        .stat-icon.guest { background: rgba(100, 116, 139, 0.15); color: #64748b; }
        .stat-icon.user { background: rgba(34, 197, 94, 0.15); color: #22c55e; }
        .stat-value {
            font-size: 28px;
            font-weight: 800;
            color: #1e293b;
            line-height: 1;
            margin-bottom: 4px;
        }
        .stat-label {
            font-size: 14px;
            color: #64748b;
            font-weight: 500;
        }

        /* Content Card */
        .content-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            padding: 24px;
        }

        /* Search Box */
        .search-box {
            position: relative;
            max-width: 400px;
            margin-bottom: 20px;
        }
        .search-box input {
            width: 100%;
            padding: 12px 20px 12px 45px;
            border-radius: 24px;
            border: 1px solid #e2e8f0;
            font-size: 14px;
            font-family: 'Be Vietnam Pro', sans-serif;
            background: #f8fafc;
            transition: all 0.3s;
        }
        .search-box input:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(181, 147, 73, 0.15);
            background: #fff;
        }
        .search-box i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gold);
        }

        /* Table */
        .table-custom {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        .table-custom th {
            background: linear-gradient(135deg, #1a1816 0%, #2d2926 100%);
            color: #fff;
            padding: 16px;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
        }
        .table-custom th:first-child { border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
        .table-custom th:last-child { border-top-right-radius: 12px; border-bottom-right-radius: 12px; }
        
        .table-custom td {
            padding: 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
            color: #475569;
        }
        .table-custom tbody tr:hover td {
            background-color: #f8fafc;
        }
        .msg-cell {
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Badges */
        .badge-user {
            background: rgba(181, 147, 73, 0.15);
            color: var(--gold-dark);
            border: 1px solid rgba(181, 147, 73, 0.3);
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 12px;
            display: inline-block;
        }
        .badge-guest {
            background: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 12px;
            display: inline-block;
        }

        /* Buttons */
        .btn-view {
            background: transparent;
            color: var(--gold);
            border: 1px solid var(--gold);
            padding: 6px 14px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            transition: all 0.2s;
        }
        .btn-view:hover {
            background: var(--gold);
            color: #fff;
        }

        /* Modal */
        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
        }
        .modal-header-gold {
            background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
            border: none;
            padding: 20px 24px;
        }
        .modal-title {
            color: #fff;
            font-weight: 700;
        }
        .btn-close-white {
            filter: brightness(0) invert(1);
        }
        .modal-body {
            padding: 24px;
        }
        .detail-group {
            background: #f8fafc;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 16px;
        }
        .detail-label {
            font-size: 12px;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 600;
            margin-bottom: 6px;
            letter-spacing: 0.5px;
        }
        .detail-value {
            font-size: 15px;
            color: #1e293b;
            font-weight: 500;
        }
        .msg-box {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 16px;
            font-size: 14.5px;
            line-height: 1.6;
            color: #334155;
            min-height: 100px;
            white-space: pre-wrap;
        }
    </style>
</head>

<body>
    <div class="main-container">
        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">Quản Lý Liên Hệ</h1>
            <div class="breadcrumb-custom">
                <a href="#">Trang chủ</a>
                <span>/</span>
                <span>Danh sách liên hệ từ khách hàng</span>
            </div>
        </div>

        <!-- Tính toán số liệu thống kê bằng JSTL -->
        <c:set var="totalContacts" value="0" />
        <c:set var="totalGuests" value="0" />
        <c:set var="totalUsers" value="0" />
        
        <c:forEach items="${listContact}" var="c">
            <c:set var="totalContacts" value="${totalContacts + 1}" />
            <c:set var="isUser" value="false" />
            <c:forEach items="${listA}" var="a">
                <c:if test="${a.accountId == c.accountID}">
                    <c:set var="isUser" value="true" />
                </c:if>
            </c:forEach>
            <c:choose>
                <c:when test="${isUser}">
                    <c:set var="totalUsers" value="${totalUsers + 1}" />
                </c:when>
                <c:otherwise>
                    <c:set var="totalGuests" value="${totalGuests + 1}" />
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon total"><i class="bi bi-inbox"></i></div>
                <div>
                    <div class="stat-value">${totalContacts}</div>
                    <div class="stat-label">Tổng tin nhắn liên hệ</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon user"><i class="bi bi-person-check"></i></div>
                <div>
                    <div class="stat-value">${totalUsers}</div>
                    <div class="stat-label">Từ thành viên</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon guest"><i class="bi bi-person"></i></div>
                <div>
                    <div class="stat-value">${totalGuests}</div>
                    <div class="stat-label">Từ khách vãng lai</div>
                </div>
            </div>
        </div>

        <!-- Bảng dữ liệu -->
        <div class="content-card">
            <!-- Search -->
            <div class="search-box">
                <i class="bi bi-search"></i>
                <input type="text" id="searchInput" placeholder="Tìm kiếm tên, SĐT, email hoặc tiêu đề...">
            </div>

            <div class="table-responsive">
                <table class="table-custom" id="contactTable">
                    <thead>
                        <tr>
                            <th>Mã</th>
                            <th>Người gửi</th>
                            <th>SĐT</th>
                            <th>Email</th>
                            <th>Loại khách</th>
                            <th>Tiêu đề</th>
                            <th>Nội dung</th>
                            <th class="text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listContact}" var="c">
                            <c:set var="accountFound" value="false" />
                            <c:set var="userName" value="" />
                            <c:forEach items="${listA}" var="a">
                                <c:if test="${a.accountId == c.accountID}">
                                    <c:set var="accountFound" value="true" />
                                    <c:set var="userName" value="${a.userName}" />
                                </c:if>
                            </c:forEach>
                            
                            <tr class="searchable-row">
                                <td class="fw-bold">#${c.contactID}</td>
                                <td class="fw-bold text-dark">${c.name}</td>
                                <td>${c.phoneNumber}</td>
                                <td>${c.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${accountFound}">
                                            <span class="badge-user"><i class="bi bi-person-check-fill me-1"></i>${userName}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-guest">Khách vãng lai</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="fw-semibold">${c.title}</td>
                                <td class="msg-cell" title="${c.message}">${c.message}</td>
                                <td class="text-center">
                                    <button class="btn btn-view" 
                                            onclick="openDetailModal('${c.contactID}', '${c.name}', '${c.phoneNumber}', '${c.email}', '${accountFound ? userName : 'Khách vãng lai'}', '${c.title}', this)">
                                        <i class="bi bi-eye me-1"></i>Chi tiết
                                        <!-- Store full message in a hidden div to preserve line breaks when passing to JS -->
                                        <div class="hidden-msg" style="display:none;">${c.message}</div>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listContact}">
                            <tr>
                                <td colspan="8" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    Chưa có liên hệ nào từ khách hàng.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal Chi Tiết Liên Hệ -->
    <div class="modal fade" id="contactDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header modal-header-gold">
                    <h5 class="modal-title"><i class="bi bi-envelope-open me-2"></i>Chi Tiết Liên Hệ #<span id="mdl-id"></span></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="detail-group">
                                <div class="detail-label">Thông tin người gửi</div>
                                <div class="detail-value fw-bold fs-5 mb-2" id="mdl-name"></div>
                                <div class="d-flex align-items-center gap-2 mb-2 text-muted" style="font-size:14px;">
                                    <i class="bi bi-telephone-fill"></i> <span id="mdl-phone"></span>
                                </div>
                                <div class="d-flex align-items-center gap-2 text-muted" style="font-size:14px;">
                                    <i class="bi bi-envelope-fill"></i> <span id="mdl-email"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="detail-group h-100">
                                <div class="detail-label">Loại tài khoản</div>
                                <div class="detail-value" id="mdl-type"></div>
                                <hr class="my-2 border-secondary opacity-25">
                                <div class="detail-label mt-2">Tiêu đề liên hệ</div>
                                <div class="detail-value fw-bold text-primary" id="mdl-title" style="color:var(--gold) !important;"></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-2">
                        <div class="detail-label mb-2"><i class="bi bi-chat-left-text me-2"></i>Nội dung tin nhắn</div>
                        <div class="msg-box" id="mdl-msg"></div>
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light rounded-bottom-4">
                    <button type="button" class="btn btn-secondary px-4 rounded-pill" data-bs-dismiss="modal">Đóng</button>
                    <!-- Có thể thêm nút "Trả lời qua Email" ở đây nếu dự án yêu cầu -->
                    <a href="#" id="mdl-mailto" class="btn btn-primary px-4 rounded-pill" style="background:var(--gold); border:none;">
                        <i class="bi bi-reply-fill me-1"></i>Trả lời qua Email
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hàm mở Modal Chi Tiết
        function openDetailModal(id, name, phone, email, type, title, btnEl) {
            document.getElementById('mdl-id').textContent = id;
            document.getElementById('mdl-name').textContent = name;
            document.getElementById('mdl-phone').textContent = phone;
            document.getElementById('mdl-email').textContent = email;
            document.getElementById('mdl-title').textContent = title;
            
            // Xử lý loại tài khoản
            const typeEl = document.getElementById('mdl-type');
            if (type === 'Khách vãng lai') {
                typeEl.innerHTML = '<span class="badge-guest">Khách vãng lai</span>';
            } else {
                typeEl.innerHTML = '<span class="badge-user"><i class="bi bi-person-check-fill me-1"></i>' + type + '</span>';
            }

            // Lấy nội dung đầy đủ từ hidden div để giữ nguyên xuống dòng (line breaks)
            const fullMsg = btnEl.querySelector('.hidden-msg').innerHTML;
            document.getElementById('mdl-msg').innerHTML = fullMsg;

            // Nút mailto
            document.getElementById('mdl-mailto').href = 'mailto:' + email + '?subject=Phản hồi: ' + encodeURIComponent(title);

            // Mở modal
            var modal = new bootstrap.Modal(document.getElementById('contactDetailModal'));
            modal.show();
        }

        // Chức năng tìm kiếm đơn giản (Vanilla JS)
        document.getElementById('searchInput').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll('.searchable-row');
            
            rows.forEach(row => {
                let text = row.textContent.toLowerCase();
                if (text.includes(filter)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>

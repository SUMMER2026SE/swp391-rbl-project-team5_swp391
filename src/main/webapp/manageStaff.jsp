<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>Quản lý nhân viên - SmartRide</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="staffAssets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="staffAssets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="staffAssets/vendor/simple-datatables/style.css" rel="stylesheet">
    
    <style>
        :root {
            --gold: #b59349;
            --gold-dark: #9a7c3a;
            --gold-light: #d4af37;
            --dark: #1a1816;
            --bg: #f0f2f5;
            --card-shadow: 0 4px 24px rgba(0,0,0,0.08);
        }
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: var(--bg);
            margin-top: 20px;
        }
        #main { padding-top: 20px; }

        /* Datatable Customization */
        .datatable-top {
            padding: 15px 0 !important;
            display: flex;
            justify-content: flex-end; /* Align search to right */
        }
        .datatable-info, .datatable-dropdown {
            display: none !important; /* Hide records per page and info */
        }
        .datatable-search {
            float: none !important;
            width: 100%;
            max-width: 450px;
        }
        .datatable-input {
            width: 100% !important; 
            padding: 10px 20px 10px 45px !important; 
            border-radius: 25px !important; 
            border: 1px solid #e2e8f0 !important;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05) !important;
            transition: all 0.3s ease;
            font-size: 0.95rem;
            font-family: 'Be Vietnam Pro', sans-serif;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="%23b59349" viewBox="0 0 16 16"><path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/></svg>') no-repeat 18px center !important;
            background-color: #ffffff !important;
            background-size: 16px !important;
        }
        .datatable-input:focus {
            border-color: var(--gold) !important;
            box-shadow: 0 0 0 4px rgba(181, 147, 73, 0.15) !important;
            outline: none !important;
        }
        .datatable-table {
            border-collapse: collapse !important;
        }
        .datatable-table > thead > tr > th {
            border-bottom: 0 !important;
            background: linear-gradient(135deg, #1a1816 0%, #2d2926 100%);
            color: #ffffff;
            font-weight: 600;
            padding: 16px;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .datatable-table > thead > tr > th:first-child { border-top-left-radius: 12px; }
        .datatable-table > thead > tr > th:last-child { border-top-right-radius: 12px; }
        
        .datatable-table > tbody > tr > td {
            padding: 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.95rem;
            color: #475569;
        }
        .datatable-table > tbody > tr:hover {
            background-color: #f8fafc;
        }
        
        /* Card & Layout */
        .content-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: var(--card-shadow);
            padding: 24px;
            margin-bottom: 24px;
        }
        
        /* Tabs */
        .custom-tabs {
            border-bottom: 2px solid #f1f5f9;
            margin-bottom: 20px;
        }
        .custom-tabs .nav-link {
            color: #94a3b8;
            font-weight: 600;
            border: none;
            padding: 12px 24px;
            position: relative;
            background: transparent;
            font-family: 'Be Vietnam Pro', sans-serif;
            transition: color 0.3s ease;
        }
        .custom-tabs .nav-link:hover {
            color: var(--gold);
        }
        .custom-tabs .nav-link.active {
            color: var(--gold);
            background: transparent;
        }
        .custom-tabs .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--gold);
            border-radius: 3px 3px 0 0;
        }

        /* Avatar */
        .avatar-sm {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .avatar-initial {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--gold-light);
            color: #fff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.1rem;
        }

        /* Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
        }
        .badge-active {
            background-color: rgba(181, 147, 73, 0.15);
            color: var(--gold-dark);
            border: 1px solid rgba(181, 147, 73, 0.3);
        }
        .badge-inactive {
            background-color: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        /* Buttons */
        .btn-gold-outline {
            color: var(--gold);
            border: 1px solid var(--gold);
            background: transparent;
            font-weight: 600;
            border-radius: 8px;
            padding: 6px 16px;
            transition: all 0.2s;
            font-size: 0.85rem;
        }
        .btn-gold-outline:hover {
            background: var(--gold);
            color: #fff;
        }
        .toggle-btn {
            background: transparent;
            border: none;
            color: #94a3b8;
            font-size: 1.5rem;
            transition: color 0.3s ease;
            padding: 0;
            cursor: pointer;
        }
        .toggle-btn.active-icon {
            color: #22c55e;
        }

        /* Modal Customization */
        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            overflow: hidden;
        }
        .modal-header-gold {
            background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
            border: none;
            padding: 20px 24px;
        }
        .modal-header-gold .modal-title {
            color: #fff;
            font-weight: 700;
            font-family: 'Be Vietnam Pro', sans-serif;
        }
        .modal-header-gold .btn-close {
            filter: brightness(0) invert(1);
            opacity: 0.8;
        }
        .modal-header-gold .btn-close:hover {
            opacity: 1;
        }
        .modal-body {
            padding: 30px 24px;
        }
        .detail-label {
            font-size: 0.8rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            margin-bottom: 4px;
        }
        .detail-value {
            font-size: 1rem;
            color: #1a1816;
            font-weight: 500;
            margin-bottom: 16px;
        }
        .profile-modal-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--gold);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .fw-bold-dark {
            color: #1a1816;
            font-weight: 700;
        }
    </style>
</head>
<body>

    <div class="container-fluid mt-4">
        <div class="container-fluid">
            <!-- Page Title -->
            <div class="pagetitle mb-4">
                <h1 style="color: #1a1816; font-weight: 800; font-size: 24px; text-transform: uppercase; margin-top: 0; margin-bottom: 5px; font-family: 'Be Vietnam Pro', sans-serif;">QUẢN LÝ NHÂN VIÊN</h1>
                <nav>
                    <ol class="breadcrumb" style="background: transparent; padding: 0; margin: 0; font-size: 14px;">
                        <li class="breadcrumb-item"><a href="homeStaff" target="_top" style="color: #b59349; text-decoration: none; font-weight: 600;">Trang chủ</a></li>
                        <li class="breadcrumb-item active" style="font-weight: 500; color: #6c757d;">Quản lý nhân viên</li>
                    </ol>
                </nav>
            </div>

            <div class="content-card">
                <!-- Tabs -->
                <ul class="nav custom-tabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="staff-list-tab" data-bs-toggle="tab" data-bs-target="#staff-list" type="button" role="tab" aria-selected="true">
                            Danh sách nhân viên
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="former-staff-tab" data-bs-toggle="tab" data-bs-target="#former-staff" type="button" role="tab" aria-selected="false">
                            Nhân viên đã nghỉ việc (Quá hạn)
                        </button>
                    </li>
                </ul>

                <div class="tab-content mt-3">
                    <!-- Tab: Danh sách nhân viên -->
                    <div class="tab-pane fade show active" id="staff-list" role="tabpanel" aria-labelledby="staff-list-tab">
                        <div class="table-responsive">
                            <table class="table datatable">
                                <thead>
                                    <tr>
                                        <th>Nhân viên</th>
                                        <th>Tên đăng nhập</th>
                                        <th>Điện thoại</th>
                                        <th>Ngày sinh</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="account" items="${sessionScope.accountStaff}">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center gap-3">
                                                    <c:choose>
                                                        <c:when test="${not empty account.image}">
                                                            <img src="${account.image}" alt="avatar" class="avatar-sm">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="avatar-initial">${fn:substring(account.firstName, 0, 1)}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div>
                                                        <div class="fw-bold-dark">${account.firstName} ${account.lastName}</div>
                                                        <div style="font-size: 0.8rem; color: #64748b;">ID: #${account.accountId}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>${account.userName}</td>
                                            <td>${account.phoneNumber}</td>
                                            <td>${account.dob}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${account.roleID == 2}">
                                                        <span class="status-badge badge-active">Đang làm việc</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge badge-inactive">Nghỉ việc</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <button class="btn btn-gold-outline" type="button"
                                                            data-accountId="${account.accountId}"
                                                            data-fullName="${account.firstName} ${account.lastName}"
                                                            data-dob="${account.dob}"
                                                            data-email="${account.email}"
                                                            data-address="${account.address}"
                                                            data-gender="${account.gender}"
                                                            data-phoneNumber="${account.phoneNumber}"
                                                            data-image="${account.image}"
                                                            data-username="${account.userName}"
                                                            onclick="openUserModal(this)">
                                                        Xem chi tiết
                                                    </button>
                                                    
                                                    <form id="form-${account.accountId}" action="manageStaff" method="post" class="m-0">
                                                        <input type="hidden" name="action" value="updateRoleAndGetStatuses">
                                                        <input type="hidden" name="accountId" value="${account.accountId}">
                                                        <input type="hidden" name="isActive" value="${account.roleID != 2}">
                                                        <button type="button" class="toggle-btn ${account.roleID == 2 ? 'active-icon' : ''}" 
                                                                onclick="showConfirmModal(${account.accountId}, ${account.roleID == 2})"
                                                                title="${account.roleID == 2 ? 'Đang hoạt động (Click để vô hiệu hóa)' : 'Đã vô hiệu hóa (Click để kích hoạt)'}">
                                                            <i class="bi ${account.roleID == 2 ? 'bi-toggle-on' : 'bi-toggle-off'}"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty sessionScope.accountStaff}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-4">Không có thông tin nhân viên nào.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Tab: Nhân viên đã nghỉ việc -->
                    <div class="tab-pane fade" id="former-staff" role="tabpanel" aria-labelledby="former-staff-tab">
                        <div class="table-responsive">
                            <table class="table datatable">
                                <thead>
                                    <tr>
                                        <th>Nhân viên</th>
                                        <th>Tên đăng nhập</th>
                                        <th>Điện thoại</th>
                                        <th>Mã Đơn hàng</th>
                                        <th>Hạn cuối</th>
                                        <th class="text-danger">Quá hạn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${sessionScope.accountBookingMap}">
                                        <c:set var="accountK" value="${entry.key}" />
                                        <c:set var="bookingK" value="${entry.value}" />
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center gap-3">
                                                    <span class="avatar-initial" style="background:#94a3b8;">${fn:substring(accountK.firstName, 0, 1)}</span>
                                                    <div>
                                                        <div class="fw-bold-dark">${accountK.firstName} ${accountK.lastName}</div>
                                                        <div style="font-size: 0.8rem; color: #64748b;">ID: #${accountK.accountId}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>${accountK.userName}</td>
                                            <td>${accountK.phoneNumber}</td>
                                            <td><span class="fw-bold text-dark">#${bookingK.bookingID}</span></td>
                                            <td>${bookingK.endDate}</td>
                                            <td class="text-danger fw-bold">${bookingK.overdueDays} ngày</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty sessionScope.accountBookingMap}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-4">Không có dữ liệu.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== Modal Xác Nhận ===== -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header modal-header-gold">
                    <h5 class="modal-title"><i class="bi bi-exclamation-triangle-fill me-2"></i>Xác nhận thay đổi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center py-4">
                    <p id="confirmModalMessage" class="fs-5 text-dark mb-0"></p>
                </div>
                <div class="modal-footer border-0 d-flex justify-content-center bg-light">
                    <button type="button" class="btn btn-secondary px-4 rounded-pill" data-bs-dismiss="modal">Không</button>
                    <button type="button" id="confirmModalYesButton" class="btn btn-gold px-4 rounded-pill text-white" style="background:var(--gold);">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== Modal Thông Tin Chi Tiết ===== -->
    <div class="modal fade" id="user-form-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header modal-header-gold">
                    <h5 class="modal-title"><i class="bi bi-person-badge me-2"></i>Hồ sơ nhân viên</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <!-- Cột Trái: Avatar & Tên -->
                        <div class="col-md-4 text-center border-end border-light mb-4 mb-md-0">
                            <img id="modal-image" src="" alt="Profile Image" class="profile-modal-avatar mb-3"
                                 onerror="this.src='https://ui-avatars.com/api/?name=NV&background=b59349&color=fff'">
                            <h4 id="modal-full-name" class="fw-bold-dark mb-1"></h4>
                            <span class="status-badge badge-active mt-2">Nhân viên SmartRide</span>
                        </div>
                        
                        <!-- Cột Phải: Thông tin chi tiết -->
                        <div class="col-md-8 px-md-4">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="detail-label">Tên đăng nhập</div>
                                    <div class="detail-value" id="modal-username"></div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="detail-label">Số điện thoại</div>
                                    <div class="detail-value" id="modal-phone-number"></div>
                                </div>
                                
                                <div class="col-sm-6">
                                    <div class="detail-label">Email</div>
                                    <div class="detail-value" id="modal-email"></div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="detail-label">Ngày sinh</div>
                                    <div class="detail-value" id="modal-dob"></div>
                                </div>
                                
                                <div class="col-sm-6">
                                    <div class="detail-label">Giới tính</div>
                                    <div class="detail-value" id="modal-gender"></div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="detail-label">Địa chỉ</div>
                                    <div class="detail-value" id="modal-address"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="staffAssets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="staffAssets/vendor/simple-datatables/simple-datatables.js"></script>
    
    <script type="text/javascript">
        // Khởi tạo datatable
        document.addEventListener('DOMContentLoaded', () => {
            const tables = document.querySelectorAll('.datatable');
            tables.forEach(table => {
                new simpleDatatables.DataTable(table, {
                    searchable: true,
                    fixedHeight: false,
                    perPage: 10,
                    labels: {
                        placeholder: "Tìm kiếm...",
                        noRows: "Không tìm thấy dữ liệu",
                        info: "Hiển thị {start} đến {end} của {rows} kết quả"
                    }
                });
            });
        });

        // Hàm mở Modal Chi Tiết
        function openUserModal(button) {
            document.getElementById('modal-full-name').textContent = button.getAttribute('data-fullName');
            document.getElementById('modal-username').textContent = button.getAttribute('data-username');
            document.getElementById('modal-phone-number').textContent = button.getAttribute('data-phoneNumber');
            document.getElementById('modal-email').textContent = button.getAttribute('data-email');
            document.getElementById('modal-dob').textContent = button.getAttribute('data-dob');
            document.getElementById('modal-gender').textContent = button.getAttribute('data-gender');
            document.getElementById('modal-address').textContent = button.getAttribute('data-address');
            
            const imgUrl = button.getAttribute('data-image');
            const imgEl = document.getElementById('modal-image');
            if (imgUrl && imgUrl.trim() !== '') {
                imgEl.src = imgUrl;
            } else {
                imgEl.src = 'https://ui-avatars.com/api/?name=' + encodeURIComponent(button.getAttribute('data-fullName')) + '&background=b59349&color=fff';
            }
            
            var modal = new bootstrap.Modal(document.getElementById('user-form-modal'));
            modal.show();
        }

        // Logic Modal Confirm
        let formToSubmit;
        function showConfirmModal(accountId, isActive) {
            formToSubmit = document.getElementById('form-' + accountId);
            document.getElementById('confirmModalMessage').innerText = isActive ?
                    "Bạn có chắc chắn muốn vô hiệu hóa tài khoản này (cho nghỉ việc) không?" :
                    "Bạn có chắc chắn muốn kích hoạt lại tài khoản này không?";
            var confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
            confirmModal.show();
        }

        document.getElementById('confirmModalYesButton').addEventListener('click', function () {
            if (formToSubmit) {
                formToSubmit.submit();
            }
        });
    </script>
</body>
</html>

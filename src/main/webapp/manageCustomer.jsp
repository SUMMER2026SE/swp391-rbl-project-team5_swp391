<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Manage Customer - SmartRide</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!-- Vendor CSS Files -->
        <link href="staffAssets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="staffAssets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="staffAssets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="staffAssets/vendor/quill/quill.snow.css" rel="stylesheet">
        <link href="staffAssets/vendor/quill/quill.bubble.css" rel="stylesheet">
        <link href="staffAssets/vendor/remixicon/remixicon.css" rel="stylesheet">
        <link href="staffAssets/vendor/simple-datatables/style.css" rel="stylesheet">
        <!-- Template Main CSS File -->
        <link href="staffAssets/css/style.css" rel="stylesheet">

        <style type="text/css">
            .info label {
                font-style: italic;
                width: 20%;
                font-weight: 500;
            }

            .close:hover {
                opacity: 0.8;
                background: lightgray;
            }

            .fa-toggle-on:before {
                color: blue;
            }

            /* Custom Table Styles matching Voucher page */
            .table {
                border-collapse: separate !important;
                border-spacing: 0 !important;
                border: 1px solid #e2e8f0 !important;
                border-radius: 8px !important;
                overflow: hidden !important;
            }
            .table th {
                white-space: nowrap;
                background-color: #f1f5f9 !important;
                color: #334155 !important;
                font-size: 0.85rem !important;
                text-transform: uppercase !important;
                letter-spacing: 0.5px !important;
                padding: 14px 16px !important;
                border-bottom: 2px solid #cbd5e1 !important;
                border-right: 1px solid #e2e8f0 !important;
            }
            .table th:last-child {
                border-right: none !important;
            }
            .table td {
                vertical-align: middle !important;
                padding: 14px 16px !important;
                border-bottom: 1px solid #e2e8f0 !important;
                border-right: 1px solid #e2e8f0 !important;
            }
            .table td:last-child {
                border-right: none !important;
            }
            .table tr:last-child td {
                border-bottom: none !important;
            }

            .datatable-top {
                padding: 15px 0 !important;
            }
            .datatable-top > div:last-child {
                position: relative;
            }
            .datatable-input {
                width: 450px !important; 
                max-width: 100%;
                padding: 10px 20px 10px 45px !important; /* Space for the icon on the left */
                border-radius: 25px !important; /* Beautiful pill shape */
                border: 1px solid #ced4da !important;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05) !important;
                transition: all 0.3s ease;
                font-size: 14.5px;
                background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="%23b59349" viewBox="0 0 16 16"><path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/></svg>') no-repeat 18px center !important;
                background-color: #ffffff !important;
                background-size: 16px !important;
            }
            .datatable-input:focus {
                border-color: #b59349 !important;
                box-shadow: 0 0 0 4px rgba(181, 147, 73, 0.15) !important;
                outline: none !important;
            }
        </style>
    </head>
    <body>
        
        <div class="container-fluid mt-4">
            <div class="pagetitle mb-4">
                <h1>Quản lý khách hàng</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="homeStaff" target="_top">Trang Chủ</a></li>
                        <li class="breadcrumb-item active">Quản lý khách hàng</li>
                    </ol>
                </nav>
            </div>

            <section class="section">
                <div class="row flex-lg-nowrap">
                    <!-- Main Content (Full Width) -->
                    <div class="col-12">
                        <div>
                            <ul class="nav nav-tabs nav-tabs-bordered">
                            <li class="nav-item">
                                <a class="nav-link active fw-bold" id="customer-tab" data-bs-toggle="tab" href="#customer">Thông tin khách hàng</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link fw-bold" id="overdue-tab" data-bs-toggle="tab" href="#overdue">Quá hạn thuê xe</a>
                            </li>
                        </ul>
                    </div>
                    <div class="tab-content mt-3">
                        <div id="customer" class="tab-pane fade show active">
                            <div class="card border-0 shadow-sm custom-card">
                                <div class="card-body p-4 pb-0">
                                    <div class="card-title mb-4">
                                        <h5 class="m-0 fw-bold text-dark" style="font-family: 'Be Vietnam Pro', sans-serif;">Danh sách khách hàng</h5>
                                    </div>
                                    <div class="e-table">
                                        <div class="table-responsive table-lg">
                                            <table class="table table-hover align-middle datatable mb-0">
                                                <thead class="table-light text-muted" style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;">
                                                    <tr>
                                                        <th class="ps-3">ID</th>
                                                        <th>Họ và tên</th>
                                                        <th>Tên đăng nhập</th>
                                                        <th>Ngày sinh</th>
                                                        <th>Điện thoại</th>
                                                        <th class="text-center">Trạng thái</th>
                                                        <th class="text-center">Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="customer-table-body">
                                                    <c:if test="${empty sessionScope.accounts}">
                                                        <tr>
                                                            <td colspan="8" style="text-align: center; font-style: italic; padding: 18px; font-size: 17px;">
                                                                Không có thông tin nào ở đây
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="account" items="${sessionScope.accounts}">
                                                        <tr id="account-${account.accountId}" data-account-id="${account.accountId}"
                                                            class="m-3 <c:out value='${account.roleID == 1 ? "active" : "disabled"}' />">
                                                            <td style="padding: 24px;" name="accountId" class="align-middle">${account.accountId}</td>                                                            <td name="fullname" class="text-nowrap align-middle">${account.firstName} ${account.lastName}</td>
                                                            <td name="username" class="text-nowrap align-middle">${account.userName}</td>
                                                            <td name="dob" class="text-nowrap align-middle">${account.dob}</td>
                                                            <td name="phoneNumber" class="text-nowrap align-middle">${account.phoneNumber}</td>
                                                            <td class="text-center align-middle">
                                                                <span class="badge ${account.roleID == 1 ? 'bg-success' : 'bg-danger'} rounded-pill fw-normal px-3 py-2" style="font-size: 0.8rem; background-color: ${account.roleID == 1 ? '#198754' : '#dc3545'};">
                                                                    <i class="fa ${account.roleID == 1 ? 'fa-check-circle' : 'fa-ban'} me-1"></i>
                                                                    ${account.roleID == 1 ? 'Hoạt động' : 'Vô hiệu hóa'}
                                                                </span>
                                                            </td>
                                                            <td class="text-center align-middle">
                                                                <div class="btn-group align-top gap-2">
                                                                    <button class="btn btn-sm btn-outline-info rounded-pill edit-btn fw-medium px-3" type="button"
                                                                            data-bs-toggle="modal" data-bs-target="#user-form-modal"
                                                                            data-accountId="${account.accountId}"
                                                                            data-fullName="${account.firstName} ${account.lastName}"
                                                                            data-dob="${account.dob}"
                                                                            data-email="${account.email}"
                                                                            data-address="${account.address}"
                                                                            data-gender="${account.gender}"
                                                                            data-phoneNumber="${account.phoneNumber}"
                                                                            data-image="${account.image}"
                                                                            data-username="${account.userName}"
                                                                            data-idCardNumber="${customerMap[account.accountId].identityCard}"
                                                                            data-idCardIssueDate="${customerMap[account.accountId].issuedOnDate}"
                                                                            data-idCardExpiryDate="${customerMap[account.accountId].expDate}"
                                                                            data-idCardType="${customerMap[account.accountId].typeCard}"
                                                                            data-idCardImage="${customerMap[account.accountId].identityCardImage}"
                                                                            data-bookingCount="${bookingCount[account.accountId]}"
                                                                            onclick="openUserModal(this)">
                                                                        <i class="fa fa-eye me-1"></i> Xem
                                                                    </button>
                                                                    <button type="button" class="btn btn-sm ${account.roleID == 1 ? 'btn-outline-danger' : 'btn-outline-success'} rounded-pill fw-medium px-3" onclick="showConfirmModal(${account.accountId}, ${account.roleID == 1})">
                                                                        <i class="fa ${account.roleID == 1 ? 'fa-lock' : 'fa-unlock'} me-1"></i> 
                                                                        ${account.roleID == 1 ? 'Khóa' : 'Mở'}
                                                                    </button>
                                                                    <form id="form-${account.accountId}" action="manageCustomer" method="post" style="display:none;">
                                                                        <input type="hidden" name="action" value="updateRoleAndGetStatuses">
                                                                        <input type="hidden" name="accountId" value="${account.accountId}">
                                                                        <input type="hidden" name="isActive" value="${account.roleID != 1}">
                                                                    </form>
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
                        </div>

                        <div id="overdue" class="tab-pane fade">
                            <div class="card border-0 shadow-sm custom-card">
                                <div class="card-body p-4 pb-0">
                                    <div class="card-title mb-4">
                                        <h5 class="m-0 fw-bold text-danger" style="font-family: 'Be Vietnam Pro', sans-serif;"><i class="fa fa-exclamation-triangle me-2"></i>Danh sách khách hàng quá hạn</h5>
                                    </div>
                                    <div class="e-table">
                                        <div class="table-responsive table-lg">
                                            <table class="table table-bordered datatable mb-0">
                                                <thead class="table-light text-muted" style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;">
                                                    <tr>
                                                        <th class="ps-3">ID</th>
                                                        <th>Họ và tên</th>
                                                        <th>Tên đăng nhập</th>
                                                        <th>Điện thoại</th>
                                                        <th>Đơn hàng</th>
                                                        <th>Hạn cuối</th>
                                                        <th scope="col">Quá hạn</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="customer-table-body">
                                                    <c:if test="${empty sessionScope.accounts}">
                                                        <tr>
                                                            <td colspan="8" style="text-align: center; font-style: italic; padding: 18px; font-size: 17px;">
                                                                Không có thông tin nào ở đây
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="entry" items="${sessionScope.accountBookingMap}">
                                                        <c:set var="accountK" value="${entry.key}" />
                                                        <c:set var="bookingK" value="${entry.value}" />
                                                       
                                                        <tr>
                                                            <td style="padding: 24px;" name="accountId" class="align-middle">${accountK.accountId}</td>
                                                            <td name="fullname" class="text-nowrap align-middle">${accountK.firstName} ${accountK.lastName}</td>
                                                            <td name="username" class="text-nowrap align-middle">${accountK.userName}</td>
                                                            <td name="phoneNumber" class="text-nowrap align-middle">${accountK.phoneNumber}</td>
                                                            <td name="bookingId" class="text-nowrap align-middle">${bookingK.bookingID}</td>
                                                            <td name="endDate" class="text-nowrap align-middle">${bookingK.endDate}</td>
                                                            <td name="overdueDays" class="text-danger fw-bold text-nowrap align-middle">${bookingK.overdueDays} ngày</td>
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

                    <!-- modal để hiển thị thông báo confirm chuyển trạng thái -->
                    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="confirmModalLabel">Xác nhận</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body" id="confirmModalMessage">
                                    <!-- Message will be set by JavaScript -->
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Không</button>
                                    <button type="button" id="confirmModalYesButton" class="btn btn-primary">Có</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal hiển thị thông tin chi tiết -->
                    <div class="modal fade" id="user-form-modal" tabindex="-1" aria-labelledby="userModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-xl modal-dialog-centered">
                            <div class="modal-content border-0 shadow-lg" style="border-radius: 15px; overflow: hidden;">
                                
                                <div class="modal-body p-0">
                                    <button type="button" class="btn-close position-absolute top-0 end-0 m-4 z-3 bg-white p-2 rounded-circle shadow-sm opacity-75" data-bs-dismiss="modal" aria-label="Close"></button>
                                    
                                    <div class="row g-0">
                                        <!-- Cột Trái: Thông tin cơ bản (Nền vàng) -->
                                        <div class="col-lg-4 text-center p-5 text-white d-flex flex-column justify-content-center" style="background: linear-gradient(135deg, #b8860b 0%, #d4af37 100%);">
                                            <div class="position-relative d-inline-block mb-4">
                                                <img id="modal-image" src="" alt="Profile" 
                                                     class="rounded-circle border border-4 border-white shadow-lg" 
                                                     style="width: 150px; height: 150px; object-fit: cover; background-color: #fff; cursor: pointer;"
                                                     onclick="zoomImage(this.src)"
                                                     onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=User&background=random';">
                                            </div>
                                            <h4 class="fw-bold mb-1 text-white" id="modal-full-name">Tên Khách Hàng</h4>
                                            <p class="text-white-50 mb-4">@<span id="modal-username">username</span></p>
                                            
                                            <div class="d-inline-flex align-items-center bg-white bg-opacity-25 rounded-pill px-4 py-2 text-white mb-4 shadow-sm border border-white border-opacity-25 mx-auto">
                                                <i class="fa fa-shopping-cart text-white me-2"></i>
                                                <span class="small me-2">Đã đặt:</span>
                                                <span class="fw-bold fs-5" id="modal-booking-count">0</span>
                                                <span class="small ms-1">xe</span>
                                            </div>
                                            
                                            <hr class="border-white opacity-25 w-75 mx-auto mb-4">
                                            
                                            <!-- Contact info short -->
                                            <div class="text-start text-white opacity-100 small px-3">
                                                <p class="mb-3 d-flex align-items-center"><i class="fa fa-phone fa-fw me-3 opacity-75"></i><span id="modal-phone-number" class="fw-medium">090xxxxxxx</span></p>
                                                <p class="mb-3 d-flex align-items-center"><i class="fa fa-envelope fa-fw me-3 opacity-75"></i><span id="modal-email" class="fw-medium text-break">email@example.com</span></p>
                                                <p class="mb-0 d-flex align-items-start"><i class="fa fa-map-marker-alt fa-fw me-3 mt-1 opacity-75"></i><span id="modal-address" class="fw-medium">Địa chỉ</span></p>
                                            </div>
                                        </div>

                                        <!-- Cột Phải: Thông tin chi tiết -->
                                        <div class="col-lg-8 p-5 bg-white">
                                            <h5 class="fw-bold text-dark mb-4 border-bottom pb-3">Hồ sơ chi tiết</h5>
                                            
                                            <div class="row mb-5">
                                                <!-- Thông tin cá nhân -->
                                                <div class="col-md-6 mb-4 mb-md-0 border-end">
                                                    <h6 class="fw-bold text-muted text-uppercase mb-4" style="font-size: 0.75rem; letter-spacing: 1px;"><i class="fa fa-user me-2"></i>Thông tin cá nhân</h6>
                                                    <div class="mb-4">
                                                        <small class="text-muted d-block mb-1">Ngày sinh</small>
                                                        <span class="fw-medium text-dark" id="modal-dob">...</span>
                                                    </div>
                                                    <div>
                                                        <small class="text-muted d-block mb-1">Giới tính</small>
                                                        <span class="fw-medium text-dark" id="modal-gender">...</span>
                                                    </div>
                                                </div>
                                                
                                                <!-- Giấy tờ tùy thân -->
                                                <div class="col-md-6 ps-md-4">
                                                    <h6 class="fw-bold text-muted text-uppercase mb-4" style="font-size: 0.75rem; letter-spacing: 1px;"><i class="fa fa-id-card me-2"></i>Giấy tờ xác minh</h6>
                                                    <div class="row">
                                                        <div class="col-sm-6 mb-4">
                                                            <small class="text-muted d-block mb-1">Loại giấy tờ</small>
                                                            <span class="fw-medium text-dark" id="modal-id-card-type">...</span>
                                                        </div>
                                                        <div class="col-sm-6 mb-4">
                                                            <small class="text-muted d-block mb-1">Mã số</small>
                                                            <span class="fw-medium text-dark" id="modal-id-card-number">...</span>
                                                        </div>
                                                        <div class="col-sm-6 mb-3 mb-sm-0">
                                                            <small class="text-muted d-block mb-1">Ngày cấp</small>
                                                            <span class="fw-medium text-dark" id="modal-id-card-issue-date">...</span>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <small class="text-muted d-block mb-1">Ngày hết hạn</small>
                                                            <span class="fw-medium text-dark" id="modal-id-card-expiry-date">...</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Ảnh CMND -->
                                            <h6 class="fw-bold text-muted text-uppercase mb-3" style="font-size: 0.75rem; letter-spacing: 1px;"><i class="fa fa-camera me-2"></i>Ảnh giấy tờ</h6>
                                            <div class="bg-light border rounded-3 p-3 text-center d-flex flex-column align-items-center justify-content-center" style="min-height: 220px; border-style: dashed !important; border-width: 2px !important;">
                                                <div id="modal-id-card-images" class="w-100 d-none row g-3 m-0">
                                                    <div class="col-6 p-0 pe-2">
                                                        <p class="small text-muted mb-1 fw-bold text-start"><i class="fa fa-id-card-o me-1"></i> Mặt trước</p>
                                                        <div class="border rounded shadow-sm" style="height: 160px; overflow: hidden; background: #fff;">
                                                            <img id="modal-id-card-front" src="" alt="Mặt trước" class="w-100 h-100" style="object-fit: cover; cursor: pointer;" onclick="zoomImage(this.src)" onerror="this.onerror=null; this.src='https://placehold.co/600x400/f8f9fa/a0aec0?text=Loi+Hien+Thi';">
                                                        </div>
                                                    </div>
                                                    <div class="col-6 p-0 ps-2">
                                                        <p class="small text-muted mb-1 fw-bold text-start"><i class="fa fa-id-card me-1"></i> Mặt sau</p>
                                                        <div class="border rounded shadow-sm" style="height: 160px; overflow: hidden; background: #fff;">
                                                            <img id="modal-id-card-back" src="" alt="Mặt sau" class="w-100 h-100" style="object-fit: cover; cursor: pointer;" onclick="zoomImage(this.src)" onerror="this.onerror=null; this.src='https://placehold.co/600x400/f8f9fa/a0aec0?text=Loi+Hien+Thi';">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="modal-id-card-placeholder" class="text-muted">
                                                    <i class="fa fa-image fs-1 mb-3 text-secondary opacity-50"></i><br>
                                                    <span class="small fw-medium">Chưa cập nhật ảnh giấy tờ</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                        </div>
                    </div>
                </div>

                <!-- Bottom Panels Row -->
                <div class="row mt-4">
                    <!-- Stats Panel -->
                    <div class="col-12 col-md-4">
                        <div class="card border-0 shadow-sm custom-card mb-4 h-100">
                            <div class="card-body p-4">
                                <h6 class="fw-bold text-dark text-uppercase mb-3" style="font-size: 0.85rem; letter-spacing: 0.5px;"><i class="bi bi-bar-chart-fill me-2 text-warning"></i>Thống kê & Trạng thái</h6>
                                
                                <div class="list-group list-group-flush border-bottom-0" id="statusFilterGroup">
                                    <button type="button" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 active rounded-3 mb-1" data-status="all" style="cursor:pointer; background-color: rgba(184, 134, 11, 0.1); color: #b8860b; font-weight: bold; border-left: 4px solid #b8860b !important;">
                                        <span><i class="fa fa-users me-2"></i>Tất cả</span>
                                        <span class="badge bg-primary rounded-pill" style="background-color: #b8860b !important;">${allCount}</span>
                                    </button>
                                    <button type="button" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 rounded-3 mb-1" data-status="active" style="cursor:pointer">
                                        <span class="text-success"><i class="fa fa-check-circle me-2"></i>Hoạt động</span>
                                        <span class="badge bg-success rounded-pill">${activeCount}</span>
                                    </button>
                                    <button type="button" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 rounded-3 mb-1" data-status="disabled" style="cursor:pointer">
                                        <span class="text-danger"><i class="fa fa-ban me-2"></i>Vô hiệu hóa</span>
                                        <span class="badge bg-danger rounded-pill">${disabledCount}</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>         
            </section>
        </div>

    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="staffAssets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="staffAssets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="staffAssets/js/main.js"></script>
    <script type="text/javascript">
                                        function openUserModal(button) {
                                            var modal = $('#user-form-modal');
                                            var accountId = button.getAttribute('data-accountId');
                                            modal.find('#modal-full-name').text(button.getAttribute('data-fullName'));
                                            modal.find('#modal-dob').text(button.getAttribute('data-dob'));
                                            modal.find('#modal-email').text(button.getAttribute('data-email'));
                                            modal.find('#modal-address').text(button.getAttribute('data-address'));
                                            modal.find('#modal-gender').text(button.getAttribute('data-gender'));
                                            let imgStr = button.getAttribute('data-image');
                                            if (!imgStr || imgStr.trim() === '') {
                                                imgStr = 'https://ui-avatars.com/api/?name=' + encodeURIComponent(button.getAttribute('data-fullName')) + '&background=random';
                                            }
                                            modal.find('#modal-image').attr('src', imgStr);
                                            modal.find('#modal-phone-number').text(button.getAttribute('data-phoneNumber'));
                                            modal.find('#modal-username').text(button.getAttribute('data-username'));
                                            modal.find('#modal-id-card-number').text(button.getAttribute('data-idCardNumber'));
                                            modal.find('#modal-id-card-issue-date').text(button.getAttribute('data-idCardIssueDate'));
                                            modal.find('#modal-id-card-expiry-date').text(button.getAttribute('data-idCardExpiryDate'));
                                            modal.find('#modal-id-card-type').text(button.getAttribute('data-idCardType'));
                                            modal.find('#modal-booking-count').text(button.getAttribute('data-bookingCount'));
                                            
                                            // Xử lý ảnh CMND/CCCD
                                            let idCardImg = button.getAttribute('data-idCardImage');
                                            if (idCardImg && idCardImg.trim() !== '' && idCardImg.trim() !== 'null' && idCardImg.trim() !== 'undefined') {
                                                let images = idCardImg.split(',');
                                                
                                                // Front Image
                                                let frontSrc = '';
                                                if (images[0] && images[0].trim() !== '' && images[0].trim() !== 'null') {
                                                    let img = images[0].trim();
                                                    frontSrc = img.startsWith('http') ? img : 'images/' + img;
                                                }
                                                
                                                // Back Image
                                                let backSrc = '';
                                                if (images.length > 1 && images[1] && images[1].trim() !== '' && images[1].trim() !== 'null') {
                                                    let img = images[1].trim();
                                                    backSrc = img.startsWith('http') ? img : 'images/' + img;
                                                }
                                                
                                                // Default placeholder URL
                                                const placeholderUrl = 'https://placehold.co/600x400/f8f9fa/a0aec0?text=Chua+Cap+Nhat';
                                                
                                                // Handle Front Image View
                                                if(frontSrc) {
                                                    modal.find('#modal-id-card-front').attr('src', frontSrc);
                                                } else {
                                                    modal.find('#modal-id-card-front').attr('src', placeholderUrl);
                                                }
                                                modal.find('#modal-id-card-front').parent().show();
                                                
                                                // Handle Back Image View
                                                if(backSrc) {
                                                    modal.find('#modal-id-card-back').attr('src', backSrc);
                                                } else {
                                                    modal.find('#modal-id-card-back').attr('src', placeholderUrl);
                                                }
                                                modal.find('#modal-id-card-back').parent().show();
                                                
                                                modal.find('#modal-id-card-images').removeClass('d-none').addClass('d-flex');
                                                modal.find('#modal-id-card-placeholder').hide();
                                            } else {
                                                modal.find('#modal-id-card-images').removeClass('d-flex').addClass('d-none');
                                                modal.find('#modal-id-card-placeholder').show();
                                            }

                                            $('#user-form-modal').modal('show'); //boostrap jqs
                                        }

                                        function closeDetail()
                                        {
                                            $('#user-form-modal').modal('hide');
                                        }

                                        document.addEventListener("DOMContentLoaded", function () {
                                            const filterButtons = document.querySelectorAll("#statusFilterGroup .list-group-item");
                                            filterButtons.forEach(button => {
                                                button.addEventListener("click", function (e) {
                                                    e.preventDefault();
                                                    
                                                    // Loại bỏ class active khỏi tất cả nút
                                                    filterButtons.forEach(btn => {
                                                        btn.classList.remove("active");
                                                        btn.style.backgroundColor = "";
                                                        btn.style.color = "";
                                                        btn.style.fontWeight = "normal";
                                                        btn.style.borderLeft = "none";
                                                    });
                                                    
                                                    // Thêm class active cho nút vừa click
                                                    this.classList.add("active");
                                                    this.style.backgroundColor = "rgba(184, 134, 11, 0.1)"; // Màu nền vàng nhạt/nâu nhạt
                                                    this.style.color = "#b8860b"; // Chữ màu vàng/nâu (dark goldenrod)
                                                    this.style.fontWeight = "bold";
                                                    this.style.borderLeft = "4px solid #b8860b";
                                                    
                                                    // Gọi hàm filter
                                                    filterTableByStatus(this.getAttribute("data-status"));
                                                });
                                            });
                                        });

                                        function filterTableByStatus(status) {
                                            const tbody = document.getElementById("customer-table-body");
                                            if (!tbody) return;
                                            
                                            const rows = tbody.querySelectorAll("tr:not(.empty-msg-row)");
                                            let visibleCount = 0;
                                            
                                            rows.forEach(row => {
                                                if (status === "all") {
                                                    row.style.display = "";
                                                    visibleCount++;
                                                } else if (status === "active" && row.classList.contains("active")) {
                                                    row.style.display = "";
                                                    visibleCount++;
                                                } else if (status === "disabled" && row.classList.contains("disabled")) {
                                                    row.style.display = "";
                                                    visibleCount++;
                                                } else {
                                                    row.style.display = "none";
                                                }
                                            });
                                            
                                            let emptyRow = tbody.querySelector(".empty-msg-row");
                                            if (visibleCount === 0) {
                                                if (!emptyRow) {
                                                    emptyRow = document.createElement("tr");
                                                    emptyRow.className = "empty-msg-row";
                                                    emptyRow.innerHTML = '<td colspan="8" style="text-align: center; font-style: italic; padding: 18px; font-size: 17px; color: #6c757d;">Không có thông tin nào ở đây</td>';
                                                    tbody.appendChild(emptyRow);
                                                }
                                                emptyRow.style.display = "";
                                            } else {
                                                if (emptyRow) {
                                                    emptyRow.style.display = "none";
                                                }
                                            }
                                        }
                                        let formToSubmit;

                                        function showConfirmModal(accountId, isActive) {
                                            formToSubmit = document.getElementById('form-' + accountId);
                                            document.getElementById('confirmModalMessage').innerText = isActive ?
                                                    "Bạn có chắc chắn muốn vô hiệu hóa tài khoản này không?" :
                                                    "Bạn có chắc chắn muốn mở tài khoản này không?";
                                            $('#confirmModal').modal('show');
                                        }

                                        document.getElementById('confirmModalYesButton').addEventListener('click', function () {
                                            if (formToSubmit) {
                                                formToSubmit.submit();
                                            } else {
                                                console.error("Form to submit is null"); // Log lỗi nếu formToSubmit không có giá trị
                                            }
                                        });
    </script>
</body>
</html>

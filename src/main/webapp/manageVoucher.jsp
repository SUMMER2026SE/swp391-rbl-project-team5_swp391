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
        <title>Manage Voucher - SmartRide</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!-- Vendor CSS Files -->
        <link href="staffAssets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="staffAssets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="staffAssets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <!-- Template Main CSS File -->
        <link href="staffAssets/css/style.css" rel="stylesheet">
        <!-- SweetAlert2 -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style type="text/css">
            .custom-card {
                border-radius: 12px;
                border: none;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            }
            .voucher-code {
                font-family: monospace;
                font-size: 1rem;
                font-weight: 700;
                color: #b8860b;
                background-color: rgba(184, 134, 11, 0.1);
                padding: 6px 12px;
                border-radius: 8px;
                border: 1px dashed rgba(184, 134, 11, 0.4);
                letter-spacing: 1px;
            }
            
            /* Restore standard table behavior */
            .table-responsive {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }
            .table {
                border-collapse: separate;
                border-spacing: 0;
                border: 1px solid #e2e8f0;
                border-radius: 8px;
                overflow: hidden;
            }
            .table th {
                white-space: nowrap;
                background-color: #f1f5f9 !important;
                color: #334155 !important;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                padding: 14px 16px !important;
                border-bottom: 2px solid #cbd5e1 !important;
                border-right: 1px solid #e2e8f0;
            }
            .table th:last-child {
                border-right: none;
            }
            .table td {
                vertical-align: middle;
                padding: 14px 16px !important;
                border-bottom: 1px solid #e2e8f0;
                border-right: 1px solid #e2e8f0;
            }
            .table td:last-child {
                border-right: none;
            }
            .table tr:last-child td {
                border-bottom: none;
            }
            .table td.nowrap {
                white-space: nowrap;
            }
            
            /* Premium Button */
            .btn-premium {
                background: linear-gradient(135deg, #d4af37 0%, #b8860b 100%);
                color: white !important;
                border: none;
                border-radius: 20px;
                padding: 10px 24px;
                font-weight: 600;
                letter-spacing: 0.5px;
                box-shadow: 0 4px 15px rgba(184, 134, 11, 0.3);
                transition: all 0.3s ease;
            }
            .btn-premium:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(184, 134, 11, 0.4);
                background: linear-gradient(135deg, #b8860b 0%, #d4af37 100%);
            }
            
            /* Modern Datatable Controls */
            .dataTable-top, .datatable-top { 
                padding: 0 0 1.5rem 0 !important; 
                margin-bottom: 1rem !important; 
                display: flex !important;
                justify-content: space-between !important;
                align-items: center !important;
            }
            .dataTable-search, .datatable-search {
                margin-bottom: 0 !important;
            }
            .dataTable-input, .datatable-input { 
                border-radius: 20px !important; 
                border: 1px solid #dee2e6 !important; 
                padding: 8px 20px !important; 
                font-size: 0.9rem !important;
                outline: none !important;
                box-shadow: 0 2px 5px rgba(0,0,0,0.02) !important;
                transition: all 0.2s ease !important;
            }
            .dataTable-input:focus, .datatable-input:focus {
                border-color: #b59349 !important;
                box-shadow: 0 0 0 0.25rem rgba(181, 147, 73, 0.25) !important;
            }
            .dataTable-selector, .datatable-selector { 
                border-radius: 8px !important; 
                border: 1px solid #dee2e6 !important; 
                padding: 6px 12px !important; 
                font-size: 0.9rem !important;
            }
            .dataTable-pagination a, .datatable-pagination a {
                border-radius: 8px !important;
                margin: 0 2px !important;
                border: none !important;
                color: #495057 !important;
                padding: 8px 16px !important;
                font-weight: 500 !important;
            }
            .dataTable-pagination a:hover, .datatable-pagination a:hover {
                background-color: #f8f9fa !important;
            }
            .dataTable-pagination .active a, .datatable-pagination .active a,
            .dataTable-pagination .active a:focus, .dataTable-pagination .active a:hover,
            .datatable-pagination .active a, .datatable-pagination .active a:focus, .datatable-pagination .active a:hover {
                background-color: #b59349 !important;
                color: white !important;
                box-shadow: 0 4px 10px rgba(181, 147, 73, 0.3) !important;
            }
            
            .datatable-top {
                padding: 15px 0 !important;
            }
            .datatable-top > div:last-child { /* The wrapper generated by simple-datatables */
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
            <div class="pagetitle mb-4 d-flex justify-content-between align-items-center">
                <div>
                    <h1>Quản lý Khuyến mãi (Voucher)</h1>
                    <nav>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="homeStaff" target="_top">Trang Chủ</a></li>
                            <li class="breadcrumb-item active">Quản lý Khuyến mãi</li>
                        </ol>
                    </nav>
                </div>
                <button class="btn btn-premium shadow-sm" data-bs-toggle="modal" data-bs-target="#voucherModal" onclick="openAddModal()">
                    <i class="bi bi-plus-circle me-1"></i> Tạo Voucher Mới
                </button>
            </div>

            <section class="section">
                <div class="row">
                    <!-- Main Content (Full Width Table) -->
                    <div class="col-12">
                        <div class="card border-0 shadow-sm custom-card">
                            <div class="card-body p-4">
                                <h5 class="card-title fw-bold text-dark mb-4">Danh sách Voucher</h5>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle datatable mb-0">
                                        <thead>
                                            <tr>
                                                <th data-sortable="false">STT</th>
                                                <th data-sortable="false">Mã Code</th>
                                                <th data-sortable="false" style="min-width: 200px;">Mô tả</th>
                                                <th data-sortable="false">Giảm giá</th>
                                                <th data-sortable="false">Ngày tạo</th>
                                                <th data-sortable="false">Trạng thái</th>
                                                <th data-sortable="false" class="text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="v" items="${vouchers}" varStatus="loop">
                                                <tr>
                                                    <td class="fw-bold text-muted nowrap">${loop.count}</td>
                                                    <td class="nowrap"><span class="voucher-code">${v.code}</span></td>
                                                    <td class="text-secondary">${v.description}</td>
                                                    <td class="text-success fw-bold fs-6 nowrap">
                                                        <fmt:formatNumber value="${v.discountAmount}" pattern="#,###"/> đ
                                                    </td>
                                                    <td class="text-secondary nowrap">${v.createdTime != null ? fn:substring(v.createdTime, 0, 16) : 'N/A'}</td>
                                                    <td class="nowrap">
                                                        <c:choose>
                                                            <c:when test="${v.status == 'Đang hoạt động'}">
                                                                <span class="badge bg-success rounded-pill px-3 py-2 fw-medium"><i class="bi bi-check-circle me-1"></i> Đang hoạt động</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary rounded-pill px-3 py-2 fw-medium"><i class="bi bi-pause-circle me-1"></i> Ngừng hoạt động</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="nowrap text-center">
                                                        <div class="d-flex justify-content-center gap-2">
                                                            <button class="btn btn-sm btn-outline-primary rounded-pill fw-medium px-3" 
                                                                data-id="${v.voucherId}" 
                                                                data-code="${v.code}" 
                                                                data-discount="${v.discountAmount}" 
                                                                data-desc="${fn:escapeXml(v.description)}" 
                                                                data-status="${v.status}" 
                                                                onclick="openEditModal(this)" title="Chỉnh sửa">
                                                                <i class="bi bi-pencil-square me-1"></i> Sửa
                                                            </button>
                                                            <c:choose>
                                                                <c:when test="${v.published}">
                                                                    <button id="publish-btn-${v.voucherId}" class="btn btn-sm rounded-pill fw-medium px-3" style="background-color: #198754; color: #fff; cursor: default; opacity: 0.8;" title="Đã phát hành" disabled>
                                                                        <i class="bi bi-check-circle me-1"></i> Đã phát hành
                                                                    </button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button id="publish-btn-${v.voucherId}" class="btn btn-sm btn-outline-success rounded-pill fw-medium px-3" onclick="publishNotification('voucher', ${v.voucherId})" title="Phát hành">
                                                                        <i class="bi bi-send me-1"></i> Phát hành
                                                                    </button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <button class="btn btn-sm btn-outline-danger rounded-pill fw-medium px-3" onclick="confirmDelete(${v.voucherId})" title="Xóa">
                                                                <i class="bi bi-trash me-1"></i> Xóa
                                                            </button>
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
                
                <!-- Bottom Panels Row -->
                <div class="row">
                    <!-- Stats Panel -->
                    <div class="col-12 col-md-4">
                        <div class="card border-0 shadow-sm custom-card mb-4 h-100">
                            <div class="card-body p-4">
                                <h6 class="fw-bold text-dark text-uppercase mb-3" style="font-size: 0.85rem; letter-spacing: 0.5px;"><i class="bi bi-bar-chart-fill me-2 text-warning"></i> Thống kê Voucher</h6>
                                
                                <div class="list-group list-group-flush border-bottom-0">
                                    <button type="button" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 active rounded-3 mb-1" style="background-color: rgba(184, 134, 11, 0.1); color: #8b6508; font-weight: 800; border-left: 4px solid #b8860b !important; cursor: default;">
                                        <span><i class="bi bi-ticket-perforated me-2"></i>Tổng số</span>
                                        <span class="badge rounded-pill" style="background-color: #b8860b !important; font-size: 0.9rem;">${fn:length(vouchers)}</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Guidelines Panel -->
                    <div class="col-12 col-md-8">
                        <div class="card border-0 shadow-sm custom-card mb-4 h-100">
                            <div class="card-body p-4">
                                <h6 class="fw-bold text-dark text-uppercase mb-3" style="font-size: 0.85rem; letter-spacing: 0.5px;"><i class="bi bi-info-circle-fill me-2 text-primary"></i> Hướng dẫn sử dụng</h6>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <p class="text-dark fw-medium small mb-2">
                                            <i class="bi bi-check-circle-fill text-success me-2"></i> <strong>Mã Code:</strong> Tự động được viết hoa khi lưu.
                                        </p>
                                        <p class="text-dark fw-medium small mb-2">
                                            <i class="bi bi-check-circle-fill text-success me-2"></i> <strong>Giảm giá:</strong> Số tiền được giảm cho khách thuê.
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <p class="text-dark fw-medium small mb-0">
                                            <i class="bi bi-check-circle-fill text-success me-2"></i> <strong>Thao tác:</strong> Có thể sửa, hoặc khóa voucher lại (ngừng áp dụng).
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- Modal Create/Edit Voucher -->
        <div class="modal fade" id="voucherModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header border-bottom-0 pb-0">
                        <h5 class="modal-title fw-bold text-dark" id="modalTitle"><i class="bi bi-ticket-perforated"></i> Tạo Voucher Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="manageVoucher" method="POST">
                        <div class="modal-body">
                            <input type="hidden" name="action" id="formAction" value="add">
                            <input type="hidden" name="voucherId" id="voucherId">
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Mã Code (Tự động in hoa)</label>
                                <input type="text" class="form-control" name="code" id="code" required placeholder="VD: SUMMER2024" style="text-transform: uppercase;">
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">Số tiền giảm (VND)</label>
                                <input type="number" class="form-control" name="discountAmount" id="discountAmount" required min="1000" step="1000" placeholder="VD: 50000">
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">Mô tả chương trình</label>
                                <textarea class="form-control" name="description" id="description" rows="3" required placeholder="Nhập lý do hoặc mô tả..."></textarea>
                            </div>
                            <div class="mb-3" id="statusDiv" style="display: none;">
                                <label class="form-label text-muted small fw-bold">Trạng thái</label>
                                <select class="form-select" name="status" id="status">
                                    <option value="Đang hoạt động">Đang hoạt động (Khách dùng được)</option>
                                    <option value="Ngừng hoạt động">Ngừng hoạt động (Tạm dừng/Hết hạn)</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer border-top-0 pt-0">
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-warning fw-bold text-dark shadow-sm">Lưu Voucher</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Delete Form -->
        <form id="deleteForm" action="manageVoucher" method="POST" style="display: none;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="voucherId" id="deleteVoucherId">
        </form>

        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

        <!-- Vendor JS Files -->
        <script src="staffAssets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="staffAssets/vendor/simple-datatables/simple-datatables.js"></script>
        <script src="staffAssets/vendor/tinymce/tinymce.min.js"></script>
        <!-- Template Main JS File -->
        <script src="staffAssets/js/main.js"></script>
        
        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            function openAddModal() {
                document.getElementById('modalTitle').innerHTML = '<i class="bi bi-ticket-perforated"></i> Tạo Voucher Mới';
                document.getElementById('formAction').value = 'add';
                document.getElementById('voucherId').value = '';
                document.getElementById('code').value = '';
                document.getElementById('discountAmount').value = '';
                document.getElementById('description').value = '';
                document.getElementById('statusDiv').style.display = 'none';
            }

            function openEditModal(btn) {
                var id = btn.getAttribute('data-id');
                var code = btn.getAttribute('data-code');
                var discount = btn.getAttribute('data-discount');
                var desc = btn.getAttribute('data-desc');
                var status = btn.getAttribute('data-status');
                
                document.getElementById('modalTitle').innerHTML = '<i class="bi bi-pencil-square"></i> Cập nhật Voucher';
                document.getElementById('formAction').value = 'edit';
                document.getElementById('voucherId').value = id;
                document.getElementById('code').value = code;
                document.getElementById('discountAmount').value = discount;
                document.getElementById('description').value = desc;
                document.getElementById('status').value = status.trim();
                
                document.getElementById('statusDiv').style.display = 'block';
                
                var myModal = new bootstrap.Modal(document.getElementById('voucherModal'));
                myModal.show();
            }

            function confirmDelete(id) {
                Swal.fire({
                    title: 'Xóa Voucher này?',
                    text: "Khách hàng sẽ không thể sử dụng mã này nữa!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Xóa ngay',
                    cancelButtonText: 'Hủy'
                }).then((result) => {
                    if (result.isConfirmed) {
                        document.getElementById('deleteVoucherId').value = id;
                        document.getElementById('deleteForm').submit();
                    }
                })
            }
            
            function publishNotification(type, id) {
                Swal.fire({
                    title: 'Phát hành thông báo?',
                    text: "Một thông báo Push Notification sẽ được gửi tự động đến TẤT CẢ KHÁCH HÀNG trong hệ thống!",
                    icon: 'info',
                    showCancelButton: true,
                    confirmButtonColor: '#198754',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Phát hành ngay',
                    cancelButtonText: 'Hủy'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/api/publish-notification',
                            type: 'POST',
                            data: { type: type, id: id },
                            success: function(res) {
                                if (res.status === 'success') {
                                    Swal.fire('Thành công!', 'Thông báo đã được phủ sóng đến toàn bộ khách hàng!', 'success');
                                    var btn = document.getElementById('publish-btn-' + id);
                                    if(btn) {
                                        btn.innerHTML = '<i class="bi bi-check-circle me-1"></i> Đã phát hành';
                                        btn.classList.remove('btn-outline-success');
                                        btn.style.backgroundColor = '#198754';
                                        btn.style.color = '#fff';
                                        btn.style.cursor = 'default';
                                        btn.style.opacity = '0.8';
                                        btn.disabled = true;
                                    }
                                } else {
                                    Swal.fire('Lỗi!', res.message || 'Không thể phát hành thông báo.', 'error');
                                }
                            },
                            error: function() {
                                Swal.fire('Lỗi!', 'Không thể kết nối đến máy chủ.', 'error');
                            }
                        });
                    }
                });
            }
            
            // Show alert from session
            <% if (session.getAttribute("successMsg") != null) { %>
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: '<%= session.getAttribute("successMsg") %>',
                    timer: 2000,
                    showConfirmButton: false
                });
                <% session.removeAttribute("successMsg"); %>
            <% } %>
            <% if (session.getAttribute("errorMsg") != null) { %>
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi!',
                    text: '<%= session.getAttribute("errorMsg") %>',
                    confirmButtonColor: '#d33'
                });
                <% session.removeAttribute("errorMsg"); %>
            <% } %>
        </script>
    </body>
</html>

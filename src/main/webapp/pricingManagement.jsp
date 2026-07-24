<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vertical Tabs with Right Navigation</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <!-- Google Fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap"
            rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet"
              href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- OWL Car -->
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <!-- Showmore css -->
        <link rel="stylesheet" href="css/showMoreItems-theme.min.css">
        <!-- Data Table -->
        <link rel="stylesheet"
              href="//cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

        <link rel="stylesheet"
              href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">

        <style>
            body, html {
                height: 100%;
                margin: 0;
                font-family: 'Be Vietnam Pro', 'Tahoma', sans-serif;
                background-color: #f5f7fb;
            }

            .tab-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                margin-top: 10px;
            }

            .tab-content {
                flex: 1;
                padding: 10px 40px;
            }

            /* --- Premium Underline Tabs --- */
            .nav-tabs {
                border-bottom: 2px solid #e2e8f0 !important;
                gap: 0;
                margin-bottom: 25px;
                margin-top: 10px;
                margin-left: 0;
                display: flex;
                background: transparent;
                padding: 0 40px;
            }

            .nav-tabs li {
                float: none !important;
                margin-bottom: -2px; /* Pull down to overlap the border */
                margin-right: 30px;
            }

            .nav-tabs li a {
                border: none !important;
                background: transparent !important;
                color: #64748b !important;
                border-radius: 0 !important;
                padding: 12px 5px !important;
                font-weight: 700 !important;
                transition: all 0.3s !important;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 14px;
                box-shadow: none !important;
                border-bottom: 3px solid transparent !important;
            }

            .nav-tabs li a:hover {
                color: #0f172a !important;
                background: transparent !important;
                border-bottom: 3px solid #cbd5e1 !important;
            }

            .nav-tabs li.active a,
            .nav-tabs li.active a:focus,
            .nav-tabs li.active a:hover {
                background: transparent !important;
                color: #b59349 !important;
                border-bottom: 3px solid #b59349 !important;
                box-shadow: none !important;
            }
            .tableview {
                width: 100%;
                margin: 0 auto;
                background: #ffffff;
                border-radius: 16px;
                padding: 20px;
                box-shadow: 0 4px 25px rgba(0, 0, 0, 0.04); 
            }

            .table-image {
                width: 100%;
                border-collapse: separate !important;
                border-spacing: 0 !important;
                margin-top: 5px !important;
                border: 1px solid #e2e8f0 !important;
                border-radius: 8px !important;
                overflow: hidden !important;
            }

            /* --- Header: Giống Voucher --- */
            .table thead th {
                background: #f8fafc !important; 
                color: #1e293b !important; 
                font-size: 0.85rem !important;
                font-weight: 800 !important;
                text-transform: uppercase !important;
                letter-spacing: 0.5px !important;
                border: none !important; 
                border-bottom: 2px solid #cbd5e1 !important;
                border-right: 1px solid #e2e8f0 !important;
                padding: 16px 16px !important;
                text-align: center;
                vertical-align: middle;
                white-space: nowrap; 
            }
            .table thead th:last-child {
                border-right: none !important;
            }

            /* Căn trái cho tiêu đề cột Mẫu xe */
            .table thead th:nth-child(5) {
                text-align: left;
            }

            /* --- Table Body: Phân cách Rõ ràng --- */
            .table-image {
                border-collapse: collapse !important;
                border-spacing: 0;
            }
            .table-image td, .table-image th[scope="row"] {
                background: transparent;
                vertical-align: middle;
                border: none !important;
                border-bottom: 2px solid #e2e8f0 !important; 
                border-right: 1px solid #cbd5e1 !important;
                padding: 14px 16px !important; 
                color: #1e293b; 
                font-weight: 500;
                font-size: 14px;
                text-align: center;
                transition: background-color 0.2s ease;
            }
            .table-image td:last-child, .table-image th[scope="row"]:last-child {
                border-right: none !important;
            }
            .table-image tr:hover td {
                background: #f8fafc !important;
            }
            .table-image tr:last-child td, .table-image tr:last-child th[scope="row"] {
                border-bottom: none !important;
            }

            .table-image tbody tr:nth-of-type(odd) td,
            .table-image tbody tr:nth-of-type(even) td {
                background-color: transparent !important;
            }
            .table-image tbody tr:hover td, .table-image tbody tr:hover th {
                background-color: #f8fafc !important; 
            }

            /* --- Premium Solid Buttons --- */
            .btn {
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: 600;
                font-size: 13px;
                text-transform: none;
                transition: all 0.2s ease;
                border: none;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1) !important;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
            }
            .btn:active {
                transform: translateY(1px);
                box-shadow: none !important;
            }

            .btn-gold {
                background: #b59349;
                color: #ffffff;
            }
            .btn-gold:hover {
                background: #9a7b3c;
                color: #ffffff;
            }

            .btn-dark-custom {
                background: #2b3445;
                color: #ffffff;
            }
            .btn-dark-custom:hover {
                background: #111827;
                color: #ffffff;
            }

            .btn-danger-custom {
                background: #ef4444;
                color: #ffffff;
            }
            .btn-danger-custom:hover {
                background: #dc2626;
                color: #ffffff;
            }

            .buttons {
                display: flex;
                gap: 8px;
                align-items: center;
                justify-content: center;
            }

            /* Forms inside Add/Update */
            .addnew, .editmotor {
                background: #fff;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            }
            
            .addnew h3, .editmotor h3 {
                color: #1a1816;
                font-weight: 800;
                font-size: 1.5rem;
                margin-bottom: 30px;
                position: relative;
            }
            .addnew h3::after, .editmotor h3::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 0;
                width: 50px;
                height: 4px;
                background: #d4af37;
                border-radius: 2px;
            }

            .form-group {
                margin-bottom: 22px;
            }

            .form-control {
                border-radius: 10px;
                border: 1px solid #e2e8f0;
                padding: 12px 15px;
                background: #f8fafc;
                transition: all 0.3s ease;
                box-shadow: none !important;
                height: auto;
                font-size: 14px;
            }
            .form-control:focus {
                border-color: #d4af37;
                background: #fff;
                box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.15) !important;
            }

            /* Nút Submit của Form */
            .addnew .btn-primary, .editmotor .btn-primary {
                background: #1a1816;
                color: #d4af37;
                padding: 14px 20px;
                font-weight: 700;
                border-radius: 10px;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
                width: 100%;
                border: none;
                transition: all 0.3s ease;
            }
            .addnew .btn-primary:hover, .editmotor .btn-primary:hover {
                background: #d4af37;
                color: #1a1816;
                box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
            }
        </style>
    </head>
    <body>

        <div class="container-fluid tab-container col-md-12">
            <div class="pagetitle" style="padding-left: 3%; margin-bottom: 20px;">
                <h1 style="color: #1a1816; font-weight: 800; font-size: 24px; text-transform: uppercase; margin-top: 0; margin-bottom: 5px; font-family: 'Tahoma', sans-serif;">QUẢN LÝ BẢNG GIÁ</h1>
                <nav>
                    <ol class="breadcrumb" style="background: transparent; padding: 0; margin: 0; font-size: 14px;">
                        <li class="breadcrumb-item"><a href="homeStaff" target="_top" style="color: #b59349; text-decoration: none; font-weight: 600;">Trang chủ</a></li>
                        <li class="breadcrumb-item active" style="font-weight: 500; color: #6c757d;">Quản lý bảng giá</li>
                    </ol>
                </nav>
            </div>
            <ul class="nav nav-tabs custom-tabs mb-4" role="tablist">
                <li role="presentation" class="nav-item">
                    <a href="#Section1" aria-controls="home" role="tab" data-toggle="tab" class="nav-link active">THÔNG TIN BẢNG GIÁ</a>
                </li>
                <li role="presentation" class="nav-item">
                    <a href="#Section2" aria-controls="profile" role="tab" data-toggle="tab" class="nav-link">THÊM GIÁ MỚI</a>
                </li>
            </ul>
            <!-- Nội dung tab -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane fade in active" id="Section1">
                    <!-- Nội dung phần tab Display All Motorbikes -->
                    <div class="container-fluid">
                        <div class="row tableview">
                            <div class="col-12">
                                <table class="table table-image">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Giá Thuê Theo Ngày</th>
                                            <th scope="col">Giá Thuê Theo Tuần</th>
                                            <th scope="col">Giá Thuê Theo Tháng</th>
                                            <th scope="col">Mẫu Xe</th>
                                            <th scope="col">Hành Động</th>
                                        </tr>
                                    </thead>

                                    <c:forEach items="${listP}" var="p">

                                        <tbody id="table-body">
                                            <tr>
                                                <th scope="row" class="text-muted fw-bold" style="font-size: 15px;">#${p.priceListId}</th>     

                                                <td style="color: #0f172a; font-weight: 600;"><fmt:formatNumber value="${p.dailyPriceForDay}" pattern="#,##0"/> <span style="font-size: 11px; color: #64748b;">VNĐ</span></td>
                                                <td style="color: #0f172a; font-weight: 600;"><fmt:formatNumber value="${p.dailyPriceForWeek}" pattern="#,##0"/> <span style="font-size: 11px; color: #64748b;">VNĐ</span></td>
                                                <td style="color: #0f172a; font-weight: 600;"><fmt:formatNumber value="${p.dailyPriceForMonth}" pattern="#,##0"/> <span style="font-size: 11px; color: #64748b;">VNĐ</span></td>
                                                <td class="align-middle" style="max-width: 250px; white-space: normal; text-align: left !important; padding-left: 20px !important;">
                                                    <div class="d-flex flex-wrap gap-1" style="justify-content: flex-start;">
                                                    <c:set var="hasMotors" value="false" />
                                                    <c:forEach items="${listM}" var="m">
                                                        <c:if test="${p.priceListId == m.priceListID}">
                                                            <span class="badge" style="background-color: #f1f5f9; color: #334155; border: 1px solid #cbd5e1; padding: 6px 12px; border-radius: 20px; font-size: 12px; margin: 2px; font-weight: 600; box-shadow: 0 1px 2px rgba(0,0,0,0.05);">${m.model}</span>
                                                            <c:set var="hasMotors" value="true" />
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${!hasMotors}">
                                                        <span style="color: #94a3b8; font-style: italic; font-size: 13px;"><i class="fas fa-exclamation-circle me-1"></i> Chưa gán xe nào</span>
                                                    </c:if>
                                                    </div>
                                                </td>
                                                <td class="action-buttons">
                                                    <div class="buttons" style="gap: 8px;">
                                                        <button class="btn btn-sm" style="background-color: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe; border-radius: 8px; transition: all 0.2s;" onmouseover="this.style.backgroundColor='#dbeafe'" onmouseout="this.style.backgroundColor='#eff6ff'" onclick="populateUpdateForm(${p.priceListId}, ${p.dailyPriceForDay}, ${p.dailyPriceForWeek}, ${p.dailyPriceForMonth})" title="Sửa gói giá">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-sm" style="background-color: #fef2f2; color: #dc2626; border: 1px solid #fecaca; border-radius: 8px; transition: all 0.2s;" onmouseover="this.style.backgroundColor='#fee2e2'" onmouseout="this.style.backgroundColor='#fef2f2'" onclick="confirmDelete('${p.priceListId}')" title="Xóa gói giá">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="Section2">
                    <!-- Nội dung phần tab Add New Motorbike -->
                    <section>
                        <div class="container-fluid">
                            <div class="row ">
                                <div class="col-lg-10 col-md-8 ml-auto">
                                    <div class="row align-items-center pt-md-5 mt-md-5 mb-5">
                                        <div class="col-md-12">
                                            <div class="addnew">
                                                <form class="addnew-motorbike-form" method="post" action="addpricing">
                                                    <h3>THÊM GIÁ MỚI</h3>
                                                    <br>
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" id="" name="priceForDay" placeholder="Giá Thuê Theo Ngày" value="" step="0.01" min="0" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" id="" name="priceForWeek" placeholder="Giá Thuê Theo Tuần" value="" step="0.01" min="0" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" id="" name="priceForMonth" placeholder="Giá Thuê Theo Tháng" value="" step="0.01" min="0" required>
                                                    </div>
                                                    <button type="submit" class="btn btn-dark">Thêm</button>
                                                    <div class="feedback mt-3">
                                                        <div id="success-message" class="alert alert-success" style="display: none;">
                                                            Motorbike added successfully!
                                                        </div>
                                                        <div id="error-message" class="alert alert-danger" style="display: none;">
                                                            File Format Not Supported
                                                        </div>

                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>


                <!-- Tab Cập Nhật Giá đã được thay bằng Modal -->
                <!-- Modal Cập nhật giá -->
                <div class="modal fade" role="dialog" tabindex="-1" id="update-price-modal">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content" style="border-radius: 15px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: none;">
                            <div class="modal-header" style="background: linear-gradient(135deg, #2b3445 0%, #111827 100%); color: white; padding: 20px;">
                                <h5 class="modal-title fw-bold" style="margin: 0; color: #fff;">CẬP NHẬT GÓI GIÁ</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white; opacity: 1; text-shadow: none;">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="padding: 30px;">
                                <form action="updatePricing" method="post">
                                    <div class="alert alert-warning" style="font-size: 13px; background-color: #fff3cd; border-left: 4px solid #ffc107; color: #664d03; padding: 10px 15px; border-radius: 4px;">
                                        <i class="fas fa-info-circle me-2"></i> 
                                        <strong>Lưu ý:</strong> Bạn đang cập nhật một <strong>Gói Giá</strong>. Mức giá mới này sẽ tự động thay đổi cho <strong>tất cả các xe</strong> thuộc danh sách mẫu xe bên ngoài.
                                    </div>
                                    <input type="hidden" id="modal-id" name="id" value="" >
                                    
                                    <div class="form-group" style="margin-bottom: 20px;">
                                        <label style="font-weight: 600; color: #1e293b; margin-bottom: 8px; display: block; text-align: left;">Giá Thuê Theo Ngày (VNĐ)</label>
                                        <input type="number" class="form-control" id="modal-priceForDay" name="priceForDay" step="0.01" min="0" required style="border-radius: 8px; padding: 10px 15px;">
                                    </div>
                                    <div class="form-group" style="margin-bottom: 20px;">
                                        <label style="font-weight: 600; color: #1e293b; margin-bottom: 8px; display: block; text-align: left;">Giá Thuê Theo Tuần (VNĐ)</label>
                                        <input type="number" class="form-control" id="modal-priceForWeek" name="priceForWeek" step="0.01" min="0" required style="border-radius: 8px; padding: 10px 15px;">
                                    </div>
                                    <div class="form-group" style="margin-bottom: 25px;">
                                        <label style="font-weight: 600; color: #1e293b; margin-bottom: 8px; display: block; text-align: left;">Giá Thuê Theo Tháng (VNĐ)</label>
                                        <input type="number" class="form-control" id="modal-priceForMonth" name="priceForMonth" step="0.01" min="0" required style="border-radius: 8px; padding: 10px 15px;">
                                    </div>
                                    
                                    <div style="text-align: right; margin-top: 10px;">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="background: #e2e8f0; color: #475569; border: none;">Hủy</button>
                                        <button type="submit" class="btn btn-gold" style="margin-left: 10px;">Lưu Thay Đổi</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>




        <script type="text/javascript">
            <c:if test="${not empty sessionScope.deleteSuccess}">
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công',
                    text: '${sessionScope.deleteSuccess}',
                    confirmButtonColor: '#1089FF'
                });
                <c:remove var="deleteSuccess" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.deleteError}">
                Swal.fire({
                    icon: 'error',
                    title: 'Không thể xóa',
                    text: '${sessionScope.deleteError}',
                    confirmButtonColor: '#d33'
                });
                <c:remove var="deleteError" scope="session" />
            </c:if>

            function confirmDelete(id) {
                Swal.fire({
                    title: 'Bạn có chắc chắn muốn xóa?',
                    text: "Sẽ không thể khôi phục lại gói giá này!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#1089FF',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, xóa nó!',
                    cancelButtonText: 'Hủy'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'deletePricing?id=' + id;
                    }
                });
            }

            function populateUpdateForm(id, priceForDay, priceForWeek, priceForMonth) {
                // Chuyển dữ liệu vào form của Modal
                document.getElementById('modal-id').value = id;
                document.getElementById('modal-priceForDay').value = priceForDay;
                document.getElementById('modal-priceForWeek').value = priceForWeek;
                document.getElementById('modal-priceForMonth').value = priceForMonth;

                // Hiển thị Modal
                $('#update-price-modal').modal('show');
            }

            // Removed OneClick function as it is no longer used
        </script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    </body>

</html>

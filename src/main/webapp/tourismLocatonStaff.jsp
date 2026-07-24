<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý các địa điểm du lịch - SmartRide</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- SweetAlert2 -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" rel="stylesheet">

    <!-- Simple Datatables -->
    <link href="staffAssets/vendor/simple-datatables/style.css" rel="stylesheet">

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
        
        /* Content Card */
        .content-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            padding: 24px;
            margin-bottom: 24px;
        }

        /* Buttons */
        .btn-gold {
            background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 8px 20px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.25s;
            box-shadow: 0 4px 12px rgba(181, 147, 73, 0.2);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-gold:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(181, 147, 73, 0.3);
            color: #fff;
        }
        
        .action-btn {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
            transition: all 0.2s;
            margin: 0 2px;
        }
        .btn-edit { background: #ecfeff; color: #0891b2; }
        .btn-edit:hover { background: #0891b2; color: #fff; }
        .btn-delete { background: #fef2f2; color: #ef4444; }
        .btn-delete:hover { background: #ef4444; color: #fff; }
        .btn-manage-moto {
            background: rgba(181, 147, 73, 0.1);
            color: var(--gold-dark);
            border: 1px solid rgba(181, 147, 73, 0.3);
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
            white-space: nowrap;
        }
        .btn-manage-moto:hover {
            background: var(--gold);
            color: #fff;
        }

        /* Modal */
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
            font-size: 1.1rem;
        }
        .btn-close-white {
            filter: brightness(0) invert(1);
            opacity: 0.8;
        }
        .btn-close-white:hover { opacity: 1; }
        .modal-body { padding: 24px; }
        .modal-footer {
            border-top: 1px solid #f1f5f9;
            padding: 16px 24px;
            background: #f8fafc;
        }

        /* Form Controls */
        .form-label {
            font-weight: 600;
            font-size: 13px;
            color: #475569;
            margin-bottom: 6px;
        }
        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #cbd5e1;
            padding: 10px 14px;
            font-size: 14px;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(181, 147, 73, 0.15);
        }
        
        /* Table Customization */
        .datatable-top { padding: 0 0 20px 0 !important; }
        .datatable-search .datatable-input {
            border-radius: 20px !important;
            padding: 8px 16px !important;
            border: 1px solid #e2e8f0 !important;
        }
        .datatable-search .datatable-input:focus {
            border-color: var(--gold) !important;
            box-shadow: 0 0 0 3px rgba(181,147,73,0.15) !important;
            outline: none;
        }
        .table-custom { width: 100%; border-collapse: separate; border-spacing: 0; }
        .table-custom th {
            background: linear-gradient(135deg, #1a1816 0%, #2d2926 100%) !important;
            color: #fff !important;
            padding: 14px 16px !important;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            border: none !important;
            text-align: center;
        }
        .table-custom th:first-child { border-top-left-radius: 12px; }
        .table-custom th:last-child { border-top-right-radius: 12px; }
        .table-custom td {
            padding: 16px !important;
            vertical-align: middle !important;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
            text-align: center;
        }
        .table-custom tbody tr:hover td { background-color: #f8fafc; }
        .img-location {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .desc-text {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-align: left;
            max-width: 250px;
            font-size: 13px;
        }

        /* Rec Table */
        .rec-table th { background: #f8fafc !important; color: #475569 !important; border-bottom: 2px solid #e2e8f0 !important; }
        .rec-box { background: #f8fafc; border-radius: 12px; padding: 20px; border: 1px solid #e2e8f0; }
    </style>
</head>

<body>
    <div class="main-container">
        <!-- Header -->
        <div class="page-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h1 class="page-title">Quản Lý Địa Điểm Du Lịch</h1>
                <div class="breadcrumb-custom">
                    <a href="homeStaff">Trang chủ</a>
                    <span>/</span>
                    <span>Quản lý địa điểm</span>
                </div>
            </div>
            <button class="btn-gold" data-bs-toggle="modal" data-bs-target="#addLocationModal">
                <i class="bi bi-plus-lg"></i> Thêm Mới Địa Điểm
            </button>
        </div>

        <div class="content-card">
            <div class="table-responsive">
                <table class="table-custom datatable" id="locationTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Tên Địa Điểm</th>
                            <th>Mô Tả</th>
                            <th>Link Bài Viết</th>
                            <th>Xe Gợi Ý</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="loc" items="${touristLocation}">
                            <tr>
                                <td class="fw-bold">#${loc.locationId}</td>
                                <td>
                                    <img src="${empty loc.locationImage ? 'images/default.jpg' : (loc.locationImage.startsWith('http') ? loc.locationImage : 'images/'.concat(loc.locationImage))}" 
                                         class="img-location" alt="Location">
                                </td>
                                <td class="fw-bold text-dark" style="text-align: left;">${loc.locationName}</td>
                                <td>
                                    <div class="desc-text" title="${loc.description}">${loc.description}</div>
                                </td>
                                <td>
                                    <a href="${loc.urlArticle}" target="_blank" class="text-primary text-decoration-none" title="${loc.urlArticle}">
                                        <i class="bi bi-box-arrow-up-right"></i> Xem Link
                                    </a>
                                </td>
                                <td>
                                    <button class="btn-manage-moto" onclick="manageRecommendations('${loc.locationId}', '${loc.locationName.replace("'", "\\'")}')">
                                        <i class="fa-solid fa-motorcycle me-1"></i> Quản Lý Xe
                                    </button>
                                </td>
                                <td>
                                    <div class="d-flex justify-content-center">
                                        <button class="action-btn btn-edit" title="Sửa" 
                                            onclick="editTouristLocation('${loc.locationId}', '${loc.locationName.replace("'", "\\'")}', '${loc.locationImage}', '${loc.description.replace("'", "\\'")}', '${loc.urlArticle.replace("'", "\\'")}')">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="action-btn btn-delete" title="Xóa" onclick="confirmDelete('${loc.locationId}')">
                                            <i class="bi bi-trash-fill"></i>
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

    <!-- ===== MODAL THÊM MỚI ===== -->
    <div class="modal fade" id="addLocationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header-gold d-flex justify-content-between align-items-center">
                    <h5 class="modal-title m-0"><i class="bi bi-map-fill me-2"></i>Thêm Mới Địa Điểm</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="addLocationForm" action="AddTouristLocationServletStaff" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label class="form-label">Tên Địa Điểm</label>
                                <input type="text" class="form-control" id="locationName" name="locationName" required placeholder="Nhập tên địa điểm du lịch...">
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Ảnh Địa Điểm</label>
                                <input type="file" class="form-control" id="locationImage" name="locationImage" accept="image/*" required>
                                <div id="locationImagePreview" class="mt-2 text-center"></div>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Mô Tả</label>
                                <textarea class="form-control" id="description" name="description" rows="3" required placeholder="Nhập mô tả về địa điểm này..."></textarea>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Đường Dẫn Bài Viết (Tùy chọn/Bắt buộc)</label>
                                <input type="text" class="form-control" id="urlArticle" name="urlArticle" required placeholder="https://...">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary px-4 rounded-pill" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn-gold rounded-pill px-4"><i class="bi bi-floppy-fill"></i> Lưu Địa Điểm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- ===== MODAL CHỈNH SỬA ===== -->
    <div class="modal fade" id="editLocationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header-gold d-flex justify-content-between align-items-center">
                    <h5 class="modal-title m-0"><i class="bi bi-pencil-square me-2"></i>Chỉnh Sửa Địa Điểm</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <!-- Sử dụng form truyền thống hoặc ajax tùy code cũ, ở đây giữ nguyên submit truyền thống tới UpdateTourismLoctionServletStaff như html gốc -->
                <form id="editLocationForm" action="UpdateTourismLoctionServletStaff" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" id="editLocationId" name="locationId">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label class="form-label">Tên Địa Điểm</label>
                                <input type="text" class="form-control" id="editLocationName" name="locationName" required>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Ảnh Địa Điểm Mới (Bỏ trống nếu giữ nguyên)</label>
                                <input type="file" class="form-control" id="editLocationImage" name="locationImage" accept="image/*">
                                <div id="editLocationImagePreview" class="mt-2 text-center"></div>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Mô Tả</label>
                                <textarea class="form-control" id="editDescription" name="description" rows="3" required></textarea>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Đường Dẫn Bài Viết</label>
                                <input type="text" class="form-control" id="editUrlArticle" name="urlArticle" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary px-4 rounded-pill" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn-gold rounded-pill px-4"><i class="bi bi-floppy-fill"></i> Cập Nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- ===== MODAL QUẢN LÝ XE GỢI Ý ===== -->
    <div class="modal fade" id="recommendationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header-gold d-flex justify-content-between align-items-center">
                    <h5 class="modal-title m-0"><i class="fa-solid fa-motorcycle me-2"></i>Quản Lý Xe Gợi Ý - <span id="recLocationName"></span></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-light">
                    <!-- Form Thêm Xe -->
                    <div class="rec-box mb-4">
                        <h6 class="fw-bold mb-3"><i class="bi bi-plus-circle-fill text-success me-2"></i>Thêm Xe Gợi Ý Mới</h6>
                        <form id="addRecForm" class="row g-2 align-items-end">
                            <input type="hidden" id="recLocationId">
                            <div class="col-md-4">
                                <label class="form-label">Chọn Xe</label>
                                <select class="form-select" id="recMotorcycleId" required>
                                    <option value="">-- Chọn một chiếc xe --</option>
                                    <c:forEach var="motor" items="${allMotorcycles}">
                                        <option value="${motor.motorcycleId}">${motor.model} (${motor.motorcycleId})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Lý do phù hợp</label>
                                <input type="text" class="form-control" id="recReason" placeholder="VD: Xe khỏe, dễ leo dốc..." maxlength="200">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-success w-100 fw-bold rounded-3">
                                    <i class="bi bi-plus-lg me-1"></i>Thêm
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Bảng Danh Sách -->
                    <div class="bg-white p-3 rounded-4 shadow-sm border">
                        <h6 class="fw-bold mb-3"><i class="bi bi-list-stars text-warning me-2"></i>Danh Sách Xe Đang Gợi Ý</h6>
                        <div class="table-responsive">
                            <table class="table-custom rec-table" id="recTable">
                                <thead>
                                    <tr>
                                        <th>Mẫu Xe</th>
                                        <th>Hình Ảnh</th>
                                        <th>Lý Do</th>
                                        <th>Thao Tác</th>
                                    </tr>
                                </thead>
                                <tbody id="recTableBody">
                                    <!-- Rendered via JS -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.all.min.js"></script>
    <script src="staffAssets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="js/imagePreview.js"></script> <!-- Giữ nguyên script preview ảnh nếu có -->

    <script>
        // Datatable Init
        document.addEventListener('DOMContentLoaded', () => {
            const table = document.querySelector('.datatable');
            if(table) {
                new simpleDatatables.DataTable(table, {
                    searchable: true,
                    fixedHeight: false,
                    perPage: 10,
                    labels: {
                        placeholder: "Tìm kiếm địa điểm...",
                        noRows: "Không tìm thấy dữ liệu",
                        info: "Hiển thị {start} đến {end} của {rows} kết quả"
                    }
                });
            }

            // Function to setup live preview and lightbox
            function setupLivePreview(inputId, previewId) {
                var input = document.getElementById(inputId);
                var previewContainer = document.getElementById(previewId);
                if (input && previewContainer) {
                    previewContainer.style.position = 'relative';
                    previewContainer.style.display = 'inline-block';

                    input.addEventListener('change', function(event) {
                        var file = event.target.files[0];
                        previewContainer.innerHTML = '';
                        if (file) {
                            var reader = new FileReader();
                            reader.onload = function(e) {
                                var img = document.createElement('img');
                                img.src = e.target.result;
                                img.className = 'img-fluid img-thumbnail cursor-pointer';
                                img.style.maxWidth = '150px';
                                img.style.cursor = 'pointer';
                                img.setAttribute('onclick', 'if(window.parent && window.parent.openLightbox) window.parent.openLightbox(this.src)');
                                
                                var btn = document.createElement('button');
                                btn.innerHTML = '&times;';
                                btn.type = 'button';
                                btn.style.position = 'absolute';
                                btn.style.top = '5px';
                                btn.style.right = '5px';
                                btn.style.background = '#ef4444';
                                btn.style.color = 'white';
                                btn.style.border = 'none';
                                btn.style.borderRadius = '50%';
                                btn.style.width = '24px';
                                btn.style.height = '24px';
                                btn.style.display = 'flex';
                                btn.style.alignItems = 'center';
                                btn.style.justifyContent = 'center';
                                btn.style.cursor = 'pointer';
                                btn.style.boxShadow = '0 2px 4px rgba(0,0,0,0.2)';
                                btn.style.fontSize = '16px';
                                btn.style.lineHeight = '1';
                                btn.onclick = function() {
                                    input.value = '';
                                    previewContainer.innerHTML = '';
                                };
                                
                                previewContainer.appendChild(img);
                                previewContainer.appendChild(btn);
                            };
                            reader.readAsDataURL(file);
                        }
                    });
                }
            }

            setupLivePreview('locationImage', 'locationImagePreview');
            setupLivePreview('editLocationImage', 'editLocationImagePreview');
        });

        // Xóa địa điểm
        function confirmDelete(locationId) {
            Swal.fire({
                title: 'Xóa địa điểm này?',
                text: "Bạn sẽ không thể khôi phục dữ liệu!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ef4444',
                cancelButtonColor: '#64748b',
                confirmButtonText: '<i class="bi bi-trash-fill"></i> Vâng, xóa nó!',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'DeleteTourismLocationServletStaff?locationId=' + locationId;
                }
            })
        }

        // Mở Modal Chỉnh Sửa
        function editTouristLocation(locationId, locationName, locationImage, description, urlArticle) {
            document.getElementById('editLocationId').value = locationId;
            document.getElementById('editLocationName').value = locationName;
            document.getElementById('editDescription').value = description;
            document.getElementById('editUrlArticle').value = urlArticle;

            var imgContainer = document.getElementById('editLocationImagePreview');
            imgContainer.innerHTML = '';
            
            if (locationImage && locationImage.trim() !== '') {
                var imgSrc = locationImage.startsWith('http') ? locationImage : 'images/' + locationImage;
                imgContainer.innerHTML = `
                    <div style="position:relative; display:inline-block;">
                        <img src="\${imgSrc}" class="img-thumbnail cursor-pointer" style="max-width:150px; max-height:150px; border-radius:8px; cursor: pointer;" onclick="if(window.parent && window.parent.openLightbox) window.parent.openLightbox(this.src)">
                        <button type="button" title="Xóa ảnh này" onclick="clearEditImage()" 
                                style="position:absolute; top:-10px; right:-10px; background:#ef4444; color:white; border:none; border-radius:50%; width:24px; height:24px; cursor:pointer; font-weight:bold;">&times;</button>
                    </div>
                `;
            }

            var editModal = new bootstrap.Modal(document.getElementById('editLocationModal'));
            editModal.show();
        }

        function clearEditImage() {
            document.getElementById('editLocationImage').value = '';
            document.getElementById('editLocationImagePreview').innerHTML = '';
        }

        // Form Add Submit Ajax
        $('#addLocationForm').submit(function (event) {
            event.preventDefault();
            
            // Validate image ext
            var fileInput = document.getElementById('locationImage').value;
            var ext = fileInput.split('.').pop().toLowerCase();
            if (['jpg', 'jpeg', 'png', 'gif', 'webp'].indexOf(ext) === -1) {
                Swal.fire('Lỗi', 'Chỉ chấp nhận file ảnh (jpg, jpeg, png, gif, webp)', 'error');
                return;
            }

            var formData = new FormData(this);
            $.ajax({
                type: 'POST',
                url: $(this).attr('action'),
                data: formData,
                processData: false,
                contentType: false,
                success: function () {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công!',
                        text: 'Đã thêm địa điểm mới.',
                        timer: 2000,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.reload();
                    });
                },
                error: function () {
                    Swal.fire('Lỗi!', 'Không thể thêm địa điểm. Vui lòng thử lại.', 'error');
                }
            });
        });

        // -------------------------
        // QUẢN LÝ XE GỢI Ý
        // -------------------------
        var recommendData = {
            <c:forEach var="entry" items="${recommendMap}" varStatus="status">
                "${entry.key}": [
                    <c:forEach var="rec" items="${entry.value}" varStatus="st">
                        {
                            motorcycleId: "${rec.motorcycleId}",
                            model: "${rec.model.replace("\"", "\\\"")}",
                            image: "${rec.image}",
                            reason: "${rec.reason.replace("\"", "\\\"")}",
                            priority: ${rec.priority}
                        }${!st.last ? ',' : ''}
                    </c:forEach>
                ]${!status.last ? ',' : ''}
            </c:forEach>
        };

        function manageRecommendations(locationId, locationName) {
            $('#recLocationId').val(locationId);
            $('#recLocationName').text(locationName);
            
            var tbody = $('#recTableBody');
            tbody.empty();
            
            var recs = recommendData[locationId] || [];
            if (recs.length === 0) {
                tbody.append('<tr><td colspan="4" class="text-center py-5 text-muted"><i class="bi bi-inbox fs-1 d-block mb-2 text-black-50"></i>Chưa có xe phù hợp nào cho địa điểm này</td></tr>');
            } else {
                recs.forEach(function(rec) {
                    var imgSrc = rec.image ? (rec.image.startsWith('http') ? rec.image : 'images/' + rec.image) : 'images/default.jpg';
                    var reasonHtml = rec.reason 
                        ? '<span class="fst-italic text-secondary"><i class="bi bi-quote"></i>' + rec.reason + '</span>'
                        : '<span class="text-muted fst-italic">Không có lý do cụ thể</span>';
                    
                    var tr = `
                        <tr>
                            <td class="text-start">
                                <div class="fw-bold text-dark">\${rec.model}</div>
                                <span class="badge bg-secondary">\${rec.motorcycleId}</span>
                            </td>
                            <td><img src="\${imgSrc}" class="img-thumbnail" style="height:60px; object-fit:cover;"></td>
                            <td class="text-start">\${reasonHtml}</td>
                            <td>
                                <button class="action-btn btn-delete" onclick="deleteRec('\${locationId}', '\${rec.motorcycleId}')" title="Xóa gợi ý này">
                                    <i class="bi bi-trash-fill"></i>
                                </button>
                            </td>
                        </tr>
                    `;
                    tbody.append(tr);
                });
            }
            
            $('#recMotorcycleId').val('');
            $('#recReason').val('');
            
            var recModal = new bootstrap.Modal(document.getElementById('recommendationModal'));
            recModal.show();
        }

        // Ajax Thêm Gợi Ý
        $('#addRecForm').submit(function(e) {
            e.preventDefault();
            var locId = $('#recLocationId').val();
            var motId = $('#recMotorcycleId').val();
            if (!motId) {
                Swal.fire('Lỗi', 'Vui lòng chọn một chiếc xe!', 'warning');
                return;
            }
            
            var recs = recommendData[locId] || [];
            var exists = recs.some(rec => rec.motorcycleId === motId);
            if (exists) {
                Swal.fire('Đã tồn tại', 'Xe này đã có trong danh sách gợi ý của địa điểm này.', 'info');
                return;
            }
            
            var reason = $('#recReason').val().trim();
            $.post('TourismLocationServletStaff', {
                action: 'add',
                locationId: locId,
                motorcycleId: motId,
                reason: reason,
                priority: 1
            }, function(res) {
                if (res.success) {
                    Swal.fire({
                        title: 'Thành công!', text: 'Đã thêm xe vào danh sách gợi ý.', icon: 'success', timer: 1500, showConfirmButton: false
                    }).then(() => window.location.reload());
                } else {
                    Swal.fire('Lỗi', res.message || 'Không thể thêm xe này.', 'error');
                }
            }).fail(() => Swal.fire('Lỗi', 'Mất kết nối máy chủ', 'error'));
        });

        // Ajax Xóa Gợi Ý
        function deleteRec(locationId, motorcycleId) {
            Swal.fire({
                title: 'Bỏ gợi ý xe này?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ef4444',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Vâng, Xóa!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.post('TourismLocationServletStaff', {
                        action: 'delete',
                        locationId: locationId,
                        motorcycleId: motorcycleId
                    }, function(res) {
                        if (res.success) {
                            Swal.fire({ title: 'Đã xóa!', icon: 'success', timer: 1500, showConfirmButton: false })
                                .then(() => window.location.reload());
                        } else {
                            Swal.fire('Lỗi', 'Không thể xóa xe này.', 'error');
                        }
                    }).fail(() => Swal.fire('Lỗi', 'Mất kết nối máy chủ', 'error'));
                }
            });
        }
    </script>
</body>
</html>

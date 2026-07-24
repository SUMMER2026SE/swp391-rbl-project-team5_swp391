<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tourist Location Management</title>
       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="//cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
        


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
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06); 
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

            /* --- Header --- */
            .table thead th {
                background: #f1f5f9 !important; 
                color: #334155 !important; 
                font-size: 0.85rem !important;
                font-weight: bold !important;
                text-transform: uppercase !important;
                letter-spacing: 0.5px !important;
                border: none !important; 
                border-bottom: 2px solid #cbd5e1 !important;
                border-right: 1px solid #e2e8f0 !important;
                padding: 14px 16px !important;
                text-align: center;
                vertical-align: middle;
                white-space: nowrap; 
            }
            .table thead th:last-child {
                border-right: none !important;
            }

            /* --- Table Body --- */
            .table-image td {
                background: transparent;
                vertical-align: middle;
                border: none !important;
                border-bottom: 1px solid #e2e8f0 !important; 
                border-right: 1px solid #e2e8f0 !important;
                padding: 14px 16px !important; 
                color: #334155; 
                font-size: 14px;
                text-align: center;
                transition: background-color 0.2s ease;
            }
            .table-image td:last-child {
                border-right: none !important;
            }
            .table-image tr:last-child td {
                border-bottom: none !important;
            }

            .table-image tbody tr:nth-of-type(odd) td,
            .table-image tbody tr:nth-of-type(even) td {
                background-color: transparent !important;
            }
            .table-image tbody tr:hover td {
                background-color: #f8fafc !important; 
            }

            /* Thu nhỏ kích thước ảnh */
            .table-image img {
                max-width: 80px;
                height: auto;
                max-height: 80px;
                object-fit: contain;
                border-radius: 4px;
            }
            
            /* Giới hạn kích thước icon */
            .table-image td:nth-child(4) img {
                max-width: 50px;
                max-height: 50px;
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
            .addnew, .editlocation {
                background: #fff;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            }
            
            .addnew h3, .editlocation h3 {
                color: #1a1816;
                font-weight: 800;
                font-size: 1.5rem;
                margin-bottom: 30px;
                position: relative;
            }
            .addnew h3::after, .editlocation h3::after {
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
            .addnew .btn-primary, .editlocation .btn-primary {
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
            .addnew .btn-primary:hover, .editlocation .btn-primary:hover {
                background: #d4af37;
                color: #1a1816;
                box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
            }
        </style>
    </head>

    <body>

        <div class="container-fluid tab-container col-md-12">
            <div class="pagetitle" style="margin-bottom: 20px; padding-left: 40px;">
                <h1 style="color: #1a1816; font-weight: 800; font-size: 24px; text-transform: uppercase; margin-top: 0; margin-bottom: 5px; font-family: 'Tahoma', sans-serif;">QUẢN LÝ PHỤ KIỆN</h1>
                <nav>
                    <ol class="breadcrumb" style="background: transparent; padding: 0; margin: 0; font-size: 14px;">
                        <li class="breadcrumb-item"><a href="homeStaff" target="_top" style="color: #b59349; text-decoration: none; font-weight: 600;">Trang chủ</a></li>
                        <li class="breadcrumb-item active" style="font-weight: 500; color: #6c757d;">Quản lý phụ kiện</li>
                    </ol>
                </nav>
            </div>
            <!-- Danh sách tab ngang -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active">
                    <a href="#Section1" aria-controls="home" role="tab" data-toggle="tab">DANH SÁCH PHỤ KIỆN</a>
                </li>
                <li role="presentation">
                    <a href="#Section2" aria-controls="profile" role="tab" data-toggle="tab">THÊM MỚI PHỤ KIỆN</a>
                </li>
            </ul>
            <!-- Nội dung tab -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane fade in active" id="Section1">
                    <div class="container-fluid">
                        <div class="row tableview">
                            <div class="col-12">
                                <table class="table table-image">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Tên Phụ Kiện</th>
                                            <th scope="col">Hình Ảnh</th>
                                            <th scope="col">Thông Tin Mô Tả</th>
                                            <th scope="col">Giá</th>
                                            <th scope="col">Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="table-body">
                                        <c:forEach var="accessoryLists" items="${accessoryList}">
                                            <tr>
                                                <td class="text-muted fw-bold">#${accessoryLists.accessoryId}</td>
                                                <td style="color: #0f172a; font-weight: 600;">${accessoryLists.accessoryName}</td>
                                                <td class="w-25">
                                                    <img src="${empty accessoryLists.accessoryImage ? 'images/default.jpg' : (accessoryLists.accessoryImage.startsWith('http') ? accessoryLists.accessoryImage : 'images/'.concat(accessoryLists.accessoryImage))}"
                                                         class="img-fluid img-thumbnail" style="border: none; box-shadow: 0 2px 4px rgba(0,0,0,0.05);" alt="${accessoryLists.accessoryName}">
                                                </td>
                                                <td style="color: #475569; font-size: 13px;">${accessoryLists.accessoryDescription}</td>
                                                <td style="color: #0f172a; font-weight: 600;">
                                                    <c:choose>
                                                        <c:when test="${accessoryLists.price == 0}">
                                                            <span style="color: #10b981; font-weight: 700;">Miễn phí</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${accessoryLists.price}" pattern="#,##0"/> <span style="font-size: 11px; color: #64748b;">VNĐ</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <td class="action-buttons">
                                                    <div class="buttons" style="gap: 8px;">
                                                        <button class="btn btn-sm" style="background-color: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe; border-radius: 8px; transition: all 0.2s;" onmouseover="this.style.backgroundColor='#dbeafe'" onmouseout="this.style.backgroundColor='#eff6ff'" onclick="editTouristLocation('${accessoryLists.accessoryId}', '${accessoryLists.accessoryName}', '${accessoryLists.accessoryImage}', '${accessoryLists.accessoryImageicon}', '${accessoryLists.accessoryDescription}', '${accessoryLists.price}')" title="Sửa phụ kiện">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-sm" style="background-color: #fef2f2; color: #dc2626; border: 1px solid #fecaca; border-radius: 8px; transition: all 0.2s;" onmouseover="this.style.backgroundColor='#fee2e2'" onmouseout="this.style.backgroundColor='#fef2f2'" onclick="confirmDelete('${accessoryLists.accessoryId}')" title="Xóa phụ kiện">
                                                            <i class="fas fa-trash"></i>
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


                <div role="tabpanel" class="tab-pane fade" id="Section2">
                    <section>
                        <div class="container-fluid">
                            <form id="addLocationForm" action="AddAccessoryStaff" method="POST" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="accessoryName">Tên Phụ Kiện:</label>
                                    <input type="text" class="form-control" id="accessoryName" name="accessoryName" required>
                                </div>
                                <div class="form-group">

                                    <label for="accessoryImage">Hình ảnh:</label>
                                    <div id="addAccessoryImagePreview" style="margin-bottom: 10px;"></div>
                                    <input type="file" class="form-control" id="accessoryImage" name="accessoryImage" accept="image/*" required>
                                </div>
                                <div class="form-group" style="display: none;">
                                                    <label for="accessoryImageIcon">Icon:</label>
                                                    <input type="file" class="form-control" id="accessoryImageIcon" name="accessoryImageIcon" accept="image/*">
                                                </div>
                                <div class="form-group">
                                    <label for="accessoryDescription">Thông Tin Mô Tả:</label>
                                    <textarea class="form-control" id="accessoryDescription" name="accessoryDescription" rows="3" required style="resize: vertical;"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="price">Giá:</label>
                                    <input type="number" class="form-control" id="price" name="price" required min="0">
                                </div>

                                <div class="buttons">
                                    <button type="submit" class="btn btn-success">Thêm Mới Phụ Kiện</button>
                                </div>
                            </form>
                        </div>
                    </section>
                </div>

                <!-- Modal Chỉnh Sửa Phụ Kiện -->
                <div class="modal fade" id="editAccessoryModal" tabindex="-1" role="dialog" aria-labelledby="editAccessoryModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="border-radius: 12px; overflow: hidden; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                            <div class="modal-header" style="background: #1a1816; border-bottom: none; padding: 20px 30px;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: #fff; opacity: 0.8; text-shadow: none; font-size: 24px;"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="editAccessoryModalLabel" style="font-weight: 700; color: #d4af37; text-transform: uppercase; font-size: 18px;">Chỉnh Sửa Phụ Kiện</h4>
                            </div>
                            <div class="modal-body" style="padding: 30px; background: #f8fafc;">
                                <form action="UpdateAccessoryStaff" id="editLocationForm" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" id="editAccessoryId" name="accessoryId" >

                                    <div class="form-group">
                                        <label for="editAccessoryName" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;">Tên Phụ Kiện:</label>
                                        <input type="text" class="form-control" id="editAccessoryName" name="accessoryName" required style="border-radius: 8px;">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="editAccessoryImage" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;">Hình ảnh:</label>
                                        <div id="editAccessoryImagePreview" style="margin-bottom: 15px; border-radius: 8px; overflow: hidden; display: inline-block;"></div>
                                        <input type="file" class="form-control" id="editAccessoryImage" name="accessoryImage" accept="image/*" style="border-radius: 8px;">
                                    </div>
                                    
                                    <div class="form-group" style="display: none;">  
                                        <label for="editAccessoryImageIcon">Biểu Tượng:</label>
                                        <div id="editAccessoryImageIconPreview"></div>
                                        <input type="file" class="form-control" id="editAccessoryImageIcon" name="accessoryImageIcon" accept="image/*">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="editAccessoryDescription" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;">Thông Tin Mô Tả:</label>
                                        <textarea class="form-control" id="editAccessoryDescription" name="accessoryDescription" rows="4" required style="resize: vertical; border-radius: 8px;"></textarea>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="editPrice" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;">Giá:</label>
                                        <input type="number" class="form-control" id="editPrice" name="price" required style="border-radius: 8px;">
                                    </div>
                                    
                                    <div style="text-align: right; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e2e8f0;">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-right: 12px; border-radius: 8px; padding: 10px 24px; font-weight: 600; color: #64748b; background: #fff; border: 1px solid #cbd5e1;">Hủy</button>
                                        <button type="submit" class="btn btn-primary" style="background: #b59349; border: none; border-radius: 8px; padding: 10px 24px; font-weight: 600; color: #fff; box-shadow: 0 4px 12px rgba(181, 147, 73, 0.3);">Cập Nhật Lưu Lại</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>



            </div>
        </div>

        <script>
            function editTouristLocation(accessoryId, accessoryName, accessoryImage, accessoryImageicon, accessoryDescription, price) {
                document.getElementById('editAccessoryName').value = accessoryName;
                document.getElementById('editAccessoryDescription').value = accessoryDescription;
                document.getElementById('editPrice').value = price;
                document.getElementById('editAccessoryId').value = accessoryId;
                var imgContainer = document.getElementById('editAccessoryImagePreview');
                var imgContainer2 = document.getElementById('editAccessoryImageIconPreview');
console.log("1");
                // Clear previous images
                imgContainer.innerHTML = '';
                imgContainer2.innerHTML = '';

                // Display images if available
                if (accessoryImage && accessoryImage !== '') {
                    var img1 = document.createElement('img');
                    img1.src = accessoryImage.startsWith('http') ? accessoryImage : 'images/' + accessoryImage;
                    img1.alt = 'Accessory Image';
                    img1.className = 'img-fluid img-thumbnail';
                    img1.style.maxWidth = '150px';
                    imgContainer.appendChild(img1);
                } else {
                    imgContainer.innerHTML = '<span class="text-muted">Chưa có hình ảnh</span>';
                }

                if (accessoryImageicon && accessoryImageicon !== '') {
                    var img2 = document.createElement('img');
                    img2.src = accessoryImageicon.startsWith('http') ? accessoryImageicon : 'images/' + accessoryImageicon;
                    img2.alt = 'Accessory Image Icon';
                    img2.className = 'img-fluid img-thumbnail';
                    img2.style.maxWidth = '150px';
                    img2.style.cursor = 'pointer';
                    img2.setAttribute('onclick', 'if(window.parent && window.parent.openLightbox) window.parent.openLightbox(this.src)');
                    imgContainer2.appendChild(img2);
                }

                // Hiển thị modal thay vì chuyển tab
                $('#editAccessoryModal').modal('show');
            }
            
            // Live Preview Function with Clear Button
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
                                btn.style.top = '-10px';
                                btn.style.right = '-10px';
                                btn.style.background = '#dc2626';
                                btn.style.color = 'white';
                                btn.style.border = 'none';
                                btn.style.borderRadius = '50%';
                                btn.style.width = '24px';
                                btn.style.height = '24px';
                                btn.style.lineHeight = '1';
                                btn.style.cursor = 'pointer';
                                btn.style.boxShadow = '0 2px 4px rgba(0,0,0,0.2)';
                                
                                btn.onclick = function() {
                                    input.value = '';
                                    previewContainer.innerHTML = '';
                                };
                                
                                previewContainer.appendChild(img);
                                previewContainer.appendChild(btn);
                            }
                            reader.readAsDataURL(file);
                        }
                    });
                }
            }
            
            // Khởi tạo live preview khi trang load
            document.addEventListener('DOMContentLoaded', function() {
                setupLivePreview('accessoryImage', 'addAccessoryImagePreview');
                setupLivePreview('editAccessoryImage', 'editAccessoryImagePreview');
            });
        </script>
<script type="text/javascript">
            function confirmDelete(accessoryId) {
                Swal.fire({
                    title: 'Bạn có chắc chắn?',
                    text: "Bạn sẽ không thể khôi phục hành động này!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#1089FF',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, xóa nó!',
                    cancelButtonText: 'Hủy'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'DeleteAccessoriesStaff?accessoryId=' + accessoryId;
                    }
                })
            }
        </script>

        <script>
            document.getElementById('addLocationForm').addEventListener('submit', function (event) {
                var fileInputImage = document.getElementById('accessoryImage');
                var fileInputIcon = document.getElementById('accessoryImageIcon');
                var errorMessage = document.getElementById('error-message');
                var successMessage = document.getElementById('success-message');
                var isValid = true;

                // Validate Accessory Image
                var fileNameImage = fileInputImage.value;
                var idxDotImage = fileNameImage.lastIndexOf(".") + 1;
                var extFileImage = fileNameImage.substr(idxDotImage, fileNameImage.length).toLowerCase();
                if (extFileImage !== "jpg" && extFileImage !== "jpeg" && extFileImage !== "png" && extFileImage !== "gif") {
                    isValid = false;
                }

                // Validate Accessory Image Icon
                var fileNameIcon = fileInputIcon.value;
                var idxDotIcon = fileNameIcon.lastIndexOf(".") + 1;
                var extFileIcon = fileNameIcon.substr(idxDotIcon, fileNameIcon.length).toLowerCase();
                if (extFileIcon !== "jpg" && extFileIcon !== "jpeg" && extFileIcon !== "png" && extFileIcon !== "gif") {
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                    errorMessage.style.display = 'block';
                    successMessage.style.display = 'none';
                } else {
                    errorMessage.style.display = 'none';
                    successMessage.style.display = 'block';

                }
            });

        </script>
        <script>
            $(document).ready(function () {
                $('#addLocationForm').submit(function (event) {
                    event.preventDefault(); // Ngăn chặn hành động mặc định của form

                    var formData = new FormData(this); // Lấy dữ liệu từ form

                    $.ajax({
                        type: 'POST',
                        url: 'AddAccessoryStaff',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            // Hiển thị thông báo thành công bằng SweetAlert
                            Swal.fire({
                                icon: 'success',
                                title: 'Success!',
                                text: 'Event added successfully!',
                                timer: 2000, // Tự động đóng sau 2 giây
                                showConfirmButton: false
                            }).then(function () {
                                // Chuyển hướng về trang TourismLocationServletStaff sau khi thêm thành công
                                window.location.href = 'accessoriesStaffServlet';
                            });
                        },
                        error: function (xhr, status, error) {
                            // Hiển thị thông báo lỗi bằng SweetAlert
                            Swal.fire({
                                icon: 'error',
                                title: 'Error!',
                                text: 'Error adding event. Please try again.',
                                confirmButtonText: 'OK'
                            });
                            console.error(xhr.responseText);
                        }
                    });
                });
            });
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>

</html>

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
    body, html { height: 100%; margin: 0; font-family: 'Poppins', sans-serif; background-color: #f8fafc; }
    .container-fluid { padding: 2rem; }
    
    /* --- Card Container --- */
    .card { background: #fff; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); border: none; margin-bottom: 2rem; }
    .card-header { background: #fff; border-bottom: 1px solid #e2e8f0; padding: 1.5rem; border-radius: 12px 12px 0 0; display: flex; justify-content: space-between; align-items: center; }
    .card-title { color: #1e293b; font-size: 1.25rem; font-weight: 600; margin: 0; }
    .card-body { padding: 0; }

    /* --- Table Styles --- */
    .table-responsive { overflow-x: auto; border-radius: 0 0 12px 12px; }
    .table { margin-bottom: 0; width: 100%; border-collapse: separate !important; border-spacing: 0 !important; border: 1px solid #e2e8f0 !important; border-radius: 8px !important; overflow: hidden !important;}
    .table th { background-color: #f1f5f9 !important; color: #334155 !important; font-size: 0.85rem !important; font-weight: 600; text-transform: uppercase !important; letter-spacing: 0.5px !important; padding: 14px 16px !important; border-bottom: 2px solid #cbd5e1 !important; border-right: 1px solid #e2e8f0 !important; text-align: center; vertical-align: middle; white-space: nowrap; }
    .table th:last-child { border-right: none !important; }
    .table td { vertical-align: middle !important; padding: 16px 16px !important; border-bottom: 1px solid #e2e8f0 !important; border-right: 1px solid #e2e8f0 !important; color: #334155; font-size: 15px !important; text-align: center; transition: background-color 0.2s; }
    .table td:last-child { border-right: none !important; }
    .table tbody tr:hover td { background-color: #f8fafc; }
    .table tr:last-child td { border-bottom: none !important; }
    .table img { max-width: 80px; height: auto; max-height: 80px; object-fit: contain; border-radius: 6px; border: 1px solid #e2e8f0; padding: 2px; }

    
    /* --- Custom Select & Text Truncate --- */
    .custom-select { appearance: none; -webkit-appearance: none; -moz-appearance: none; background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 12px center; background-size: 16px; background-color: #fff; border: 1px solid #cbd5e1; border-radius: 20px; padding: 6px 36px 6px 16px; font-weight: 500; color: #475569; transition: all 0.2s; cursor: pointer; height: auto; }
    .custom-select:focus { outline: none; border-color: #d4af37; box-shadow: 0 0 0 3px rgba(212,175,55,0.1); }
    .dataTables_wrapper .dataTables_length select { margin: 0 10px; border: 1px solid #cbd5e1; border-radius: 20px; padding: 5px 30px 5px 15px; outline: none; background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 8px center; background-size: 16px; appearance: none; -webkit-appearance: none; }
    
    .desc-text { display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; max-width: 160px; color: #6c757d; font-size: 13px; text-align: center; margin: 0 auto; }

    /* --- Button Styles --- */
    .btn-custom-add { background: #f59e0b; color: #fff; border: none; border-radius: 6px; padding: 8px 16px; font-weight: 500; font-size: 0.9rem; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
    .btn-custom-add:hover { background: #d97706; color: #fff; transform: translateY(-1px); }
    
    .action-buttons { white-space: nowrap; }
    .action-buttons .btn { border-radius: 5px; padding: 5px 10px; margin: 0 2px; font-size: 0.85rem; transition: all 0.15s; border: 1px solid; cursor: pointer; }
    .btn-edit { background-color: #e0f2fe; color: #0369a1; border-color: #bae6fd !important; }
    .btn-edit:hover { background-color: #bae6fd; color: #075985; }
    .btn-delete { background-color: #fee2e2; color: #dc2626; border-color: #fecaca !important; }
    .btn-delete:hover { background-color: #fecaca; color: #991b1b; }

    /* --- Modal Styles --- */
    .modal-content { border-radius: 12px; border: none; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
    .modal-header { background: #fff; border-bottom: 1px solid #e2e8f0; border-radius: 12px 12px 0 0; padding: 1.5rem; }
    .modal-title { color: #1e293b; font-weight: 600; font-size: 1.25rem; }
    .modal-body { padding: 1.5rem; }
    .modal-footer { border-top: 1px solid #e2e8f0; padding: 1rem 1.5rem; background: #f8fafc; border-radius: 0 0 12px 12px; }
    .close { color: #64748b; opacity: 0.7; transition: opacity 0.2s; }
    .close:hover { opacity: 1; color: #0f172a; }
    .form-control, .form-control-file { border-radius: 6px; border: 1px solid #cbd5e1; padding: 0.5rem 0.75rem; box-shadow: inset 0 1px 2px rgba(0,0,0,0.05); }
    .form-control:focus { border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1); }
    label { font-weight: 500; color: #475569; margin-bottom: 0.5rem; display: inline-block; }
    label .required { color: #ef4444; }
    .input-group-addon { background: #f8fafc; border: 1px solid #cbd5e1; padding: 0.5rem 0.75rem; font-weight: 600; color: #64748b; }
    .help-block { font-size: 0.875rem; color: #64748b; margin-top: 0.5rem; }
</style>
    </head>

    <body>
        <div class="container-fluid mt-4">
            <div class="pagetitle" style="margin-bottom: 20px; padding-left: 0;">
                <h1 style="color: #1a1816; font-weight: 800; font-size: 24px; text-transform: uppercase; margin-top: 0; margin-bottom: 5px; font-family: 'Tahoma', sans-serif;">QUẢN LÝ SỰ KIỆN</h1>
                <nav>
                    <ol class="breadcrumb" style="background: transparent; padding: 0; margin: 0; font-size: 14px;">
                        <li style="display: inline-block;"><a href="homeStaff" target="_top" style="color: #b59349; text-decoration: none; font-weight: 600;">Trang chủ</a></li>
                        <li class="active" style="display: inline-block; font-weight: 500; color: #6c757d;">Quản lý sự kiện</li>
                    </ol>
                </nav>
            </div>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title"><i class="fa fa-calendar-alt text-primary mr-2"></i> DANH SÁCH SỰ KIỆN</h3>
                    <button class="btn btn-custom-add" data-toggle="modal" data-target="#addEventModal">
                        <i class="fa fa-plus-circle"></i> Thêm Sự Kiện
                    </button>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Tiêu Đề</th>
                                            <th scope="col">Ngày Tạo</th>
                                            <th scope="col">Ngày Bắt Đầu</th>
                                            <th scope="col">Ngày Kết Thúc</th>
                                            <th scope="col">Nội Dung</th>
                                            <th scope="col">Ảnh</th>
                                            <th scope="col">Giảm Giá</th>
                                            <th scope="col">Hành Động</th>

                                        </tr>
                                    </thead>
                            <tbody>
                                        <c:forEach var="eventLists" items="${eventList}">
                                            <tr>
                                                <td>${eventLists.eventID}</td>

                                                <td style="max-width: 100px;">${eventLists.eventTitle}</td>
                                                <td>${eventLists.createdDate}</td>
                                                <td>${eventLists.startDate}</td>
                                                <td>${eventLists.endDate}</td>
                                                <td style="max-width: 250px;">${eventLists.content}</td>
                                                <td class="w-25" style="max-width: 150px;">
                                                    <img src="${empty eventLists.eventImage ? 'images/default.jpg' : (eventLists.eventImage.startsWith('http') ? eventLists.eventImage : 'images/'.concat(eventLists.eventImage))}"
                                                         class="img-fluid img-thumbnail" loading="lazy" alt="Event Image">
                                                </td>
                                                <td>
                                                    <span style="background: #dcfce7; color: #166534; padding: 4px 10px; border-radius: 12px; font-weight: 600; font-size: 13px;">
                                                        <fmt:formatNumber value="${eventLists.discount * 100}" maxFractionDigits="1" minFractionDigits="0"/>%
                                                    </span>
                                                </td>
                                                <td class="action-buttons">
                                                    <div class="buttons">
                                                        <button class="btn btn-edit" onclick="editEventForm('${eventLists.eventID}', '${eventLists.eventTitle}', '${eventLists.createdDate}', '${eventLists.startDate}', '${eventLists.endDate}', '${eventLists.content}', '${eventLists.eventImage}', '${eventLists.discount}', '${eventLists.staffID}')">
                                                            <i class="fa fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-delete" onclick="confirmDelete('${eventLists.eventID}')">
                                                            <i class="fa fa-trash"></i>
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
</div>
                
<!-- Add Event Modal -->
<div class="modal fade" id="addEventModal" tabindex="-1" role="dialog" aria-labelledby="addEventModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background: #3b82f6; border-bottom: none; padding: 1.25rem 1.5rem;">
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 0.9;"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addEventModalLabel" style="color: #fff; font-weight: 600; font-size: 1.125rem;"><i class="fa fa-plus-circle"></i> Thêm Mới Sự Kiện</h4>
            </div>
            <form class="form-horizontal addnew-event-form" id="addLocationForm" action="AddNewEventStaff" method="post" enctype="multipart/form-data">
                <div class="modal-body" style="padding: 1.5rem;">
                    
                                        <!-- Event Title -->
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="eventTitle">Tiêu Đề <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="eventTitle" name="eventTitle" placeholder="Nhập tiêu đề sự kiện" required>
                                            </div>
                                        </div>
                                        <!-- Start Date -->
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="startDate">Ngày Bắt Đầu <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="date" class="form-control" id="startDate" name="startDate" required>
                                            </div>
                                        </div>
                                        <!-- End Date -->
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="endDate">Ngày Kết Thúc <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="date" class="form-control" id="endDate" name="endDate" required>
                                            </div>
                                        </div>
                                        <!-- Content -->
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="content">Nội Dung <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <textarea class="form-control" id="content" name="content" rows="3" placeholder="Nhập nội dung sự kiện" required></textarea>
                                            </div>
                                        </div>
                                        <!-- Event Image -->
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="eventImage">Hình Ảnh <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="file" class="form-control-file" id="eventImage" name="eventImage" accept="image/*" required>
                                            </div>
                                        </div>
                                        <!-- Discount -->
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="discount">Giảm Giá (%) <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <div class="input-group">
                                                    <input type="number" class="form-control" id="discount" name="discount" placeholder="VD: 5" step="0.01" min="0" max="100" oninput="validateDiscount(this)" required>
                                                    <span class="input-group-addon">%</span>
                                                </div>
                                                <small class="help-block">Nhập số từ 0-100. VD: nhập <strong>5</strong> để giảm <strong>5%</strong></small>
                                            </div>
                                        </div>
                                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Thêm Sự Kiện</button>
                </div>
            </form>
        </div>
    </div>
</div>

                            </div>
                        </div>
                    </section>
                </div>

                
<!-- Edit Event Modal -->
<div class="modal fade" id="editEventModal" tabindex="-1" role="dialog" aria-labelledby="editEventModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background: #06b6d4; border-bottom: none; padding: 1.25rem 1.5rem;">
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close" style="opacity: 0.9;"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editEventModalLabel" style="color: #fff; font-weight: 600; font-size: 1.125rem;"><i class="fa fa-edit"></i> Chỉnh Sửa Sự Kiện</h4>
            </div>
            <form class="form-horizontal edit-event-form" id="editEventForm" action="UpdateEventStaff" method="post" enctype="multipart/form-data">
                <div class="modal-body" style="padding: 1.5rem;">
                    
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="editEventID" style="font-weight: 600; color: #334155;">ID:</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="editEventID" name="editEventID" readonly style="border-radius: 8px; border: 2px solid #e2e8f0; padding: 10px 14px; background: #f1f5f9; color: #64748b;">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="editEventTitle" style="font-weight: 600; color: #334155;">Tiêu Đề: <span style="color: #ef4444;">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="editEventTitle" name="editEventTitle" placeholder="Nhập tiêu đề" style="border-radius: 8px; border: 2px solid #e2e8f0; padding: 10px 14px;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="editCreatedDate" style="font-weight: 600; color: #334155;">Ngày Tạo:</label>
                                            <div class="col-sm-9">
                                                <input type="date" class="form-control" id="editCreatedDate" name="editCreatedDate" readonly style="border-radius: 8px; border: 2px solid #e2e8f0; padding: 10px 14px; background: #f1f5f9; color: #64748b;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="editStartDate" style="font-weight: 600; color: #334155;">Ngày Bắt Đầu: <span style="color: #ef4444;">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="date" class="form-control" id="editStartDate" name="editStartDate" style="border-radius: 8px; border: 2px solid #e2e8f0; padding: 10px 14px;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="editEndDate" style="font-weight: 600; color: #334155;">Ngày Kết Thúc: <span style="color: #ef4444;">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="date" class="form-control" id="editEndDate" name="editEndDate" style="border-radius: 8px; border: 2px solid #e2e8f0; padding: 10px 14px;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="editContent" style="font-weight: 600; color: #334155;">Nội Dung: <span style="color: #ef4444;">*</span></label>
                                            <div class="col-sm-9">
                                                <textarea class="form-control" id="editContent" name="editContent" rows="4" placeholder="Nhập nội dung" style="resize: vertical; border-radius: 8px; border: 2px solid #e2e8f0; padding: 10px 14px;"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="editEventImage" style="font-weight: 600; color: #334155;">Hình Ảnh:</label>
                                            <div class="col-sm-9">
                                                <div id="editEventImagePreview" style="margin-bottom: 10px;"></div>
                                                <input type="file" class="form-control-file" id="editEventImage" name="editEventImage" accept="image/*" style="border: 2px dashed #cbd5e1; padding: 12px; border-radius: 8px; background: #fff;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-sm-3" for="editDiscount" style="font-weight: 600; color: #334155;">Giảm Giá (%): <span style="color: #ef4444;">*</span></label>
                                            <div class="col-sm-9">
                                                <div class="input-group">
                                                    <input type="number" class="form-control" id="editDiscount" name="editDiscount" placeholder="VD: 5 (tương đương 5%)" step="0.01" min="0" max="100" oninput="validateDiscount(this)" style="border-radius: 8px 0 0 8px; border: 2px solid #e2e8f0; padding: 10px 14px;">
                                                    <span class="input-group-addon" style="background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%); border: 2px solid #e2e8f0; border-left: none; font-weight: 700; color: #475569; border-radius: 0 8px 8px 0; padding: 10px 16px; display: flex; align-items: center;">%</span>
                                                </div>
                                                <small class="help-block" style="color: #64748b; font-style: italic; margin-top: 8px; display: block;">
                                                    <i class="fa fa-info-circle" style="color: #06b6d4;"></i> Nhập số từ 0-100. VD: nhập <strong style="color: #059669;">5</strong> để giảm <strong style="color: #059669;">5%</strong>
                                                </small>
                                            </div>
                                        </div>
                                        
                                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-info"><i class="fa fa-save"></i> Cập Nhật</button>
                </div>
            </form>
        </div>
    </div>
</div>

                            </div>
                        </div>
                    </section>
                </div>



        <script>

            function convertToInputDateFormat(dateString) {
                // Tách chuỗi thành các phần ngày, tháng, năm
                const [day, month, year] = dateString.split('-');
                // Sắp xếp lại theo định dạng yyyy-MM-dd
                return {
                    day, month, year
                };
            }

            function editEventForm(eventID, eventTitle, createdDate, startDate, endDate, content, eventImage, discount, staffID) {
                const formattedCreatedDate = convertToInputDateFormat(createdDate);
                const formattedStartDate = convertToInputDateFormat(startDate);
                const formattedEndDate = convertToInputDateFormat(endDate);
                document.getElementById('editEventID').value = eventID;
                document.getElementById('editEventTitle').value = eventTitle;
                document.getElementById('editCreatedDate').value = formattedCreatedDate.year + "-" + formattedCreatedDate.month + "-" + formattedCreatedDate.day;
                document.getElementById('editStartDate').value = formattedStartDate.year + "-" + formattedStartDate.month + "-" + formattedStartDate.day;
                document.getElementById('editEndDate').value = formattedEndDate.year + "-" + formattedEndDate.month + "-" + formattedEndDate.day;
                document.getElementById('editContent').value = content;
                // Chuyển đổi từ thập phân (0.05) sang phần trăm (5) để hiển thị cho user
                document.getElementById('editDiscount').value = parseFloat(discount) * 100;
                document.getElementById('editStaffID').value = staffID;

                var imgContainer = document.getElementById('editEventImagePreview');
                imgContainer.innerHTML = ''; // Xóa hình ảnh cũ (nếu có)
                console.log("thinh");
                // Hiển thị hình ảnh đối tượng
                if (eventImage) {
                    console.log("hihihi");
                    var img = document.createElement('img');
                    img.src = eventImage;
                    img.alt = 'Event Image';
                    img.className = 'img-thumbnail';
                    img.style.maxWidth = '150px';
                    img.style.maxHeight = '150px';
                    
                    var btn = document.createElement('button');
                    btn.innerHTML = '&times;';
                    btn.type = 'button';
                    btn.title = 'Remove Image';
                    btn.style.position = 'absolute';
                    btn.style.top = '0px';
                    btn.style.right = '-10px';
                    btn.style.background = '#dc2626';
                    btn.style.color = 'white';
                    btn.style.border = 'none';
                    btn.style.borderRadius = '50%';
                    btn.style.width = '24px';
                    btn.style.height = '24px';
                    btn.style.cursor = 'pointer';
                    btn.onclick = function() {
                        document.getElementById('editEventImage').value = '';
                        imgContainer.innerHTML = '';
                    };
                    
                    imgContainer.style.position = 'relative';
                    imgContainer.style.display = 'inline-block';
                    imgContainer.appendChild(img);
                    imgContainer.appendChild(btn);
                } else {
                    imgContainer.innerHTML = '<span class="text-muted">No image available</span>';
                }

                // Chuyển sang tab Section 3 (nếu cần thiết)
                $('#editEventModal').modal('show');
            }

        </script>


        <!--        <script>
                    $(document).ready(function () {
                        $('#editEventForm').submit(function (event) {
                            event.preventDefault(); // Ngăn chặn hành động mặc định của form
        
                            var formData = new FormData(this); // Lấy dữ liệu từ form
        
                            $.ajax({
                                type: 'POST',
                                url: $(this).attr('action'),
                                data: formData,
                                processData: false,
                                contentType: false,
                                success: function (response) {
                                    // Xử lý kết quả thành công
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Event updated successfully!',
                                        showConfirmButton: false,
                                        timer: 1500
                                    }).then(function () {
                                        // Cập nhật hoặc chuyển hướng sau khi cập nhật thành công
                                        window.location.reload(); // Ví dụ: tải lại trang để cập nhật dữ liệu mới
                                    });
                                },
                                error: function (xhr, status, error) {
                                    // Xử lý lỗi khi cập nhật sự kiện
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Error updating event!',
                                        text: 'Please try again later.',
                                        confirmButtonText: 'OK'
                                    });
                                    console.error(xhr.responseText);
                                }
                            });
                        });
                    });
                </script>-->


        <script>
            function validateDiscount(input) {
                if (input.value < 0) {
                    input.value = 0;
                }
            }
        </script>
        <script type="text/javascript">
            function confirmDelete(eventID) {
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
                        window.location.href = 'DeleteEvent?eventID=' + eventID;
                    }
                })
            }
        </script>
        <script>
            document.getElementById('addLocationForm').addEventListener('submit', function (event) {
                var fileInput = document.getElementById('eventImage');
                var errorMessage = document.getElementById('error-message');
                var successMessage = document.getElementById('success-message');

                // Validate file type if needed
                var fileName = fileInput.value;
                var idxDot = fileName.lastIndexOf(".") + 1;
                var extFile = fileName.substr(idxDot, fileName.length).toLowerCase();
                if (extFile != "jpg" && extFile != "jpeg" && extFile != "png" && extFile != "gif") {
                    event.preventDefault();
                    errorMessage.style.display = 'block';
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
                        url: $(this).attr('action'),
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
                                window.location.href = 'eventStaffServlet';
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
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="js/imagePreview.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                if (typeof setupLivePreview === 'function') {
                    setupLivePreview('eventImage', 'eventImagePreview');
                    setupLivePreview('editEventImage', 'editEventImagePreview');
                }
            });
        </script>
    </body>
</html>

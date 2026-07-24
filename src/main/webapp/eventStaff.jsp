<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    
    .cursor-pointer { transition: all 0.2s ease-in-out; }
    .cursor-pointer:hover { opacity: 0.8; transform: scale(1.03); }
    
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
    .btn-premium { background: linear-gradient(135deg, #d4af37 0%, #b8860b 100%); color: white !important; border-radius: 50rem; padding: 8px 20px; font-weight: 500; border: none; transition: all 0.3s ease; box-shadow: 0 .125rem .25rem rgba(0,0,0,.075); display: inline-flex; align-items: center; gap: 5px; }
    .btn-premium:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(184, 134, 11, 0.4); color: white; }
    
    .rounded-pill { border-radius: 50rem !important; }
    .btn-action-outline { padding: 4px 16px; font-weight: 500; font-size: 0.875rem; background: transparent; border-width: 1px; border-style: solid; transition: all 0.2s; cursor: pointer; display: inline-flex; align-items: center; gap: 4px; justify-content: center; }
    .btn-outline-primary-custom { color: #0d6efd; border-color: #0d6efd; }
    .btn-outline-primary-custom:hover { color: #fff; background-color: #0d6efd; }
    .btn-outline-success-custom { color: #198754; border-color: #198754; }
    .btn-outline-success-custom:hover { color: #fff; background-color: #198754; }
    .btn-outline-danger-custom { color: #dc3545; border-color: #dc3545; }
    .btn-outline-danger-custom:hover { color: #fff; background-color: #dc3545; }

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
                    <button class="btn btn-premium shadow-sm" data-toggle="modal" data-target="#addEventModal">
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
                                                <td class="fw-bold text-muted" style="white-space: nowrap;">${eventLists.eventID}</td>

                                                <td style="max-width: 150px; font-weight: 600; color: #334155;">
                                                    <span style="font-family: monospace; font-size: 0.9rem; color: #b8860b; background-color: rgba(184, 134, 11, 0.1); padding: 0.4rem 0.8rem; border-radius: 6px; border: 1px dashed #d4af37; display: inline-block;">
                                                        ${eventLists.eventTitle}
                                                    </span>
                                                </td>
                                                <td style="color: #6c757d; white-space: nowrap;">${eventLists.createdDate}</td>
                                                <td style="color: #6c757d; white-space: nowrap;">${eventLists.startDate}</td>
                                                <td style="color: #6c757d; white-space: nowrap;">${eventLists.endDate}</td>

                                                <td>
                                                    <div class="desc-text">${eventLists.content}</div>
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty eventLists.eventImage}">
                                                            <img src="${eventLists.eventImage.startsWith('http') ? eventLists.eventImage : 'images/'.concat(eventLists.eventImage)}" alt="Event Image" class="cursor-pointer" onclick="if(window.parent && window.parent.openLightbox) window.parent.openLightbox(this.src)">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span style="color: #94a3b8; font-style: italic; font-size: 13px;">Không có ảnh</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="color: #198754; font-weight: 700; font-size: 1.1rem; white-space: nowrap;">
                                                    <fmt:formatNumber value="${eventLists.discount * 100}" maxFractionDigits="1" minFractionDigits="0"/>%
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <div style="display: flex; flex-direction: row; gap: 8px; justify-content: center; flex-wrap: wrap;">
                                                        <button class="btn rounded-pill btn-action-outline btn-outline-primary-custom" 
                                                                data-id="${eventLists.eventID}"
                                                                data-title="${fn:escapeXml(eventLists.eventTitle)}"
                                                                data-created="${eventLists.createdDate}"
                                                                data-start="${eventLists.startDate}"
                                                                data-end="${eventLists.endDate}"
                                                                data-content="${fn:escapeXml(eventLists.content)}"
                                                                data-img="${eventLists.eventImage}"
                                                                data-discount="${eventLists.discount}"
                                                                onclick="editEventForm(this)" title="Chỉnh sửa">
                                                            <i class="fa fa-pencil-square-o"></i> Sửa
                                                        </button>
                                                        <c:choose>
                                                            <c:when test="${eventLists.published}">
                                                                <button id="publish-btn-${eventLists.eventID}" class="btn rounded-pill btn-action-outline publish-btn" data-id="${eventLists.eventID}" style="background-color: #198754; color: #fff; cursor: default; opacity: 0.8;" title="Đã phát hành" disabled>
                                                                    <i class="fa fa-check-circle"></i> Đã phát hành
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button id="publish-btn-${eventLists.eventID}" class="btn rounded-pill btn-action-outline btn-outline-success-custom publish-btn" data-id="${eventLists.eventID}" onclick="publishNotification('event', '${eventLists.eventID}')" title="Phát hành">
                                                                    <i class="fa fa-paper-plane"></i> Phát hành
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <button class="btn rounded-pill btn-action-outline btn-outline-danger-custom" onclick="confirmDelete('${eventLists.eventID}')" title="Xóa">
                                                            <i class="fa fa-trash"></i> Xóa
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                        </table>
                    </div>
                </div>
            <!-- Add Event Modal -->
<div class="modal fade" id="addEventModal" tabindex="-1" role="dialog" aria-labelledby="addEventModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 25px rgba(0,0,0,0.1);">
            <div class="modal-header" style="border-bottom: none; padding-bottom: 0; background: transparent;">
                <button type="button" data-dismiss="modal" aria-label="Close" style="float: right; background: transparent; border: none; font-size: 1.5rem; line-height: 1; cursor: pointer; color: #64748b; padding: 0; outline: none; transition: color 0.2s;" onmouseover="this.style.color='#0f172a'" onmouseout="this.style.color='#64748b'"><i class="fa fa-times"></i></button>
                <h4 class="modal-title" id="addEventModalLabel" style="font-weight: 700; color: #212529; font-size: 1.25rem;"><i class="fa fa-ticket"></i> Thêm Mới Sự Kiện</h4>
            </div>
            <form id="addLocationForm" action="AddNewEventStaff" method="post" enctype="multipart/form-data">
                <div class="modal-body" style="padding: 1.5rem; background: #fff;">
                    <div class="row">
                        <!-- Event Title -->
                        <div class="col-md-12 mb-3">
                            <div class="form-group">
                                <label for="eventTitle" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">TIÊU ĐỀ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="eventTitle" name="eventTitle" required style="border-radius: 6px; box-shadow: none;">
                            </div>
                        </div>
                        
                        <!-- Start Date & End Date -->
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label for="startDate" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">NGÀY BẮT ĐẦU <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required style="border-radius: 6px; box-shadow: none;">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label for="endDate" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">NGÀY KẾT THÚC <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="endDate" name="endDate" required style="border-radius: 6px; box-shadow: none;">
                            </div>
                        </div>

                        <!-- Content -->
                        <div class="col-md-12 mb-3">
                            <div class="form-group">
                                <label for="content" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">NỘI DUNG <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="content" name="content" rows="4" required style="border-radius: 6px; box-shadow: none; resize: vertical;"></textarea>
                            </div>
                        </div>

                        <!-- Discount -->
                        <div class="col-md-12 mb-3">
                            <div class="form-group">
                                <label for="discount" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">GIẢM GIÁ (%) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="discount" name="discount" step="0.01" min="0" max="100" oninput="validateDiscount(this)" required style="border-radius: 6px 0 0 6px; box-shadow: none; height: auto; padding: 6px 12px;">
                                    <span class="input-group-addon" style="background-color: #e9ecef; border: 1px solid #ced4da; border-radius: 0 6px 6px 0; color: #495057;">%</span>
                                </div>
                            </div>
                        </div>

                        <!-- Image Upload -->
                        <div class="col-md-12 mb-3">
                            <div class="form-group">
                                <label style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">ẢNH BANNER <span class="text-danger">*</span></label>
                                <div id="addEventImagePreviewContainer" style="margin-bottom: 10px; display: none; position: relative;">
                                    <img id="addEventImagePreview" src="#" alt="Preview" class="img-thumbnail cursor-pointer" style="max-height: 150px; border-radius: 6px; cursor: pointer;" onclick="if(window.parent && window.parent.openLightbox) window.parent.openLightbox(this.src)">
                                </div>
                                <input type="file" class="form-control-file" id="eventImage" name="eventImage" accept="image/*" required onchange="previewImage(this, 'addEventImagePreview', 'addEventImagePreviewContainer')" style="border-radius: 6px; box-shadow: none;">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: none; padding-top: 0; background: transparent;">
                    <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color: #f8f9fa; border-color: #f8f9fa; color: #000; border-radius: 6px;">Hủy</button>
                    <button type="submit" class="btn btn-warning" style="background-color: #ffc107; border-color: #ffc107; color: #212529; font-weight: 700; border-radius: 6px; box-shadow: 0 .125rem .25rem rgba(0,0,0,.075);">Thêm Sự Kiện</button>
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
        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 25px rgba(0,0,0,0.1);">
            <div class="modal-header" style="border-bottom: none; padding-bottom: 0; background: transparent;">
                <button type="button" data-dismiss="modal" aria-label="Close" style="float: right; background: transparent; border: none; font-size: 1.5rem; line-height: 1; cursor: pointer; color: #64748b; padding: 0; outline: none; transition: color 0.2s;" onmouseover="this.style.color='#0f172a'" onmouseout="this.style.color='#64748b'"><i class="fa fa-times"></i></button>
                <h4 class="modal-title" id="editEventModalLabel" style="font-weight: 700; color: #212529; font-size: 1.25rem;"><i class="fa fa-pencil-square-o"></i> Cập nhật Sự Kiện</h4>
            </div>
            <form id="editEventForm" action="UpdateEventStaff" method="post" enctype="multipart/form-data">
                <div class="modal-body" style="padding: 1.5rem; background: #fff;">
                    <div class="row">
                        <!-- ID and Created Date -->
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label for="editEventID" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">ID</label>
                                <input type="text" class="form-control" id="editEventID" name="editEventID" readonly style="border-radius: 6px; box-shadow: none; background: #e9ecef; cursor: not-allowed;">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label for="editCreatedDate" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">NGÀY TẠO</label>
                                <input type="date" class="form-control" id="editCreatedDate" name="editCreatedDate" readonly style="border-radius: 6px; box-shadow: none; background: #e9ecef; cursor: not-allowed;">
                            </div>
                        </div>

                        <!-- Event Title -->
                        <div class="col-md-12 mb-3">
                            <div class="form-group">
                                <label for="editEventTitle" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">TIÊU ĐỀ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="editEventTitle" name="editEventTitle" required style="border-radius: 6px; box-shadow: none;">
                            </div>
                        </div>
                        
                        <!-- Start Date & End Date -->
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label for="editStartDate" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">NGÀY BẮT ĐẦU <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="editStartDate" name="editStartDate" required style="border-radius: 6px; box-shadow: none;">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label for="editEndDate" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">NGÀY KẾT THÚC <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="editEndDate" name="editEndDate" required style="border-radius: 6px; box-shadow: none;">
                            </div>
                        </div>

                        <!-- Content -->
                        <div class="col-md-12 mb-3">
                            <div class="form-group">
                                <label for="editContent" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">NỘI DUNG <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="editContent" name="editContent" rows="4" required style="border-radius: 6px; box-shadow: none; resize: vertical;"></textarea>
                            </div>
                        </div>

                        <!-- Discount -->
                        <div class="col-md-12 mb-3">
                            <div class="form-group">
                                <label for="editDiscount" style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">GIẢM GIÁ (%) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="editDiscount" name="editDiscount" step="0.01" min="0" max="100" oninput="validateDiscount(this)" required style="border-radius: 6px 0 0 6px; box-shadow: none; height: auto; padding: 6px 12px;">
                                    <span class="input-group-addon" style="background-color: #e9ecef; border: 1px solid #ced4da; border-radius: 0 6px 6px 0; color: #495057;">%</span>
                                </div>
                            </div>
                        </div>

                        <!-- Image Upload -->
                        <div class="col-md-12 mb-3">
                            <div class="form-group">
                                <label style="color: #6c757d; font-size: 0.875rem; font-weight: 700; margin-bottom: 0.5rem; display: block;">ẢNH BANNER (Tùy chọn)</label>
                                <div id="editEventImagePreviewContainer" style="margin-bottom: 10px; display: none; position: relative;">
                                    <img id="editEventImagePreview" src="#" alt="Preview" class="img-thumbnail cursor-pointer" style="max-height: 150px; border-radius: 6px; cursor: pointer;" onclick="if(window.parent && window.parent.openLightbox) window.parent.openLightbox(this.src)">
                                </div>
                                <input type="file" class="form-control-file" id="editEventImage" name="editEventImage" accept="image/*" onchange="previewImage(this, 'editEventImagePreview', 'editEventImagePreviewContainer')" style="border-radius: 6px; box-shadow: none;">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: none; padding-top: 0; background: transparent;">
                    <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color: #f8f9fa; border-color: #f8f9fa; color: #000; border-radius: 6px;">Hủy</button>
                    <button type="submit" class="btn btn-warning" style="background-color: #ffc107; border-color: #ffc107; color: #212529; font-weight: 700; border-radius: 6px; box-shadow: 0 .125rem .25rem rgba(0,0,0,.075);">Cập nhật Sự Kiện</button>
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

            function editEventForm(btn) {
                const eventID = btn.getAttribute('data-id');
                const eventTitle = btn.getAttribute('data-title');
                const createdDate = btn.getAttribute('data-created');
                const startDate = btn.getAttribute('data-start');
                const endDate = btn.getAttribute('data-end');
                const content = btn.getAttribute('data-content');
                const eventImage = btn.getAttribute('data-img');
                const discount = btn.getAttribute('data-discount');
                
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
                document.getElementById('editDiscount').value = (parseFloat(discount) * 100).toFixed(0);

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
            
            function publishNotification(type, id) {
                Swal.fire({
                    title: 'Phát hành thông báo Sự kiện?',
                    text: "Thông báo này sẽ được gửi ngay lập tức đến chuông báo của TẤT CẢ KHÁCH HÀNG!",
                    icon: 'info',
                    showCancelButton: true,
                    confirmButtonColor: '#17a2b8',
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
                                    Swal.fire('Thành công!', 'Đã gửi Push Notification sự kiện đến toàn bộ khách hàng!', 'success');
                                    // Update UI to show it's published
                                    localStorage.setItem('published_event_' + id, 'true');
                                    var btn = document.getElementById('publish-btn-' + id);
                                    if(btn) {
                                        btn.innerHTML = '<i class="fa fa-check-circle"></i> Đã phát hành';
                                        btn.classList.remove('btn-outline-success-custom');
                                        btn.style.backgroundColor = '#198754';
                                        btn.style.color = '#fff';
                                        btn.style.borderColor = '#198754';
                                        btn.style.cursor = 'default';
                                        btn.onclick = null;
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
            
            // Check local storage on page load to update published buttons
            document.addEventListener('DOMContentLoaded', function() {
                var publishBtns = document.querySelectorAll('.publish-btn');
                publishBtns.forEach(function(btn) {
                    var eventId = btn.getAttribute('data-id');
                    if (localStorage.getItem('published_event_' + eventId) === 'true') {
                        btn.innerHTML = '<i class="fa fa-check-circle"></i> Đã phát hành';
                        btn.classList.remove('btn-outline-success-custom');
                        btn.style.backgroundColor = '#198754';
                        btn.style.color = '#fff';
                        btn.style.borderColor = '#198754';
                        btn.style.cursor = 'default';
                        btn.onclick = null;
                    }
                });
            });
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

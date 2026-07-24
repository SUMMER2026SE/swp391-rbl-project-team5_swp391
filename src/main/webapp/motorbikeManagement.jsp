<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vertical Tabs with Right Navigation</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="//cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
        <style>
            
            
            body, html {
                height: 100%;
                margin: 0;
                font-family: 'Be Vietnam Pro', 'Tahoma', sans-serif;
                background-color: #f5f7fb; /* Light modern gray */
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
                display: flex;
                background: transparent;
                padding: 0;
            }
            .nav-tabs li {
                float: none !important;
                margin-bottom: -2px; 
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
            
            
            
            
            /* --- Custom Dropdown --- */
            .custom-select { appearance: none; -webkit-appearance: none; -moz-appearance: none; background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 12px center; background-size: 16px; background-color: #fff; border: 1px solid #cbd5e1; border-radius: 20px; padding: 6px 36px 6px 16px; font-weight: 500; color: #475569; transition: all 0.2s; cursor: pointer; height: auto; }
            .custom-select:focus { outline: none; border-color: #d4af37; box-shadow: 0 0 0 3px rgba(212,175,55,0.1); }
            
            /* DataTables dropdown override */
            .dataTables_wrapper .dataTables_length select { margin: 0 10px; border: 1px solid #cbd5e1; border-radius: 20px; padding: 5px 30px 5px 15px; outline: none; background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 8px center; background-size: 16px; appearance: none; -webkit-appearance: none; }

/* --- Clean Table Styles --- */
            .e-panel.card {
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                border: 1px solid #e9ecef;
                background: #fff;
            }
            .table {
                margin-bottom: 0;
            }
            .table th {
                background-color: #f8f9fa;
                color: #495057;
                font-weight: 600;
                font-size: 13px;
                border-top: none !important;
                border-bottom: 2px solid #dee2e6 !important;
                padding: 15px 10px;
                text-align: center;
                vertical-align: middle;
            }
            .table td {
                vertical-align: middle;
                padding: 15px 10px;
                color: #333;
                font-size: 14px;
                border-bottom: 1px solid #e9ecef;
                text-align: center;
            }
            .table td.text-left {
                text-align: left;
            }
            /* Truncate description */
            .desc-text {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 220px;
                color: #6c757d;
                font-size: 13px;
                text-align: left;
                margin: 0 auto;
            }
            /* Action Buttons Alignment */
            .action-buttons {
                min-width: 90px;
                white-space: nowrap;
            }
            
            /* DataTables Styling Overrides */
            .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_length {
                margin-bottom: 15px;
                margin-top: 10px;
            }
            .dataTables_wrapper .dataTables_filter label {
                font-weight: 500;
                color: #495057;
                display: flex;
                align-items: center;
                justify-content: flex-end;
            }
            .dataTables_wrapper .dataTables_filter input {
                margin-left: 10px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding: 5px 10px;
                outline: none;
                width: 200px;
            }
            .dataTables_wrapper .dataTables_length label {
                font-weight: 500;
                color: #495057;
                display: flex;
                align-items: center;
            }
            .dataTables_wrapper .dataTables_length select {
                margin: 0 10px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding: 5px 10px;
                outline: none;
            }


            /* --- Custom Dropdown --- */
            .custom-select { appearance: none; -webkit-appearance: none; -moz-appearance: none; background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 12px center; background-size: 16px; background-color: #fff; border: 1px solid #cbd5e1; border-radius: 20px; padding: 6px 36px 6px 16px; font-weight: 500; color: #475569; transition: all 0.2s; cursor: pointer; height: auto; }
            .custom-select:focus { outline: none; border-color: #d4af37; box-shadow: 0 0 0 3px rgba(212,175,55,0.1); }
            
            /* DataTables dropdown override */
            .dataTables_wrapper .dataTables_length select { margin: 0 10px; border: 1px solid #cbd5e1; border-radius: 20px; padding: 5px 30px 5px 15px; outline: none; background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 8px center; background-size: 16px; appearance: none; -webkit-appearance: none; }

/* --- Clean Table Styles --- */
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
                margin-bottom: 22px; /* Tạo khoảng cách giữa các ô nhập liệu */
            }

            .form-control {
                border-radius: 10px;
                border: 1px solid #e2e8f0;
                padding: 12px 15px;
                background: #f8fafc;
                transition: all 0.3s ease;
                box-shadow: none !important;
                height: auto; /* Fix lỗi đè chữ ở select box */
                font-size: 14px;
            }
            .form-control:focus {
                border-color: #d4af37;
                background: #fff;
                box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.15) !important;
            }

            /* Làm đẹp nút tải ảnh lên */
            input[type="file"].form-control-file {
                padding: 15px;
                background: #f8fafc;
                border: 2px dashed #cbd5e1;
                border-radius: 10px;
                width: 100%;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            input[type="file"].form-control-file:hover {
                border-color: #d4af37;
                background: #fff;
            }

            /* Nút Submit của Form */
            .addnew .btn-dark, .editmotor .btn-dark {
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
            .addnew .btn-dark:hover, .editmotor .btn-dark:hover {
                background: #d4af37;
                color: #1a1816;
                box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
            }

            .btn-dark {
                background: #1a1816;
                border: none;
                border-radius: 10px;
                padding: 12px 25px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s;
            }
            .btn-dark:hover {
                background: #d4af37;
                color: #1a1816;
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(212, 175, 55, 0.3);
            }

            .container-fluid {
                padding: 0;
                background: transparent;
            }

            /* Page title fixes */
            .pagetitle {
                padding-left: 40px !important;
            }

        </style>
     
    </head>

    <body>
        <!-- ======= Header ======= -->

        <div class="container-fluid tab-container col-md-12">
            <div class="pagetitle" style="padding-left: 3%; margin-bottom: 20px;">
                <h1 style="color: #1a1816; font-weight: 800; font-size: 24px; text-transform: uppercase; margin-top: 0; margin-bottom: 5px; font-family: 'Tahoma', sans-serif;">QUẢN LÝ XE MÁY</h1>
                <nav>
                    <ol class="breadcrumb" style="background: transparent; padding: 0; margin: 0; font-size: 14px;">
                        <li class="breadcrumb-item"><a href="homeStaff" target="_top" style="color: #b59349; text-decoration: none; font-weight: 600;">Trang chủ</a></li>
                        <li class="breadcrumb-item active" style="font-weight: 500; color: #6c757d;">Quản lý xe máy</li>
                    </ol>
                </nav>
            </div>
            <!-- Danh sách tab ngang -->
            <style>
                .nav-tabs { border-bottom: 1px solid #dee2e6; margin-left: 0; padding-left: 20px; }
                .nav-tabs li { margin-bottom: -1px; }
                .nav-tabs li a { border: none !important; background: transparent !important; color: #6c757d !important; font-weight: 600 !important; font-size: 14px; padding: 15px 20px !important; text-transform: uppercase; border-radius: 0 !important; }
                .nav-tabs li.active a { color: #212529 !important; border-bottom: 3px solid #d4af37 !important; background: transparent !important; box-shadow: none !important; }
                .nav-tabs li a:hover { color: #d4af37 !important; }
            </style>
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#Section1" aria-controls="home" role="tab" data-toggle="tab">THÔNG TIN XE MÁY</a></li>
                <li role="presentation"><a href="#Section2" aria-controls="profile" role="tab" data-toggle="tab">THÊM MẪU XE MỚI</a></li>
                <li role="presentation"><a href="#Section3" aria-controls="addNewMotorbike" role="tab" data-toggle="tab">THÊM XE MÁY MỚI</a></li>
            </ul>
            <!-- Nội dung tab -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="Section1" style="opacity: 1 !important; display: block;">
                    <!-- Nội dung phần tab Display All Motorbikes -->
                    <div class="container-fluid">
                        <div class="e-panel card">
                            <div class="card-body">
                                <div class="e-table">
                                    <style>
                                        .beautiful-table {
                                            width: 100%;
                                            border-collapse: collapse;
                                            background-color: #fff;
                                            border-radius: 12px;
                                            overflow: hidden;
                                            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                                        }
                                        .beautiful-table th, .beautiful-table td {
                                            border: 1px solid #e2e8f0;
                                            padding: 12px 10px;
                                            vertical-align: middle;
                                            text-align: center;
                                            color: #334155;
                                            font-size: 14px;
                                        }
                                        .beautiful-table thead th {
                                            background-color: #f8fafc;
                                            color: #475569;
                                            font-weight: 700;
                                            text-transform: uppercase;
                                            font-size: 11px;
                                            letter-spacing: 0.05em;
                                        }
                                        .beautiful-table tbody tr:hover {
                                            background-color: #f1f5f9;
                                        }
                                        .btn-outline-custom-blue, .btn-outline-custom-gold, .btn-outline-custom-red {
                                            display: inline-flex;
                                            align-items: center;
                                            justify-content: center;
                                            gap: 6px;
                                            white-space: nowrap;
                                            border-radius: 8px;
                                            padding: 8px 14px;
                                            font-weight: 600;
                                            font-size: 13px;
                                            transition: all 0.2s ease-in-out;
                                            border: none;
                                        }
                                        .btn-outline-custom-blue {
                                            color: #0ea5e9;
                                            background: #e0f2fe;
                                        }
                                        .btn-outline-custom-blue:hover {
                                            background: #0ea5e9;
                                            color: white;
                                            transform: translateY(-2px);
                                            box-shadow: 0 4px 6px rgba(14, 165, 233, 0.2);
                                        }
                                        .btn-outline-custom-gold {
                                            color: #d97706;
                                            background: #fef3c7;
                                        }
                                        .btn-outline-custom-gold:hover {
                                            background: #d97706;
                                            color: white;
                                            transform: translateY(-2px);
                                            box-shadow: 0 4px 6px rgba(217, 119, 6, 0.2);
                                        }
                                        .btn-outline-custom-red {
                                            color: #dc2626;
                                            background: #fee2e2;
                                        }
                                        .btn-outline-custom-red:hover {
                                            background: #dc2626;
                                            color: white;
                                            transform: translateY(-2px);
                                            box-shadow: 0 4px 6px rgba(220, 38, 38, 0.2);
                                        }
                                        .img-box {
                                            border: 1px solid #e2e8f0;
                                            border-radius: 8px;
                                            padding: 4px;
                                            display: inline-block;
                                            background: #fff;
                                        }
                                        .img-box img {
                                            max-height: 50px;
                                            object-fit: contain;
                                        }
                                        .desc-text-truncate {
                                            max-width: 140px;
                                            white-space: nowrap;
                                            overflow: hidden;
                                            text-overflow: ellipsis;
                                            color: #64748b;
                                            font-size: 13px;
                                            margin: 0 auto;
                                        }
                                        .model-text {
                                            font-weight: 700;
                                            color: #0f172a;
                                            max-width: 100px;
                                            word-wrap: break-word;
                                            margin: 0 auto;
                                        }
                                        /* Styling DataTables to match screenshot */
                                        .dataTables_wrapper .dataTables_length label {
                                            font-weight: 600;
                                            color: #1e293b;
                                        }
                                        .dataTables_wrapper .dataTables_filter label {
                                            font-weight: 600;
                                            color: #1e293b;
                                        }
                                        .dataTables_wrapper .dataTables_filter input {
                                            border: 1px solid #cbd5e1;
                                            border-radius: 20px;
                                            padding: 6px 15px;
                                            outline: none;
                                        }
                                    </style>
                                    <div class="table-responsive mt-3" style="padding: 10px;">
                                        <table class="beautiful-table" id="motorTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>HÌNH ẢNH</th>
                                            <th>MẪU</th>
                                            <th>PHÂN KHỐI</th>
                                            <th>THÔNG TIN MÔ TẢ</th>
                                            <th>TUỔI</th>
                                            <th>HÃNG</th>
                                            <th>LOẠI XE</th>
                                            <th>GIÁ</th>
                                            <th>KHO XE</th>
                                            <th>CHI TIẾT</th>
                                            <th>HÀNH ĐỘNG</th>
                                        </tr>
                                    </thead>
                                    <tbody id="table-body">
                                    <c:forEach items="${listM}" var="m">
                                            <tr>
                                                <td style="font-weight: 700; color: #1e293b;">${m.motorcycleId}</td>
                                                <td>
                                                    <div class="img-box">
                                                        <img src="${empty m.image ? 'images/default.jpg' : (m.image.startsWith('http') ? m.image : 'images/'.concat(m.image))}" alt="motor">
                                                    </div>
                                                </td>
                                                <td><div class="model-text">${m.model}</div></td>
                                                <td>${m.displacement}</td>
                                                <td><div class="desc-text-truncate" title="${m.description}">${m.description}</div></td>
                                                <td>${m.minAge}+</td>
                                                <td>
                                                    <c:forEach items="${listB}" var="b">
                                                        <c:if test="${m.brandID == b.brandID}">${b.brandName}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:forEach items="${listC}" var="c">
                                                        <c:if test="${m.categoryID == c.categoryID}">${c.categoryName}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:forEach items="${listP}" var="p">
                                                        <c:if test="${m.priceListID == p.priceListId}">${p.dailyPriceForDay}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:set var="mID" value="${m.motorcycleId}" />
                                                    <c:set var="availString" value="${mapA[mID]}" />
                                                    <div style="margin: 0 auto; min-width: 80px;">
                                                        <c:choose>
                                                            <c:when test="${not empty availString && availString != '0'}">
                                                                <div style="font-weight: 600; font-size: 13px; color: #16a34a;" title="Sẵn sàng: ${availString} xe">
                                                                    <i class="fas fa-check-circle"></i> Sẵn sàng: ${availString} xe
                                                                </div>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <div style="font-weight: 600; font-size: 13px; color: #dc2626;" title="Hết xe">
                                                                    <i class="fas fa-times-circle"></i> Hết xe
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn-outline-custom-blue" id="launchModalBtn" data-toggle="modal" data-target="#user-form-modal" onclick="OneClick(this)" data-motorcycleId="${m.motorcycleId}" data-motorcycleName="${m.model}" data-license="<c:forEach items="${m.listMotorcycleDetails}" var="listmd">${listmd.licensePlate}|${listmd.statusAction}|${listmd.note},</c:forEach>">
                                                        <i class="fas fa-eye"></i> Chi Tiết
                                                    </button>
                                                </td>
                                                <td>
                                                    <div style="display: flex; gap: 6px; justify-content: center;">
                                                        <button type="button" class="btn-outline-custom-gold" title="Sửa"
                                                                data-id="${m.motorcycleId}"
                                                                data-model="${m.model}"
                                                                data-image="${m.image}"
                                                                data-displacement="${m.displacement}"
                                                                data-desc="${fn:escapeXml(m.description)}"
                                                                data-age="${m.minAge}"
                                                                data-bid="${m.brandID}"
                                                                data-cid="${m.categoryID}"
                                                                data-pid="${m.priceListID}"
                                                                onclick="openEditModal(this)">
                                                            <i class="fas fa-edit"></i> Sửa
                                                        </button>
                                                        <button type="button" class="btn-outline-custom-red" title="Xóa" onclick="confirmDelete('${m.motorcycleId}')">
                                                            <i class="fas fa-trash"></i> Xóa
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
                <div role="tabpanel" class="tab-pane" id="Section2" style="opacity: 1 !important;">
                    <!-- Nội dung phần tab Add New Motorbike -->
                    <section>
                        <div class="container-fluid">
                            <div class="row ">
                                <div class="col-lg-10 col-md-8 ml-auto">
                                    <div class="row align-items-center pt-md-5 mt-md-5 mb-5">
                                        <div class="col-md-12">
                                            <div class="addnew">
                                                <form class="addnew-motorbike-form" method="post" action="addMotorbike" enctype="multipart/form-data">
                                                    <h3>THÊM MẪU XE MỚI</h3>
                                                    <div class="row">
                                                        <!-- Left Side: Fields -->
                                                        <div class="col-md-8">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="form-group mb-3">
                                                                        <label>Tên mẫu xe (Nhập để kiểm tra xe đã tồn tại chưa)</label>
                                                                        <input type="text" class="form-control" list="modelList" placeholder="Ví dụ: Honda Vision 2023" name="model" required style="border-radius: 8px;">
                                                                        <datalist id="modelList">
                                                                            <c:forEach items="${listM}" var="m">
                                                                                <option value="${m.model}">
                                                                            </c:forEach>
                                                                        </datalist>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group mb-3">
                                                                        <label>Phân khối động cơ</label>
                                                                        <input type="text" class="form-control" list="dispList" placeholder="Ví dụ: 150cc, 50 kW..." name="displacement" id="add-displacement" required style="border-radius: 8px;">
                                                                        <datalist id="dispList">
                                                                <!-- Xe máy xăng phổ biến -->
                                                                <option value="50cc">
                                                                <option value="110cc">
                                                                <option value="125cc">
                                                                <option value="135cc">
                                                                <option value="150cc">
                                                                <option value="155cc">
                                                                <option value="160cc">
                                                                <option value="175cc">
                                                                <option value="250cc">
                                                                <option value="300cc">
                                                                <!-- Xe máy điện phổ biến -->
                                                                <option value="500W">
                                                                <option value="800W">
                                                                <option value="1000W">
                                                                <option value="1200W">
                                                                <option value="1500W">
                                                                <option value="2000W">
                                                                <option value="3000W">
                                                                <option value="4000W">
                                                                <option value="50 kW">
                                                                <option value="62 kW">
                                                                <!-- Gợi ý từ Database (nếu có các loại khác) -->
                                                                <c:forEach items="${listDisplacement}" var="o">
                                                                    <option value="${o}">
                                                                </c:forEach>
                                                        </datalist>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group mb-3">
                                                                        <label>Hãng xe</label>
                                                                        <input type="text" class="form-control" list="brandList" placeholder="Ví dụ: Honda, Yamaha, Kawasaki..." name="brandName" required style="border-radius: 8px;">
                                                                        <datalist id="brandList">
                                                                            <c:forEach items="${listB}" var="b">
                                                                                <option value="${b.brandName}">
                                                                            </c:forEach>
                                                                        </datalist>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group mb-3">
                                                                        <label>Loại xe</label>
                                                                        <select class="form-control custom-select" id="cid" name="categoryID">
                                                                            <c:forEach items="${listC}" var="c">
                                                                                <option value="${c.categoryID}">${c.categoryName}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group mb-3">
                                                                        <label>Tuổi tối thiểu</label>
                                                                        <input type="number" class="form-control" placeholder="Ví dụ: 18" name="minAge" required style="border-radius: 8px;">
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12">
                                                                    <div class="form-group mb-3">
                                                                        <label>Bảng giá thuê</label>
                                                                        <select class="form-control custom-select" id="pid" name="priceListID">
                                                                            <c:forEach items="${listP}" var="p">
                                                                                <option value="${p.priceListId}"><fmt:formatNumber value="${p.dailyPriceForDay}" type="number" pattern="#,###"/> đ/ngày - <fmt:formatNumber value="${p.dailyPriceForWeek}" type="number" pattern="#,###"/> đ/tuần - <fmt:formatNumber value="${p.dailyPriceForMonth}" type="number" pattern="#,###"/> đ/tháng</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <!-- Right Side: Image -->
                                                        <div class="col-md-4" style="border-left: 1px solid #e2e8f0;">
                                                            <div class="form-group mb-3" style="text-align: center;">
                                                                <label style="display: block; text-align: left;">Ảnh mẫu xe</label>
                                                                <div id="motorbikeImagePreview" style="margin-bottom: 10px; min-height: 120px; background: #f8fafc; border: 1px dashed #cbd5e1; border-radius: 8px; width: 100%;"></div>
                                                                <input type="file" class="form-control" id="motorbikeImage" name="image" accept="image/*" style="border-radius: 8px; padding: 4px;" onchange="previewAddImage(event)">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- Full Width: Description -->
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group mb-4">
                                                                <label>Thông tin mô tả</label>
                                                                <textarea class="form-control" rows="5" placeholder="Mô tả các ưu điểm, tính năng của xe..." name="description" required style="resize: vertical; border-radius: 8px; padding: 12px;"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <button type="submit" class="btn btn-dark" style="background-color: #1a1816; border-color: #d4af37; color: #d4af37; font-weight: bold; width: 100%; padding: 12px; border-radius: 8px;">THÊM MẪU XE</button>
                                                    <div class="feedback mt-3">
                                                        <div id="success-message" class="alert alert-success" style="display: none;">Motorbike added successfully!</div>
                                                        <div id="error-message" class="alert alert-danger" style="display: none;">File Format Not Supported</div>
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
                <!-- Nội dung của Section 3 -->
                <div role="tabpanel" class="tab-pane fade" id="Section3">
                    <!-- Nội dung phần tab Add New Motorbike -->
                    <section>
                        <div class="container-fluid">
                            <div class="row ">
                                <div class="col-lg-10 col-md-8 ml-auto">
                                    <div class="row align-items-center pt-md-5 mt-md-5 mb-5">
                                        <div class="col-md-12">
                                            <div class="addnew">
                                                <!-- <form class="addnew-motorbike-form" method="post" action="addMotorDetail">-->
                                                <h3>THÊM XE MÁY MỚI</h3>
                                                <div class="form-group mb-4">
                                                    <label>Mẫu xe</label>
                                                    <select class="form-control custom-select" id="model" name="model">
                                                        <c:forEach items="${listM}" var="m" varStatus="loop">
                                                            <option value="${m.motorcycleId}">${m.model}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group mb-4">
                                                    <label>Biển số xe</label>
                                                    <input type="text" class="form-control" placeholder="Ví dụ: 29A1-12345" name="licensePlate" id="licensePlate">
                                                </div>
                                                <div style="color: red;" id="msg"></div> <br>
                                                <button type="submit" class="btn btn-dark" onclick="addMotorbikeDetail()">Thêm xe máy</button>
                                                <div class="feedback mt-3">
                                                    <div id="success-message" class="alert alert-success" style="display: none;">
                                                        Motorbike added successfully!
                                                    </div>
                                                    <div id="error-message" class="alert alert-danger" style="display: none;">
                                                        File Format Not Supported
                                                    </div>

                                                </div>
                                                <!--                                                </form>-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Nội dung của Section 4 -->
                
                
                <!-- Modal Cập Nhật Xe Máy -->
                <div class="modal fade" id="updateMotorbikeModal" tabindex="-1" role="dialog" aria-labelledby="updateMotorbikeModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" style="border-radius: 12px; overflow: hidden; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                            <div class="modal-header" style="background: #f8fafc; border-bottom: 1px solid #e2e8f0; padding: 20px 30px; position: relative;">
                                <h4 class="modal-title" id="updateMotorbikeModalLabel" style="font-weight: 700; color: #1e293b; text-transform: uppercase; font-size: 18px;">
                                    <i class="fas fa-edit" style="color: #3b82f6; margin-right: 8px;"></i> Cập Nhật Xe Máy
                                </h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: #64748b; opacity: 0.8; font-size: 28px; position: absolute; right: 25px; top: 15px;"><span aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body" style="padding: 30px; background: #fff;">
                                <form action="updateMotorcycle" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" id="modal-update-id" name="id">

                                    <div class="row">
                                        <!-- Left Side: Fields -->
                                        <div class="col-md-8">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group mb-3">
                                                        <label for="modal-update-model" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase;">Mẫu xe:</label>
                                                        <input type="text" class="form-control" id="modal-update-model" name="model" required style="border-radius: 8px;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group mb-3">
                                                        <label for="modal-update-displacement" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase;">Phân khối:</label>
                                                        <input type="text" class="form-control" list="dispList2" placeholder="Ví dụ: 150cc, 50 kW..." name="displacement" id="modal-update-displacement" required style="border-radius: 8px;" onfocus="this.dataset.oldValue = this.value; this.value='';" onblur="if(this.value=='') this.value = this.dataset.oldValue;">
                                                        <datalist id="dispList2">
                                                                <!-- Xe máy xăng phổ biến -->
                                                                <option value="50cc">
                                                                <option value="110cc">
                                                                <option value="125cc">
                                                                <option value="135cc">
                                                                <option value="150cc">
                                                                <option value="155cc">
                                                                <option value="160cc">
                                                                <option value="175cc">
                                                                <option value="250cc">
                                                                <option value="300cc">
                                                                <!-- Xe máy điện phổ biến -->
                                                                <option value="500W">
                                                                <option value="800W">
                                                                <option value="1000W">
                                                                <option value="1200W">
                                                                <option value="1500W">
                                                                <option value="2000W">
                                                                <option value="3000W">
                                                                <option value="4000W">
                                                                <option value="50 kW">
                                                                <option value="62 kW">
                                                                <!-- Gợi ý từ Database (nếu có các loại khác) -->
                                                                <c:forEach items="${listDisplacement}" var="o">
                                                                    <option value="${o}">
                                                                </c:forEach>
                                                        </datalist>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group mb-3">
                                                        <label for="modal-update-bid" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase;">Hãng:</label>
                                                        <select class="form-control custom-select" id="modal-update-bid" name="brandID">
                                                            <c:forEach items="${listB}" var="b">
                                                                <option value="${b.brandID}">${b.brandName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group mb-3">
                                                        <label for="modal-update-cid" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase;">Loại xe:</label>
                                                        <select class="form-control custom-select" id="modal-update-cid" name="categoryID">
                                                            <c:forEach items="${listC}" var="c">
                                                                <option value="${c.categoryID}">${c.categoryName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group mb-3">
                                                        <label for="modal-update-minAge" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase;">Tuổi tối thiểu:</label>
                                                        <input type="number" class="form-control" id="modal-update-minAge" name="minAge" required style="border-radius: 8px;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group mb-3">
                                                        <label for="modal-update-pid" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase;">Bảng giá thuê:</label>
                                                        <select class="form-control custom-select" id="modal-update-pid" name="priceListID" style="font-size: 12px; padding: 6px;">
                                                            <c:forEach items="${listP}" var="p">
                                                                <option value="${p.priceListId}"><fmt:formatNumber value="${p.dailyPriceForDay}" type="number" pattern="#,###"/> đ/ngày - <fmt:formatNumber value="${p.dailyPriceForWeek}" type="number" pattern="#,###"/> đ/tuần - <fmt:formatNumber value="${p.dailyPriceForMonth}" type="number" pattern="#,###"/> đ/tháng</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Right Side: Image -->
                                        <div class="col-md-4" style="border-left: 1px solid #e2e8f0;">
                                            <div class="form-group" style="text-align: center;">
                                                <label for="modal-update-image" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase; display: block; text-align: left;">Hình ảnh:</label>
                                                <div id="modal-update-image-preview" style="position: relative; margin-bottom: 10px; border-radius: 8px; overflow: hidden; display: inline-block; min-height: 120px; background: #f8fafc; width: 100%; border: 1px dashed #cbd5e1;"></div>
                                                <input type="file" class="form-control" id="modal-update-image" name="image" accept="image/*" style="border-radius: 8px; padding: 4px;" onchange="previewUpdateImage(event)">
                                                <input type="hidden" id="modal-update-image-removed" name="imageRemoved" value="false">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Full Width: Description -->
                                    <div class="row mt-3">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="modal-update-description" style="color: #475569; font-weight: 600; font-size: 13px; text-transform: uppercase;">Thông Tin Mô Tả:</label>
                                                <textarea class="form-control" id="modal-update-description" name="description" rows="5" required style="resize: vertical; border-radius: 8px; padding: 12px;"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="text-align: right; margin-top: 20px; padding-top: 20px; border-top: 1px solid #e2e8f0;">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-right: 12px; border-radius: 8px; padding: 10px 24px; font-weight: 600; color: #64748b; background: #fff; border: 1px solid #cbd5e1;">Hủy</button>
                                        <button type="submit" class="btn btn-primary" style="border-radius: 8px; padding: 10px 24px; font-weight: 600; color: #fff; background: #3b82f6; border: none; box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);">Lưu Cập Nhật</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- modal để hiển thị thông tin chi tiết -->
                <div class="modal fade" role="dialog" tabindex="-1" id="user-form-modal">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 25px rgba(0,0,0,0.1);">
                            <div class="modal-header bg-light" style="padding: 20px 24px; border-bottom: 1px solid #e2e8f0; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                                <h5 class="modal-title" id="modal-title" style="font-weight: 700; color: #1e293b; font-size: 18px; margin: 0;">
                                    <i class="fas fa-info-circle text-primary me-2"></i>Chi tiết xe máy
                                </h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeDetail()" style="color: #64748b; font-size: 24px;">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="padding: 30px;">
                                <div class="row">                                       
                                    <div class="col-md-12">
                                        <div style="background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%); border-radius: 16px; padding: 24px; border: 1px solid #e2e8f0; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);">
                                            <div class="row" style="margin-bottom: 20px; align-items: center;">
                                                <div class="col-sm-3" style="font-weight: 600; color: #64748b; text-transform: uppercase; font-size: 12px; letter-spacing: 0.5px;">
                                                    <i class="fas fa-fingerprint" style="margin-right: 8px; color: #94a3b8;"></i>Mã Dòng Xe
                                                </div>
                                                <div class="col-sm-9" id="modal-motorcycleID" style="font-weight: 700; color: #0f172a; font-size: 16px; background: #f1f5f9; padding: 8px 16px; border-radius: 8px; display: inline-block; width: auto; border: 1px solid #e2e8f0;"></div>
                                            </div>
                                            <div class="row" style="margin-bottom: 24px; align-items: center;">
                                                <div class="col-sm-3" style="font-weight: 600; color: #64748b; text-transform: uppercase; font-size: 12px; letter-spacing: 0.5px;">
                                                    <i class="fas fa-motorcycle" style="margin-right: 8px; color: #94a3b8;"></i>Tên Mẫu Xe
                                                </div>
                                                <div class="col-sm-9" id="modal-motorcycleName" style="font-weight: 800; color: #2563eb; font-size: 18px;"></div>
                                            </div>
                                            <div style="height: 1px; background: #e2e8f0; margin: 20px 0;"></div>
                                            <div class="row">
                                                <div class="col-sm-12" style="font-weight: 600; color: #64748b; text-transform: uppercase; font-size: 12px; letter-spacing: 0.5px; margin-bottom: 16px;">
                                                    <i class="fas fa-list-ol" style="margin-right: 8px; color: #94a3b8;"></i>Danh Sách Biển Số Hiện Có (<span id="modal-license-count" style="color: #2563eb; font-weight: bold;">0</span> chiếc)
                                                </div>
                                                <div class="col-sm-12" id="modal-license" style="display: flex; flex-wrap: wrap; gap: 10px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        <!-- Tải thư viện JS theo đúng thứ tự (jQuery -> Bootstrap -> DataTables -> Plugin khác) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="//cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/showMoreItems.min.js"></script>
        <script src="js/main.js"></script>

        <script>
            $(document).ready(function() {
                // Ép buộc các tab hoạt động (khắc phục lỗi xung đột Bootstrap 3 vs 4)
                $('.nav-tabs a').on('click', function (e) {
                    e.preventDefault();
                    $(this).tab('show');
                    // Buộc hiển thị thẻ div tương ứng để chống lỗi tàng hình
                    $('.tab-pane').hide();
                    $($(this).attr('href')).show();
                });

                // Khởi tạo DataTables
                $('#motorTable').DataTable({
                    "pageLength": 10,
                    "lengthMenu": [[5, 10, 20, -1], [5, 10, 20, "Tất cả"]],
                    "language": {
                        "lengthMenu": "Hiển thị _MENU_ xe mỗi trang",
                        "zeroRecords": "Không tìm thấy xe nào",
                        "info": "Trang _PAGE_ / _PAGES_",
                        "infoEmpty": "Không có dữ liệu",
                        "infoFiltered": "(lọc từ _MAX_ xe)",
                        "search": "Tìm kiếm:",
                        "paginate": {
                            "first": "Đầu",
                            "last": "Cuối",
                            "next": "Sau",
                            "previous": "Trước"
                        }
                    },
                    "initComplete": function(settings, json) {
                        $('.dataTables_length select').addClass('form-control d-inline-block').css({'width': '80px', 'margin': '0 10px', 'border-radius': '6px', 'border': '1px solid #ced4da'});
                        $('.dataTables_wrapper').css('padding', '20px');
                    }
                });
            });
        </script>
    






<script>
    function openEditModal(btn) {
        var id = btn.getAttribute('data-id');
        var model = btn.getAttribute('data-model');
        var image = btn.getAttribute('data-image');
        var displacement = btn.getAttribute('data-displacement');
        var description = btn.getAttribute('data-desc');
        var minAge = btn.getAttribute('data-age');
        var bid = btn.getAttribute('data-bid');
        var cid = btn.getAttribute('data-cid');
        var pid = btn.getAttribute('data-pid');

        document.getElementById('modal-update-id').value = id;
        document.getElementById('modal-update-model').value = model;
        document.getElementById('modal-update-displacement').value = displacement;
        document.getElementById('modal-update-description').value = description;
        document.getElementById('modal-update-minAge').value = minAge;
        document.getElementById('modal-update-bid').value = bid;
        document.getElementById('modal-update-cid').value = cid;
        document.getElementById('modal-update-pid').value = pid;
        document.getElementById('modal-update-image-removed').value = "false";
        document.getElementById('modal-update-image').value = ""; // clear file input

        var imgContainer = document.getElementById('modal-update-image-preview');
        imgContainer.innerHTML = '';
        if (image && image !== 'null' && image !== '') {
            var imgSrc = image.startsWith('http') ? image : 'images/' + image;
            imgContainer.innerHTML = '<div style="position: relative; display: inline-block;">' +
                '<img src="' + imgSrc + '" class="img-fluid img-thumbnail" style="max-height: 150px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); cursor: pointer;" alt="Preview" onclick="if(window.parent && window.parent.openLightbox) window.parent.openLightbox(this.src)">' +
                '<button type="button" onclick="removeUpdateImage()" style="position: absolute; top: 5px; right: 5px; background: #ef4444; color: white; border: none; border-radius: 50%; width: 28px; height: 28px; display: flex; align-items: center; justify-content: center; cursor: pointer; box-shadow: 0 2px 4px rgba(0,0,0,0.2); font-size: 18px; line-height: 1;">&times;</button>' +
                '</div>';
        } else {
            imgContainer.innerHTML = '<span class="text-muted">No image available</span>';
        }

        $('#updateMotorbikeModal').modal('show');
    }

    function removeUpdateImage() {
        var imgContainer = document.getElementById('modal-update-image-preview');
        imgContainer.innerHTML = '<span class="text-muted">Hình ảnh đã bị xóa. Vui lòng chọn ảnh mới.</span>';
        document.getElementById('modal-update-image-removed').value = "true";
        document.getElementById('modal-update-image').value = "";
    }

    function previewUpdateImage(event) {
        var reader = new FileReader();
        reader.onload = function(){
            var imgContainer = document.getElementById('modal-update-image-preview');
            imgContainer.innerHTML = '<div style="position: relative; display: inline-block;">' +
                '<img src="' + reader.result + '" class="img-fluid img-thumbnail" style="max-height: 150px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);" alt="Preview">' +
                '<button type="button" onclick="removeUpdateImage()" style="position: absolute; top: 5px; right: 5px; background: #ef4444; color: white; border: none; border-radius: 50%; width: 28px; height: 28px; display: flex; align-items: center; justify-content: center; cursor: pointer; box-shadow: 0 2px 4px rgba(0,0,0,0.2); font-size: 18px; line-height: 1;">&times;</button>' +
                '</div>';
            document.getElementById('modal-update-image-removed').value = "false";
        };
        if(event.target.files[0]){
            reader.readAsDataURL(event.target.files[0]);
        }
    }
</script>


<script>
    function OneClick(btn) {
        var id = btn.getAttribute('data-motorcycleId');
        var name = btn.getAttribute('data-motorcycleName');
        var license = btn.getAttribute('data-license');

        document.getElementById("modal-motorcycleID").innerHTML = id;
        document.getElementById("modal-motorcycleName").innerHTML = name;

        var str = license.split(",");
        var text = "";
        var count = 0;
        for (var i = 0; i < str.length; i++) {
            if (str[i].trim() !== "") {
                var parts = str[i].trim().split("|");
                var plate = parts[0] || "";
                var st = parts[1] || "Sẵn sàng";
                var note = parts[2] || "";
                
                if (st === 'null' || st === '') st = "Sẵn sàng";
                if (note === 'null') note = "";
                
                var stColor = (st === "Sẵn sàng" || st === "Có sẵn") ? "#16a34a" : "#dc2626";
                var noteHtml = note ? " <span style='font-size: 11px; color: #64748b; font-weight: normal;'>(" + note + ")</span>" : "";
                
                text += "<div style='display: flex; flex-direction: column; align-items: flex-start; background-color: #f8fafc; border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; margin-bottom: 6px; font-weight: 600; color: #334155; box-shadow: 0 1px 2px rgba(0,0,0,0.05);'>"
                     + "  <div style='display: inline-flex; align-items: center;'><i class='fas fa-motorcycle' style='color: #64748b; margin-right: 8px;'></i>" + plate + "</div>"
                     + "  <div style='font-size: 12px; color: " + stColor + "; margin-top: 4px; display: inline-flex; align-items: center;'><i class='fas fa-info-circle' style='margin-right: 4px;'></i>" + st + noteHtml + "</div>"
                     + "</div>";
                count++;
            }
        }
        document.getElementById("modal-license").innerHTML = text;
        document.getElementById("modal-license-count").innerHTML = count;
    }
</script>

<script>
    function deduplicateDatalist(datalistId) {
        var datalist = document.getElementById(datalistId);
        if (!datalist) return;
        var options = datalist.getElementsByTagName('option');
        var seen = {};
        for (var i = options.length - 1; i >= 0; i--) {
            var val = options[i].value.trim();
            if (seen[val]) {
                datalist.removeChild(options[i]);
            } else {
                seen[val] = true;
            }
        }
    }
    
    function previewAddImage(event) {
        var reader = new FileReader();
        reader.onload = function(){
            var imgContainer = document.getElementById('motorbikeImagePreview');
            imgContainer.innerHTML = '<div style="position: relative; display: inline-block;">' +
                '<img src="' + reader.result + '" class="img-fluid img-thumbnail" style="max-height: 120px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); cursor: pointer;" alt="Preview" onclick="if(window.parent && window.parent.openLightbox) window.parent.openLightbox(this.src)">' +
                '<button type="button" onclick="removeAddImage()" style="position: absolute; top: 5px; right: 5px; background: #ef4444; color: white; border: none; border-radius: 50%; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; cursor: pointer; box-shadow: 0 2px 4px rgba(0,0,0,0.2); font-size: 16px; line-height: 1;">&times;</button>' +
                '</div>';
        };
        if(event.target.files[0]){
            reader.readAsDataURL(event.target.files[0]);
        }
    }

    function addMotorbikeDetail() {
        var motorcycleId = document.getElementById('model').value;
        var licensePlate = document.getElementById('licensePlate').value;

        if (!motorcycleId || !licensePlate) {
            document.getElementById('msg').innerText = "Vui lòng nhập đầy đủ thông tin!";
            return;
        }

        var data = {
            motorcycleId: motorcycleId,
            licensePlate: licensePlate
        };

        fetch('addMotorDetail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (response.ok) {
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công',
                    text: 'Thêm xe máy mới thành công!',
                    confirmButtonColor: '#1089FF'
                }).then(() => {
                    location.reload();
                });
            } else {
                return response.text().then(text => {
                    document.getElementById('msg').innerText = text || "Đã xảy ra lỗi!";
                });
            }
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('msg').innerText = "Đã xảy ra lỗi hệ thống!";
        });
    }

    function removeAddImage() {
        document.getElementById('motorbikeImagePreview').innerHTML = '';
        document.getElementById('motorbikeImage').value = '';
    }

    function confirmDelete(id) {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa?',
            text: "Dữ liệu xe máy này sẽ bị xóa vĩnh viễn khỏi hệ thống!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#1089FF',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Vâng, xóa nó!',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'deleteMotor?id=' + id;
            }
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        deduplicateDatalist('dispList');
        deduplicateDatalist('dispList2');
        deduplicateDatalist('modelList');
        deduplicateDatalist('brandList');
    });
</script>
</body>
</html>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Dashboard - Quản lý</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta content="" name="description">
        <meta content="" name="keywords">

        <!-- Favicons -->
        <!--        <link href="staffAssets/img/favicon.png" rel="icon">
                <link href="staffAssets/img/apple-touch-icon.png" rel="apple-touch-icon">-->
        <link rel="website icon" type="png" href="images/logo.png">

        <!-- Google Fonts -->
        <style>
        @import url('https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');
        
        /* Gold Accent Segmented Control for Period Filtering */
        .global-filter-group {
            background: rgba(192, 157, 98, 0.06);
            border: 1px solid rgba(192, 157, 98, 0.15);
            padding: 4px;
            border-radius: 30px;
            display: inline-flex;
            align-items: center;
            gap: 2px;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.02);
        }
        .global-filter-btn {
            background: transparent !important;
            border: none !important;
            color: #6b7280 !important;
            font-weight: 600 !important;
            font-size: 13px !important;
            padding: 8px 18px !important;
            border-radius: 30px !important;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important;
            outline: none !important;
            box-shadow: none !important;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .global-filter-btn:hover {
            color: #C09D62 !important;
            background: rgba(192, 157, 98, 0.08) !important;
        }
        .global-filter-btn.active {
            background: #C09D62 !important;
            color: #ffffff !important;
            box-shadow: 0 4px 12px rgba(192, 157, 98, 0.25) !important;
        }

        /* Modal Custom Styling */
        #customDateModal .modal-content {
            border-radius: 12px;
            border: 1px solid rgba(192, 157, 98, 0.2);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        #customDateModal .modal-header {
            border-bottom: 1px solid rgba(192, 157, 98, 0.1);
            background: rgba(192, 157, 98, 0.03);
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        #customDateModal .modal-title {
            font-family: 'Be Vietnam Pro', sans-serif;
            font-weight: 700;
            color: #1F2937;
        }
        #customDateModal .modal-footer {
            border-top: 1px solid rgba(192, 157, 98, 0.1);
        }
        #customDateModal .form-control:focus {
            border-color: #C09D62;
            box-shadow: 0 0 0 0.2rem rgba(192, 157, 98, 0.15);
        }
        #customDateModal .btn-primary {
            background-color: #C09D62 !important;
            border-color: #C09D62 !important;
            border-radius: 30px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        #customDateModal .btn-primary:hover {
            background-color: #A6854F !important;
            border-color: #A6854F !important;
            box-shadow: 0 4px 10px rgba(192, 157, 98, 0.2);
        }
        #customDateModal .btn-secondary {
            border-radius: 30px;
            padding: 8px 20px;
        }
        </style>

        <!-- Vendor CSS Files -->
        <link href="staffAssets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="staffAssets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="staffAssets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="staffAssets/vendor/quill/quill.snow.css" rel="stylesheet">
        <link href="staffAssets/vendor/quill/quill.bubble.css" rel="stylesheet">
        <link href="staffAssets/vendor/remixicon/remixicon.css" rel="stylesheet">
        <link href="staffAssets/vendor/simple-datatables/style.css" rel="stylesheet">
        <!-- Leaflet CSS for GPS Map -->
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
        
        <!-- Template Main CSS File -->
        <link href="staffAssets/css/style.css" rel="stylesheet">
    </head>
    <body>

        <jsp:include page="/includes/staff/header-staff.jsp" />
        <!--       sidebar-->
        <jsp:include page="/includes/staff/sidebar.jsp" />

        <main id="main" class="main">

            <div class="pagetitle d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h1>Thống Kê</h1>
                    <nav>
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="homeStaff.jsp">Trang Chủ</a></li>
                            <li class="breadcrumb-item active">Thống Kê</li>
                        </ol>
                    </nav>
                </div>
                <div class="col-md-8 text-end">
                    <ul class="nav custom-tabs justify-content-end" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link global-filter-btn" id="pills-today-tab" data-period="today" type="button" role="tab">Hôm nay</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link global-filter-btn active" id="pills-30d-tab" data-period="30days" type="button" role="tab">30 Ngày</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link global-filter-btn" id="pills-90d-tab" data-period="90days" type="button" role="tab">90 Ngày</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link global-filter-btn" id="pills-180d-tab" data-period="180days" type="button" role="tab">180 Ngày</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link global-filter-btn" id="pills-all-tab" data-period="all" type="button" role="tab">Tất cả</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link global-filter-btn" data-period="custom" type="button" data-bs-toggle="modal" data-bs-target="#customDateModal">
                                <i class="bi bi-calendar3 me-1"></i> Tùy chọn...
                            </button>
                        <li class="nav-item ms-3" role="presentation">
                            <button class="nav-link global-filter-btn" style="background: #dc3545 !important; color: white !important; font-weight: bold;" onclick="document.getElementById('gps-section').scrollIntoView({behavior: 'smooth'})" type="button">
                                <i class="bi bi-geo-alt-fill me-1"></i> Định Vị Xe
                            </button>
                        </li>
                    </ul>
                </div>
            </div><!-- End Page Title -->



            <style>
                body, main#main {
                    background-color: #f4f6f9;
                }
                .dashboard .card {
                    border: none;
                    border-radius: 20px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
                    transition: transform 0.25s ease, box-shadow 0.25s ease;
                    background: #ffffff;
                    margin-bottom: 25px;
                }
                .dashboard .card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.06);
                }
                .dashboard .card-title {
                    font-weight: 700;
                    color: #1a1816;
                    font-family: 'Be Vietnam Pro', sans-serif;
                    padding: 20px 0 15px 0;
                    font-size: 1.05rem;
                }
                .dashboard .info-card {
                    padding-bottom: 5px;
                }
                .dashboard .info-card h6 {
                    font-size: 26px;
                    color: #112a46;
                    font-weight: 800;
                    margin: 0;
                    padding: 0;
                    font-family: 'Be Vietnam Pro', sans-serif;
                    letter-spacing: -0.5px;
                }
                .dashboard .card-icon {
                    font-size: 28px;
                    line-height: 0;
                    width: 56px;
                    height: 56px;
                    flex-shrink: 0;
                    flex-grow: 0;
                    border-radius: 16px !important;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .sales-card .card-icon {
                    color: #4154f1;
                    background: #f0f3ff;
                }
                .revenue-card .card-icon {
                    color: #2eca6a;
                    background: #e6f9ed;
                }
                .customers-card .card-icon {
                    color: #ff771d;
                    background: #fff0e6;
                }
                /* Premium Filter Tabs */
                .custom-tabs {
                    background: #eef2f6;
                    border-radius: 50px;
                    padding: 6px;
                    display: inline-flex;
                }
                .custom-tabs .nav-item {
                    margin: 0;
                }
                .custom-tabs .nav-link {
                    border-radius: 50px;
                    color: #6c757d;
                    font-weight: 600;
                    font-size: 0.9rem;
                    padding: 8px 24px;
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    border: none;
                    background: transparent;
                }
                .custom-tabs .nav-link.active {
                    background: #c09d62;
                    color: #fff !important;
                    box-shadow: 0 4px 15px rgba(192, 157, 98, 0.35);
                }
                .custom-tabs .nav-link:hover:not(.active) {
                    background: rgba(192, 157, 98, 0.1);
                    color: #c09d62;
                }
                #top-motorcycles-body td {
                    vertical-align: middle;
                }
            </style>

            <section class="section dashboard">
                <div class="row">
                    <!-- KPI Cards Row -->
                    <div class="col-md-4 mb-4">
                        <div class="card info-card revenue-card h-100 mb-0" style="border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.03);">
                            <div class="card-body">
                                <h5 class="card-title" style="font-size: 0.85rem; color: #8c98a4; padding: 15px 0 10px 0; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">Tổng Doanh Thu</h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; background: #e6f9ed; color: #2eca6a;">
                                        <i class="bi bi-currency-dollar" style="font-size: 20px;"></i>
                                    </div>
                                    <div class="ps-3" id="revenue-container" style="transition: opacity 0.2s;">
                                        <h6 id="stat-revenue" style="font-size: 22px; margin-bottom: 0; font-weight: 800; color: #1f2937;">...</h6>
                                        <div id="trend-revenue" class="mt-1" style="font-size: 13px;">
                                            <span class="spinner-border spinner-border-sm text-success" role="status"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-4">
                        <div class="card info-card sales-card h-100 mb-0" style="border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.03);">
                            <div class="card-body">
                                <h5 class="card-title" style="font-size: 0.85rem; color: #8c98a4; padding: 15px 0 10px 0; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">Tổng Đơn Hàng</h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; background: #f0f3ff; color: #4154f1;">
                                        <i class="bi bi-cart" style="font-size: 20px;"></i>
                                    </div>
                                    <div class="ps-3" id="orders-container" style="transition: opacity 0.2s;">
                                        <h6 id="stat-orders" style="font-size: 22px; margin-bottom: 0; font-weight: 800; color: #1f2937;">...</h6>
                                        <div id="trend-orders" class="mt-1" style="font-size: 13px;">
                                            <span class="spinner-border spinner-border-sm text-primary" role="status"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 mb-4">
                        <div class="card info-card customers-card h-100 mb-0" style="border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.03);">
                            <div class="card-body">
                                <h5 class="card-title" style="font-size: 0.85rem; color: #8c98a4; padding: 15px 0 10px 0; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">Tổng Khách Hàng</h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; background: #fff0e6; color: #ff771d;">
                                        <i class="bi bi-people" style="font-size: 20px;"></i>
                                    </div>
                                    <div class="ps-3" id="customers-container" style="transition: opacity 0.2s;">
                                        <h6 id="stat-customers" style="font-size: 22px; margin-bottom: 0; font-weight: 800; color: #1f2937;">...</h6>
                                        <div id="trend-customers" class="mt-1" style="font-size: 13px;">
                                            <span class="spinner-border spinner-border-sm text-warning" role="status"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Line Chart -->
                    <div class="col-12 mb-4">
                        <div class="card mb-0" style="border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.03);">
                            <div class="card-body">
                                <h5 class="card-title text-dark fw-bold mb-0" style="font-family: 'Be Vietnam Pro', sans-serif;">Biểu Đồ Tổng Quan</h5>
                                <div id="reportsChart" style="min-height: 280px; width: 100%;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Right side charts (Moved next to Line Chart) -->
                    <div class="col-lg-6 mb-4">
                        <!-- Budget Report -->
                        <div class="card h-100 mb-0" style="border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.03);">
                            <div class="card-body pb-0">
                                <h5 class="card-title text-dark fw-bold" style="font-family: 'Be Vietnam Pro', sans-serif;">Doanh Thu Theo Hãng</h5>
                                <div id="budgetChart" style="min-height: 250px;" class="echart"></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-6 mb-4">
                        <!-- Website Traffic -->
                        <div class="card h-100 mb-0" style="border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.03);">
                            <div class="card-body pb-0">
                                <h5 class="card-title text-dark fw-bold" style="font-family: 'Be Vietnam Pro', sans-serif;">Thống Kê Lượng Thuê</h5>
                                <div id="trafficChart" style="min-height: 250px;" class="echart"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">                            <!-- Top Selling -->
                            <div class="col-12 mt-4">
                                <div class="card border-0 shadow-sm custom-card">
                                    <div class="card-body p-4 pb-0">
                                        <h5 class="card-title text-dark fw-bold mb-4" style="font-family: 'Be Vietnam Pro', sans-serif;">Danh Sách Xe Được Thuê</h5>

                                        <table class="table table-hover table-borderless align-middle">
                                            <thead class="table-light text-muted" style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;">
                                                <tr>
                                                    <th scope="col" class="ps-3" style="border-top-left-radius: 8px; border-bottom-left-radius: 8px;">Hình Ảnh</th>
                                                    <th scope="col">Mẫu Xe</th>
                                                    <th scope="col">Giá Theo Ngày</th>
                                                    <th scope="col">Giá Theo Tuần</th>
                                                    <th scope="col" style="border-top-right-radius: 8px; border-bottom-right-radius: 8px;">Giá Theo Tháng</th>
                                                </tr>
                                            </thead>
                                            <tbody id="top-motorcycles-body">
                                                <!-- Populated by AJAX -->
                                            </tbody>
                                        </table>

                                    </div>

                                </div>
                            </div><!-- End Top Selling -->

                </div>
                <!-- GPS Tracker Section -->
                <div class="row mt-4" id="gps-section">
                    <div class="col-12">
                        <div class="card" style="border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.03);">
                            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center" style="border-bottom: 1px solid rgba(0,0,0,0.05);">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 48px; height: 48px; background-color: rgba(220, 53, 69, 0.1); color: #dc3545;">
                                        <i class="bi bi-geo-alt-fill fs-4"></i>
                                    </div>
                                    <div>
                                        <h5 class="card-title text-dark fw-bold mb-0 p-0" style="font-family: 'Be Vietnam Pro', sans-serif;">Định vị GPS Trực Tuyến</h5>
                                        <p class="text-muted mb-0" style="font-size: 13px;">Theo dõi lộ trình xe đang cho thuê theo thời gian thực</p>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center gap-3">
                                    <span class="text-muted" style="font-size: 14px;">Hoạt động: <span id="stat-gps" class="fw-bold text-danger">0</span> xe</span>
                                    <button id="btn-test-gps" class="btn btn-danger rounded-pill px-4 py-2 fw-semibold d-flex align-items-center shadow-sm" onclick="startGpsSimulation()" style="font-size: 14px; transition: all 0.3s;">
                                        <i class="bi bi-play-fill fs-5 me-1" style="margin-left: -4px;"></i> Khởi chạy Test
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0 position-relative">
                                <div class="row g-0">
                                    <div id="map-col" class="col-lg-8 position-relative" style="transition: all 0.4s ease;">
                                        <button id="toggle-list-btn" class="btn btn-light shadow-sm" style="position: absolute; right: 15px; top: 15px; z-index: 1000;" onclick="toggleVehicleList()" title="Ẩn/Hiện danh sách">
                                            <i class="bi bi-arrows-fullscreen"></i>
                                        </button>
                                        <div class="position-absolute top-0 start-0 w-100 h-100" style="box-shadow: inset 0 6px 12px -6px rgba(0,0,0,0.15); pointer-events: none; z-index: 2;"></div>
                                        <div id="map" style="height: 550px; width: 100%; z-index: 1;"></div>
                                    </div>
                                    <div id="list-col" class="col-lg-4 border-start" style="transition: all 0.4s ease; overflow: hidden;">
                                        <div class="p-3 bg-light border-bottom fw-bold text-dark d-flex justify-content-between align-items-center" style="white-space: nowrap;">
                                            <span><i class="bi bi-list-ul me-2"></i>Danh sách phương tiện</span>
                                        </div>
                                        <div id="gps-vehicle-list" style="height: 501px; overflow-y: auto; background: #fff;">
                                            <div class="p-4 text-center text-muted"><i class="bi bi-inbox fs-2"></i><br>Không có xe nào</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </section>

        </main><!-- End #main -->



        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                class="bi bi-arrow-up-short"></i></a>

        <!-- Vendor JS Files -->
        <script src="staffAssets/vendor/apexcharts/apexcharts.min.js"></script>
        <script src="staffAssets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="staffAssets/vendor/chart.js/chart.umd.js"></script>
        <script src="staffAssets/vendor/echarts/echarts.min.js"></script>
        <script src="staffAssets/vendor/quill/quill.js"></script>
        <script src="staffAssets/vendor/simple-datatables/simple-datatables.js"></script>
        <script src="staffAssets/vendor/tinymce/tinymce.min.js"></script>
        <script src="staffAssets/vendor/php-email-form/validate.js"></script>

        <!-- Template Main JS File -->
        <script src="staffAssets/js/main.js"></script>

        <!-- Custom Date Modal -->
        <div class="modal fade" id="customDateModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Chọn Khoảng Thời Gian</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Từ ngày</label>
                            <input type="date" class="form-control" id="startDate">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Đến ngày</label>
                            <input type="date" class="form-control" id="endDate">
                        </div>
                        <div id="customDateError" class="text-danger small mt-2" style="display: none;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" id="btnApplyCustomDate">Áp dụng</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                let currentPeriod = '30days';
                let currentStartDate = '';
                let currentEndDate = '';
                
                // Initialize charts globally with dual-axes layout
                window.reportsChart = new ApexCharts(document.querySelector("#reportsChart"), {
                    series: [],
                    chart: { 
                        height: '100%', 
                        type: 'area',
                        toolbar: { 
                            show: true,
                            tools: {
                                selection: false,
                                zoom: false,
                                zoomin: true,
                                zoomout: false, // Tắt nút zoom out để khỏi bị lố
                                pan: true,
                                reset: true
                            },
                            autoSelected: 'pan'
                        },
                        zoom: {
                            enabled: true,
                            type: 'x',
                            autoScaleYaxis: true
                        },
                        fontFamily: 'Be Vietnam Pro'
                    },
                    markers: {
                        size: 4,
                        colors: ["#fff"],
                        strokeColors: ['#4154f1', '#2eca6a', '#ff771d'],
                        strokeWidth: 2,
                        hover: { size: 7 }
                    },
                    colors: ['#4154f1', '#2eca6a', '#ff771d'],
                    fill: {
                        type: "gradient",
                        gradient: {
                            shadeIntensity: 1,
                            opacityFrom: 0.3,
                            opacityTo: 0.4,
                            stops: [0, 90, 100]
                        }
                    },
                    dataLabels: { enabled: false },
                    stroke: { curve: 'smooth', width: 2 },
                    legend: { position: 'bottom', horizontalAlign: 'center' },
                    xaxis: { 
                        type: 'datetime', 
                        categories: [],
                        tickAmount: 6,
                        labels: { 
                            style: { colors: '#6b7280' },
                            datetimeUTC: false
                        }
                    },
                    yaxis: [
                        {
                            seriesName: 'Đơn Hàng',
                            labels: { style: { colors: '#4154f1' }, formatter: function(val) { return Math.round(val); } },
                            min: 0, forceNiceScale: true, tickAmount: 5
                        },
                        {
                            seriesName: 'Doanh Thu',
                            opposite: true,
                            labels: {
                                style: { colors: '#2eca6a' },
                                formatter: function(val) {
                                    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val).replace('₫', 'VNĐ');
                                }
                            },
                            min: 0, forceNiceScale: true, tickAmount: 5
                        },
                        {
                            seriesName: 'Đơn Hàng', // Syncs 'Khách Hàng' (3rd series) to the 'Đơn Hàng' scale
                            show: false
                        }
                    ],
                    tooltip: { 
                        shared: true,
                        intersect: false,
                        y: {
                            formatter: function(val, { seriesIndex }) {
                                if (seriesIndex === 1) return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val).replace('₫', 'VNĐ');
                                return val + (seriesIndex === 0 ? ' Đơn' : ' Khách');
                            }
                        }
                    }
                });
                window.reportsChart.render();

                // Right side charts logic restored
                window.budgetChart = echarts.init(document.querySelector("#budgetChart"));
                window.trafficChart = echarts.init(document.querySelector("#trafficChart"));

                // Automatically resize ECharts on window resize for responsiveness
                window.addEventListener('resize', () => {
                    window.budgetChart.resize();
                    window.trafficChart.resize();
                });

                function fetchDashboardData() {
                    // Show real-time loading UI
                    if(window.reportsChart) {
                        try {
                            window.budgetChart.showLoading({ color: '#C09D62' });
                            window.trafficChart.showLoading({ color: '#C09D62' });
                        } catch(e) {}
                    }
                    
                    document.getElementById('revenue-container').style.opacity = '0.4';
                    document.getElementById('orders-container').style.opacity = '0.4';
                    document.getElementById('customers-container').style.opacity = '0.4';

                    let url = 'api/dashboard?period=' + currentPeriod + '&startDate=' + currentStartDate + '&endDate=' + currentEndDate;
                    fetch(url)
                        .then(res => res.json())
                        .then(data => {
                            // Update Stats Cards
                            if(document.getElementById('stat-orders')) document.getElementById('stat-orders').textContent = data.stats.orders;
                            
                            if(document.getElementById('stat-revenue')) {
                                let rev = data.stats.revenue;
                                rev = rev.replace(' VNĐ', ' <span style="font-size: 15px; font-weight: 600; color: #8c98a4; margin-left: 4px;">VNĐ</span>');
                                document.getElementById('stat-revenue').innerHTML = rev;
                            }
                            
                            if(document.getElementById('stat-customers')) document.getElementById('stat-customers').textContent = data.stats.customers;
                            
                            if(document.getElementById('trend-orders')) document.getElementById('trend-orders').innerHTML = data.stats.trends.o;
                            if(document.getElementById('trend-revenue')) document.getElementById('trend-revenue').innerHTML = data.stats.trends.r;
                            if(document.getElementById('trend-customers')) document.getElementById('trend-customers').innerHTML = data.stats.trends.c;
                            
                            let rawCats = data.charts.lineChart.categories;
                            let rawOrd = data.charts.lineChart.orders;
                            let rawRev = data.charts.lineChart.revenue;
                            let rawCus = data.charts.lineChart.customers;
                            
                            let newCats = rawCats;
                            let newOrd = rawOrd;
                            let newRev = rawRev;
                            let newCus = rawCus;

                            // Update Line Chart (Reports)
                            let minTime = newCats.length > 0 ? new Date(newCats[0]).getTime() : undefined;
                            let maxTime = newCats.length > 0 ? new Date(newCats[newCats.length - 1]).getTime() : undefined;
                            window.reportsChart.updateOptions({
                                xaxis: { 
                                    categories: newCats,
                                    min: minTime,
                                    max: maxTime
                                }
                            });
                            window.reportsChart.updateSeries([
                                { name: 'Đơn Hàng', type: 'area', data: newOrd },
                                { name: 'Doanh Thu', type: 'area', data: newRev },
                                { name: 'Khách Hàng', type: 'area', data: newCus }
                            ]);
                            
                            // Update Brand Chart to Bar Chart
                            let brandKeys = Object.keys(data.charts.radarChart);
                            let brandRevenues = Object.values(data.charts.radarChart);
                            
                            window.budgetChart.setOption({
                                tooltip: { 
                                    trigger: 'axis',
                                    axisPointer: { type: 'shadow' },
                                    formatter: function(params) {
                                        var val = params[0].value;
                                        return '<strong>' + params[0].name + '</strong><br/>Doanh Thu: ' + new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val).replace('₫', 'VNĐ');
                                    }
                                },
                                grid: { left: '5%', right: '5%', bottom: '5%', containLabel: true },
                                xAxis: {
                                    type: 'category',
                                    data: brandKeys,
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 30
                                    }
                                },
                                yAxis: {
                                    type: 'value',
                                    axisLabel: {
                                        formatter: function(val) {
                                            if(val >= 1000000) return (val/1000000) + ' Tr';
                                            if(val >= 1000) return (val/1000) + ' K';
                                            return val;
                                        }
                                    }
                                },
                                series: [{
                                    name: 'Doanh Thu',
                                    type: 'bar',
                                    barWidth: '45%',
                                    data: brandRevenues,
                                    itemStyle: {
                                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                            { offset: 0, color: '#C09D62' },
                                            { offset: 0.5, color: '#A6854F' },
                                            { offset: 1, color: '#8A6D3B' }
                                        ]),
                                        borderRadius: [4, 4, 0, 0]
                                    },
                                    emphasis: {
                                        itemStyle: {
                                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                                { offset: 0, color: '#E4CC9C' },
                                                { offset: 0.7, color: '#C09D62' },
                                                { offset: 1, color: '#A6854F' }
                                            ])
                                        }
                                    }
                                }]
                            }, true);
                            
                            // Update Pie Chart (Category)
                            let pieSeries = Object.keys(data.charts.pieChart)
                                .map(k => ({ value: data.charts.pieChart[k], name: k }))
                                .filter(item => item.value > 0);
                            let totalRentals = pieSeries.reduce((s, i) => s + i.value, 0);
                            
                            window.trafficChart.setOption({
                                tooltip: { 
                                    trigger: 'item',
                                    formatter: '<strong>{b}</strong> <br/>Số lượng: {c} chiếc ({d}%)'
                                },
                                legend: { 
                                    type: 'scroll',
                                    orient: 'vertical',
                                    left: '65%', 
                                    top: 'center',
                                    icon: 'circle',
                                    itemGap: 20,
                                    itemWidth: 16,
                                    itemHeight: 16,
                                    textStyle: {
                                        fontSize: 16,
                                        fontWeight: '500'
                                    }
                                },
                                color: ['#4154f1', '#2eca6a', '#ff771d', '#C09D62', '#0dcaf0', '#6610f2'],
                                series: [{
                                    name: 'Đã thuê', 
                                    type: 'pie', 
                                    radius: ['55%', '85%'],
                                    center: ['40%', '50%'],
                                    itemStyle: {
                                        borderRadius: 10,
                                        borderColor: '#fff',
                                        borderWidth: 2,
                                        shadowBlur: 15,
                                        shadowColor: 'rgba(0, 0, 0, 0.1)'
                                    },
                                    label: { 
                                        show: false,
                                        position: 'center'
                                    },
                                    emphasis: { 
                                        label: { 
                                            show: true, 
                                            fontSize: '18', 
                                            fontWeight: 'bold',
                                            formatter: '{b}\n{c} xe'
                                        },
                                        itemStyle: {
                                            shadowBlur: 25,
                                            shadowColor: 'rgba(0, 0, 0, 0.2)'
                                        }
                                    },
                                    data: pieSeries.sort(function (a, b) { return a.value - b.value; })
                                }]
                            }, true);
                            
                            // Update Top Motorcycles Table
                            let topTbody = document.getElementById('top-motorcycles-body');
                            if (topTbody && data.topMotorcycles) {
                                topTbody.innerHTML = '';
                                data.topMotorcycles.forEach(m => {
                                    let tr = document.createElement('tr');
                                    let imgSrc = !m.image ? 'images/default.jpg' : (m.image.startsWith('http') ? m.image : 'images/' + m.image);
                                    tr.innerHTML = `
                                        <td class="ps-3 py-3">
                                            <div class="d-flex align-items-center">
                                                <img src="`+imgSrc+`" alt="`+m.model+`" class="rounded shadow-sm" style="width: 70px; height: 50px; object-fit: cover; border: 2px solid #fff;">
                                            </div>
                                        </td>
                                        <td class="py-3">
                                            <div class="fw-bold text-dark fs-6 mb-1">`+m.model+`</div>
                                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-3 py-2 border border-primary border-opacity-25"><i class="bi bi-graph-up-arrow me-1"></i>Đã thuê: `+m.rentCount+` lần</span>
                                        </td>
                                        <td class="fw-semibold text-success py-3">`+ m.priceDay +`</td>
                                        <td class="fw-semibold text-success py-3">`+ m.priceWeek +`</td>
                                        <td class="fw-semibold text-success py-3">`+ m.priceMonth +`</td>
                                    `;
                                    topTbody.appendChild(tr);
                                });
                            }
                        })
                        .catch(err => console.error("Error fetching dashboard data:", err))
                        .finally(() => {
                            // Hide real-time loading UI
                            try {
                                window.budgetChart.hideLoading();
                                window.trafficChart.hideLoading();
                            } catch(e) {}
                            
                            document.getElementById('revenue-container').style.opacity = '1';
                            document.getElementById('orders-container').style.opacity = '1';
                            document.getElementById('customers-container').style.opacity = '1';
                        });
                }

                // Initial load
                fetchDashboardData();

                // Add event listeners to dropdowns and global buttons
                document.querySelectorAll('.dashboard-filter-menu .dropdown-item, .global-filter-btn').forEach(item => {
                    item.addEventListener('click', (e) => {
                        let targetEl = e.currentTarget;
                        let period = targetEl.getAttribute('data-period');
                        if (period === 'custom') {
                            // Let the modal open, do not fetch yet
                        } else {
                            if(targetEl.tagName !== 'BUTTON') e.preventDefault();
                            
                            // Update active state of global buttons
                            document.querySelectorAll('.global-filter-btn').forEach(btn => btn.classList.remove('active'));
                            let btnMatch = document.querySelector('.global-filter-btn[data-period="' + period + '"]');
                            if(btnMatch) btnMatch.classList.add('active');

                            currentPeriod = period;
                            currentStartDate = '';
                            currentEndDate = '';
                            fetchDashboardData();
                        }
                    });
                });
                
                // Custom Date apply
                document.getElementById('btnApplyCustomDate').addEventListener('click', () => {
                    let errDiv = document.getElementById('customDateError');
                    let startVal = document.getElementById('startDate').value;
                    let endVal = document.getElementById('endDate').value;
                    
                    if(!startVal || !endVal) {
                        errDiv.textContent = "Vui lòng chọn đầy đủ Từ ngày và Đến ngày!";
                        errDiv.style.display = 'block';
                        return;
                    }
                    if(new Date(startVal) > new Date(endVal)) {
                        errDiv.textContent = "Từ ngày không được lớn hơn Đến ngày!";
                        errDiv.style.display = 'block';
                        return;
                    }
                    
                    errDiv.style.display = 'none';
                    currentPeriod = 'custom';
                    currentStartDate = startVal;
                    currentEndDate = endVal;
                    
                    // Update active state of global buttons to Custom
                    document.querySelectorAll('.global-filter-btn').forEach(btn => btn.classList.remove('active'));
                    let customBtn = document.querySelector('.global-filter-btn[data-period="custom"]');
                    if(customBtn) customBtn.classList.add('active');

                    // Hide modal programmatically
                    let modalEl = document.getElementById('customDateModal');
                    let modalInstance = bootstrap.Modal.getInstance(modalEl);
                    if(modalInstance) modalInstance.hide();

                    fetchDashboardData();
                });
            });
        </script>
        <!-- Leaflet JS for GPS Map -->
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
        
        <script>
            // === GPS TRACKING MAP LOGIC ===
            let map;
            let vehicleMarkers = {};
            let selectedVehicleId = null;
            let isListVisible = true;
            
            function toggleVehicleList() {
                let mapCol = document.getElementById('map-col');
                let listCol = document.getElementById('list-col');
                let btnIcon = document.querySelector('#toggle-list-btn i');
                
                if (isListVisible) {
                    listCol.style.width = '0px';
                    listCol.style.opacity = '0';
                    listCol.classList.remove('col-lg-4');
                    mapCol.classList.remove('col-lg-8');
                    mapCol.classList.add('col-lg-12');
                    btnIcon.className = 'bi bi-list-ul';
                } else {
                    listCol.style.width = '';
                    listCol.style.opacity = '1';
                    listCol.classList.add('col-lg-4');
                    mapCol.classList.remove('col-lg-12');
                    mapCol.classList.add('col-lg-8');
                    btnIcon.className = 'bi bi-arrows-fullscreen';
                }
                isListVisible = !isListVisible;
                setTimeout(() => { if (map) map.invalidateSize(); }, 400);
            }
            
            function initMap() {
                // Initialize map centered at FPT University Da Nang
                map = L.map('map').setView([16.0609, 108.2057], 15);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    maxZoom: 19,
                    attribution: '&copy; OpenStreetMap contributors'
                }).addTo(map);
                
                // --- Store Marker ---
                var storeIcon = L.divIcon({
                    className: 'custom-store-marker',
                    html: `
                        <style>
                        @keyframes pulse-ring-store {
                          0% { box-shadow: 0 0 0 0 rgba(181, 147, 73, 0.7); }
                          70% { box-shadow: 0 0 0 20px rgba(181, 147, 73, 0); }
                          100% { box-shadow: 0 0 0 0 rgba(181, 147, 73, 0); }
                        }
                        .store-pulse-icon {
                          background-color: #b59349; 
                          color: white; 
                          width: 48px; 
                          height: 48px; 
                          border-radius: 50%; 
                          display: flex; 
                          align-items: center; 
                          justify-content: center; 
                          border: 3px solid white;
                          animation: pulse-ring-store 2s infinite;
                          position: relative;
                          z-index: 1000;
                        }
                        </style>
                        <div class="store-pulse-icon">
                            <i class="fas fa-store" style="font-size: 22px;"></i>
                        </div>
                    `,
                    iconSize: [48, 48],
                    iconAnchor: [24, 24],
                    popupAnchor: [0, -24]
                });
                
                L.marker([16.0609, 108.2057], {icon: storeIcon, zIndexOffset: 1000}).addTo(map)
                    .bindPopup('<div style="text-align:center; min-width: 120px;"><b style="color:#b59349; font-size:16px;">SmartRide Store</b><br><span style="color:#666; font-size:13px;">254 Nguyễn Văn Linh, Đà Nẵng</span></div>');

                
                // Fetch vehicle locations every 3 seconds
                setInterval(fetchVehicleLocations, 3000);
                fetchVehicleLocations();
            }
            
            let currentVehicles = [];
            let currentPage = 1;
            const itemsPerPage = 6;
            
            function fetchVehicleLocations() {
                fetch('api/get-locations')
                    .then(res => res.json())
                    .then(data => {
                        currentVehicles = data.locations || [];
                        updateMapMarkers();
                        renderVehicleList();
                    })
                    .catch(err => console.error("Error fetching GPS:", err));
            }
            
            function updateMapMarkers() {
                let statGps = document.getElementById('stat-gps');
                statGps.textContent = currentVehicles.length;
                let newMarkers = {};
                
                currentVehicles.forEach(v => {
                    let key = v.bookingId;
                    
                    let bikeIcon = L.icon({
                        iconUrl: 'images/motorbike-marker.png', // Add a default marker or this
                        iconSize: [40, 40],
                        iconAnchor: [20, 40],
                        popupAnchor: [0, -40]
                    });
                    
                    let ageMin = Math.floor(v.age / 60);
                    let ageSec = v.age % 60;
                    let ageStr = ageMin > 0 ? ageMin + ' phút ' + ageSec + ' giây' : ageSec + ' giây';
                    
                    let popupHtml = '<div style="font-family:Inter,sans-serif;min-width:200px;">' +
                        '<div style="font-weight:800;color:#e11d48;margin-bottom:6px;font-size:14px;"><i class="fas fa-motorcycle"></i> ' + (v.vehicleName||'Xe máy') + '</div>' +
                        '<div style="font-size:12px;color:#374151;margin-bottom:2px;"><i class="fas fa-hashtag" style="color:#94a3b8;width:16px;"></i> Mã đơn: <strong>' + v.bookingId + '</strong></div>' +
                        '<div style="font-size:12px;color:#374151;margin-bottom:2px;"><i class="fas fa-user" style="color:#94a3b8;width:16px;"></i> Khách: <strong>' + (v.name||'') + '</strong></div>' +
                        '<div style="font-size:12px;color:#374151;margin-bottom:2px;"><i class="fas fa-phone" style="color:#94a3b8;width:16px;"></i> SĐT: <strong>' + (v.phone||'') + '</strong></div>' +
                        '<div style="font-size:11px;color:#94a3b8;margin-top:6px;border-top:1px solid #e5e7eb;padding-top:4px;"><i class="fas fa-clock"></i> Cập nhật: ' + ageStr + ' trước</div>' +
                        '<div style="font-size:11px;color:#94a3b8;font-family:monospace;">Lat: ' + v.lat.toFixed(5) + ' / Lon: ' + v.lon.toFixed(5) + '</div>' +
                        '</div>';
                    
                    if(vehicleMarkers[key]) {
                        // Update existing marker
                        vehicleMarkers[key].setLatLng([v.lat, v.lon]);
                        vehicleMarkers[key].getPopup().setContent(popupHtml);
                        newMarkers[key] = vehicleMarkers[key];
                    } else {
                        // Create new marker
                        let marker = L.marker([v.lat, v.lon]).addTo(map)
                            .bindPopup(popupHtml, {maxWidth: 260});
                        newMarkers[key] = marker;
                    }
                });
                
                // Remove stale markers
                Object.keys(vehicleMarkers).forEach(k => {
                    if(!newMarkers[k]) {
                        map.removeLayer(vehicleMarkers[k]);
                    }
                });
                vehicleMarkers = newMarkers;
            }

            function renderVehicleList() {
                let listContainer = document.getElementById('gps-vehicle-list');
                if(currentVehicles.length === 0) {
                    listContainer.innerHTML = '<div class="p-4 text-center text-muted"><i class="bi bi-inbox fs-2"></i><br>Không có xe nào đang hoạt động</div>';
                    return;
                }

                let totalPages = Math.ceil(currentVehicles.length / itemsPerPage);
                if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;

                let startIdx = (currentPage - 1) * itemsPerPage;
                let paginatedItems = currentVehicles.slice(startIdx, startIdx + itemsPerPage);

                let html = '';
                paginatedItems.forEach(v => {
                    let key = v.bookingId;
                    let statusColor = (v.age !== undefined && v.age <= 60) ? 'text-success' : 'text-warning';
                    let statusText = (v.age !== undefined && v.age <= 60) ? 'Đang trực tuyến' : 'Mất tín hiệu (' + v.age + 's)';
                    
                    let vehicleName = v.vehicleName || 'Xe máy';
                    let phone = v.phone || 'Chưa cập nhật';
                    
                    // Geofencing Check
                    let dist = haversine(16.0609, 108.2057, v.lat, v.lon);
                    let isOutOfBounds = (dist > 50);
                    let isAllowed = allowedVehicles.includes(key);
                    
                    let isSelected = (key === selectedVehicleId) ? 'bg-primary bg-opacity-10 border-primary border-start border-4' : 'bg-white hover-bg-light';
                    let warningStyle = '';
                    let warningBadge = '';
                    let actionBtn = '';
                    
                    if (isOutOfBounds && !isAllowed) {
                        warningStyle = 'bg-danger bg-opacity-25 border-danger border-start border-4';
                        warningBadge = '<span class="badge bg-danger mt-2" style="font-size:10px;"><i class="bi bi-exclamation-triangle"></i> Đi quá giới hạn (' + dist.toFixed(1) + 'km)</span>';
                        actionBtn = '<button class="btn btn-sm btn-danger mt-2 ms-2" style="font-size:10px; font-weight:bold;" onclick="allowOutside(\''+key+'\', event)">Cho phép</button>';
                        isSelected = ''; // Override selected style if warning
                    } else if (isOutOfBounds && isAllowed) {
                        warningBadge = '<span class="badge bg-success mt-2" style="font-size:10px;"><i class="bi bi-check-circle"></i> Đã cấp phép đi xa (' + dist.toFixed(1) + 'km)</span>';
                    }
                    
                    html += `
                        <div class="p-3 border-bottom d-flex align-items-center ${warningStyle || isSelected}" style="cursor: pointer; transition: 0.2s;" onclick="focusVehicle('`+key+`', `+v.lat+`, `+v.lon+`)">
                            <div class="rounded-circle ${warningStyle ? 'bg-danger text-white' : 'bg-danger bg-opacity-10 text-danger'} d-flex justify-content-center align-items-center me-3" style="width: 42px; height: 42px; flex-shrink: 0;">
                                <i class="bi ${warningStyle ? 'bi-exclamation-triangle-fill' : 'bi-person-bounding-box'} fs-5"></i>
                            </div>
                            <div style="flex-grow: 1; min-width: 0;">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <h6 class="mb-0 fw-bold text-dark text-truncate">`+v.name+`</h6>
                                    <small class="text-primary fw-bold" style="font-size: 11px;">
                                        <i class="bi bi-telephone-fill"></i> `+phone+`
                                    </small>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mt-1">
                                    <small class="text-muted text-truncate fw-semibold" style="font-size: 11.5px; max-width: 55%;">
                                        `+vehicleName+`
                                    </small>
                                    <small class="`+statusColor+` fw-semibold text-end" style="font-size: 11px; white-space: nowrap;">
                                        <i class="bi bi-circle-fill" style="font-size: 8px;"></i> `+statusText+`
                                    </small>
                                </div>
                                ${warningBadge} ${actionBtn}
                            </div>
                        </div>
                    `;
                });

                if (totalPages > 1) {
                    html += '<div class="d-flex justify-content-between align-items-center p-3 bg-light border-top">';
                    html += '    <button class="btn btn-sm btn-outline-secondary" onclick="changePage(-1)" ' + (currentPage === 1 ? 'disabled' : '') + '>';
                    html += '        <i class="bi bi-chevron-left"></i> Trước';
                    html += '    </button>';
                    html += '    <small class="fw-bold text-muted">Trang ' + currentPage + ' / ' + totalPages + '</small>';
                    html += '    <button class="btn btn-sm btn-outline-secondary" onclick="changePage(1)" ' + (currentPage === totalPages ? 'disabled' : '') + '>';
                    html += '        Sau <i class="bi bi-chevron-right"></i>';
                    html += '    </button>';
                    html += '</div>';
                }
                listContainer.innerHTML = html;
            }

            function changePage(delta) {
                currentPage += delta;
                renderVehicleList();
            }
            
            function focusVehicle(id, lat, lng) {
                selectedVehicleId = id;
                renderVehicleList();
                map.setView([lat, lng], 17);
                if(vehicleMarkers[id]) vehicleMarkers[id].openPopup();
            }
            
            let allowedVehicles = [];
            
            function allowOutside(id, event) {
                event.stopPropagation();
                if(!allowedVehicles.includes(id)) {
                    allowedVehicles.push(id);
                    renderVehicleList();
                }
            }
            
            function haversine(lat1, lon1, lat2, lon2) {
                const R = 6371;
                const dLat = (lat2 - lat1) * Math.PI / 180;
                const dLon = (lon2 - lon1) * Math.PI / 180;
                const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                          Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                          Math.sin(dLon/2) * Math.sin(dLon/2);
                const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
                return R * c;
            }
            
            let simulationInterval = null;
            let fakeVehicles = [
                { id: 'TEST-001', name: 'Nguyễn Văn Test', phone: '0987654321', vehicleName: 'Honda Airblade', lat: 16.0609, lon: 108.2057, dLat: 0.0001, dLon: 0.0001 },
                { id: 'TEST-002', name: 'Trần Thị Demo', phone: '0912345678', vehicleName: 'Yamaha Vision', lat: 16.0604, lon: 108.2080, dLat: -0.00008, dLon: 0.00015 },
                { id: 'TEST-003', name: 'Phượt Thủ Cứng', phone: '0933333333', vehicleName: 'Honda Winner X', lat: 15.6500, lon: 108.2080, dLat: 0.0002, dLon: 0.0001 } // Distance ~45km at start, will quickly go out of bounds
            ];
            
            function startGpsSimulation() {
                let btn = document.getElementById('btn-test-gps');
                
                if (simulationInterval) {
                    // Stop simulation
                    clearInterval(simulationInterval);
                    simulationInterval = null;
                    btn.innerHTML = '<i class="bi bi-play-fill fs-5 me-1" style="margin-left: -4px;"></i> Khởi chạy Test';
                    btn.classList.remove('btn-warning');
                    btn.classList.add('btn-danger');
                    
                    // Remove fake vehicles from server
                    fakeVehicles.forEach(v => {
                        let fdStop = new URLSearchParams();
                        fdStop.append('action', 'stop');
                        fdStop.append('bookingId', v.id);
                        fetch('api/update-location', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: fdStop.toString()
                        });
                    });
                    
                    return;
                }
                
                // Start simulation
                btn.innerHTML = '<i class="bi bi-stop-fill fs-5 me-1" style="margin-left: -4px;"></i> Dừng Test';
                btn.classList.remove('btn-danger');
                btn.classList.add('btn-warning');
                
                // Immediately send one tick, then every 3 seconds
                simulateTick();
                simulationInterval = setInterval(simulateTick, 3000);
            }
            
            function simulateTick() {
                fakeVehicles.forEach(v => {
                    // Move slightly
                    v.lat += v.dLat;
                    v.lon += v.dLon;
                    
                    // Bounce back if they go too far (rough bounds around new shop)
                    if (v.id !== 'TEST-003') {
                        if(v.lat > 16.070 || v.lat < 16.050) v.dLat = -v.dLat;
                        if(v.lon > 108.220 || v.lon < 108.190) v.dLon = -v.dLon;
                    } else {
                        // TEST-003 goes far away continuously
                        if(v.lat > 16.070 || v.lat < 15.400) v.dLat = -v.dLat;
                    }
                    
                    // Send to backend
                    let formData = new URLSearchParams();
                    formData.append('bookingId', v.id);
                    formData.append('customerName', v.name);
                    formData.append('phone', v.phone);
                    formData.append('vehicleName', v.vehicleName);
                    formData.append('lat', v.lat);
                    formData.append('lon', v.lon);
                    
                    fetch('api/update-location', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: formData.toString()
                    }).catch(err => console.error("Sim error:", err));
                });
            }
            
            // Wait for DOM
            document.addEventListener('DOMContentLoaded', () => {
                // ... (Existing code) ...
                
                setTimeout(() => {
                    initMap();
                }, 500);
            });
        </script>
    </body>
</html>

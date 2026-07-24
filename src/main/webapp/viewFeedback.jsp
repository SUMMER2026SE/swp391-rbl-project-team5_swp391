<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    body, html { height: 100%; margin: 0; font-family: 'Poppins', sans-serif; background-color: #f8fafc; }
    .container-fluid { padding: 2rem; background: #f8fafc; }
    
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

    
    /* --- Custom Select & Text Truncate --- */
    .custom-select { appearance: none; -webkit-appearance: none; -moz-appearance: none; background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 12px center; background-size: 16px; background-color: #fff; border: 1px solid #cbd5e1; border-radius: 20px; padding: 6px 36px 6px 16px; font-weight: 500; color: #475569; transition: all 0.2s; cursor: pointer; height: auto; }
    .custom-select:focus { outline: none; border-color: #d4af37; box-shadow: 0 0 0 3px rgba(212,175,55,0.1); }
    .dataTables_wrapper .dataTables_length select { margin: 0 10px; border: 1px solid #cbd5e1; border-radius: 20px; padding: 5px 30px 5px 15px; outline: none; background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 8px center; background-size: 16px; appearance: none; -webkit-appearance: none; }
    
    .desc-text { display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; max-width: 160px; color: #6c757d; font-size: 13px; text-align: center; margin: 0 auto; }

    /* --- Filters --- */
    .filters-container { padding: 1rem 1.5rem; background: #f8fafc; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: flex-end; gap: 10px; }
    .form-control { border-radius: 6px; border: 1px solid #cbd5e1; padding: 0.5rem 0.75rem; box-shadow: inset 0 1px 2px rgba(0,0,0,0.05); }
    .form-control:focus { border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1); }
</style>
    </head>

    <body>
        <div class="container-fluid mt-4">
            <div class="pagetitle" style="margin-bottom: 20px; padding-left: 0;">
                <h1 style="color: #1a1816; font-weight: 800; font-size: 24px; text-transform: uppercase; margin-top: 0; margin-bottom: 5px; font-family: 'Tahoma', sans-serif;">QUẢN LÝ ĐÁNH GIÁ</h1>
                <nav>
                    <ol class="breadcrumb" style="background: transparent; padding: 0; margin: 0; font-size: 14px;">
                        <li style="display: inline-block;"><a href="homeStaff" target="_top" style="color: #b59349; text-decoration: none; font-weight: 600;">Trang chủ</a></li>
                        <li class="active" style="display: inline-block; font-weight: 500; color: #6c757d;">Quản lý đánh giá</li>
                    </ol>
                </nav>
            </div>
    <div class="row">
        <div class="col-12">
            <!-- Stats Cards -->
            <div class="row" style="margin-bottom: 1.5rem;">
                <div class="col-md-3">
                    <div class="stat-card" style="background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%); color: white; padding: 1.25rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(59, 130, 246, 0.2);">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <p style="margin: 0; font-size: 0.85rem; opacity: 0.9;">Tổng Đánh Giá</p>
                                <h3 style="margin: 5px 0 0 0; font-weight: 700; font-size: 1.75rem;" id="total-feedbacks">${listF.size()}</h3>
                            </div>
                            <i class="fa fa-comments" style="font-size: 2.5rem; opacity: 0.3;"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card" style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: white; padding: 1.25rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(245, 158, 11, 0.2);">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <p style="margin: 0; font-size: 0.85rem; opacity: 0.9;">Đánh Giá Trung Bình</p>
                                <h3 style="margin: 5px 0 0 0; font-weight: 700; font-size: 1.75rem;" id="avg-rating">-</h3>
                            </div>
                            <i class="fa fa-star" style="font-size: 2.5rem; opacity: 0.3;"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white; padding: 1.25rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(16, 185, 129, 0.2);">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <p style="margin: 0; font-size: 0.85rem; opacity: 0.9;">5 Sao</p>
                                <h3 style="margin: 5px 0 0 0; font-weight: 700; font-size: 1.75rem;" id="five-stars">0</h3>
                            </div>
                            <i class="fa fa-thumbs-up" style="font-size: 2.5rem; opacity: 0.3;"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card" style="background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%); color: white; padding: 1.25rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(239, 68, 68, 0.2);">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <p style="margin: 0; font-size: 0.85rem; opacity: 0.9;">1-2 Sao</p>
                                <h3 style="margin: 5px 0 0 0; font-weight: 700; font-size: 1.75rem;" id="low-stars">0</h3>
                            </div>
                            <i class="fa fa-exclamation-triangle" style="font-size: 2.5rem; opacity: 0.3;"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><i class="fa fa-star text-warning mr-2"></i> DANH SÁCH ĐÁNH GIÁ</h3>
                </div>
                <div class="filters-container" style="padding: 1.25rem 1.5rem; background: #fff; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center;">
                    <div style="display: flex; gap: 12px;">
                        <select class="form-control" style="width: 180px; border-radius: 8px; border: 2px solid #e2e8f0; padding: 8px 12px; font-weight: 500;" onchange="sortTable(this.value)">
                            <option value="">📊 Sắp xếp theo sao</option>
                            <option value="asc">⬆️ Tăng dần (1→5)</option>
                            <option value="desc">⬇️ Giảm dần (5→1)</option>
                        </select>
                        <select class="form-control" style="width: 180px; border-radius: 8px; border: 2px solid #e2e8f0; padding: 8px 12px; font-weight: 500;" onchange="filterTable(this.value)">
                            <option value="">🔍 Lọc theo sao</option>
                            <option value="5">⭐⭐⭐⭐⭐ 5 sao</option>
                            <option value="4">⭐⭐⭐⭐ 4 sao</option>
                            <option value="3">⭐⭐⭐ 3 sao</option>
                            <option value="2">⭐⭐ 2 sao</option>
                            <option value="1">⭐ 1 sao</option>
                        </select>
                    </div>
                    <div style="color: #64748b; font-weight: 500; font-size: 14px;">
                        <span id="visible-count">${listF.size()}</span>/<span>${listF.size()}</span> đánh giá
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle" id="feedbackTable">
                            <thead>
                                        <tr>
                                            <th scope="col" style="width: 8%;">ID</th>
                                            <th scope="col" style="width: 45%;">Nội Dung</th>
                                            <th scope="col" style="width: 20%;">Đánh Giá</th>
                                            <th scope="col" style="width: 27%;">Tên Khách Hàng</th>

                                        </tr>
                                    </thead>
                            <tbody id="table-body">
                                <c:forEach items="${listF}" var="f">
                                    
                                            <tr data-rating="${f.serviceRate}">
                                                <td style="font-weight: 600; color: #64748b;">#${f.feedbackID}</td>                                                                                           
                                                <td style="text-align: left; padding-left: 20px;">
                                                    <div style="display: flex; align-items: start; gap: 10px;">
                                                        <i class="fa fa-quote-left" style="color: #cbd5e1; font-size: 18px; margin-top: 2px;"></i>
                                                        <span style="color: #475569; line-height: 1.6; font-size: 14px;">${f.content}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
                                                        <div style="display: flex; gap: 2px;">
                                                            <c:forEach begin="1" end="${f.serviceRate}" var="star">
                                                                <span style="color: #fbbf24; font-size: 18px;" class="fa fa-star"></span>
                                                            </c:forEach>
                                                            <c:forEach begin="${f.serviceRate + 1}" end="5" var="emptyStar">
                                                                <span style="color: #e5e7eb; font-size: 18px;" class="fa fa-star"></span>
                                                            </c:forEach>
                                                        </div>
                                                        <span class="hidden-rate" style="display: none;">${f.serviceRate}</span>
                                                        <span style="font-size: 12px; font-weight: 600; color: #64748b;">${f.serviceRate}/5</span>
                                                    </div>
                                                </td>   

                                                <td>
                                                    <div style="display: flex; align-items: center; justify-content: center; gap: 8px;">
                                                        <div style="width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 14px;">
                                                            ${f.customerName.substring(0, 1).toUpperCase()}
                                                        </div>
                                                        <span style="font-weight: 600; color: #1e293b;">${f.customerName}</span>
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
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


        <script type="text/javascript">
            // Tính toán stats khi load trang
            $(document).ready(function() {
                calculateStats();
            });
            
            function calculateStats() {
                var rows = $("#feedbackTable tbody tr");
                var total = rows.length;
                var sum = 0;
                var fiveStars = 0;
                var lowStars = 0;
                
                rows.each(function() {
                    var rating = parseInt($(this).find('.hidden-rate').text());
                    sum += rating;
                    if (rating === 5) fiveStars++;
                    if (rating <= 2) lowStars++;
                });
                
                var average = total > 0 ? (sum / total).toFixed(1) : 0;
                
                $('#avg-rating').text(average + " ⭐");
                $('#five-stars').text(fiveStars);
                $('#low-stars').text(lowStars);
            }
            
            function confirmDelete(motorcycleId) {
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
                        window.location.href = 'motorManage?motorcycleId=' + motorcycleId;
                    }
                });
            }

            function sortTable(order) {
                if (!order)
                    return;
                var table = document.getElementById("feedbackTable");
                var rows = Array.from(table.rows).slice(1); // Get all rows except the header

                rows.sort(function (a, b) {
                    var rateA = parseInt(a.querySelector('.hidden-rate').innerText);
                    var rateB = parseInt(b.querySelector('.hidden-rate').innerText);
                    return order === 'asc' ? rateA - rateB : rateB - rateA;
                });

                rows.forEach(function (row) {
                    table.appendChild(row); // Reattach rows in sorted order
                });
            }

            function filterTable(stars) {
                var table = document.getElementById("feedbackTable");
                var rows = Array.from(table.rows).slice(1);
                var visibleCount = 0;

                rows.forEach(function(row) {
                    var rate = parseInt(row.querySelector('.hidden-rate').innerText);
                    if (stars === "" || rate == stars) {
                        row.style.display = "";
                        visibleCount++;
                    } else {
                        row.style.display = "none";
                    }
                });

                document.getElementById("visible-count").innerText = visibleCount;
            }
        </script>


        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!--         Bootstrap js 
                <script type="text/javascript" src="js/jquery.js"></script>
                <script type="text/javascript" src="js/popper.js"></script>
                 OWL Car 
                <script src="js/owl.carousel.min.js"></script>
                 Show More js 
                <script src="js/showMoreItems.min.js"></script>
                 Data TAble 
                <script
                src="//cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
                 Bootstrap 
                <script type="text/javascript" src="js/bootstrap.min.js"></script>
                 Theme js 
                <script type="text/javascript" src="js/main.js"></script>-->
    </body>

</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="com.smartride.dto.Favorite"%>
<%@page import="com.smartride.dao.FavoriteDAO"%>
<%@page import="com.smartride.dto.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Xe Yêu Thích - SmartRide</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="${pageContext.request.contextPath}/images/newlogo_transparent.png" rel="icon" type="image/png">
</head>
<body>
    <jsp:include page="/includes/customer/navbar.jsp" />

    <style>
        body {
            background-color: #fbfaf8 !important;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        .page-header {
            padding: 140px 0 60px 0;
            background: linear-gradient(to bottom, #ffffff, #fbfaf8);
            text-align: center;
        }
        .page-header h1 {
            font-weight: 800;
            color: #1a1816;
            font-size: 42px;
            letter-spacing: -0.5px;
            margin-bottom: 15px;
        }
        .page-header p {
            color: #64748b;
            font-size: 16px;
            max-width: 600px;
            margin: 0 auto;
        }
        /* Vertical Premium Card */
        .motor-card-vertical {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            padding: 25px;
            transition: all 0.4s ease;
            position: relative;
            border: 1px solid rgba(181, 147, 73, 0.1);
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .motor-card-vertical:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(181, 147, 73, 0.12);
            border-color: rgba(181, 147, 73, 0.4);
        }
        .motor-card-vertical .img-wrapper {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 220px;
            position: relative;
        }
        .motor-card-vertical .img-wrapper img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            transition: transform 0.4s ease;
        }
        .motor-card-vertical:hover .img-wrapper img {
            transform: scale(1.08);
        }
        .motor-card-vertical h3 {
            font-size: 22px;
            font-weight: 800;
            color: #1a1816;
            margin-bottom: 10px;
            text-align: center;
        }
        .motor-card-vertical .price-wrap {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #e2e8f0;
        }
        .motor-card-vertical .price-wrap .price-val {
            font-size: 24px;
            font-weight: 800;
            color: #b59349;
        }
        .motor-card-vertical .price-wrap .price-unit {
            font-size: 14px;
            color: #64748b;
        }
        .motor-card-vertical .action-row {
            display: flex;
            gap: 10px;
            margin-top: auto;
        }
        .motor-card-vertical .action-row a {
            flex: 1;
            padding: 12px;
            border-radius: 12px;
            text-align: center;
            font-weight: 700;
            font-size: 14px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn-rent {
            background: #b59349;
            color: white !important;
            box-shadow: 0 4px 15px rgba(181, 147, 73, 0.2);
        }
        .btn-rent:hover {
            background: #a0813f;
            transform: translateY(-2px);
        }
        .btn-detail {
            background: #f1f5f9;
            color: #475569 !important;
        }
        .btn-detail:hover {
            background: #e2e8f0;
            color: #1e293b !important;
        }
        .btn-remove {
            position: absolute;
            top: 15px;
            right: 15px;
            background: white;
            color: #ef4444;
            border: 1px solid #fee2e2;
            border-radius: 50%;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: all 0.2s;
            cursor: pointer;
        }
        .btn-remove:hover {
            background: #fee2e2;
            color: #dc2626;
            transform: scale(1.1);
        }
    </style>

    <div class="page-header">
        <div class="container">
            <h1>Xe Yêu Thích</h1>
            <p>Danh sách những mẫu xe tuyệt vời mà bạn đã lưu lại để chuẩn bị cho hành trình sắp tới cùng SmartRide.</p>
        </div>
    </div>

    <section class="ftco-section bg-light">
        <div class="container">
            <div class="row">
                <% 
                    Account acc = (Account) session.getAttribute("account");
                    if (acc != null) {
                        List<Favorite> list = FavoriteDAO.getInstance().getFavoritesByAccountId(acc.getAccountId());
                        if (list != null && !list.isEmpty()) {
                            request.setAttribute("favorites", list);
                %>
                <c:forEach items="${favorites}" var="f">
                    <div class="col-md-4 mb-4">
                        <div class="motor-card-vertical">
                            <button onclick="removeFav('${f.motorcycleId}', this)" class="btn-remove" title="Bỏ yêu thích">
                                <i class="fas fa-trash-can"></i>
                            </button>
                            
                            <a href="motorcycledetail?motorcycleid=${f.motorcycleId}" class="img-wrapper">
                                <img src="${empty f.motorcycleImage ? 'images/default.jpg' : (f.motorcycleImage.startsWith('http') ? f.motorcycleImage : 'images/'.concat(f.motorcycleImage))}" alt="${f.motorcycleName}">
                            </a>
                            
                            <h3><a href="motorcycledetail?motorcycleid=${f.motorcycleId}" style="color: inherit; text-decoration: none;">${f.motorcycleName}</a></h3>
                            
                            <div class="price-wrap">
                                <span class="price-val"><fmt:formatNumber value="${f.rentPrice}" pattern="#,###"/></span>
                                <span class="price-unit">VNĐ / ngày</span>
                            </div>
                            
                            <div class="action-row">
                                <a href="booking?motorcycleid=${f.motorcycleId}" class="btn-rent">THUÊ NGAY</a>
                                <a href="motorcycleDetail?id=${f.motorcycleId}" class="btn-detail">Chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <% 
                        } else {
                %>
                    <div class="col-12 text-center py-5">
                        <img src="images/empty-cart.png" alt="Empty" style="width: 150px; opacity: 0.5; margin-bottom: 20px;" onerror="this.style.display='none'">
                        <h3 class="text-muted" style="font-family: 'Plus Jakarta Sans', sans-serif;">Bạn chưa có xe yêu thích nào</h3>
                        <p class="text-muted">Hãy tham khảo các dòng xe và thêm vào danh sách yêu thích nhé!</p>
                        <a href="motorcycle" class="btn btn-primary mt-3 px-4 py-2" style="border-radius: 8px;">Xem danh sách xe</a>
                    </div>
                <%
                        }
                    } else {
                %>
                    <div class="col-12 text-center py-5">
                        <h3 class="text-muted">Vui lòng đăng nhập để xem danh sách yêu thích</h3>
                        <a href="login.jsp" class="btn btn-primary mt-3 px-4 py-2" style="border-radius: 8px;">Đăng nhập</a>
                    </div>
                <% } %>
            </div>
        </div>
    </section>

    <jsp:include page="/includes/customer/footer.jsp" />

    <script src="js/jquery.min.js"></script>
    <script src="js/jquery-migrate-3.0.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.stellar.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/jquery.animateNumber.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/jquery.timepicker.min.js"></script>
    <script src="js/scrollax.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        function removeFav(motorcycleId, btnElement) {
            var cardCol = btnElement.closest('.col-md-4');
            
            // Animation mờ dần
            cardCol.style.transition = "opacity 0.3s ease, transform 0.3s ease";
            cardCol.style.opacity = "0.5";
            cardCol.style.transform = "scale(0.95)";
            
            fetch('favorite?action=remove&motorcycleId=' + motorcycleId, { method: 'POST' })
            .then(res => res.json())
            .then(data => {
                if(data.status === 'success') {
                    cardCol.style.opacity = "0";
                    setTimeout(() => {
                        cardCol.remove();
                        // Kiểm tra nếu danh sách trống thì reload lại để hiện ảnh báo trống
                        if(document.querySelectorAll('.motor-card-vertical').length === 0) {
                            location.reload();
                        }
                    }, 200);
                } else {
                    // Phục hồi nếu lỗi
                    cardCol.style.opacity = "1";
                    cardCol.style.transform = "scale(1)";
                }
            }).catch(e => {
                cardCol.style.opacity = "1";
                cardCol.style.transform = "scale(1)";
            });
        }
    </script>
</body>
</html>

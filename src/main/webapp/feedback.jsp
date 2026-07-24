<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Motorcycle Rental Feedback</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                margin: 0;
                padding: 0;
                height: 100vh;
                background-size: cover;
                font-family: 'Plus Jakarta Sans', sans-serif;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #fbfaf8 !important;
            }

            .feedback-container {
                width: 48%;
                max-width: 650px;
                margin: 20px auto;
                background-color: #ffffff !important;
                border: 1px solid #eae6df !important;
                padding: 30px;
                border-radius: 16px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.03) !important;
                animation: fadeIn 1.2s ease-in-out;
                color: #2b2824;
            }

            .header h1 {
                text-align: center;
                margin-bottom: 25px;
                font-weight: 700;
                color: #1a1816;
                font-family: 'Playfair Display', serif !important;
                font-size: 26px;
                letter-spacing: 0.5px;
            }

            .product-info {
                display: flex;
                align-items: center;
                margin-top: 10px;
                margin-bottom: 30px;
                background: #fcfbf9;
                padding: 15px;
                border-radius: 10px;
                border: 1px solid #eae6df;
            }

            .product-info img {
                width: 110px;
                height: 85px;
                border-radius: 8px;
                object-fit: cover;
                margin-right: 20px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }
            .product-info h5 {
                color: #b59349 !important;
                font-family: 'Playfair Display', serif !important;
                font-weight: 600;
                margin-bottom: 5px;
            }
            .product-info h7 {
                color: #666666 !important;
                font-size: 13px;
            }

            .feedback-form {
                display: flex;
                flex-direction: column;
            }

            .rating-section, .service-rating, .delivery-speed {
                display: flex;
                align-items: center;
                background: #fcfbf9;
                padding: 12px 15px;
                border-radius: 8px;
                border: 1px solid #eae6df;
            }

            .rating-section label, .service-rating label, .delivery-speed label {
                width: 45%;
                font-weight: 600;
                color: #2b2824;
                margin-bottom: 0;
            }

            .rating-section .rating, .service-rating .rating, .delivery-speed .rating {
                width: 30%;
            }

            .rating-section, .additional-feedback, .submit-section, .service-rating, .delivery-speed {
                margin-bottom: 20px;
            }

            .rating .star {
                font-size: 26px;
                color: #eae6df;
                cursor: pointer;
                transition: transform 0.2s, color 0.2s;
                margin-right: 5px;
            }

            .rating .star:hover,
            .rating .star.hovered {
                transform: scale(1.2);
                color: #b59349;
                opacity: 0.8;
            }

            .rating .star.selected {
                color: #b59349;
                transform: scale(1.25);
                opacity: 1;
            }

            .rating-text {
                margin-left: auto;
                font-size: 14px;
                color: #b59349 !important;
                font-weight: 600;
            }

            textarea {
                width: 100%;
                height: 100px !important;
                margin-bottom: 10px;
                padding: 12px;
                background-color: #ffffff !important;
                border: 1px solid #eae6df !important;
                border-radius: 8px;
                color: #2b2824 !important;
                transition: all 0.3s;
            }

            textarea:focus {
                border-color: #b59349 !important;
                outline: none;
                box-shadow: 0 0 10px rgba(181, 147, 73, 0.15) !important;
            }
            .additional-feedback label {
                font-weight: 600;
                color: #2b2824;
                margin-bottom: 8px;
            }

            .submit-section {
                text-align: center;
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 10px;
            }

            .submit-section button {
                padding: 12px 24px;
                background-color: #b59349 !important;
                color: #ffffff !important;
                font-weight: 700;
                border: none;
                border-radius: 50px;
                cursor: pointer;
                transition: all 0.3s;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 13px;
                min-width: 140px;
            }

            .submit-section button:hover {
                background-color: #a38241 !important;
                box-shadow: 0 5px 15px rgba(181, 147, 73, 0.25);
                transform: translateY(-2px);
            }

            .submit-section button[onclick*="closeFeedback"] {
                background-color: transparent !important;
                color: #2b2824 !important;
                border: 1px solid rgba(0, 0, 0, 0.1) !important;
            }
            .submit-section button[onclick*="closeFeedback"]:hover {
                background-color: #f5f2eb !important;
                border-color: rgba(0, 0, 0, 0.2) !important;
                box-shadow: none;
            }

            @media (max-width: 768px) {
                .feedback-container {
                    width: 92%;
                    padding: 20px;
                }
                .rating-section, .service-rating, .delivery-speed {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .rating-section label, .service-rating label, .delivery-speed label {
                    width: 100%;
                    margin-bottom: 10px;
                }
                .rating-text {
                    margin-left: 0;
                    margin-top: 5px;
                }
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 10;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.7);
            }

            .modal-content {
                background-color: #111111 !important;
                border: 1px solid rgba(212, 175, 55, 0.2) !important;
                margin: 15% auto;
                padding: 25px;
                width: 80%;
                max-width: 500px;
                border-radius: 12px;
                color: #ffffff;
                text-align: center;
                animation: slideIn 0.4s ease-in-out;
            }

            .close {
                color: #d4af37;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover {
                color: #ffffff;
            }

            @keyframes slideIn {
                from {
                    transform: translateY(-30%);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            .selected {
                color: #d4af37 !important;
            }

            .loading {
                position: fixed;
                z-index: 999;
                width: 100%;
                height: 100%;
                display: none;
                align-items:center;
                justify-content:center;
                background: rgba(0, 0, 0, 0.7);
                top: 0;
                left: 0;
            }
            .loading img{
                width: 5rem;
            }

        </style>
    </head>
    <body>
        <div class="loading" id="loading" >
            <img src="images/loading.gif" alt="loading">
        </div>
        <div class="feedback-container">
            <div class="header">
                <h1 class="fw-bold">Đánh giá dịch vụ thuê xe máy SmartRide</h1>
            </div>
            <c:if test="${not empty sessionScope.feedbackResult}">
                <p style="color: green; font-style: italic; margin-bottom: 0">${sessionScope.feedbackResult}</p>
                <c:remove var="feedbackResult" scope="session"/>
                <script>
                    setTimeout(() => {
                        window.location.href = 'bookingHistory?status=all';
                    }, 3000);
                </script>
            </c:if>
            <c:if test="${not empty sessionScope.feedbackUpdate}">
                <p style="color: green; font-style: italic; margin-bottom: 0">${sessionScope.feedbackUpdate}</p>
                <c:remove var="feedbackUpdate" scope="session"/>
                <script>
                    setTimeout(() => {
                        window.location.href = 'bookingHistory?status=all';
                    }, 3000);
                </script>
            </c:if>
            <c:if test="${not empty sessionScope.feedbackFail}">
                <p style="color: red; font-style: italic; margin-bottom: 0">${sessionScope.feedbackFail}</p>
                <c:remove var="feedbackFail" scope="session"/>
            </c:if>

            <div class="product-info d-flex">
                <c:forEach var="motorcycle" items="${motorcycleBook}">

                    <img style="margin-bottom: 20px" 
                         src="${empty motorcycle['Image'] ? pageContext.request.contextPath.concat('/images/default.jpg') : (motorcycle['Image'].startsWith('http') ? motorcycle['Image'] : pageContext.request.contextPath.concat('/images/').concat(motorcycle['Image']))}" 
                         alt="${motorcycle['Model']}" onerror="this.src='${pageContext.request.contextPath}/images/default.jpg'">
                    <div>
                        <h5>${motorcycle.Model}</h5>
                        <h7>Phân loại: ${motorcycle.CategoryName}</h7><br>
                        <h7>Số lượng: ${motorcycle.Quantity}</h7>
                        <p>${text}</p>  
                    </div>
                </c:forEach>
            </div>
            <form class="feedback-form" id="feedback-form" action="feedback" method="post">
                <input type="hidden" name="bookingId" value="${booking.bookingID}" />
                <div class="rating-section">
                    <label for="product-quality">Chất lượng sản phẩm</label>
                    <div id="product-quality" class="rating d-flex">
                        <span class="star ${fb.productRate >= 1 ? 'selected' : ''}" name="product" data-value="1">&#9733;</span>
                        <span class="star ${fb.productRate >= 2 ? 'selected' : ''}" name="product" data-value="2">&#9733;</span>
                        <span class="star ${fb.productRate >= 3 ? 'selected' : ''}" name="product" data-value="3">&#9733;</span>
                        <span class="star ${fb.productRate >= 4 ? 'selected' : ''}" name="product" data-value="4">&#9733;</span>
                        <span class="star ${fb.productRate >= 5 ? 'selected' : ''}" name="product" data-value="5">&#9733;</span>
                    </div>
                    <span class="rating-text"></span>
                </div>
                <div class="service-rating">
                    <label for="service-rating">Dịch vụ của chúng tôi</label>
                    <div id="service-rating" class="rating d-flex">
                        <span class="star ${fb.serviceRate >= 1 ? 'selected' : ''}" data-value="1" name="service">&#9733;</span>
                        <span class="star ${fb.serviceRate >= 2 ? 'selected' : ''}" data-value="2" name="service">&#9733;</span>
                        <span class="star ${fb.serviceRate >= 3 ? 'selected' : ''}" data-value="3" name="service">&#9733;</span>
                        <span class="star ${fb.serviceRate >= 4 ? 'selected' : ''}" data-value="4" name="service">&#9733;</span>
                        <span class="star ${fb.serviceRate >= 5 ? 'selected' : ''}" name="service" data-value="5">&#9733;</span>
                    </div>
                    <span class="rating-text"></span>
                </div>
                <div class="delivery-speed">
                    <label for="delivery-speed">Tốc độ giao hàng</label>
                    <div id="delivery-speed" class="rating d-flex">
                        <span class="star ${fb.deliveryRate >= 1 ? 'selected' : ''}" data-value="1" name="delivery">&#9733;</span>
                        <span class="star ${fb.deliveryRate >= 2 ? 'selected' : ''}" data-value="2" name="delivery">&#9733;</span>
                        <span class="star ${fb.deliveryRate >= 3 ? 'selected' : ''}" data-value="3" name="delivery">&#9733;</span>
                        <span class="star ${fb.deliveryRate >= 4 ? 'selected' : ''}" data-value="4" name="delivery">&#9733;</span>
                        <span class="star ${fb.deliveryRate >= 5 ? 'selected' : ''}" data-value="5" name="delivery">&#9733;</span>
                    </div>
                    <span class="rating-text"></span>
                </div>

                <div class="additional-feedback">
                    <label for="general-feedback">Nhận xét chung:</label>
                    <textarea id="general-feedback" name="content" style="margin-top: 12px; width: 100%; height: 128px;" value="${fb.content}" placeholder="Hãy chia sẻ nhận xét cho sản phẩm này bạn nhé!">${fb.content}</textarea>
                </div>

                <div id="submit-feedback" class="submit-section">
                    <c:if test="${fb.productRate == null && fb.serviceRate == null && fb.deliveryRate == null}">
                        <button type="submit" onclick="submitForm()">Gửi</button>
                    </c:if>
                    <c:if test="${fb.productRate != null && fb.serviceRate != null && fb.deliveryRate != null}">
                        <button onclick="submitForm()" type="button" id="edit-feedback">Sửa đánh giá</button>
                    </c:if>
                    <button type="button" onclick="closeFeedback()">Quay về</button>
                </div>
                <input type="hidden" id="productRating" name="product" value="${fb.productRate}">
                <input type="hidden" id="serviceRating" name="service" value="${fb.serviceRate}">
                <input type="hidden" id="deliveryRating" name="delivery" value="${fb.deliveryRate}">
            </form>
        </div>

        <!-- Modal -->
        <div id="modal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <p id="modal-message"></p>
            </div>
        </div>

        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', () => {

                const stars = document.querySelectorAll('.rating .star');
                const ratingTexts = {
                    1: 'Tệ',
                    2: 'Kém',
                    3: 'Bình thường',
                    4: 'Tốt',
                    5: 'Tuyệt vời'
                };
                stars.forEach(star => {
                    star.addEventListener('mouseover', () => {
                        const ratingValue = star.getAttribute('data-value');
                        const parent = star.parentElement;
                        let siblings = parent.children;
                        for (let sibling of siblings) {
                            sibling.classList.remove('hovered');
                            if (sibling.getAttribute('data-value') <= ratingValue) {
                                sibling.classList.add('hovered');
                            }
                        }
                    });
                    star.addEventListener('mouseleave', () => {
                        stars.forEach(s => s.classList.remove('hovered'));
                    });
                    star.addEventListener('click', () => {
                        const ratingValue = star.getAttribute('data-value');
                        const parent = star.parentElement;
                        const ratingText = parent.nextElementSibling;
                        let siblings = parent.children;
                        for (let sibling of siblings) {
                            sibling.classList.remove('selected');
                            if (sibling.getAttribute('data-value') <= ratingValue) {
                                sibling.classList.add('selected');
                            }
                        }

                        ratingText.textContent = ratingTexts[ratingValue];
                        ratingText.style.opacity = 1;
                        const ratingType = star.getAttribute('name'); // Lấy loại đánh giá từ name
                        const hiddenInput = document.getElementById(ratingType + 'Rating'); // Đặt id cho input ẩn là productRating, serviceRating, deliveryRating, v.v...
                        if (hiddenInput) {
                            hiddenInput.value = ratingValue;
                        }
                    });
                });
            });
            function closeFeedback() {
                window.location.href = 'bookingHistory?status=all';
            }

            const iconLoading = document.getElementById("loading");
            const showLoading = () => {
                iconLoading.style.display = "flex";
            };

            function submitForm() {
                showLoading();
                document.getElementById('feedback-form').submit();
            }
        </script>
    </body>
</html>


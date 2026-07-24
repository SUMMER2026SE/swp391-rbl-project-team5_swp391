<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <title>Liên hệ</title>
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
        <jsp:include page="/includes/customer/header.jsp" />
        <style>
            body {
                background-color: #fbfaf8 !important;
                color: #2b2824 !important;
                font-family: 'Plus Jakarta Sans', sans-serif;
            }
            
            /* Section Title Styling */
            .section-title h2 {
                color: #1a1816 !important;
                font-family: 'Playfair Display', Georgia, serif !important;
                font-weight: 800;
                letter-spacing: 2px;
                text-transform: uppercase;
                margin-top: 10px;
                text-align: center;
            }
            .section-title span {
                color: rgba(181, 147, 73, 0.08) !important;
                font-family: 'Playfair Display', Georgia, serif !important;
                font-weight: 800;
                font-size: 52px;
                text-transform: uppercase;
                letter-spacing: 4px;
                display: block;
                text-align: center;
            }
            .section-title p {
                color: #666666 !important;
                text-align: center;
                font-size: 1.1rem;
                max-width: 600px;
                margin: 0 auto;
                line-height: 1.6;
            }

            /* contact form styling */
            .contact-form .form-group {
                justify-content: center;
                margin-bottom: 22px; 
            }
            .contact-form {
                background-color: #ffffff !important;
                border: 1px solid #eae6df !important;
                border-radius: 12px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.03);
                padding: 40px !important;
            }
            .contact-form .form-control {
                background-color: #ffffff !important;
                border: 1px solid #eae6df !important;
                color: #2b2824 !important;
                border-radius: 8px;
                padding: 12px 18px;
                height: auto;
                transition: all 0.3s ease;
            }
            .contact-form .form-control::placeholder {
                color: #999999 !important;
            }
            .contact-form .form-control:focus {
                border-color: #b59349 !important;
                box-shadow: 0 0 10px rgba(181, 147, 73, 0.2) !important;
                background-color: #ffffff !important;
            }

            /* contact info cards styling */
            .contact-info .icon {
                font-size: 26px; 
                margin-right: 15px; 
                color: #b59349 !important; 
            }

            .contact-info .border {
                display: flex;
                align-items: center; 
                padding: 25px 30px !important; 
                border-radius: 16px; 
                background-color: #ffffff !important; 
                border: 1px solid rgba(181, 147, 73, 0.1) !important;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.03);
                transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                position: relative;
                overflow: hidden;
                z-index: 2;
            }
            .contact-info .border::before {
                content: '';
                position: absolute;
                top: 0; left: 0; right: 0; bottom: 0;
                border-radius: 16px;
                padding: 2px;
                background: linear-gradient(135deg, rgba(181, 147, 73, 0.4), rgba(181, 147, 73, 0));
                -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                -webkit-mask-composite: xor;
                mask-composite: exclude;
                opacity: 0;
                transition: opacity 0.4s ease;
            }
            .contact-info .border:hover {
                transform: translateY(-8px);
                box-shadow: 0 20px 40px rgba(181, 147, 73, 0.12);
                border-color: rgba(181, 147, 73, 0.3) !important;
            }
            .contact-info .border:hover::before {
                opacity: 1;
            }
            .contact-info .border:hover .icon i {
                transform: scale(1.15);
                color: #a38241;
            }
            .contact-info .icon i {
                transition: transform 0.3s ease, color 0.3s ease;
            }

            .premium-label {
                display: block;
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 3px;
                color: #999999;
                margin-bottom: 10px;
                font-weight: 500;
            }

            .contact-form .form-control {
                border: none !important;
                border-bottom: 1px solid #eae6df !important;
                border-radius: 0 !important;
                padding: 10px 0 !important;
                height: auto !important;
                background-color: transparent !important;
                color: #1a1816 !important;
                font-size: 1.05rem !important;
                transition: border-color 0.3s ease !important;
                box-shadow: none !important;
            }
            .contact-form .form-control:focus {
                border-bottom: 1px solid #b59349 !important;
                box-shadow: none !important;
                background-color: transparent !important;
                outline: none !important;
            }
            .contact-form .form-control::placeholder {
                color: #b3b3b3 !important;
                font-weight: 300;
            }

            .contact-form-container {
                background: #ffffff;
                padding: 45px 40px;
                border-radius: 20px;
                box-shadow: 0 15px 50px rgba(0, 0, 0, 0.05);
                border: 1px solid rgba(181, 147, 73, 0.08);
            }

            .contact-form .btn-primary {
                color: #b59349 !important;
                text-decoration: none;
                transition: color 0.3s ease;
            }
            .contact-info p a:hover {
                color: #a38241 !important;
            }
            .contact-info p span {
                font-weight: 700;
                color: #1a1816;
                display: block;
                margin-bottom: 3px;
            }

            .contact-info .row > .col-md-12 {
                margin-bottom: 20px; 
            }

            /* Google Maps Frame */
            .container iframe {
                width: 100%; 
                border: 1px solid #eae6df !important; 
                border-radius: 12px; 
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.03);
            }

            .hero-wedding-style {
                position: relative;
                width: 100%;
                padding: 110px 0 90px 0;
                background: linear-gradient(135deg, #1a1816 0%, #2b2824 100%); /* Nền tối gradient sang trọng */
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                margin-top: 75px;
                border-bottom: 3px solid #b59349;
            }

            .hero-content {
                position: relative;
                z-index: 3;
                max-width: 800px;
                padding: 0 20px;
                color: #ffffff; /* Chữ trắng */
            }

            .contact-form .btn-primary {
                background: #b59349 !important; 
                border: none !important; 
                color: #ffffff !important;
                font-weight: 700;
                padding: 16px 35px; 
                border-radius: 12px; 
                transition: all 0.3s ease; 
                text-transform: uppercase;
                letter-spacing: 2px;
                font-size: 14px;
                box-shadow: 0 8px 20px rgba(181, 147, 73, 0.2);
                width: 100%;
            }

            .contact-form .btn-primary:hover {
                background: #a38241 !important; 
                transform: translateY(-3px); 
                box-shadow: 0 12px 25px rgba(181, 147, 73, 0.35) !important;
            }

            @media (max-width: 768px) {
                .contact-info .border {
                    flex-direction: column; 
                    align-items: flex-start; 
                }

                .contact-info .icon {
                    margin-bottom: 10px; 
                }
            }

            .animate__animated {
                visibility: hidden;
            }
            .animate__animated.animate__fadeInUp {
                visibility: visible;
            }
        </style>
    </head>

    <body>

        <jsp:include page="/includes/customer/navbar.jsp" />


        <div>

            <!-- Premium Header Section -->
            <section class="hero-wedding-style">
                <div class="hero-content" data-aos="fade-up" data-aos-duration="1500">
                    <div style="display: inline-flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                        <div style="height: 1px; width: 40px; background: rgba(181, 147, 73, 0.8);"></div>
                        <span style="color: #b59349; font-size: 14px; font-weight: 800; letter-spacing: 4px; text-transform: uppercase; font-family: 'Plus Jakarta Sans', sans-serif;">Hỗ trợ 24/7</span>
                        <div style="height: 1px; width: 40px; background: rgba(181, 147, 73, 0.8);"></div>
                    </div>
                    <h1 style="color: #ffffff; font-family: 'Playfair Display', serif; font-weight: 800; font-size: 4rem; margin-bottom: 20px; letter-spacing: 1px;">Liên Hệ <span style="color: #b59349;">SmartRide</span></h1>
                    <p style="color: rgba(255,255,255,0.8); font-size: 1.15rem; max-width: 600px; margin: 0 auto; line-height: 1.7; font-weight: 300;">
                        Bạn có câu hỏi hoặc cần hỗ trợ? Đừng ngần ngại để lại lời nhắn, đội ngũ tư vấn viên của chúng tôi luôn sẵn sàng hỗ trợ bạn một cách nhanh chóng nhất.
                    </p>
                </div>
            </section>
            
            <section class="ftco-section contact-section animate__animated animate__fadeInUp" style="padding-top: 40px;">
                <div class="container">
                    <c:choose>
                        <c:when test="${not empty msg}">
                            <!-- Giao diện báo thành công (Success State) -->
                            <div class="row d-flex mb-5 align-items-center" data-aos="fade-up" data-aos-duration="1000" style="background: #ffffff; padding: 70px 40px; border-radius: 24px; box-shadow: 0 20px 60px rgba(0,0,0,0.04); margin-top: -80px; position: relative; z-index: 10;">
                                <div class="col-md-6 text-center pe-lg-5" style="border-right: 1px solid #eae6df;">
                                    <div style="width: 80px; height: 80px; border: 1px solid rgba(181, 147, 73, 0.5); border-radius: 0; display: flex; align-items: center; justify-content: center; margin: 0 auto 30px;">
                                        <i class="fas fa-check" style="font-size: 30px; color: #b59349; font-weight: 300;"></i>
                                    </div>
                                    <h2 style="font-family: 'Playfair Display', serif; font-size: 2.5rem; font-weight: 700; color: #1a1816; margin-bottom: 20px;">Cảm ơn bạn đã liên hệ!</h2>
                                    <p style="color: #666; font-size: 1.05rem; line-height: 1.8; margin-bottom: 40px; max-width: 400px; margin-left: auto; margin-right: auto;">
                                        ${msg}
                                    </p>
                                    <a href="contact" style="display: inline-block; padding: 12px 30px; border-bottom: 1px solid #1a1816; color: #1a1816; text-transform: uppercase; font-weight: 700; letter-spacing: 2px; text-decoration: none; font-size: 0.85rem; transition: all 0.3s;" onmouseover="this.style.color='#b59349'; this.style.borderColor='#b59349'" onmouseout="this.style.color='#1a1816'; this.style.borderColor='#1a1816'">
                                        Gửi yêu cầu khác
                                    </a>
                                </div>
                                <div class="col-md-6 ps-lg-5 mt-5 mt-md-0 text-start">
                                    <h3 style="font-family: 'Playfair Display', serif; font-size: 1.8rem; font-weight: 700; color: #1a1816; margin-bottom: 25px;">Điều gì sẽ diễn ra tiếp theo?</h3>
                                    <p style="color: #666; font-size: 1.05rem; line-height: 1.8; margin-bottom: 35px;">
                                        Ngay sau khi nhận được yêu cầu của bạn, đội ngũ tư vấn viên của SmartRide sẽ phân bổ chuyên viên phù hợp nhất để liên hệ và giải đáp mọi thắc mắc của bạn một cách nhanh chóng và chi tiết nhất.
                                    </p>
                                    <div style="display: flex; flex-direction: column; gap: 20px;">
                                        <div style="display: flex; align-items: flex-start; gap: 15px;">
                                            <i class="fas fa-map-marker-alt" style="color: #b59349; font-size: 1.2rem; margin-top: 5px;"></i>
                                            <div>
                                                <span style="display: block; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; color: #999; margin-bottom: 5px;">Địa chỉ văn phòng</span>
                                                <p style="color: #1a1816; margin: 0; line-height: 1.6;">Số 01 Đại lộ Tự Do - Quận Hành Trình - TP. SmartRide</p>
                                            </div>
                                        </div>
                                        <div style="display: flex; align-items: flex-start; gap: 15px;">
                                            <i class="fas fa-phone-alt" style="color: #b59349; font-size: 1.2rem; margin-top: 5px;"></i>
                                            <div>
                                                <span style="display: block; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; color: #999; margin-bottom: 5px;">Số điện thoại</span>
                                                <p style="color: #1a1816; margin: 0; line-height: 1.6;">0824 551 789</p>
                                            </div>
                                        </div>
                                        <div style="display: flex; align-items: flex-start; gap: 15px;">
                                            <i class="fas fa-envelope" style="color: #b59349; font-size: 1.2rem; margin-top: 5px;"></i>
                                            <div>
                                                <span style="display: block; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; color: #999; margin-bottom: 5px;">Email</span>
                                                <p style="color: #1a1816; margin: 0; line-height: 1.6;">smartride.system@gmail.com</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Giao diện Form bình thường -->
                            <div class="row d-flex mb-5 contact-info">
                        <div class="col-md-5">
                            <div class="row mb-5">
                                <div class="col-md-12">
                                    <div class="border w-100 p-4 rounded mb-2 d-flex">
                                        <div class="icon mr-3">
                                            <i class="fas fa-map-marker-alt"></i> <!-- Font Awesome class -->
                                        </div>
                                        <p class="info"><span>Địa Chỉ:</span> Kiệt 144 Hải Phòng, Thanh Bình, Quận Hải Châu, Đà Nẵng</p>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="border w-100 p-4 rounded mb-2 d-flex">
                                        <div class="icon mr-3">
                                            <i class="fas fa-mobile-alt"></i> <!-- Font Awesome class -->
                                        </div>
                                        <p class="info"><span>Số Điện Thoại:</span> <a href="tel://0824551789">0824 551 789</a></p>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="border w-100 p-4 rounded mb-2 d-flex">
                                        <div class="icon mr-3">
                                            <i class="fas fa-envelope"></i> <!-- Font Awesome class -->
                                        </div>
                                        <p class="info"><span>Email:</span> <a href="mailto:smartride.system@gmail.com">smartride.system@gmail.com</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7 block-9 mb-md-5">
                            <div class="contact-form-container">
                                <c:if test="${not empty errorMsg}">
                                    <div class="alert alert-danger" style="border-radius: 10px; background-color: #fdf2f2; color: #d9534f; border: 1px solid #f2dede; padding: 15px; margin-bottom: 25px; font-size: 0.95rem;">
                                        <i class="fas fa-exclamation-triangle" style="margin-right: 8px;"></i> ${errorMsg}
                                    </div>
                                </c:if>
                                <form action="contact" method="post" class="contact-form">
                                    <!-- Honeypot field for spam prevention -->
                                    <div style="display:none; visibility:hidden;">
                                        <input type="text" name="website_url_honeypot" value="" autocomplete="off" tabindex="-1">
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 form-group mb-4">
                                            <label class="premium-label">Họ & Tên *</label>
                                            <input type="text" name="name" class="form-control" placeholder="Họ & tên của bạn" required>
                                        </div>
                                        <div class="col-md-6 form-group mb-4">
                                            <label class="premium-label">Số điện thoại *</label>
                                            <input type="text" name="phone" class="form-control" placeholder="0123 456 789" required>
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-6 form-group mb-4">
                                            <label class="premium-label">Địa chỉ Email *</label>
                                            <input type="email" name="email" class="form-control" placeholder="email@domain.com" required>
                                        </div>
                                        <div class="col-md-6 form-group mb-4">
                                            <label class="premium-label">Tiêu Đề *</label>
                                            <input type="text" name="title" class="form-control" placeholder="Bạn cần hỗ trợ về vấn đề gì?" required>
                                        </div>
                                    </div>
                                    <div class="form-group mb-4 mt-2">
                                        <label class="premium-label">Nội dung *</label>
                                        <textarea name="message" id="" cols="30" rows="5" class="form-control" placeholder="Nội dung lời nhắn của bạn..." required></textarea>
                                    </div>
                                    
                                    <div class="form-group mb-0 mt-4">
                                        <button type="submit" class="btn btn-primary animate__animated animate__fadeInUp w-100">
                                            Gửi Yêu Cầu <i class="fas fa-paper-plane ms-2"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Iframe Google Maps -->
                    <div class="animate__animated animate__fadeInUp">
                        <iframe
                            src="https://maps.google.com/maps?q=16.0609,108.2057&hl=vi&z=16&output=embed"
                            width="1100" height="400" style="border:0;" allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                    <!-- end map -->

                </div>
            </section>
        </div>

        <jsp:include page="/includes/customer/footer.jsp" />

        <!-- Các tệp JS -->
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
            // Kích hoạt animation khi cuộn
            $(document).ready(function () {
                if (typeof AOS !== 'undefined') {
                    AOS.init({
                        duration: 1000,
                        once: true,
                        offset: 50
                    });
                }
                $('.animate__animated').waypoint(function () {
                    $(this.element).addClass('animate__fadeInUp');
                }, {
                    offset: '75%'
                });
            });
        </script>

    </body>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <title>Chính sách & Điều Khoản</title>
        
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
        <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
        
        <style>
            body {
                background-color: #f8f9fa !important;
                color: #2b2824 !important;
                font-family: 'Plus Jakarta Sans', sans-serif;
            }
            .page-header {
                padding: 60px 0 40px;
                text-align: center;
                background: linear-gradient(to right, #1a1a1a, #2d2d2d);
                color: white;
                margin-bottom: 50px;
                margin-top: 80px;
            }
            .page-header h1 {
                font-family: 'Playfair Display', serif;
                font-weight: 800;
                color: #d4af37;
                margin-bottom: 15px;
            }
            .page-header p {
                color: #ccc;
                max-width: 600px;
                margin: 0 auto;
            }
            
            /* Sidebar Navigation */
            .policy-nav-container {
                position: sticky;
                top: 120px;
                background: #fff;
                border-radius: 15px;
                padding: 20px 0;
                box-shadow: 0 5px 20px rgba(0,0,0,0.03);
            }
            .policy-nav {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .policy-nav li {
                margin: 0;
            }
            .policy-nav li a {
                display: block;
                padding: 12px 25px;
                color: #666;
                text-decoration: none;
                font-weight: 600;
                font-size: 15px;
                border-left: 3px solid transparent;
                transition: all 0.3s ease;
            }
            .policy-nav li a:hover, .policy-nav li.active a {
                color: #b59349;
                background-color: rgba(181, 147, 73, 0.05);
                border-left-color: #b59349;
            }

            /* Content Sections */
            .policy-content-wrapper {
                padding-bottom: 50px;
            }
            .content-section {
                background: #fff;
                border-radius: 15px;
                padding: 40px;
                margin-bottom: 30px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.03);
                border: 2px solid transparent;
                transition: all 0.3s ease;
            }
            .content-section:hover {
                box-shadow: 0 10px 30px rgba(0,0,0,0.06);
                border-color: rgba(181, 147, 73, 0.3);
            }
            .content-section.active-card {
                border-color: #b59349;
                box-shadow: 0 10px 30px rgba(181, 147, 73, 0.15);
            }
            .content-section h3 {
                font-size: 26px;
                color: #1a1a1a;
                font-family: 'Playfair Display', serif;
                font-weight: 700;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 2px solid rgba(181, 147, 73, 0.2);
                display: inline-block;
            }
            .content-section p {
                color: #555;
                line-height: 1.8;
                font-size: 15px;
                margin-bottom: 0;
            }
            .content-section b {
                color: #333;
                font-weight: 700;
                display: inline-block;
                margin-top: 10px;
            }

            @media (max-width: 991px) {
                .policy-nav-container {
                    position: static;
                    margin-bottom: 30px;
                }
            }
        </style>
    </head>

    <body>
        <div>
            <jsp:include page="/includes/customer/navbar.jsp" />
        </div>
        
        <div class="page-header animate__animated animate__fadeInDown">
            <div class="container">
                <h1>Chính sách & Điều khoản</h1>
                <p>Khám phá các quy định và cam kết của SmartRide nhằm mang lại trải nghiệm dịch vụ an toàn, minh bạch và tốt nhất cho bạn.</p>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-lg-3">
                    <div class="policy-nav-container animate__animated animate__fadeInLeft">
                        <ul class="policy-nav">
                            <li><a href="#Section0">Giới thiệu</a></li>
                            <li><a href="#Section1">Đăng ký và Tài khoản</a></li>
                            <li><a href="#Section2">Điều khoản Thuê xe</a></li>
                            <li><a href="#Section3">Sử dụng Xe</a></li>
                            <li><a href="#Section4">Bảo hiểm & Trách nhiệm</a></li>
                            <li><a href="#Section5">Hủy bỏ & Hoàn tiền</a></li>
                            <li><a href="#Section6">Quyền riêng tư</a></li>
                            <li><a href="#Section7">Thay đổi Điều khoản</a></li>
                            <li><a href="#Section8">Liên hệ</a></li>
                        </ul>
                    </div>
                </div>

                <!-- Content -->
                <div class="col-lg-9">
                    <div class="policy-content-wrapper">
                        
                        <div id="Section0" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Giới thiệu</h3>
                            <p>Chào mừng bạn đến với SmartRide! Trang web của chúng tôi cung cấp dịch vụ cho thuê xe máy nhằm giúp bạn dễ dàng di chuyển và khám phá. Vui lòng đọc kỹ các điều khoản và điều kiện dưới đây trước khi sử dụng dịch vụ của chúng tôi.</p>
                        </div>
                        
                        <div id="Section1" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Đăng ký và Tài khoản</h3>
                            <p>
                                <b>Đăng ký Tài khoản:</b> Người dùng phải đăng ký một tài khoản hợp lệ trên trang web SmartRide để sử dụng dịch vụ cho thuê xe.<br>
                                <b>Bảo mật Tài khoản:</b> Người dùng có trách nhiệm bảo mật thông tin tài khoản của mình. SmartRide không chịu trách nhiệm cho bất kỳ thiệt hại nào phát sinh do việc lạm dụng tài khoản.
                            </p>
                        </div>
                        
                        <div id="Section2" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Điều khoản Thuê xe</h3>
                            <p>
                                <b>Điều kiện Thuê xe:</b> Người thuê xe phải có bằng lái xe hợp lệ và đủ 18 tuổi trở lên.<br>
                                <b>Quá trình Thuê xe:</b> Người dùng có thể đặt xe trực tuyến thông qua trang web của chúng tôi. Một khi đặt xe, người dùng sẽ nhận được xác nhận qua email với thông tin chi tiết về xe và thời gian thuê.<br>
                                <b>Thanh toán:</b> Thanh toán phải được thực hiện trước khi nhận xe. Chúng tôi chấp nhận các phương thức thanh toán qua thẻ tín dụng, thẻ ghi nợ, và các ví điện tử hợp lệ.
                            </p>
                        </div>
                        
                        <div id="Section3" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Sử dụng Xe</h3>
                            <p>
                                <b>Sử dụng An toàn:</b> Người dùng phải tuân thủ tất cả các luật giao thông hiện hành và đảm bảo an toàn khi sử dụng xe.<br>
                                <b>Bảo quản Xe:</b> Người dùng có trách nhiệm bảo quản xe trong suốt thời gian thuê. Mọi hư hại hoặc mất mát phải được báo cáo ngay lập tức cho SmartRide.<br>
                                <b>Trả Xe:</b> Xe phải được trả đúng giờ và đúng địa điểm quy định. Trả xe muộn sẽ bị tính phí thêm theo quy định của SmartRide.
                            </p>
                        </div>
                        
                        <div id="Section4" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Bảo hiểm và Trách nhiệm</h3>
                            <p>
                                <b>Bảo hiểm:</b> SmartRide cung cấp bảo hiểm cơ bản cho xe thuê. Người dùng có thể mua thêm các gói bảo hiểm mở rộng nếu cần.<br>
                                <b>Trách nhiệm:</b> Người dùng chịu trách nhiệm pháp lý cho mọi hành động và hậu quả phát sinh từ việc sử dụng xe thuê.
                            </p>
                        </div>
                        
                        <div id="Section5" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Hủy Bỏ và Hoàn Tiền</h3>
                            <p>
                                <b>Chính sách Hủy bỏ:</b> Người dùng có thể hủy đơn hàng mà không mất phí trước 24 giờ so với thời gian nhận xe.<br>
                                <b>Hoàn Tiền:</b> Hoàn tiền sẽ được xử lý trong vòng 7 ngày làm việc sau khi yêu cầu hủy bỏ được xác nhận.
                            </p>
                        </div>
                        
                        <div id="Section6" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Quyền riêng tư</h3>
                            <p>
                                <b>Bảo vệ Thông tin:</b> Chúng tôi cam kết bảo vệ thông tin cá nhân của người dùng và chỉ sử dụng thông tin này theo các mục đích hợp pháp liên quan đến dịch vụ của chúng tôi.<br>
                                <b>Chia sẻ Thông tin:</b> Chúng tôi không bán, cho thuê hoặc chia sẻ thông tin cá nhân của người dùng cho bên thứ ba ngoài các mục đích được quy định trong chính sách bảo vệ thông tin.
                            </p>
                        </div>
                        
                        <div id="Section7" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Thay đổi Điều khoản</h3>
                            <p>
                                <b>Cập nhật Điều khoản:</b> Chúng tôi có quyền điều chỉnh và cập nhật Điều khoản và Điều kiện này vào bất kỳ lúc nào. Người dùng nên xem lại các điều khoản này thường xuyên để cập nhật thông tin mới nhất.
                            </p>
                        </div>
                        
                        <div id="Section8" class="content-section" data-aos="fade-up" data-aos-duration="800">
                            <h3>Liên hệ</h3>
                            <p>
                                <b>Hỗ trợ Khách hàng:</b> Nếu có bất kỳ câu hỏi hoặc thắc mắc nào về các điều khoản và điều kiện này, vui lòng liên hệ với chúng tôi qua email hoặc số điện thoại được cung cấp trên trang web của chúng tôi.
                            </p>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/includes/customer/footer.jsp" />

        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
        <script src="js/main.js"></script>
        
        <script>
            // Initialize AOS
            AOS.init({
                once: false,
                offset: 100
            });
            // Highlight active menu item and card on scroll
            $(window).scroll(function() {
                var scrollDistance = $(window).scrollTop() + 200;
                var hasActive = false;
                
                $('.content-section').each(function(i) {
                    if ($(this).position().top <= scrollDistance) {
                        $('.policy-nav li.active').removeClass('active');
                        $('.policy-nav li').eq(i).addClass('active');
                        
                        $('.content-section.active-card').removeClass('active-card');
                        $(this).addClass('active-card');
                        hasActive = true;
                    }
                });
                
                // If scrolled to top before any section, remove active classes
                if (!hasActive && scrollDistance < $('.content-section').first().position().top) {
                    $('.content-section.active-card').removeClass('active-card');
                    $('.policy-nav li.active').removeClass('active');
                }
            }).scroll();
            
            // Highlight card when clicked directly
            $('.content-section').on('click', function() {
                $('.content-section.active-card').removeClass('active-card');
                $(this).addClass('active-card');
            });
            
            // Smooth scrolling logic for the sidebar clicks with offset
            $('.policy-nav a').on('click', function(e) {
                e.preventDefault();
                var target = $(this.hash);
                if (target.length) {
                    $('html, body').animate({
                        scrollTop: target.offset().top - 180 // Increased offset for the fixed navbar
                    }, 500);
                    
                    // Update URL without jumping
                    if (history.pushState) {
                        history.pushState(null, null, this.hash);
                    }
                    
                    // Also update active state immediately
                    $('.policy-nav li.active').removeClass('active');
                    $(this).parent().addClass('active');
                    
                    $('.content-section.active-card').removeClass('active-card');
                    target.addClass('active-card');
                }
            });
        </script>
    </body>
</html>

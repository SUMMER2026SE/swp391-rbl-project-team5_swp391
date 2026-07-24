<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Về Chúng Tôi - SmartRide</title>
        <link rel="stylesheet"
              href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;1,400&family=Plus+Jakarta+Sans:wght@300;400;500&display=swap" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        
        <style>
            :root {
                --primary: #b59349;
                --text-dark: #1a1816;
                --text-body: #666666;
                --bg-light: #ffffff;
                --white: #ffffff;
            }

            body {
                background-color: var(--bg-light) !important;
                color: var(--text-body) !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                overflow-x: hidden;
            }

            h1, h2, h3, h4, h5, h6 {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                color: var(--text-dark) !important;
                font-weight: 800;
                letter-spacing: -0.5px;
            }

            .noidung {
                padding-top: 0;
                margin-top: 75px; 
            }

            /* --- HERO SECTION --- */
            .hero-wedding-style {
                position: relative;
                width: 100%;
                height: 80vh;
                min-height: 600px;
                /* Sử dụng ảnh đen tĩnh mịch tạo sự sang trọng */
                background: url('images/gen_gallery_2.png') center/cover no-repeat;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
            }

            .hero-fade-bottom {
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 100%;
                height: 300px;
                background: linear-gradient(to bottom, rgba(255,255,255,0) 0%, rgba(255,255,255,1) 100%);
                z-index: 2;
            }

            /* Lớp phủ tối hơn cho ảnh Hero nổi bật chữ trắng */
            .hero-overlay {
                position: absolute;
                top: 0; left: 0; width: 100%; height: 100%;
                background: rgba(0, 0, 0, 0.6);
                z-index: 1;
            }

            .hero-content {
                position: relative;
                z-index: 3;
                max-width: 800px;
                padding: 0 20px;
                color: var(--white);
            }
            
            .hero-subtitle {
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 0.9rem;
                letter-spacing: 4px;
                text-transform: uppercase;
                margin-bottom: 20px;
                display: block;
                color: var(--primary);
                font-weight: 500;
            }

            .hero-content h1 {
                font-size: 4rem;
                font-weight: 800;
                color: var(--white) !important;
                margin-bottom: 15px;
                text-shadow: 2px 2px 10px rgba(0,0,0,0.5);
                text-transform: uppercase;
            }

            .hero-divider {
                width: 40px;
                height: 2px;
                background-color: var(--primary);
                margin: 20px auto 30px auto;
            }

            .hero-content p {
                font-size: 1.1rem;
                font-weight: 300;
                letter-spacing: 1px;
                color: rgba(255,255,255,0.9);
                text-shadow: 1px 1px 5px rgba(0,0,0,0.8);
            }


            /* --- MASONRY & GENERAL --- */
            .section-padding {
                padding: 100px 0;
            }

            .story-subtitle {
                font-size: 0.8rem;
                letter-spacing: 3px;
                text-transform: uppercase;
                color: var(--primary);
                margin-bottom: 15px;
                display: block;
            }

            .story-title {
                font-size: 3rem;
                line-height: 1.2;
                margin-bottom: 30px;
                font-weight: 800;
            }

            .story-text {
                font-size: 1.05rem;
                line-height: 1.8;
                font-weight: 300;
                margin-bottom: 20px;
            }

            /* Fix lỗi cắt ảnh: Dùng object-fit contain cho các ảnh xe trên nền trắng để không bị mất góc */
            .masonry-grid {
                display: grid;
                grid-template-columns: 1.5fr 1fr;
                gap: 20px;
                height: 600px;
            }

            .masonry-main {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 4px;
            }

            .masonry-side {
                display: flex;
                flex-direction: column;
                gap: 20px;
                height: 100%;
            }

            .masonry-side img {
                width: 100%;
                height: calc(50% - 10px);
                /* Contain giúp ảnh xe ko bị cắt đầu/đuôi */
                object-fit: contain; 
                border-radius: 4px;
                background-color: #fbfaf8; /* Tạo nền nhẹ cho ảnh xe */
            }


            /* --- MINIMALIST VALUES (3 Columns) with Hover --- */
            .values-section {
                padding: 80px 0 120px;
                background-color: #faf9f7; 
                text-align: center;
            }

            .values-header {
                margin-bottom: 80px;
            }

            /* Hiệu ứng Đổi màu khi Trỏ chuột (Hover Invert) */
            .value-item {
                padding: 40px 30px;
                text-align: left;
                border-left: 1px solid rgba(0,0,0,0.08);
                height: 100%;
                transition: all 0.4s ease;
                background-color: transparent;
                cursor: default;
            }

            .value-item:hover {
                background-color: #000000;
            }

            .value-number {
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-weight: 800;
                font-size: 3rem;
                color: rgba(181, 147, 73, 0.4);
                margin-bottom: 15px;
                display: block;
                transition: color 0.4s ease;
            }

            .value-title {
                font-size: 1.5rem;
                margin-bottom: 15px;
                font-weight: 700;
                transition: color 0.4s ease;
                letter-spacing: -0.5px;
            }

            .value-desc {
                font-size: 0.95rem;
                line-height: 1.8;
                font-weight: 300;
                transition: color 0.4s ease;
            }

            .value-item:hover .value-number {
                color: var(--primary);
            }
            .value-item:hover .value-title, 
            .value-item:hover .value-desc {
                color: #ffffff !important;
            }

            @media (min-width: 992px) {
                .col-lg-4:first-child .value-item { border-left: none; }
            }


            /* --- FULL WIDTH GALLERY --- */
            .gallery-container {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                width: 100%;
                gap: 15px;
                padding: 0 15px;
                margin-bottom: 60px;
            }

            .gallery-img-wrapper {
                position: relative;
                overflow: hidden;
                padding-top: 130%; 
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.08);
                background-color: #f8f9fa;
            }

            .gallery-img-wrapper img {
                position: absolute;
                top: 0; left: 0;
                width: 100%; height: 100%;
                object-fit: cover !important;
                border-radius: 0 !important; /* Force reset any inline border radius */
                transition: transform 0.6s cubic-bezier(0.165, 0.84, 0.44, 1);
            }

            .gallery-img-wrapper:hover img {
                transform: scale(1.08);
            }

            .btn-book {
                display: inline-block;
                background: #1a1816;
                color: #fff !important;
                padding: 15px 40px;
                letter-spacing: 2px;
                font-size: 0.85rem;
                text-transform: uppercase;
                text-decoration: none;
                margin-top: 30px;
                transition: all 0.3s;
            }

            .btn-book:hover {
                background: var(--primary);
            }

            .mission-vision-card {
                background: white;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 15px 40px rgba(0,0,0,0.04);
                height: 100%;
                transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                position: relative;
                z-index: 2;
                overflow: hidden;
            }
            .mission-vision-card.primary-border {
                border-top: 4px solid var(--primary);
            }
            .mission-vision-card.dark-border {
                border-top: 4px solid #1a1816;
            }
            .mission-vision-card::before {
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
            .mission-vision-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 20px 40px rgba(181, 147, 73, 0.15);
            }
            .mission-vision-card:hover::before {
                opacity: 1;
            }

            .mission-icon-box {
                width: 70px;
                height: 70px;
                background: rgba(181, 147, 73, 0.1);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 25px;
                transition: all 0.4s ease;
            }
            .mission-vision-card.dark-border .mission-icon-box {
                background: rgba(26, 24, 22, 0.05);
            }
            .mission-vision-card:hover .mission-icon-box {
                background: linear-gradient(135deg, #c4a14b, #b59349);
                transform: scale(1.1) rotate(5deg);
                box-shadow: 0 10px 20px rgba(181, 147, 73, 0.3);
            }
            .mission-vision-card:hover .mission-icon-box svg {
                stroke: #ffffff !important;
            }
            .mission-icon-box svg {
                transition: stroke 0.4s ease;
            }

            @media (max-width: 991px) {
                .masonry-grid { grid-template-columns: 1fr; height: auto; }
                .masonry-side { flex-direction: row; height: 300px; }
                .value-item { border-left: none; border-bottom: 1px solid rgba(0,0,0,0.08); padding: 30px; margin-bottom: 0; text-align: center; }
                .gallery-container { grid-template-columns: repeat(2, 1fr); }
            }
        </style>

        <jsp:include page="/includes/customer/header.jsp" />
    </head>
    <body>
        <jsp:include page="/includes/customer/navbar.jsp" />
        
        <div class="noidung">
            
            <!-- 1. HERO SECTION -->
            <section class="hero-wedding-style">
                <div class="hero-overlay"></div>
                <div class="hero-content" data-aos="fade-up" data-aos-duration="1500">
                    <span class="hero-subtitle">Về Chúng Tôi</span>
                    <h1>Trải Nghiệm SmartRide</h1>
                    <div class="hero-divider"></div>
                    <p>Dịch vụ cho thuê xe máy cao cấp tại Đà Nẵng</p>
                </div>
                <div class="hero-fade-bottom"></div>
            </section>

            <!-- 2. STORY SECTION -->
            <section class="section-padding bg-white">
                <div class="container">
                    <div class="row align-items-center gy-5">
                        <div class="col-lg-6 pe-lg-5" data-aos="fade-right">
                            <span class="story-subtitle">Câu chuyện của chúng tôi</span>
                            <h2 class="story-title">Khởi nguồn từ một chuyến đi</h2>
                            <blockquote class="blockquote" style="font-style: italic; border-left: 4px solid var(--primary); padding-left: 15px; margin-bottom: 25px;">
                                "Sau này, điều ta nhớ nhất không phải là đích đến, mà là những hành trình đã đi qua. Dù là một chuyến đi, một quãng đời trưởng thành hay những đổi thay nội tâm, tất cả đều để lại dấu ấn bằng trải nghiệm và ký ức đẹp đẽ."
                                <footer class="blockquote-footer mt-2" style="font-size: 0.85rem;">Nhà Sáng Lập SmartRide</footer>
                            </blockquote>
                            <p class="story-text">Ý tưởng về SmartRide bắt nguồn từ một khoảnh khắc bất ngờ cách đây vài năm, trong chuyến công tác của nhà sáng lập đến thành phố Đà Nẵng xinh đẹp.</p>
                            <p class="story-text">Do đến sớm hơn dự kiến, anh quyết định khám phá thành phố bằng cách tìm dịch vụ cho thuê xe máy tự lái trên Internet. Tuy nhiên, phải mất hơn 30 phút loay hoay khó khăn mới tìm được một đơn vị cung cấp dịch vụ xe đáng tin cậy tại địa phương.</p>
                            <p class="story-text">Từ trải nghiệm đó, SmartRide chính thức ra đời với một nền tảng website hiện đại. Chúng tôi cam kết mang đến dịch vụ cho thuê xe máy minh bạch, chuyên nghiệp, định hướng trở thành người bạn đồng hành đáng tin cậy của mọi du khách.</p>
                            
                            <a href="home" class="btn-book" style="margin-top: 10px;">Khám Phá Xe Ngay</a>
                        </div>
                        <div class="col-lg-6" data-aos="fade-left">
                            <div class="masonry-grid">
                                <!-- Trả lại các ảnh phong cảnh / xe gốc có sẵn trên web để căn chỉnh lại -->
                                <img src="images/caurong_danang.png" class="masonry-main shadow-sm" alt="SmartRide Experience" style="object-fit: cover;" onerror="this.src='images/gen_masonry_main.png'">
                                <div class="masonry-side">
                                    <!-- Dùng object-fit: cover vì đây là ảnh có nền đẹp -->
                                    <img src="images/gen_masonry_side1.png" class="shadow-sm" alt="SmartRide Premium Bike 1" style="object-fit: cover;" onerror="this.src='images/imageM5.jpg'">
                                    <img src="images/gen_masonry_side2.png" class="shadow-sm" alt="SmartRide Premium Bike 2" style="object-fit: cover;" onerror="this.src='images/imageM9.jpg'">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- 2.5 MISSION & VISION SECTION -->
            <section style="background-color: #faf9f7; padding: 60px 0 100px 0;">
                <div class="container">
                    <div class="row gy-4 justify-content-center">
                        <div class="col-md-5" data-aos="fade-up">
                            <div class="mission-vision-card primary-border">
                                <div class="mission-icon-box">
                                    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <circle cx="12" cy="12" r="6"></circle>
                                        <circle cx="12" cy="12" r="2"></circle>
                                    </svg>
                                </div>
                                <h3 class="mb-3 text-center" style="color: var(--text-dark); font-weight: 800;">Sứ Mệnh</h3>
                                <p class="story-text text-center mb-0" style="font-size: 1.05rem;">Cung cấp dịch vụ thuê xe máy an toàn – minh bạch – dễ tiếp cận, đồng hành cùng mọi hành trình khám phá Việt Nam của khách hàng với trải nghiệm chuyên nghiệp và tin cậy nhất.</p>
                            </div>
                        </div>
                        <div class="col-md-5" data-aos="fade-up" data-aos-delay="100">
                            <div class="mission-vision-card dark-border">
                                <div class="mission-icon-box">
                                    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#1a1816" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"></path>
                                        <circle cx="12" cy="12" r="3"></circle>
                                    </svg>
                                </div>
                                <h3 class="mb-3 text-center" style="color: var(--text-dark); font-weight: 800;">Tầm Nhìn</h3>
                                <p class="story-text text-center mb-0" style="font-size: 1.05rem;">Trở thành thương hiệu dẫn đầu trong lĩnh vực cho thuê xe máy tự lái tại miền Trung Việt Nam, xây dựng tiêu chuẩn mới về chất lượng dịch vụ trong ngành du lịch và di chuyển cá nhân.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- 3. TEAM SECTION (Đội Ngũ - Bổ sung theo yêu cầu) -->
            <section class="section-padding bg-white pt-0">
                <div class="container text-center">
                    <div data-aos="fade-up">
                        <span class="story-subtitle">Đội Ngũ</span>
                        <h2 class="story-title">Những người đứng sau tay lái</h2>
                        <p class="story-text mx-auto" style="max-width: 800px; margin-bottom: 50px;">SmartRide sở hữu đội ngũ nhân sự dày dặn kinh nghiệm trong lĩnh vực vận hành và dịch vụ khách hàng, đặc biệt am hiểu nhu cầu và hành vi di chuyển của khách du lịch. Chúng tôi không ngừng cập nhật công nghệ và nâng cấp trải nghiệm người dùng trên cả nền tảng online lẫn offline.</p>
                    </div>
                    
                    <div class="row gy-4 justify-content-center">
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                            <img src="images/team_mechanic.png" alt="Team Member - Mechanic" class="img-fluid rounded-2 shadow-sm" style="height: 400px; object-fit: cover; width: 100%;">
                        </div>
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                            <img src="images/team_support.png" alt="Team Member - Support" class="img-fluid rounded-2 shadow-sm" style="height: 400px; object-fit: cover; width: 100%;">
                        </div>
                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                            <img src="images/team_guide.png" alt="Team Member - Guide" class="img-fluid rounded-2 shadow-sm" style="height: 400px; object-fit: cover; width: 100%;">
                        </div>
                    </div>
                </div>
            </section>

            <!-- 4. MINIMALIST VALUES (Hover effects) -->
            <section class="values-section">
                <div class="container">
                    <div class="values-header" data-aos="fade-up">
                        <span class="story-subtitle">Triết lý dịch vụ</span>
                        <h2 class="story-title" style="font-size: 3rem;">Chúng tôi tin vào điều gì</h2>
                    </div>
                    
                    <div class="row gy-0 align-items-stretch">
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                            <div class="value-item">
                                <span class="value-number">01</span>
                                <h3 class="value-title" style="font-size: 1.3rem;">Chất Lượng & An Toàn</h3>
                                <p class="value-desc">Xe luôn được bảo dưỡng định kỳ, đảm bảo vận hành ổn định và an toàn tuyệt đối cho mọi hành trình khám phá.</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                            <div class="value-item">
                                <span class="value-number">02</span>
                                <h3 class="value-title" style="font-size: 1.3rem;">Đồng Hành & Tận Tâm</h3>
                                <p class="value-desc">Hỗ trợ khách hàng nhanh chóng, chu đáo từ lúc đặt xe đến khi kết thúc chuyến đi, cứu hộ 24/7 trên mọi nẻo đường.</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                            <div class="value-item">
                                <span class="value-number">03</span>
                                <h3 class="value-title" style="font-size: 1.3rem;">Linh Hoạt & Tiện Lợi</h3>
                                <p class="value-desc">Giao – nhận xe linh hoạt tại nhiều điểm, thủ tục tối giản, dễ dàng đặt xe và thanh toán theo cách bạn muốn.</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                            <div class="value-item">
                                <span class="value-number">04</span>
                                <h3 class="value-title" style="font-size: 1.3rem;">Minh Bạch & Đáng Tin</h3>
                                <p class="value-desc">Giá cả rõ ràng, không phụ phí ẩn. Cam kết trung thực trong mọi thông tin và dịch vụ để khách hàng hoàn toàn an tâm.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- 4.5 COMMITMENT SECTION -->
            <section class="section-padding bg-white" style="border-top: 1px solid #eee;">
                <div class="container text-center">
                    <div data-aos="fade-up">
                        <span class="story-subtitle">Lời Hứa Từ SmartRide</span>
                        <h2 class="story-title">Không chỉ là dịch vụ – đó là lời cam kết</h2>
                        <p class="story-text mx-auto" style="max-width: 800px; margin-bottom: 40px;">Với triết lý hoạt động đặt trải nghiệm khách hàng làm trọng tâm, SmartRide tự hào mang đến những chiếc xe chất lượng, dịch vụ chuyên nghiệp và những câu chuyện thành công đầy cảm hứng. Chúng tôi cam kết:</p>
                    </div>
                    <div class="row justify-content-center" data-aos="fade-up" data-aos-delay="100">
                        <div class="col-md-8 col-lg-6 text-start">
                            <ul style="list-style: none; padding: 0; display: flex; flex-direction: column; gap: 15px;">
                                <li style="font-size: 1.1rem; display: flex; align-items: flex-start;">
                                    <span style="color: var(--primary); font-weight: bold; margin-right: 15px; font-size: 1.2rem;">✓</span> 
                                    <span>Giao xe đúng loại – đúng hẹn – đúng địa điểm.</span>
                                </li>
                                <li style="font-size: 1.1rem; display: flex; align-items: flex-start;">
                                    <span style="color: var(--primary); font-weight: bold; margin-right: 15px; font-size: 1.2rem;">✓</span> 
                                    <span>Hỗ trợ nhanh chóng mọi sự cố trong hành trình.</span>
                                </li>
                                <li style="font-size: 1.1rem; display: flex; align-items: flex-start;">
                                    <span style="color: var(--primary); font-weight: bold; margin-right: 15px; font-size: 1.2rem;">✓</span> 
                                    <span>Cung cấp thông tin đầy đủ, minh bạch về dịch vụ.</span>
                                </li>
                                <li style="font-size: 1.1rem; display: flex; align-items: flex-start;">
                                    <span style="color: var(--primary); font-weight: bold; margin-right: 15px; font-size: 1.2rem;">✓</span> 
                                    <span>Không ngừng cải tiến để mang lại giá trị cao nhất cho khách hàng.</span>
                                </li>
                            </ul>
                        </div>
                    </div>

            <!-- 5. FULL WIDTH GALLERY -->
            <section>
                <div class="gallery-container">
                    <div class="gallery-img-wrapper" data-aos="fade-in" data-aos-delay="0">
                        <img src="images/haivan_pass.png" loading="lazy" alt="Đèo Hải Vân" style="object-fit: cover;" onerror="this.src='images/imageM12.jpg'">
                    </div>
                    <div class="gallery-img-wrapper" data-aos="fade-in" data-aos-delay="150">
                        <img src="images/hoian_ancient.png" loading="lazy" alt="Phố cổ Hội An" style="object-fit: cover;" onerror="this.src='images/imageM11.jpg'">
                    </div>
                    <div class="gallery-img-wrapper" data-aos="fade-in" data-aos-delay="300">
                        <img src="images/nguhanhson.png" loading="lazy" alt="Ngũ Hành Sơn" style="object-fit: cover;" onerror="this.src='images/imageM5.jpg'">
                    </div>
                    <div class="gallery-img-wrapper" data-aos="fade-in" data-aos-delay="450">
                        <img src="images/sontra_peninsula.png" loading="lazy" alt="Bán Đảo Sơn Trà" style="object-fit: cover;" onerror="this.src='images/imageM9.jpg'">
                    </div>
                </div>
            </section>

        </div>

        <jsp:include page="/includes/customer/footer.jsp" />
        
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>
        <script src="assets/vendor/aos/aos.js"></script>
        <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
        <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
        <script src="assets/js/main.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                if(typeof AOS !== 'undefined') {
                    AOS.init({
                        duration: 1000,
                        easing: 'ease-out-cubic',
                        once: true,
                        offset: 50
                    });
                }
            });
        </script>
    </body>
</html>

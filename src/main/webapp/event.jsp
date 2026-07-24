<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sự kiện & Khuyến mãi - SmartRide</title>
        
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;1,400&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css"/>
        
        <style>
            :root {
                --primary: #b59349;
                --text-dark: #1a1816;
                --text-body: #666666;
                --bg-light: #fbfaf8;
            }

            body {
                background-color: #fff !important;
                font-family: 'Plus Jakarta Sans', sans-serif;
                color: var(--text-body);
                overflow-x: hidden;
            }

            h1, h2, h3, h4, h5, h6 {
                color: var(--text-dark);
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-weight: 800;
            }

            /* HERO SECTION */
            .hero-wedding-style {
                position: relative;
                width: 100%;
                height: 50vh;
                min-height: 400px;
                background: url('images/gen_gallery_4.png') center/cover no-repeat;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                margin-top: 75px; /* Account for fixed navbar */
            }

            .hero-overlay {
                position: absolute;
                top: 0; left: 0; width: 100%; height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1;
            }

            .hero-content {
                position: relative;
                z-index: 3;
                color: white;
            }

            .hero-subtitle {
                font-size: 0.9rem;
                letter-spacing: 4px;
                text-transform: uppercase;
                color: var(--primary);
                font-weight: 600;
                display: block;
                margin-bottom: 15px;
            }

            .hero-content h1 {
                font-size: 3.5rem;
                color: white !important;
                text-transform: uppercase;
                text-shadow: 2px 2px 10px rgba(0,0,0,0.3);
            }

            .hero-divider {
                width: 40px;
                height: 2px;
                background-color: var(--primary);
                margin: 20px auto;
            }

            .hero-fade-bottom {
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                height: 150px;
                background: linear-gradient(to bottom, rgba(255,255,255,0) 0%, rgba(255,255,255,1) 100%);
                z-index: 2;
            }

            /* SEARCH BAR */
            .search-section {
                margin-top: -35px;
                position: relative;
                z-index: 10;
            }
            .search-box {
                background: white;
                border-radius: 50px;
                padding: 10px 10px 10px 30px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.08);
                display: flex;
                align-items: center;
            }
            .search-box input {
                border: none;
                outline: none;
                width: 100%;
                font-size: 1.1rem;
                color: var(--text-dark);
            }
            .search-box button {
                background: var(--text-dark);
                color: white;
                border: none;
                border-radius: 40px;
                padding: 12px 30px;
                font-weight: 600;
                transition: all 0.3s;
            }
            .search-box button:hover {
                background: var(--primary);
            }

            /* CARDS */
            .event-card {
                border: none;
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.04);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                background: white;
            }
            .event-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.08);
            }
            .btn-read-more {
                background: rgba(181, 147, 73, 0.1);
                color: var(--primary);
                font-weight: 600;
                border-radius: 8px;
                transition: all 0.3s;
            }
            .btn-read-more:hover {
                background: var(--primary);
                color: white;
            }

            /* PAGINATION */
            .pagination .page-link {
                color: var(--text-dark);
                border: none;
                margin: 0 5px;
                border-radius: 8px;
                font-weight: 600;
                padding: 10px 16px;
            }
            .pagination .page-item.active .page-link {
                background-color: var(--primary);
                color: white;
            }
            .pagination .page-link:hover:not(.active) {
                background-color: rgba(181, 147, 73, 0.1);
                color: var(--primary);
            }
        </style>

        <jsp:include page="/includes/customer/header.jsp" />
    </head>
    <body>
        <jsp:include page="/includes/customer/navbar.jsp" />

        <div style="background-color: #ffffff; width: 100%; min-height: 100vh; position: relative;">
            <!-- HERO SECTION -->
        <section class="hero-wedding-style">
            <div class="hero-overlay"></div>
            <div class="hero-content" data-aos="fade-up">
                <span class="hero-subtitle">Cập nhật mới nhất</span>
                <h1>Sự kiện & Khuyến mãi</h1>
                <div class="hero-divider"></div>
            </div>
            <div class="hero-fade-bottom"></div>
        </section>

        <!-- SEARCH SECTION -->
        <section class="search-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8" data-aos="fade-up" data-aos-delay="100">
                        <form action="searchevent" method="get" class="search-box">
                            <i class="ri-search-line me-2 fs-4 text-muted"></i>
                            <input type="text" placeholder="Tìm kiếm sự kiện, ưu đãi..." name="textSearch" value="${textSearch}">
                            <button type="submit">Tìm kiếm</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- EVENTS GRID -->
        <section class="py-5 mt-4">
            <div class="container">
                <c:if test="${empty listEvent}">
                    <div class="text-center py-5" data-aos="fade-up">
                        <img src="images/gen_hero.png" alt="No events" style="width: 200px; opacity: 0.5; border-radius: 20px; margin-bottom: 20px;">
                        <h3 class="text-muted">Hiện tại chưa có sự kiện nào</h3>
                        <p>Vui lòng quay lại sau để nhận những ưu đãi hấp dẫn nhất từ SmartRide!</p>
                        <a href="home" class="btn btn-dark mt-3 px-4 py-2" style="border-radius: 50px;">Về Trang Chủ</a>
                    </div>
                </c:if>

                <div class="row gy-4">
                    <c:forEach items="${listEvent}" var="event">
                        <!-- Prepare data for modal -->
                        <c:set var="imgSrc" value="${empty event.eventImage ? 'images/gen_masonry_main.png' : (event.eventImage.startsWith('http') ? event.eventImage : 'images/'.concat(event.eventImage))}" />
                        
                        <div class="col-lg-4 col-md-6" data-aos="fade-up">
                            <div class="event-card h-100 d-flex flex-column">
                                <div style="height: 220px; position: relative; overflow: hidden;">
                                    <img src="${imgSrc}" class="w-100 h-100" style="object-fit: cover;" 
                                         alt="${event.eventTitle}" 
                                         onerror="this.onerror=null;this.src='assets/img/about.jpg';">
                                    <c:if test="${event.discount > 0}">
                                        <div class="position-absolute top-0 end-0 bg-danger text-white px-3 py-1 m-3 rounded-pill" style="font-weight: 700; font-size: 0.85rem; box-shadow: 0 4px 10px rgba(220,53,69,0.3);">
                                            GIẢM ${Math.round(event.discount * 100)}%
                                        </div>
                                    </c:if>
                                </div>
                                <div class="card-body p-4 d-flex flex-column">
                                    <h4 class="mb-3" style="font-size: 1.3rem;">${event.eventTitle}</h4>
                                    <div class="d-flex align-items-center mb-4 text-muted" style="font-size: 0.9rem;">
                                        <i class="ri-calendar-event-line me-2" style="color: var(--primary);"></i> 
                                        ${event.startDate} đến ${event.endDate}
                                    </div>
                                    <p class="text-muted mb-4" style="flex-grow: 1; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.6;">
                                        ${event.content}
                                    </p>
                                    <div class="event-hidden-content d-none">${event.content}</div>
                                    <button class="btn btn-read-more w-100" 
                                            data-title="${event.eventTitle}"
                                            data-date="${event.startDate} - ${event.endDate}"
                                            data-img="${imgSrc}"
                                            data-discount="${event.discount}"
                                            onclick="openModal(this)">
                                        Xem chi tiết
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- PAGINATION -->
                <c:if test="${not empty listEvent and endP > 1}">
                    <div class="row mt-5">
                        <div class="col-12 d-flex justify-content-center">
                            <ul class="pagination">
                                <c:if test="${tag > 1}">
                                    <li class="page-item"><a class="page-link shadow-sm" href="event?index=${tag - 1}"><i class="ri-arrow-left-s-line"></i></a></li>
                                </c:if>
                                <c:forEach begin="1" end="${endP}" var="i">
                                    <li class="page-item ${tag == i ? 'active' : ''}"><a class="page-link shadow-sm" href="event?index=${i}">${i}</a></li>
                                </c:forEach>
                                <c:if test="${tag < endP}">
                                    <li class="page-item"><a class="page-link shadow-sm" href="event?index=${tag + 1}"><i class="ri-arrow-right-s-line"></i></a></li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>
        </div>

        <!-- EVENT MODAL -->
        <div class="modal fade" id="eventModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 20px; overflow: hidden; background-color: #fff;">
                    <div class="modal-header border-0 position-absolute top-0 end-0 z-3 p-3">
                        <button type="button" class="btn-close bg-white rounded-circle p-2 shadow-sm" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-0">
                        <div class="position-relative">
                            <img id="modalImg" src="" class="w-100" style="height: 350px; object-fit: cover;" onerror="this.onerror=null;this.src='assets/img/about.jpg';">
                            <div class="position-absolute bottom-0 start-0 w-100" style="height: 150px; background: linear-gradient(to top, #ffffff, transparent);"></div>
                        </div>
                        <div class="p-5 pt-3" style="margin-top: -40px; position: relative; z-index: 2;">
                            <div class="d-flex justify-content-between align-items-end mb-4">
                                <div id="modalDiscount" class="d-inline-block text-white px-4 py-2 rounded-pill fw-bold" style="display: none !important; background: linear-gradient(135deg, #ff416c, #ff4b2b); font-size: 1.1rem; box-shadow: 0 4px 15px rgba(255, 75, 43, 0.4);"></div>
                            </div>
                            
                            <h2 id="modalTitle" class="fw-bold mb-3" style="color: #1a1a1a; font-size: 2.2rem; font-family: 'Playfair Display', serif;"></h2>
                            
                            <div class="d-flex align-items-center mb-4 text-muted pb-3 border-bottom" style="font-size: 0.95rem;">
                                <div class="d-flex align-items-center bg-light px-3 py-2 rounded-3 me-3">
                                    <i class="ri-calendar-event-fill me-2 fs-5" style="color: #b59349;"></i> 
                                    <span id="modalDate" class="fw-medium" style="color: #555;"></span>
                                </div>
                            </div>
                            
                            <div id="modalContent" class="text-dark mb-4" style="line-height: 1.8; font-size: 1.05rem; color: #444;"></div>
                            

                            <div class="mt-4 text-center">
                                <a href="motorcycle" class="btn px-5 py-3 text-white fw-bold shadow-sm" style="background: linear-gradient(135deg, #1a1a1a, #333); border-radius: 50px; font-size: 1.1rem; letter-spacing: 0.5px; transition: all 0.3s ease;">
                                    ĐẶT XE NGAY THÔI <i class="ri-arrow-right-line ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/includes/customer/footer.jsp" />
        
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/aos/aos.js"></script>
        
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

            function openModal(btn) {
                const title = btn.getAttribute('data-title');
                const date = btn.getAttribute('data-date');
                const img = btn.getAttribute('data-img');
                const discount = parseFloat(btn.getAttribute('data-discount'));
                
                const card = btn.closest('.event-card');
                let content = card.querySelector('.event-hidden-content').innerText || card.querySelector('.event-hidden-content').textContent;
                
                // Extract voucher code [CODE] if exists and remove it since it's applied automatically
                const codeMatch = content.match(/\[([A-Z0-9]+)\]/);
                if (codeMatch && codeMatch[1]) {
                    content = content.replace(codeMatch[0], ''); // Remove from content
                }

                document.getElementById('modalTitle').innerText = title;
                document.getElementById('modalDate').innerText = date.replace(' - ', ' đến ');
                document.getElementById('modalContent').innerHTML = content.replace(/\n/g, '<br>');
                
                const modalImg = document.getElementById('modalImg');
                modalImg.onerror = function() {
                    this.onerror = null;
                    this.src = 'assets/img/about.jpg';
                };
                modalImg.src = img;
                
                const discountEl = document.getElementById('modalDiscount');
                if(discount > 0) {
                    discountEl.innerText = "GIẢM ĐẾN " + Math.round(discount * 100) + "%";
                    discountEl.style.setProperty("display", "inline-block", "important");
                } else {
                    discountEl.style.setProperty("display", "none", "important");
                }
                
                var myModal = new bootstrap.Modal(document.getElementById('eventModal'));
                myModal.show();
            }
        </script>
    </body>
</html>

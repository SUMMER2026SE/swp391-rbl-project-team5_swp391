<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <jsp:include page="/includes/customer/header.jsp" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Các địa điểm du lịch - SmartRide</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    </head>
    <body>
        <jsp:include page="/includes/customer/navbar.jsp" />
        <div class="noidung">
            <section class="tour-section">
                <div class="container">
                    <div class="page-header animate__animated animate__fadeInDown">
                        <h2>Khám phá không giới hạn</h2>
                        <p>Trải nghiệm từng khoảnh khắc tuyệt vời tại các địa danh nổi tiếng cùng SmartRide</p>
                    </div>

                    <div class="row g-4">
                        <c:forEach var="loc" items="${touristLocation}">
                            <c:set var="locImg" value="${empty loc.locationImage ? 'images/default.jpg' : (loc.locationImage.startsWith('http') ? loc.locationImage : 'images/'.concat(loc.locationImage))}"/>
                            <div class="col-lg-4 col-md-6 animate__animated animate__zoomIn">
                                <div class="tour-card" onclick="openLocationModal('${loc.locationId}','${loc.locationName}','${loc.urlArticle}','${locImg}')">

                                    <div class="tour-img-wrapper">
                                        <img src="${locImg}?v=2" alt="${loc.locationName}" loading="lazy" decoding="async">
                                        <c:if test="${not empty recommendMap[loc.locationId]}">
                                            <div class="rec-badge">
                                                <i class="bi bi-star-fill"></i>
                                                <c:out value="${fn:length(recommendMap[loc.locationId])}"/> xe gợi ý
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="tour-content">
                                        <h3>${loc.locationName}</h3>
                                        <p class="tour-desc">${loc.description}</p>

                                        <c:if test="${not empty recommendMap[loc.locationId]}">
                                            <div class="rec-preview">
                                                <span class="rec-label"><i class="bi bi-star-fill text-warning"></i> Xe phù hợp</span>
                                                <div class="rec-avatars">
                                                    <c:set var="cnt" value="0"/>
                                                    <c:forEach var="rec" items="${recommendMap[loc.locationId]}">
                                                        <c:if test="${cnt < 3}">
                                                            <div class="rec-avatar-item">
                                                                <img src="images/${rec.image}" alt="${rec.model}">
                                                                <span>${rec.model}</span>
                                                            </div>
                                                            <c:set var="cnt" value="${cnt + 1}"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:set var="total" value="${fn:length(recommendMap[loc.locationId])}"/>
                                                    <c:if test="${total > 3}">
                                                        <div class="rec-more">+${total - 3}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:if>

                                        <div class="tour-footer">
                                            <span class="btn-detail">Xem chi tiết <i class="bi bi-arrow-right"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- CTA BANNER -->
                    <div class="cta-banner animate__animated animate__fadeInUp">
                        <div class="cta-banner-inner">
                            <div class="cta-banner-left">
                                <span class="cta-badge"><i class="bi bi-lightning-charge-fill"></i> Sẵn sàng khám phá?</span>
                                <h3>Thuê xe máy — tự do đi bất cứ đâu!</h3>
                                <p>Hơn 50+ mẫu xe đa dạng, giá cả cạnh tranh. Đặt xe trong 2 phút, nhận xe ngay hôm nay.</p>
                                <div class="cta-banner-btns">
                                    <a href="motorcycle" class="cta-btn-primary">
                                        <i class="bi bi-motorcycle"></i> Xem danh sách xe
                                    </a>
                                    <a href="touristLocation" class="cta-btn-secondary">
                                        <i class="bi bi-map"></i> Xem thêm địa điểm
                                    </a>
                                </div>
                            </div>
                            <div class="cta-banner-right">
                                <div class="cta-icon-ring">
                                    <i class="bi bi-motorcycle"></i>
                                </div>
                                <div class="cta-stats">
                                    <div class="cta-stat">
                                        <strong>50+</strong>
                                        <span>Mẫu xe</span>
                                    </div>
                                    <div class="cta-stat">
                                        <strong>24/7</strong>
                                        <span>Hỗ trợ</span>
                                    </div>
                                    <div class="cta-stat">
                                        <strong>★ 4.9</strong>
                                        <span>Đánh giá</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="pagination-container animate__animated animate__fadeInUp">
                        <ul class="pagination">
                            <c:if test="${tag > 1}">
                                <li><a href="touristLocation?index=${tag - 1}">&laquo;</a></li>
                            </c:if>
                            <c:forEach begin="1" end="${endP}" var="i">
                                <li class="${tag == i ? 'active' : ''}"><a href="touristLocation?index=${i}">${i}</a></li>
                            </c:forEach>
                            <c:if test="${tag < endP}">
                                <li><a href="touristLocation?index=${tag + 1}">&raquo;</a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </section>
        </div>

        <!-- MODAL CHI TIET -->
        <div id="locationModal" class="loc-modal-overlay" onclick="closeModal(event)">
            <div class="loc-modal" onclick="event.stopPropagation()">
                <button class="loc-modal-close" onclick="closeLocationModal()"><i class="bi bi-x-lg"></i></button>
                <div class="loc-modal-img-wrap">
                    <img id="modalImg" src="" alt="">
                    <div class="loc-modal-img-overlay"><h2 id="modalName"></h2></div>
                </div>
                <div class="loc-modal-body">
                    <p id="modalDesc" class="loc-modal-desc"></p>
                    <div id="modalRecSection">
                        <div class="loc-modal-rec-header">
                            <i class="bi bi-star-fill text-warning"></i>
                            <strong>Xe phù hợp cho chuyến đi</strong>
                        </div>
                        <div id="modalRecList" class="loc-modal-rec-list"></div>
                    </div>
                    <div class="loc-modal-actions">
                        <a id="modalArticleLink" href="#" target="_blank" class="btn-article" onclick="event.stopPropagation()">
                            <i class="bi bi-globe2"></i> Xem bài viết
                        </a>
                        <a href="motorcycle" class="btn-rent-now" onclick="event.stopPropagation()">
                            <i class="bi bi-motorcycle"></i> Thuê xe ngay
                        </a>
                    </div>
                    <div class="loc-modal-cta-hint">
                        <i class="bi bi-lightning-charge-fill"></i>
                        Thuê xe máy — khám phá địa điểm này theo cách của bạn!
                    </div>
                </div>
            </div>
        </div>

        <script id="recommendDataScript" type="application/json">
        {<c:forEach var="entry" items="${recommendMap}" varStatus="s">"${entry.key}":[<c:forEach var="rec" items="${entry.value}" varStatus="st">{"model":"<c:out value="${rec.model}"/>","image":"images/<c:out value="${rec.image}"/>","reason":"<c:out value="${rec.reason}"/>"}<c:if test="${!st.last}">,</c:if></c:forEach>]<c:if test="${!s.last}">,</c:if></c:forEach>}
        </script>
        <script id="descDataScript" type="application/json">
        {<c:forEach var="loc" items="${touristLocation}" varStatus="s">"<c:out value="${loc.locationId}"/>":"<c:out value="${loc.description}"/>"<c:if test="${!s.last}">,</c:if></c:forEach>}
        </script>

        <script>
            var recommendData = {}, descData = {};
            try { recommendData = JSON.parse(document.getElementById('recommendDataScript').textContent); } catch(e) {}
            try { descData = JSON.parse(document.getElementById('descDataScript').textContent); } catch(e) {}

            function openLocationModal(id, name, url, imgSrc) {
                document.getElementById('modalName').textContent = name;
                document.getElementById('modalDesc').textContent = descData[id] || '';
                document.getElementById('modalImg').src = imgSrc;
                document.getElementById('modalImg').alt = name;
                document.getElementById('modalArticleLink').href = url || '#';

                var recList = document.getElementById('modalRecList');
                var recSection = document.getElementById('modalRecSection');
                var recs = recommendData[id] || [];

                if (recs.length === 0) {
                    recSection.style.display = 'none';
                } else {
                    recSection.style.display = 'block';
                    recList.innerHTML = recs.map(function(r) {
                        return '<div class="loc-rec-item">' +
                            '<img src="' + r.image + '" alt="' + r.model + '" onerror="this.src=\'images/default.jpg\'">' +
                            '<div class="loc-rec-info">' +
                                '<strong>' + r.model + '</strong>' +
                                '<span>' + (r.reason || '') + '</span>' +
                            '</div>' +
                        '</div>';
                    }).join('');
                }

                document.getElementById('locationModal').classList.add('active');
                document.body.style.overflow = 'hidden';
            }

            function closeLocationModal() {
                document.getElementById('locationModal').classList.remove('active');
                document.body.style.overflow = '';
            }

            function closeModal(e) {
                if (e.target === document.getElementById('locationModal')) closeLocationModal();
            }

            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') closeLocationModal();
            });
        </script>

        <jsp:include page="/includes/customer/footer.jsp" />
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/main.js"></script>
    </body>

    <style>
        :root { --primary: #b59349; --primary-dark: #8c6f32; --text-dark: #1a1816; --text-body: #666; --bg-light: #fbfaf8; }
        body { font-family: 'Plus Jakarta Sans', sans-serif !important; background: var(--bg-light); }
        .noidung { padding-top: 120px; padding-bottom: 80px; }

        .page-header { text-align: center; margin-bottom: 60px; }
        .page-header h2 { font-size: 2.5rem; font-weight: 800; color: var(--text-dark); margin-bottom: 15px; letter-spacing: -0.5px; }
        .page-header p { font-size: 1.1rem; color: var(--text-body); max-width: 600px; margin: 0 auto; }

        .tour-card {
            background: #fff; border-radius: 20px; overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,.05);
            transition: all .4s cubic-bezier(.165,.84,.44,1);
            display: flex; flex-direction: column;
            border: 1px solid rgba(0,0,0,.04); cursor: pointer; height: 100%;
        }
        .tour-card:hover { transform: translateY(-8px); box-shadow: 0 20px 40px rgba(181,147,73,.18); }

        .tour-img-wrapper { position: relative; width: 100%; padding-top: 60%; overflow: hidden; }
        .tour-img-wrapper img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; transition: transform .6s ease; }
        .tour-card:hover .tour-img-wrapper img { transform: scale(1.07); }

        .rec-badge {
            position: absolute; top: 12px; right: 12px;
            background: rgba(181,147,73,.9); color: #fff;
            font-size: .72rem; font-weight: 700; padding: 4px 10px;
            border-radius: 20px; display: flex; align-items: center; gap: 5px; backdrop-filter: blur(4px);
        }

        .tour-content { padding: 20px 22px; display: flex; flex-direction: column; flex: 1; }
        .tour-content h3 { font-size: 1.2rem; font-weight: 700; color: var(--text-dark); margin: 0 0 8px; }
        .tour-desc {
            font-size: .88rem; line-height: 1.6; color: var(--text-body); margin: 0 0 14px;
            display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
        }

        .rec-preview { margin-bottom: 14px; }
        .rec-label { font-size: .72rem; font-weight: 700; color: var(--text-dark); display: block; margin-bottom: 8px; text-transform: uppercase; letter-spacing: .4px; }
        .rec-avatars { display: flex; align-items: flex-start; gap: 8px; flex-wrap: nowrap; }
        .rec-avatar-item { display: flex; flex-direction: column; align-items: center; gap: 4px; flex: 0 0 60px; text-align: center; }
        .rec-avatar-item img { width: 48px; height: 48px; object-fit: contain; border-radius: 10px; border: 1px solid #eee; background: #f8f8f8; padding: 3px; }
        .rec-avatar-item span { font-size: .63rem; color: #444; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 60px; }
        .rec-more { width: 44px; height: 44px; border-radius: 50%; background: #f0ebe0; color: var(--primary); font-weight: 800; font-size: .78rem; display: flex; align-items: center; justify-content: center; flex-shrink: 0; border: 2px dashed var(--primary); }

        .tour-footer { margin-top: auto; padding-top: 12px; border-top: 1px solid #f0ede8; }
        .btn-detail { font-size: .85rem; font-weight: 700; color: var(--primary); display: inline-flex; align-items: center; gap: 6px; transition: gap .25s; }
        .tour-card:hover .btn-detail { gap: 10px; color: var(--primary-dark); }

        .pagination-container { margin-top: 50px; display: flex; justify-content: center; }
        .pagination { display: flex; gap: 10px; list-style: none; padding: 0; margin: 0; }
        .pagination li a { display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; border-radius: 50%; background: #fff; color: var(--text-dark); font-weight: 600; text-decoration: none; border: 1px solid rgba(0,0,0,.1); transition: all .3s; }
        .pagination li.active a, .pagination li a:hover { background: var(--primary); color: #fff; border-color: var(--primary); box-shadow: 0 5px 15px rgba(181,147,73,.3); }

        /* MODAL */
        .loc-modal-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,.55); backdrop-filter: blur(5px); z-index: 9999; align-items: center; justify-content: center; padding: 16px; }
        .loc-modal-overlay.active { display: flex; }
        .loc-modal { background: #fff; border-radius: 24px; max-width: 580px; width: 100%; max-height: 90vh; overflow-y: auto; box-shadow: 0 30px 80px rgba(0,0,0,.28); position: relative; animation: modalIn .32s cubic-bezier(.165,.84,.44,1); }
        @keyframes modalIn { from { opacity: 0; transform: scale(.9) translateY(24px); } to { opacity: 1; transform: none; } }
        .loc-modal-close { position: absolute; top: 12px; right: 12px; z-index: 10; background: rgba(0,0,0,.4); color: #fff; border: none; width: 34px; height: 34px; border-radius: 50%; cursor: pointer; font-size: .95rem; display: flex; align-items: center; justify-content: center; transition: background .2s; }
        .loc-modal-close:hover { background: rgba(0,0,0,.75); }
        .loc-modal-img-wrap { position: relative; height: 210px; overflow: hidden; border-radius: 24px 24px 0 0; }
        .loc-modal-img-wrap img { width: 100%; height: 100%; object-fit: cover; }
        .loc-modal-img-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,.65) 0%, transparent 55%); display: flex; align-items: flex-end; padding: 18px 22px; }
        .loc-modal-img-overlay h2 { color: #fff; font-size: 1.55rem; font-weight: 800; margin: 0; }
        .loc-modal-body { padding: 22px; }
        .loc-modal-desc { font-size: .93rem; line-height: 1.7; color: #555; margin: 0 0 18px; }
        .loc-modal-rec-header { display: flex; align-items: center; gap: 8px; font-size: .92rem; color: var(--text-dark); margin-bottom: 12px; padding-bottom: 10px; border-bottom: 2px solid #f5f0e8; }
        .loc-modal-rec-list { display: flex; flex-direction: column; gap: 9px; margin-bottom: 22px; }
        .loc-rec-item { display: flex; align-items: center; gap: 14px; background: #fbfaf8; border: 1px solid #eee; border-radius: 12px; padding: 10px 14px; transition: box-shadow .2s; }
        .loc-rec-item:hover { box-shadow: 0 4px 14px rgba(181,147,73,.12); }
        .loc-rec-item img { width: 54px; height: 54px; object-fit: contain; border-radius: 10px; background: #fff; border: 1px solid #eee; padding: 3px; flex-shrink: 0; }
        .loc-rec-info { display: flex; flex-direction: column; gap: 3px; }
        .loc-rec-info strong { font-size: .9rem; color: var(--text-dark); }
        .loc-rec-info span { font-size: .8rem; color: #777; }
        .loc-modal-actions { text-align: center; display: flex; gap: 10px; justify-content: center; flex-wrap: wrap; }
        .btn-article { display: inline-flex; align-items: center; gap: 8px; background: #f5f0e8; color: var(--primary-dark); font-weight: 700; font-size: .9rem; padding: 11px 22px; border-radius: 50px; text-decoration: none; transition: all .3s; border: 2px solid var(--primary); }
        .btn-article:hover { background: var(--primary); color: #fff; transform: translateY(-2px); }
        .btn-rent-now { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg, var(--primary), var(--primary-dark)); color: #fff; font-weight: 700; font-size: .9rem; padding: 11px 22px; border-radius: 50px; text-decoration: none; transition: all .3s; box-shadow: 0 6px 20px rgba(181,147,73,.4); }
        .btn-rent-now:hover { box-shadow: 0 10px 28px rgba(181,147,73,.6); transform: translateY(-3px); color: #fff; }
        .loc-modal-cta-hint { text-align: center; margin-top: 12px; font-size: .78rem; color: #999; display: flex; align-items: center; justify-content: center; gap: 5px; }
        .loc-modal-cta-hint i { color: var(--primary); }

        /* CTA BANNER */
        .cta-banner { margin: 60px 0 40px; }
        .cta-banner-inner {
            background: linear-gradient(135deg, #1a1816 0%, #2d2520 40%, #3d2f18 100%);
            border-radius: 28px;
            padding: 50px 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 40px;
            position: relative;
            overflow: hidden;
        }
        .cta-banner-inner::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 280px; height: 280px;
            background: radial-gradient(circle, rgba(181,147,73,.25) 0%, transparent 70%);
            border-radius: 50%;
        }
        .cta-banner-inner::after {
            content: '';
            position: absolute;
            bottom: -40px; left: 30%;
            width: 200px; height: 200px;
            background: radial-gradient(circle, rgba(181,147,73,.1) 0%, transparent 70%);
            border-radius: 50%;
        }
        .cta-banner-left { flex: 1; position: relative; z-index: 1; }
        .cta-badge {
            display: inline-flex; align-items: center; gap: 6px;
            background: rgba(181,147,73,.2); color: #f0c96a;
            font-size: .72rem; font-weight: 700; letter-spacing: 1px;
            padding: 5px 14px; border-radius: 20px; text-transform: uppercase;
            border: 1px solid rgba(181,147,73,.3); margin-bottom: 16px;
        }
        .cta-banner-left h3 {
            font-size: 1.9rem; font-weight: 800; color: #fff;
            margin: 0 0 12px; line-height: 1.2;
        }
        .cta-banner-left p {
            font-size: .95rem; color: rgba(255,255,255,.65); margin: 0 0 28px; line-height: 1.6;
        }
        .cta-banner-btns { display: flex; gap: 14px; flex-wrap: wrap; }
        .cta-btn-primary {
            display: inline-flex; align-items: center; gap: 8px;
            background: linear-gradient(135deg, #b59349, #8c6f32);
            color: #fff; font-weight: 700; font-size: .92rem;
            padding: 13px 28px; border-radius: 50px; text-decoration: none;
            transition: all .3s; box-shadow: 0 6px 24px rgba(181,147,73,.5);
        }
        .cta-btn-primary:hover { transform: translateY(-3px); box-shadow: 0 10px 32px rgba(181,147,73,.7); color: #fff; }
        .cta-btn-secondary {
            display: inline-flex; align-items: center; gap: 8px;
            background: rgba(255,255,255,.08); color: rgba(255,255,255,.85);
            font-weight: 600; font-size: .92rem;
            padding: 13px 24px; border-radius: 50px; text-decoration: none;
            border: 1.5px solid rgba(255,255,255,.2); transition: all .3s;
        }
        .cta-btn-secondary:hover { background: rgba(255,255,255,.15); border-color: rgba(255,255,255,.4); color: #fff; transform: translateY(-2px); }
        .cta-banner-right { position: relative; z-index: 1; flex-shrink: 0; display: flex; flex-direction: column; align-items: center; gap: 24px; }
        .cta-icon-ring {
            width: 110px; height: 110px; border-radius: 50%;
            background: rgba(181,147,73,.15); border: 2px dashed rgba(181,147,73,.4);
            display: flex; align-items: center; justify-content: center;
            font-size: 2.8rem; color: #b59349;
            animation: ringPulse 3s ease-in-out infinite;
        }
        @keyframes ringPulse { 0%,100%{box-shadow:0 0 0 0 rgba(181,147,73,.3);} 50%{box-shadow:0 0 0 16px rgba(181,147,73,0);} }
        .cta-stats { display: flex; gap: 28px; }
        .cta-stat { text-align: center; }
        .cta-stat strong { display: block; font-size: 1.4rem; font-weight: 800; color: #f0c96a; line-height: 1; }
        .cta-stat span { font-size: .72rem; color: rgba(255,255,255,.5); text-transform: uppercase; letter-spacing: .5px; margin-top: 4px; display: block; }
        @media(max-width:768px) {
            .cta-banner-inner { flex-direction: column; padding: 36px 28px; }
            .cta-banner-right { flex-direction: row; }
            .cta-banner-left h3 { font-size: 1.5rem; }
        }
    </style>
</html>

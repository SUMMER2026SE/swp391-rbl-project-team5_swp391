<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>Câu Hỏi Thường Gặp - SmartRide</title>
    <meta name="description" content="Giải đáp mọi thắc mắc về dịch vụ thuê xe máy SmartRide – giá cả, thủ tục, giao nhận, chất lượng xe và an toàn.">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <jsp:include page="/includes/customer/header.jsp" />
    <style>
        body {
            background: #f9f8f6;
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: #2b2824;
        }

        /* ── Hero Banner ── */
        .faq-hero {
            background: linear-gradient(135deg, #1a1816 0%, #2d2520 60%, #3a2e1e 100%);
            padding: 130px 0 70px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .faq-hero::before {
            content: 'FAQ';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 220px;
            font-weight: 900;
            color: rgba(181,147,73,0.04);
            pointer-events: none;
            white-space: nowrap;
            font-family: 'Poppins', sans-serif;
        }
        .faq-hero h1 {
            font-family: 'Poppins', sans-serif;
            font-weight: 800;
            font-size: 3rem;
            color: #fff;
            margin-bottom: 16px;
            position: relative;
        }
        .faq-hero h1 span {
            background: linear-gradient(135deg, #b59349, #d4a843);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .faq-hero p {
            color: rgba(255,255,255,0.65);
            font-size: 1.1rem;
            max-width: 540px;
            margin: 0 auto 30px;
            position: relative;
        }
        .faq-search-bar {
            position: relative;
            max-width: 520px;
            margin: 0 auto;
        }
        .faq-search-bar input {
            width: 100%;
            padding: 16px 55px 16px 24px;
            border-radius: 50px;
            border: none;
            font-size: 15px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            outline: none;
            box-shadow: 0 8px 30px rgba(0,0,0,0.2);
        }
        .faq-search-bar i {
            position: absolute;
            right: 22px;
            top: 50%;
            transform: translateY(-50%);
            color: #b59349;
            font-size: 18px;
        }

        /* ── Main Section ── */
        .faq-section {
            padding: 70px 0 100px;
        }

        /* ── Category Block ── */
        .faq-category {
            margin-bottom: 56px;
        }
        .faq-category-header {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 28px;
        }
        .faq-category-header h3 {
            font-family: 'Poppins', sans-serif;
            font-weight: 800;
            font-size: 1rem;
            letter-spacing: 2px;
            color: #1a1816;
            white-space: nowrap;
            margin: 0;
            text-transform: uppercase;
        }
        .faq-dashed {
            flex: 1;
            border: none;
            border-top: 2px dashed rgba(181,147,73,0.35);
            margin: 0;
        }

        /* ── FAQ Grid (2 columns) ── */
        .faq-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0 40px;
        }
        @media (max-width: 768px) {
            .faq-grid { grid-template-columns: 1fr; }
            .faq-hero h1 { font-size: 2rem; }
        }

        /* ── FAQ Item (Premium Card) ── */
        .faq-item {
            background: #ffffff;
            border: 1px solid rgba(0,0,0,0.05);
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.02);
            transition: all 0.3s ease;
            overflow: hidden;
            cursor: pointer;
            height: fit-content;
        }
        .faq-item:hover {
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
            border-color: rgba(196, 161, 75, 0.3);
        }
        .faq-question {
            padding: 22px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-weight: 700;
            font-size: 16px;
            color: #1a1a1a;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .faq-question span {
            flex: 1;
            text-align: left;
            line-height: 1.5;
            margin: 0;
            padding: 0;
            display: block;
        }
        .faq-item.open .faq-question {
            color: #b59349;
            background: rgba(196, 161, 75, 0.02);
        }
        .faq-chevron {
            flex-shrink: 0;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #888;
            font-size: 12px;
            transition: all 0.3s ease;
            margin-left: 10px;
        }
        .faq-item.open .faq-chevron {
            background: #b59349;
            color: #fff;
            transform: rotate(180deg);
        }
        .faq-answer {
            max-height: 0;
            opacity: 0;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 0 30px;
            color: #666;
            font-size: 14.5px;
            line-height: 1.7;
            border-top: 1px solid transparent;
        }
        .faq-item.open .faq-answer {
            max-height: 500px;
            opacity: 1;
            padding: 0 30px 25px 30px;
            border-top-color: rgba(0,0,0,0.03);
            margin-top: 5px;
        }

        /* ── CTA Bottom ── */
        .faq-cta {
            background: linear-gradient(135deg, #1a1816, #2d2520);
            border-radius: 20px;
            padding: 48px 40px;
            text-align: center;
            margin-top: 60px;
        }
        .faq-cta h4 {
            color: #fff;
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
        .faq-cta p {
            color: rgba(255,255,255,0.6);
            margin-bottom: 24px;
            font-size: 15px;
        }
        .faq-cta a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, #b59349, #d4a843);
            color: #fff;
            font-weight: 700;
            font-size: 14px;
            padding: 14px 32px;
            border-radius: 50px;
            text-decoration: none;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            box-shadow: 0 4px 20px rgba(181,147,73,0.35);
        }
        .faq-cta a:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 28px rgba(181,147,73,0.45);
            color: #fff;
        }
    </style>
</head>
<body>

<jsp:include page="/includes/customer/navbar.jsp" />

<!-- Hero Banner -->
<div class="faq-hero" data-aos="fade-in">
    <div class="container">
        <h1>Câu Hỏi <span>Thường Gặp</span></h1>
        <p>Giải đáp mọi thắc mắc về dịch vụ thuê xe máy tại SmartRide</p>
        <div class="faq-search-bar" data-aos="fade-up" data-aos-delay="150">
            <input type="text" id="faqSearch" placeholder="Tìm câu hỏi bạn cần..." />
            <i class="fas fa-search"></i>
        </div>
    </div>
</div>

<!-- FAQ Main -->
<section class="faq-section">
    <div class="container">

        <!-- Category: Dynamic FAQs from DB -->
        <c:if test="${not empty sessionScope.FAQ}">
        <div class="faq-category" data-aos="fade-up">
            <div class="faq-category-header">
                <hr class="faq-dashed">
                <h3>Danh sách câu hỏi thường gặp</h3>
                <hr class="faq-dashed">
            </div>
            <div class="faq-grid" id="dynamicFaqGrid">
                <c:forEach var="faq" items="${sessionScope.FAQ}" varStatus="status">
                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">
                        <span>${faq.question}</span>
                        <i class="faq-chevron fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">${faq.answer}</div>
                </div>
                </c:forEach>
            </div>
        </div>
        </c:if>

        <!-- CTA Bottom -->
        <div class="faq-cta" data-aos="fade-up">
            <h4>Vẫn còn thắc mắc?</h4>
            <p>Đội ngũ hỗ trợ SmartRide luôn sẵn sàng giải đáp mọi câu hỏi của bạn 24/7</p>
            <a href="contact.jsp"><i class="fas fa-headset"></i> Liên hệ với chúng tôi</a>
        </div>

    </div>
</section>

<jsp:include page="/includes/customer/footer.jsp" />

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/main.js"></script>
<script>
    AOS.init({ duration: 600, once: true });

    function toggleFaq(el) {
        el.classList.toggle('open');
    }

    // Search filter
    document.getElementById('faqSearch').addEventListener('input', function() {
        const q = this.value.toLowerCase();
        
        document.querySelectorAll('.faq-category').forEach(category => {
            let hasVisibleItem = false;
            
            category.querySelectorAll('.faq-item').forEach(item => {
                const questionText = item.querySelector('.faq-question span').textContent.toLowerCase();
                const answerText = item.querySelector('.faq-answer').textContent.toLowerCase();
                
                if (questionText.includes(q) || answerText.includes(q)) {
                    item.style.display = '';
                    hasVisibleItem = true;
                } else {
                    item.style.display = 'none';
                }
            });
            
            // Hide category completely if no items match
            category.style.display = hasVisibleItem ? 'block' : 'none';
        });
    });
</script>
</body>
</html>

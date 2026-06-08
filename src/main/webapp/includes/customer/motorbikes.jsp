<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!-- thanh search -->
<link rel="stylesheet" type="text/css"
      href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    /*mới*/
    body {
        background-size: cover;
        background-position: center;

        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
    }


    .box {
        backdrop-filter: blur(16px) saturate(180%);
        -webkit-backdrop-filter: blur(16px) saturate(180%);
        background-color: rgba(17, 25, 40, 0.25);
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.125);
        padding: 38px;
        filter: drop-shadow(0 30px 10px rgba(0,0,0,0.125));
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content:center;
        text-align: center;
        margin: 20px 0;

    }

    .col-md-4{
        width: 30.333333%;
    }
    .container {
        width: 100%;
        height: 100%;

    }

    .banner-image {
        /*background-image: url(https://images.unsplash.com/photo-1641326201918-3cafc641038e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80);*/
        background-position: center;
        background-size: cover;
        height: 300px;
        width: 100%;
        border-radius: 12px;
        border: 1px solid rgba(255,255,255, 0.255)
    }

    h1{
        font-family: 'Righteous', sans-serif;
        color: rgba(255,255,255,0.98);
        text-transform: uppercase;
        font-size: 2.4rem;
    }

    p {
        color: #fff;
        font-family: 'Lato', sans-serif;
        text-align: center;
        font-size: 0.8rem;
        line-height: 150%;
        letter-spacing: 2px;
        text-transform: uppercase;
    }

    .button-wrapper{
        margin-top: 18px;
    }

    .btn {
        border: none;
        padding: 12px 24px;
        border-radius: 24px;
        font-size: 12px;
        font-size: 0.8rem;
        letter-spacing: 2px;
        cursor: pointer;
    }

    .btn + .btn {
        margin-left: 10px;
    }

    .outline {
        background: transparent;
        color: rgba(0, 212, 255, 0.9);
        border: 1px solid rgba(0, 212, 255, 0.6);
        transition: all .3s ease;

    }

    .outline:hover{
        transform: scale(1.125);
        color: rgba(255, 255, 255, 0.9);
        border-color: rgba(255, 255, 255, 0.9);
        transition: all .3s ease;
    }

    .fill {
        background: rgba(0, 212, 255, 0.9);
        color: rgba(255,255,255,0.95);
        filter: drop-shadow(0);
        font-weight: bold;
        transition: all .3s ease;
    }

    .fill:hover{
        transform: scale(1.125);
        border-color: rgba(255, 255, 255, 0.9);
        filter: drop-shadow(0 10px 5px rgba(0,0,0,0.125));
        transition: all .3s ease;
    }
    .wrapper {
        display: flex;
        justify-content: space-around; /* khoảng cách đều giữa các khung */
        /* gap: 5px; tạo khoảng cách giữa các khung */

        padding: 10px;
    }
</style>

<div class="container">
    <div class="wrapper row">
        <c:forEach var="motorbike" items="${motorcycles}">
            <div class="box col-md-4">
                <div class="banner-image" style="background-image: url('${motorbike.image}');"></div>
                <h1 href="motorcycleDetail?id=${motorbike.motorcycleId}">${motorbike.model}</h1>
                <p>${categoryMap[motorbike.categoryID]}<br/>${priceMap[motorbike.priceListID]}/ngày</p>
                <div class="button-wrapper">
                    <button class="btn outline" href="motorcycleDetail?id=${motorbike.motorcycleId}">DETAILS</button>
                    <button class="btn fill" href="booking?motorcycleid=${motorbike.motorcycleId}">BUY NOW</button>
                </div>
            </div>
        </c:forEach>
        <div class="row mt-5">
            <div class="col text-center">
                <div class="block-27">
                    <ul class="pagination">
                        <c:forEach begin="1" end="${endP}" var="i">
                            <li class="page-item ${currentIndex == i ? 'active' : ''}">
                                <a class="page-link" href="motorcycle?index=${i}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>





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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>

<script src="js/main.js"></script>

</script>

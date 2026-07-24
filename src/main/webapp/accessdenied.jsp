<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Access Denied</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
            }
            .container {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                margin-top: -60px;
            }
            .error-icon {
                width: 100px;
                height: 100px;
                background-color: #d9534f;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
            }
            .error-icon::before {
                content: "✖";
                color: white;
                font-size: 48px;
            }
            .error-message {
                font-size: 24px;
                color: #333;
                margin-bottom: 10px;
            }
            .error-description {
                font-size: 18px;
                color: #666;
                margin-bottom: 20px;
            }
            .error-code {
                font-size: 14px;
                color: #999;
            }
            
            .error-image{
                width: 8%;
                border-radius: 50%;
                margin-bottom: 25px;
                /*border: solid red;*/
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!--<div class="error-icon"></div>-->

            <!--<img class="error-image" src="assets/img/sorry.jpg" alt="alt"/>-->
            <img class="error-image" src="images/loading.jpg" alt="alt"/>

            <div class="error-message">Truy cập bị từ chối</div>
            <div class="error-description">
                Bạn không có quyền xem trang này.<br>
                Vui lòng kiểm tra thông tin xác thực của bạn và thử lại.
            </div>
     
        </div>
    </body>
</html>

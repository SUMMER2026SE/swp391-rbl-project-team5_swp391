<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.smartride.dao.EventDAO" %>
<%@ page import="com.smartride.dto.Event" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Event activeEvent = EventDAO.getInstance().getActiveEvent();
    request.setAttribute("activeEvent", activeEvent);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <title>Motorcycles Detail</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!--logo-->
        
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">


        <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

        <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
        <link rel="stylesheet" href="css/animate.css">

        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">

        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/ionicons.min.css">

        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="css/jquery.timepicker.css">

        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/icomoon.css">
        <link rel="stylesheet" href="css/style.css">        <style>             body {
                background: radial-gradient(circle at 50% 50%, #ffffff 0%, #f4f5f8 100%) !important;
                color: #2d3748 !important;
                font-family: 'Be Vietnam Pro', 'Poppins', sans-serif !important;
            }
            .ftco-section {
                background: transparent !important;
                padding: 6em 0 !important;
            }
            .ftco-car-details {
                padding-top: 130px !important;
            }
            
            /* Hero Section Styles */
            .hero-wrap {
                width: 100%;
                min-height: 200px;
                position: relative;
                background-color: #1a202c;
                margin-top: 20px;
            }
            .hero-wrap.js-fullheight {
                height: 400px !important;
            }
            .hero-wrap .overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                content: '';
                background: linear-gradient(135deg, rgba(26, 32, 44, 0.95) 0%, rgba(45, 55, 72, 0.9) 100%);
                opacity: 1;
            }
            .slider-text {
                position: relative;
                z-index: 1;
            }
            .breadcrumbs {
                font-size: 13px;
                font-weight: 600;
                letter-spacing: 1px;
                color: rgba(255, 255, 255, 0.8);
            }
            .breadcrumbs a {
                color: rgba(255, 255, 255, 0.8);
                transition: color 0.3s;
            }
            .breadcrumbs a:hover {
                color: #b89228;
            }
            .bread {
                font-size: 54px;
                font-weight: 900;
                color: #fff;
                line-height: 1.2;
                letter-spacing: -1px;
                text-shadow: 0 4px 12px rgba(0,0,0,0.3);
            }
            
            /* Motorcycle Showcase */
            .motorcycle-showcase {
                position: relative;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 40px;
                background: #ffffff;
                border-radius: 24px;
                border: 1px solid rgba(0, 0, 0, 0.05);
                overflow: hidden;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05);
                min-height: 400px;
            }
            .spotlight-glow {
                position: absolute;
                width: 320px;
                height: 320px;
                background: radial-gradient(circle, rgba(184, 146, 40, 0.08) 0%, rgba(184, 146, 40, 0) 70%);
                filter: blur(40px);
                pointer-events: none;
                z-index: 1;
            }
            .hero-image {
                max-width: 100%;
                max-height: 350px;
                object-fit: contain;
                filter: drop-shadow(0 20px 30px rgba(0, 0, 0, 0.15));
                transition: transform 0.6s cubic-bezier(0.25, 1, 0.5, 1);
                z-index: 2;
            }
            .motorcycle-showcase:hover .hero-image {
                transform: scale(1.04) translateY(-8px);
            }

            /* Details Sidebar Card */
            .details-sidebar {
                background: #ffffff;
                border: 1px solid rgba(0, 0, 0, 0.05);
                border-radius: 24px;
                padding: 35px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05);
            }
            .brand-badge {
                display: inline-block;
                padding: 6px 14px;
                background: rgba(184, 146, 40, 0.08);
                border: 1px solid rgba(184, 146, 40, 0.2);
                color: #b89228;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                border-radius: 50px;
                margin-bottom: 16px;
            }
            .model-title {
                font-size: 36px;
                font-weight: 800;
                color: #1a202c;
                margin-bottom: 24px;
                line-height: 1.2;
                letter-spacing: -0.5px;
            }

            /* Accessory Grid */
            .accessories-section {
                margin-top: 60px;
                padding: 0;
            }
            .accessories-section h3 {
                color: #1a202c !important;
                font-size: 32px;
                font-weight: 900;
                margin-bottom: 15px;
                letter-spacing: -0.8px;
                position: relative;
                padding-bottom: 0;
                font-family: 'Plus Jakarta Sans', sans-serif;
            }
            .accessories-section > p {
                color: #64748b;
                font-size: 16px;
                margin-bottom: 40px;
                font-weight: 500;
                line-height: 1.6;
            }
            .accessories-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
                gap: 20px;
            }
            .accessory-card {
                background: #ffffff;
                border: 1.5px solid rgba(0, 0, 0, 0.08);
                border-radius: 20px;
                padding: 28px 20px;
                text-align: center;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                cursor: pointer;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 170px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.04);
                position: relative;
                overflow: hidden;
            }
            .accessory-card::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(145deg, rgba(184, 146, 40, 0.03), rgba(212, 165, 116, 0.02));
                opacity: 0;
                transition: opacity 0.4s ease;
            }
            .accessory-card:hover {
                border-color: rgba(184, 146, 40, 0.4);
                transform: translateY(-8px);
                box-shadow: 
                    0 16px 32px rgba(184, 146, 40, 0.12),
                    0 0 0 1px rgba(184, 146, 40, 0.08);
            }
            .accessory-card:hover::before {
                opacity: 1;
            }
            .accessory-icon-wrapper {
                width: 72px;
                height: 72px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 18px;
                background: linear-gradient(145deg, #fdfbf7 0%, #f8f4ec 100%);
                border: 2px solid rgba(184, 146, 40, 0.15);
                border-radius: 50%;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                box-shadow: 0 4px 12px rgba(184, 146, 40, 0.08);
                position: relative;
                z-index: 1;
            }
            .accessory-card:hover .accessory-icon-wrapper {
                background: linear-gradient(145deg, #b89228, #d4af37);
                transform: scale(1.1);
                border-color: rgba(255, 255, 255, 0.3);
                box-shadow: 0 12px 28px rgba(184, 146, 40, 0.3);
            }
            .accessory-icon-wrapper i {
                font-size: 32px !important;
                color: #b89228;
                transition: all 0.4s ease;
            }
            .accessory-card:hover .accessory-icon-wrapper i {
                color: #ffffff !important;
                transform: scale(1.05);
            }
            .accessory-title {
                font-size: 15px;
                font-weight: 700;
                color: #1a202c;
                margin: 0;
                line-height: 1.4;
                position: relative;
                z-index: 1;
                transition: all 0.3s ease;
                font-family: 'Plus Jakarta Sans', sans-serif;
            }
            .accessory-card:hover .accessory-title {
                color: #b89228;
            }

            /* Custom Pills & Tabs */
            .modern-tabs {
                border-bottom: 1px solid rgba(0, 0, 0, 0.08);
                margin-bottom: 10px;
                display: flex;
                justify-content: center;
                background: #fafafa;
                border-radius: 12px;
                padding: 5px;
            }
            .modern-tabs .nav-link {
                background: transparent !important;
                border: none !important;
                color: #a0aec0 !important;
                font-weight: 600;
                font-size: 16px;
                padding: 14px 20px;
                position: relative;
                transition: all 0.3s ease;
                border-radius: 8px !important;
                cursor: pointer;
            }
            .modern-tabs .nav-link:hover {
                color: #4a5568 !important;
                background: rgba(0, 0, 0, 0.02) !important;
            }
            .modern-tabs .nav-link.active {
                color: #1a202c !important;
                background: #ffffff !important;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            }
            .modern-tabs .nav-link.active::after {
                display: none;
            }

            /* Pricing List Refined */
            .pricing-list {
                margin-top: 30px;
                background: linear-gradient(145deg, #fffdf8 0%, #fdfbf7 100%);
                border: 2px solid rgba(184, 146, 40, 0.2);
                border-radius: 20px;
                padding: 8px 28px;
                box-shadow: 
                    0 10px 30px rgba(184, 146, 40, 0.08),
                    inset 0 2px 0 rgba(255, 255, 255, 0.8);
                position: relative;
                overflow: hidden;
            }
            .pricing-list::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 3px;
                background: linear-gradient(90deg, #b89228, #d4af37, #b89228);
            }
            .pricing-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 20px 0;
                border-bottom: 1px dashed rgba(184, 146, 40, 0.25);
                transition: all 0.3s ease;
                position: relative;
            }
            .pricing-item:hover {
                padding-left: 10px;
                background: rgba(184, 146, 40, 0.03);
                border-radius: 12px;
                margin: 0 -10px;
                padding: 20px 20px;
            }
            .pricing-item:last-child {
                border-bottom: none;
            }
            .pricing-label {
                color: #4a5568;
                font-size: 15px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .pricing-label::before {
                content: '';
                width: 8px;
                height: 8px;
                background: #b89228;
                border-radius: 50%;
                box-shadow: 0 0 10px rgba(184, 146, 40, 0.4);
            }
            .pricing-value {
                color: #b89228;
                font-weight: 900;
                font-size: 20px;
                letter-spacing: 0.5px;
                text-shadow: 0 2px 4px rgba(184, 146, 40, 0.1);
            }
            
            #pills-manufacturer {
                padding-top: 25px;
            }
            #pills-manufacturer p {
                color: #2d3748 !important;
                line-height: 1.9;
                font-size: 17px;
                margin: 0;
                padding: 30px 28px;
                background: linear-gradient(145deg, #ffffff 0%, #fffdf8 100%);
                border: 2px solid rgba(184, 146, 40, 0.15);
                border-radius: 20px;
                font-style: normal;
                text-align: justify;
                letter-spacing: 0.2px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
                position: relative;
                overflow: hidden;
                font-weight: 400;
                font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif !important;
            }
            #pills-manufacturer p::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 3px;
                background: linear-gradient(90deg, #b89228, #d4af37, #b89228);
            }
            #pills-manufacturer p::after {
                content: '"';
                position: absolute;
                top: 18px;
                left: 18px;
                font-size: 90px;
                color: rgba(184, 146, 40, 0.08);
                font-family: Georgia, serif;
                line-height: 1;
            }

            /* Premium Rent Button */
            .rent-now-btn {
                width: 100%;
                background: linear-gradient(135deg, #a67c2a 0%, #b89228 50%, #a67c2a 100%) !important;
                background-size: 200% 200% !important;
                color: #ffffff !important;
                padding: 20px;
                border: none !important;
                border-radius: 60px;
                font-size: 17px;
                font-weight: 900;
                letter-spacing: 2.5px;
                text-transform: uppercase;
                transition: all 0.5s cubic-bezier(0.165, 0.84, 0.44, 1);
                box-shadow: 
                    0 10px 30px rgba(166, 124, 42, 0.35),
                    0 0 40px rgba(166, 124, 42, 0.15),
                    inset 0 2px 4px rgba(255, 255, 255, 0.2),
                    inset 0 -2px 4px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
                position: relative;
                overflow: hidden;
                animation: shimmer-btn 4s ease-in-out infinite;
                cursor: pointer;
                outline: none;
            }
            .rent-now-btn::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(
                    45deg,
                    transparent 30%,
                    rgba(255, 255, 255, 0.2) 50%,
                    transparent 70%
                );
                transform: rotate(45deg);
                animation: shine-btn 4s ease-in-out infinite;
            }
            @keyframes shimmer-btn {
                0%, 100% { 
                    background-position: 0% 50%;
                }
                50% { 
                    background-position: 100% 50%;
                }
            }
            @keyframes shine-btn {
                0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
                100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
            }
            .rent-now-btn:hover {
                background: linear-gradient(135deg, #b89228 0%, #c9a33a 50%, #b89228 100%) !important;
                transform: translateY(-6px) scale(1.02);
                box-shadow: 
                    0 15px 40px rgba(184, 146, 40, 0.45),
                    0 0 60px rgba(184, 146, 40, 0.25),
                    inset 0 3px 6px rgba(255, 255, 255, 0.3),
                    inset 0 -3px 6px rgba(0, 0, 0, 0.15);
                letter-spacing: 3px;
            }
            .rent-now-btn:active {
                transform: translateY(-3px) scale(1.01);
                box-shadow: 
                    0 10px 25px rgba(184, 146, 40, 0.35),
                    inset 0 3px 10px rgba(0, 0, 0, 0.2);
            }
            .rent-now-btn:focus {
                outline: 2px solid #b89228;
                outline-offset: 2px;
            }
            
            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 10000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.6);
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                animation: fadeIn 0.3s ease;
                align-items: center;
                justify-content: center;
                overflow-y: auto;
                padding: 20px;
            }
            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
            .modal-content {
                background: #ffffff !important;
                border: none !important;
                margin: auto;
                padding: 0;
                width: 90%;
                max-width: 900px;
                border-radius: 28px;
                box-shadow: 0 25px 60px rgba(0,0,0,0.2);
                color: #2d3748 !important;
                transform: scale(0.95);
                opacity: 0;
                transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
                overflow: hidden;
                position: relative;
            }
            .modal.show-modal {
                display: flex !important;
            }
            .modal.show-modal .modal-content {
                transform: scale(1);
                opacity: 1;
            }
            .close {
                position: absolute;
                top: 20px;
                right: 20px;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: rgba(255, 255, 255, 0.8);
                border-radius: 50%;
                color: #718096 !important;
                font-size: 24px;
                font-weight: 400;
                transition: all 0.3s ease;
                cursor: pointer;
                border: 1px solid rgba(0, 0, 0, 0.06);
                line-height: 1;
                z-index: 10;
            }
            .close:hover {
                background: #1a202c;
                color: #ffffff !important;
                transform: rotate(90deg);
                border-color: #1a202c;
            }
            #accessoryName {
                font-size: 38px;
                font-weight: 900;
                margin: 0 0 12px 0;
                line-height: 1.2;
                font-family: 'Plus Jakarta Sans', sans-serif;
                letter-spacing: -0.8px;
                background: linear-gradient(135deg, #1a202c 0%, #4a5568 100%);
                background-clip: text;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            #accessoryDescription {
                color: #64748b !important;
                font-size: 17px;
                line-height: 1.7;
                margin: 0 0 30px 0;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-weight: 400;
            }
            #accessoryPrice {
                display: inline-flex;
                align-items: center;
                color: #ffffff !important;
                font-size: 24px;
                font-weight: 800;
                padding: 14px 35px;
                background: linear-gradient(135deg, #d4af37 0%, #b89228 100%);
                border: none;
                border-radius: 50px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                box-shadow: 0 10px 25px rgba(184, 146, 40, 0.35);
                text-transform: uppercase;
                letter-spacing: 1px;
                position: relative;
                overflow: hidden;
            }
            #accessoryPrice::after {
                content: '';
                position: absolute;
                top: -50%; left: -50%; width: 200%; height: 200%;
                background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
                transform: rotate(45deg);
                animation: shine-badge 3s infinite;
            }
            @keyframes shine-badge {
                0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
                100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
            }
            .modal-img-container {
                background: radial-gradient(circle at center, #ffffff 0%, #f7f9fa 100%);
                border: 1px solid rgba(184, 146, 40, 0.15);
                border-radius: 24px;
                padding: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 320px;
                position: relative;
                box-shadow: inset 0 0 30px rgba(0,0,0,0.02);
            }
            .modal-img-container::before {
                content: '';
                position: absolute;
                width: 220px;
                height: 220px;
                background: rgba(184, 146, 40, 0.05);
                border-radius: 50%;
                z-index: 0;
            }
            .modal-img-container img {
                max-width: 100%;
                max-height: 280px;
                object-fit: contain;
                z-index: 1;
                mix-blend-mode: multiply;
                transform: scale(1.05);
                transition: transform 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
            }
            .modal-img-container:hover img {
                transform: scale(1.15) rotate(-3deg);
            }
            
            @media (max-width: 767px) {
                .modal {
                    padding: 10px;
                }
                .modal-content {
                    width: 95%;
                    border-radius: 20px;
                }
                .modal-content > div {
                    padding: 30px 20px !important;
                }
                #accessoryName {
                    font-size: 28px;
                }
                #accessoryDescription {
                    font-size: 15px;
                }
                #accessoryPrice {
                    font-size: 20px;
                    padding: 12px 28px;
                }
                .modal-img-container {
                    min-height: 240px;
                    padding: 30px;
                }
                .modal-img-container img {
                    max-height: 200px;
                }
                .close {
                    width: 36px;
                    height: 36px;
                    font-size: 20px;
                    top: 15px;
                    right: 15px;
                }
            }
            .heading-section h2 {
                color: #1a202c !important;
            }
            .heading-section .subheading {
                color: #b89228 !important;
            }
            
            /* Responsive Styles */
            @media (max-width: 991px) {
                .details-sidebar {
                    position: relative;
                    top: auto;
                    margin-top: 40px;
                }
                .hero-wrap.js-fullheight {
                    height: 300px !important;
                }
                .bread {
                    font-size: 38px;
                }
                .model-title {
                    font-size: 28px;
                }
                .motorcycle-showcase {
                    min-height: 300px;
                }
            }
            
            @media (max-width: 767px) {
                .accessories-grid {
                    grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
                    gap: 15px;
                }
                .accessory-card {
                    min-height: 150px;
                    padding: 20px 15px;
                }
                .accessory-icon-wrapper {
                    width: 60px;
                    height: 60px;
                }
                .accessory-icon-wrapper i {
                    font-size: 26px !important;
                }
                .accessories-section h3 {
                    font-size: 24px;
                }
                .rent-now-btn {
                    font-size: 15px;
                    padding: 18px;
                    letter-spacing: 2px;
                }
                .bread {
                    font-size: 32px;
                }
            }
            
            @media (max-width: 575px) {
                .accessories-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
                .pricing-value {
                    font-size: 16px;
                }
                .pricing-label {
                    font-size: 13px;
                }
            }
        </style>
        </head>
        <body>

            <jsp:include page="/includes/customer/header.jsp" />
            <jsp:include page="/includes/customer/navbar.jsp" />

            <section class="ftco-section ftco-car-details">
                <div class="container">
                    <div class="row mb-4">
                        <div class="col-md-12">
                            <p class="breadcrumbs" style="font-size: 14px; text-transform: uppercase; font-weight: 600; letter-spacing: 1px; margin-bottom: 0;">
                                <span class="mr-2"><a href="home" style="color: #b89228;">Trang Chủ <i class="ion-ios-arrow-forward"></i></a></span> 
                                <span class="mr-2"><a href="motorcycle" style="color: #b89228;">Danh Sách Xe <i class="ion-ios-arrow-forward"></i></a></span> 
                                <span style="color: #999;">Chi Tiết Xe <i class="ion-ios-arrow-forward"></i></span>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <!-- Left Column: Motorcycle Hero Showcase & Accessories Grid -->
                        <div class="col-lg-7 pr-lg-5 animate__animated animate__fadeInLeft">
                            <div class="motorcycle-showcase">
                                <div class="spotlight-glow"></div>
                                <img src="${empty motorcycleDetail.image ? 'images/default.jpg' : (motorcycleDetail.image.startsWith('http') ? motorcycleDetail.image : 'images/'.concat(motorcycleDetail.image))}" 
                                     class="hero-image" 
                                     alt="${motorcycleDetail.model}"/>
                            </div>
                            
                            <!-- Accessories Section -->
                            <div class="accessories-section">
                                <h3 style="font-family: 'Times New Roman', serif; font-size: 26px; font-weight: 800; color: #1a202c; letter-spacing: 0.5px; border-bottom: 2px solid #b89228; display: inline-block; padding-bottom: 8px;">Phụ Kiện Kèm Theo</h3>
                                <div class="accessories-grid" style="margin-top: 25px;">
                                    <c:forEach items="${listAccess}" var="listAccess">
                                        <c:set var="formattedPrice">
                                            <c:choose>
                                                <c:when test="${listAccess.price == 0}">Miễn phí</c:when>
                                                <c:otherwise><fmt:formatNumber value="${listAccess.price}" pattern="#,###"/> VNĐ</c:otherwise>
                                            </c:choose>
                                        </c:set>
                                        <div class="accessory-card" style="border: 1px solid #f2e8d5; background: linear-gradient(145deg, #fff 0%, #fffdf8 100%);"
                                             onclick="openModal('${listAccess.accessoryName}', '${listAccess.accessoryDescription}', '${formattedPrice}', '${listAccess.accessoryImage}')">
                                            <div class="accessory-icon-wrapper" style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                                <img src="${empty listAccess.accessoryImage ? 'images/default.jpg' : (listAccess.accessoryImage.startsWith('http') ? listAccess.accessoryImage : 'images/'.concat(listAccess.accessoryImage))}" alt="${listAccess.accessoryName}" style="max-width: 100%; max-height: 100%; object-fit: contain; mix-blend-mode: multiply;">
                                            </div>
                                            <p class="accessory-title">${listAccess.accessoryName}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right Column: Premium Sticky Sidebar (Title, Tabs, Price List, CTA Button) -->
                        <div class="col-lg-5 mt-5 mt-lg-0 animate__animated animate__fadeInRight">
                            <div class="details-sidebar">
                                <c:forEach var="brands" items="${brand}">
                                    <c:if test="${brands.brandID == motorcycleDetail.brandID}">
                                        <span class="brand-badge">${brands.brandName}</span>
                                    </c:if>
                                </c:forEach>
                                <div class="d-flex align-items-center justify-content-between">
                                    <h1 class="model-title mb-0" style="margin-bottom: 0;">${motorcycleDetail.model}</h1>
                                    <c:if test="${sessionScope.account != null}">
                                        <button id="fav-btn" class="btn shadow-sm d-flex align-items-center justify-content-center" style="height: 45px; padding: 0 20px; font-weight: 600; border-radius: 8px; transition: all 0.3s; background-color: #c4a14b; color: white; border: none;" onclick="toggleFavorite('${motorcycleDetail.motorcycleId}')">
                                            <i class="fa-solid fa-cart-plus me-2" id="fav-icon" style="font-size: 1.2rem; transition: all 0.2s;"></i>
                                            <span id="fav-text">Thêm vào giỏ hàng</span>
                                        </button>
                                    </c:if>
                                </div>
                                <div style="margin-bottom: 24px;"></div>
                                
                                <ul class="nav nav-pills modern-tabs" id="pills-tab" role="tablist">
                                    <li class="nav-item" style="width: 50%; text-align: center;">
                                        <a class="nav-link active" id="pills-pricing-tab" data-toggle="pill" data-target="#pills-pricing" href="#pills-pricing" role="tab" aria-controls="pills-pricing" aria-selected="true">Giá Thuê</a>
                                    </li>
                                    <li class="nav-item" style="width: 50%; text-align: center;">
                                        <a class="nav-link" id="pills-manufacturer-tab" data-toggle="pill" data-target="#pills-manufacturer" href="#pills-manufacturer" role="tab" aria-controls="pills-manufacturer" aria-selected="false">Mô tả</a>
                                    </li>
                                </ul>
                                
                                <div class="tab-content" id="pills-tabContent">
                                    <!-- Pricing Tab -->
                                    <div class="tab-pane fade show active" id="pills-pricing" role="tabpanel" aria-labelledby="pills-pricing-tab">
                                        <div class="pricing-list">
                                            <div class="pricing-item">
                                                <span class="pricing-label">Giá thuê theo ngày:</span>
                                                <span class="pricing-value">
                                                    <c:choose>
                                                        <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                            <div style="font-size: 14px; color: #999; text-decoration: line-through; text-align: right;">
                                                                <fmt:formatNumber value="${priceList.dailyPriceForDay }" pattern="#,### VNĐ" />
                                                            </div>
                                                            <div style="color: #dc2626; font-size: 12px; font-weight: bold; background: #fee2e2; padding: 2px 6px; border-radius: 4px; display: inline-block; margin-bottom: 5px;">
                                                                Giảm <fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%
                                                            </div><br/>
                                                            <fmt:formatNumber value="${priceList.dailyPriceForDay * (1 - activeEvent.discount) }" pattern="#,### VNĐ" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${priceList.dailyPriceForDay }" pattern="#,### VNĐ" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <div class="pricing-item">
                                                <span class="pricing-label">Giá thuê theo tuần:</span>
                                                <span class="pricing-value">
                                                    <c:choose>
                                                        <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                            <div style="font-size: 14px; color: #999; text-decoration: line-through; text-align: right;">
                                                                <fmt:formatNumber value="${priceList.dailyPriceForWeek }" pattern="#,### VNĐ" />
                                                            </div>
                                                            <div style="color: #dc2626; font-size: 12px; font-weight: bold; background: #fee2e2; padding: 2px 6px; border-radius: 4px; display: inline-block; margin-bottom: 5px;">
                                                                Giảm <fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%
                                                            </div><br/>
                                                            <fmt:formatNumber value="${priceList.dailyPriceForWeek * (1 - activeEvent.discount) }" pattern="#,### VNĐ" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${priceList.dailyPriceForWeek }" pattern="#,### VNĐ" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <div class="pricing-item">
                                                <span class="pricing-label">Giá thuê theo tháng:</span>
                                                <span class="pricing-value">
                                                    <c:choose>
                                                        <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                            <div style="font-size: 14px; color: #999; text-decoration: line-through; text-align: right;">
                                                                <fmt:formatNumber value="${priceList.dailyPriceForMonth }" pattern="#,### VNĐ" />
                                                            </div>
                                                            <div style="color: #dc2626; font-size: 12px; font-weight: bold; background: #fee2e2; padding: 2px 6px; border-radius: 4px; display: inline-block; margin-bottom: 5px;">
                                                                Giảm <fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%
                                                            </div><br/>
                                                            <fmt:formatNumber value="${priceList.dailyPriceForMonth * (1 - activeEvent.discount) }" pattern="#,### VNĐ" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${priceList.dailyPriceForMonth }" pattern="#,### VNĐ" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Description Tab -->
                                    <div class="tab-pane fade" id="pills-manufacturer" role="tabpanel" aria-labelledby="pills-manufacturer-tab">
                                        <c:set var="desc" value="${motorcycleDetail.description}" />
                                        <c:choose>
                                            <c:when test="${empty desc || desc == 'Mô tả' || desc == 'Mô tả '}">
                                                <c:choose>
                                                    <c:when test="${motorcycleDetail.model == 'Yamaha NVX'}">
                                                        <p><strong>Yamaha NVX 155cc</strong> là dòng xe tay ga thể thao mạnh mẽ với thiết kế góc cạnh hầm hố đầy nam tính. Xe được trang bị động cơ Blue Core 155cc VVA tiên tiến, hệ thống phanh ABS chống bó cứng an toàn, khóa thông minh Smartkey tiện lợi và cổng sạc điện thoại tích hợp. NVX mang lại khả năng tăng tốc bứt phá và cảm giác vận hành vô cùng linh hoạt, là sự lựa chọn hoàn hảo cho những bạn trẻ đam mê tốc độ và phong cách năng động.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Yamaha Excite'}">
                                                        <p><strong>Yamaha Exciter 150cc (Yamaha Excite)</strong> được mệnh danh là "Ông vua đường phố" - mẫu xe côn tay huyền thoại được yêu thích nhất tại Việt Nam. Sở hữu khối động cơ 150cc mạnh mẽ, hộp số côn tay 5 cấp linh hoạt, và thiết kế khí động học đậm chất thể thao GP, Exciter mang lại khả năng bứt tốc vượt trội và trải nghiệm ôm cua, côn tay vô cùng phấn khích. Xe cực kỳ thích hợp cho các hành trình phượt xa lẫn di chuyển năng động hàng ngày.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Yamaha Sirius'}">
                                                        <p><strong>Yamaha Sirius 110cc</strong> là dòng xe số quốc dân nổi tiếng với sự bền bỉ, thiết kế gọn gàng tinh tế và khả năng vận hành vô cùng tiết kiệm nhiên liệu. Sở hữu động cơ 110cc 4 thì bền bỉ, khả năng tăng tốc mượt mà và cảm giác lái nhẹ nhàng, Sirius là người bạn đồng hành tin cậy cho mọi phân khúc khách hàng di chuyển hàng ngày trong đô thị hay đi học, đi làm.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Yamaha Sirius RC'}">
                                                        <p><strong>Yamaha Sirius RC 110cc</strong> kết hợp giữa động cơ 110cc bền bỉ siêu tiết kiệm xăng và bộ tem RC thể thao cá tính, vành đúc chắc chắn. Dòng xe này mang lại trải nghiệm lái xe linh hoạt, nhẹ nhàng và an toàn, cực kỳ phù hợp cho học sinh, sinh viên và nhân viên văn phòng đi lại hàng ngày.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Yamaha YZF-R15'}">
                                                        <p><strong>Yamaha YZF-R15 155cc</strong> là mẫu xe sportbike phân khối nhỏ kế thừa DNA đường đua từ dòng R-Series huyền thoại của Yamaha. Thiết kế khí động học hầm hố, tư thế ngồi lái thể thao chồm người phía trước, động cơ 155cc tích hợp van biến thiên VVA và bộ ly hợp chống trượt Slipper Clutch mang đến cảm giác vận hành mạnh mẽ, phấn khích và tốc độ cực đỉnh trên mọi cung đường.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Honda Air Blade'}">
                                                        <p><strong>Honda Air Blade 160cc</strong> là mẫu xe tay ga thể thao sang trọng bán chạy hàng đầu tại Việt Nam. Thiết kế lịch lãm, hiện đại kết hợp với khối động cơ eSP+ 160cc 4 van thế hệ mới mang lại sức mạnh bứt phá vượt trội nhưng vẫn êm ái, tiết kiệm xăng. Xe được trang bị phanh ABS, hộc chứa đồ siêu rộng có đèn soi và cổng sạc USB, đem lại sự tiện nghi và đẳng cấp tối đa cho người lái.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Honda Vario'}">
                                                        <p><strong>Honda Vario 125cc</strong> là dòng xe tay ga nhập khẩu vô cùng cá tính với những đường nét góc cạnh thể thao, năng động. Động cơ eSP 125cc thông minh, tiết kiệm nhiên liệu vượt trội cùng sàn để chân rộng rãi và cốp xe tiện ích giúp Vario trở thành sự lựa chọn hoàn hảo cho việc đi lại linh hoạt, phong cách hàng ngày trong thành phố.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Honda Future'}">
                                                        <p><strong>Honda Future 125cc</strong> là dòng xe số cao cấp hàng đầu của Honda, nổi tiếng với thiết kế lịch lãm giống xe ga và khả năng tiết kiệm xăng vượt trội hàng đầu phân khúc. Động cơ 125cc bền bỉ, êm ái, cốp xe U-box tiện lợi đựng được mũ bảo hiểm nửa đầu đem lại cảm giác lái đầm chắc, thư thái và vô cùng tiết kiệm cho những hành trình dài.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Honda Winner X'}">
                                                        <p><strong>Honda Winner X 150cc</strong> là mẫu xe côn tay thể thao hàng đầu đầy góc cạnh, hiện đại từ Honda. Với thiết kế pô uy lực, phanh ABS bánh trước chống trượt, động cơ DOHC 150cc 6 cấp số mạnh mẽ vượt trội, Winner X đem đến khả năng tăng tốc bứt phá phấn khích, đầm chắc ở tốc độ cao, là chiến hữu đích thực cho mọi chuyến đi phượt và chinh phục các cung đường.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Honda CBR150R'}">
                                                        <p><strong>Honda CBR150R 150cc</strong> là dòng xe sportbike đô thị đẳng cấp mang phong cách thiết kế từ đàn anh CBR250RR đầy góc cạnh. Trang bị phuộc trước hành trình ngược Upside Down cao cấp, ly hợp hỗ trợ và chống trượt hai chiều cùng động cơ DOHC 150cc cực kỳ mạnh mẽ mang lại trải nghiệm ôm cua, bứt tốc thể thao đỉnh cao.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Suzuki RAIDER R150'}">
                                                        <p><strong>Suzuki Raider R150 150cc</strong> là dòng xe côn tay phân khúc Hyper Underbone huyền thoại với biệt danh "vua tốc độ". Thiết kế gọn nhẹ độc đáo tối ưu khí động học kết hợp cùng khối động cơ DOHC cam kép 150cc, làm mát bằng dung dịch cho khả năng bứt tốc từ ga đầu cực kỳ kinh ngạc, mang lại cảm giác phấn khích tột độ cho người mê tốc độ.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Suzuki SATRIA F150'}">
                                                        <p><strong>Suzuki Satria F150 150cc</strong> nhập khẩu nguyên chiếc là mẫu xe Hyper Underbone thể thao đầy cá tính. Sở hữu sức mạnh bứt phá ga đầu ấn tượng từ động cơ 150cc cam kép DOHC mạnh mẽ, khả năng điều khiển linh hoạt luồn lách trên mọi con phố đông đúc giúp Satria trở thành dòng xe côn tay được săn đón hàng đầu.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Suzuki GSX R150'}">
                                                        <p><strong>Suzuki GSX-R150 150cc</strong> là mẫu xe sportbike có tỉ lệ công suất trên trọng lượng tối ưu nhất phân khúc. Thiết kế khí động học lấy cảm hứng từ dòng GSX-R danh tiếng, động cơ DOHC 150cc mạnh mẽ vượt trội đem lại tốc độ bứt phá kinh ngạc, là chiếc xe lý tưởng cho những tín đồ đam mê tốc độ và đường đua chuyên nghiệp.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Sym Galaxy'}">
                                                        <p><strong>Sym Galaxy 50cc</strong> là dòng xe số thể thao cá tính không cần bằng lái, vô cùng được ưa chuộng bởi học sinh và sinh viên. Thiết kế trẻ trung với góc cạnh cá tính, động cơ 50cc êm ái, hoạt động siêu tiết kiệm xăng giúp việc di chuyển đến trường, đi dạo phố trở nên vô cùng an toàn, tiết kiệm và nhẹ nhàng.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Sym Attila'}">
                                                        <p><strong>Sym Attila 50cc</strong> là biểu tượng xe tay ga cổ điển dành riêng cho phái đẹp không cần bằng lái. Thiết kế kiểu dáng Ý thanh lịch, cốp xe siêu rộng đựng nhiều đồ dùng cá nhân, cùng khối động cơ 50cc êm ái, dễ vận hành giúp mọi hành trình dạo phố của bạn trở nên vô cùng nhẹ nhàng, quý phái.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Sym Elegant'}">
                                                        <p><strong>Sym Elegant 50cc</strong> là dòng xe số 50cc bền bỉ, tiết kiệm xăng cực tốt và thân thiện với học sinh, sinh viên chưa có bằng lái. Thiết kế thon gọn lịch lãm, tay lái đầm chắc, phuộc nhún êm ái đem lại trải nghiệm di chuyển cực kỳ ổn định, an toàn trên mọi con đường thành phố.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'VinFast Evo200'}">
                                                        <p><strong>VinFast Evo200</strong> là mẫu xe máy điện thông minh thế hệ mới từ VinFast sở hữu thiết kế Châu Âu thanh lịch. Sử dụng pin LFP tiên tiến cho quãng đường di chuyển lên tới hơn 200km mỗi lần sạc đầy, động cơ điện êm ái chống nước tuyệt đối tiêu chuẩn IP67, đem lại giải pháp di chuyển xanh đột phá và cực kỳ kinh tế.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'VinFast Klara S'}">
                                                        <p><strong>VinFast Klara S</strong> là mẫu xe máy điện cao cấp đầy kiêu hãnh được ví như "viên ngọc" đô thị. Xe tích hợp động cơ Bosch 1200W mạnh mẽ, hệ thống 2 pin Lithium tiên tiến siêu bền bỉ, tính năng kết nối điện thoại thông minh định vị GPS mang lại hành trình di chuyển êm ái, sang trọng và hiện đại.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Piaggio Liberty'}">
                                                        <p><strong>Piaggio Liberty 150cc</strong> là mẫu xe tay ga cao cấp mang đậm phong cách thời trang Ý thanh lịch và thời thượng. Thiết kế bánh xe lớn vững chãi, hệ thống phanh ABS bánh trước an toàn tuyệt đối và động cơ i-Get thế hệ mới tiết kiệm nhiên liệu mang lại trải nghiệm di chuyển vô cùng đẳng cấp và cuốn hút.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Piaggio Medley'}">
                                                        <p><strong>Piaggio Medley 150cc</strong> là mẫu xe tay ga bánh lớn cao cấp tích hợp nhiều công nghệ tối tân từ Piaggio. Động cơ i-Get 150cc phun xăng điện tử làm mát bằng dung dịch mạnh mẽ, cốp xe siêu khủng chứa được 2 mũ bảo hiểm cả đầu và phanh ABS đôi bánh trước sau mang lại sự tiện nghi tối đa.</p>
     ãng đường di chuyển lên tới hơn 200km mỗi lần sạc đầy, động cơ điện êm ái chống nước tuyệt đối tiêu chuẩn IP67, đem lại giải pháp di chuyển xanh đột phá và cực kỳ kinh tế.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'VinFast Klara S'}">
                                                        <p><strong>VinFast Klara S</strong> là mẫu xe máy điện cao cấp đầy kiêu hãnh được ví như "viên ngọc" đô thị. Xe tích hợp động cơ Bosch 1200W mạnh mẽ, hệ thống 2 pin Lithium tiên tiến siêu bền bỉ, tính năng kết nối điện thoại thông minh định vị GPS mang lại hành trình di chuyển êm ái, sang trọng và hiện đại.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Piaggio Liberty'}">
                                                        <p><strong>Piaggio Liberty 150cc</strong> là mẫu xe tay ga cao cấp mang đậm phong cách thời trang Ý thanh lịch và thời thượng. Thiết kế bánh xe lớn vững chãi, hệ thống phanh ABS bánh trước an toàn tuyệt đối và động cơ i-Get thế hệ mới tiết kiệm nhiên liệu mang lại trải nghiệm di chuyển vô cùng đẳng cấp và cuốn hút.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Piaggio Medley'}">
                                                        <p><strong>Piaggio Medley 150cc</strong> là mẫu xe tay ga bánh lớn cao cấp tích hợp nhiều công nghệ tối tân từ Piaggio. Động cơ i-Get 150cc phun xăng điện tử làm mát bằng dung dịch mạnh mẽ, cốp xe siêu khủng chứa được 2 mũ bảo hiểm cả đầu và phanh ABS đôi bánh trước sau mang lại sự tiện nghi tối đa.</p>
                                                    </c:when>
                                                    <c:when test="${motorcycleDetail.model == 'Piaggio Fly'}">
                                                        <p><strong>Piaggio Fly 120cc (hoặc Fly 50cc)</strong> là mẫu xe tay ga thời trang châu Âu vô cùng thực dụng, đầm chắc. Sàn để chân rộng rãi, thiết kế cổ điển bền bỉ theo thời gian và động cơ êm ái đem lại cảm giác dạo phố nhẹ nhàng, đầm ấm và vô cùng an toàn cho cả gia đình.</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p><strong>${motorcycleDetail.model}</strong> là dòng xe chất lượng cao mang lại sự bền bỉ, êm ái và siêu tiết kiệm nhiên liệu cho mọi chuyến hành trình của bạn. Xe được bảo dưỡng định kỳ cẩn thận, cam kết trạng thái hoạt động tốt nhất trước khi bàn giao cho khách hàng.</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <p>${desc}</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <!-- Modern Rent CTA Button -->
                                <button class="rent-now-btn" onclick="redirectToBooking(event, '${motorcycleDetail.motorcycleId}')">
                                    THUÊ XE NGAY
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            
            <!-- Polish Modal definition -->
            <div id="myModal" class="modal">
                <div class="modal-content" style="position: relative; padding: 40px; overflow: hidden;">
                    <span class="close" onclick="closeModal()" style="position: absolute; top: 20px; right: 25px; z-index: 10; font-size: 32px; color: #a0aec0 !important;">&times;</span>
                    <div class="row align-items-center" id="accessoryForm">
                        <div class="col-md-6 pr-md-5 text-left" style="text-align: left;">
                            <h2 id="accessoryName"></h2>
                            <p id="accessoryDescription"></p>
                            <h3 id="accessoryPrice"></h3>
                        </div>
                        <div class="col-md-6 mt-4 mt-md-0">
                            <div class="modal-img-container">
                                <img id="accessoryImage" src="" alt="Accessory Image">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- REVIEWS SECTION -->
            <section style="padding: 70px 0; background: #f4f5f8;">
                <div class="container">
                    <!-- Header -->
                    <div class="d-flex align-items-center justify-content-between flex-wrap mb-5" style="gap:16px;">
                        <div>
                            <div style="display:flex;align-items:center;gap:10px;margin-bottom:8px;">
                                <span style="width:40px;height:2px;background:linear-gradient(90deg,transparent,#b59349);display:block;"></span>
                                <span style="color:#b59349;font-size:12px;font-weight:800;text-transform:uppercase;letter-spacing:3px;">Nhận Xét Thực Tế</span>
                                <span style="width:40px;height:2px;background:linear-gradient(270deg,transparent,#b59349);display:block;"></span>
                            </div>
                            <h2 style="font-family:'Times New Roman',serif;font-weight:800;color:#1a202c;font-size:34px;margin:0;">Đánh Giá Từ Khách Hàng</h2>
                            <p style="color:#718096;font-size:14px;margin-top:6px;">Nhận xét thực tế về <strong>${motorcycleDetail.model}</strong></p>
                        </div>
                        <div id="write-review-area" style="text-align:right;">
                            <!-- Blocked State -->
                            <div id="review-blocked-msg" style="display:inline-block; text-align:right;">
                                <span style="display:inline-flex; align-items:center; padding:10px 24px; border-radius:50px; background:#f8fafc; color:#94a3b8; font-weight:600; font-size:14px; cursor:not-allowed; border:1px dashed #cbd5e1;">
                                    <i class="fas fa-lock mr-2"></i> Viết Đánh Giá
                                </span>
                                <p style="color:#718096; font-size:12px; margin-top:8px; margin-bottom:0; font-style:italic;">
                                    Trải nghiệm chuyến đi cùng <strong>${motorcycleDetail.model}</strong> để mở khóa tính năng đánh giá.
                                </p>
                            </div>
                            
                            <!-- Enabled State -->
                            <a id="write-review-btn" href="#"
                               style="display:none; background:linear-gradient(135deg,#b59349,#d4af37);color:white;padding:13px 30px;border-radius:50px;font-weight:700;font-size:14px;text-decoration:none;box-shadow:0 4px 15px rgba(181,147,73,0.35);align-items:center;gap:9px;transition:all 0.3s;"
                               onmouseover="this.style.transform='scale(1.04)'" onmouseout="this.style.transform='scale(1)'">
                                <i class="fas fa-pen"></i> Viết Đánh Giá Của Bạn
                            </a>
                        </div>
                    </div>

                    <div class="row">
                        <!-- LEFT: Rating Summary Panel -->
                        <div class="col-md-4 mb-4">
                            <div id="rating-summary-panel" style="background:white;border-radius:20px;padding:32px 28px;box-shadow:0 4px 24px rgba(0,0,0,0.07);height:100%;display:flex;flex-direction:column;align-items:center;justify-content:center;text-align:center;">
                                <div id="avg-score" style="font-size:64px;font-weight:900;color:#b59349;line-height:1;font-family:'Times New Roman',serif;">—</div>
                                <div id="avg-stars" style="font-size:26px;color:#b59349;letter-spacing:4px;margin:8px 0;">☆☆☆☆☆</div>
                                <div id="total-reviews" style="color:#a0aec0;font-size:13px;margin-bottom:24px;">Chưa có đánh giá</div>
                                <div id="star-bars" style="width:100%;">
                                    <!-- Filled by JS -->
                                </div>
                            </div>
                        </div>

                        <!-- RIGHT: Reviews List -->
                        <div class="col-md-8">
                            <div class="row" id="reviews-container">
                                <div class="col-12 text-center" style="padding:60px 0;">
                                    <div style="width:48px;height:48px;border:4px solid #f3e7c8;border-top-color:#b59349;border-radius:50%;animation:spin 1s linear infinite;margin:0 auto;"></div>
                                    <p style="color:#a0aec0;margin-top:14px;">Đang tải đánh giá...</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <style>
                @keyframes spin{to{transform:rotate(360deg)}}
                .bar-fill { transition: width 0.8s cubic-bezier(.4,0,.2,1); }
            </style>
            <!-- END REVIEWS -->

            <section class="ftco-section ftco-no-pt" style="margin-top: 50px;">
                <div class="container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-md-12 text-center mb-5" style="opacity: 1; transform: none;">
                            <div style="display: inline-flex; align-items: center; justify-content: center; gap: 15px; margin-bottom: 15px;">
                                <span style="display: block; width: 50px; height: 2px; background: linear-gradient(90deg, transparent, #b89228);"></span>
                                <span style="color: #b89228; font-family: 'Plus Jakarta Sans', sans-serif; font-size: 13px; font-weight: 800; text-transform: uppercase; letter-spacing: 3px;">Khám Phá Thêm</span>
                                <span style="display: block; width: 50px; height: 2px; background: linear-gradient(270deg, transparent, #b89228);"></span>
                            </div>
                            <h2 style="font-family: 'Times New Roman', serif; font-size: 42px; font-weight: 800; color: #1a202c; margin-bottom: 0; letter-spacing: 1px;">Các Mẫu Xe Tương Tự</h2>
                            <a href="motorcycle" style="display: inline-flex; align-items: center; gap: 8px; margin-top: 25px; padding: 12px 30px; background: transparent; color: #b89228; border: 2px solid #b89228; border-radius: 50px; font-weight: 700; font-size: 14px; text-transform: uppercase; letter-spacing: 1px; transition: all 0.3s; text-decoration: none;" onmouseover="this.style.background='#b89228'; this.style.color='#fff';" onmouseout="this.style.background='transparent'; this.style.color='#b89228';">
                                Xem Toàn Bộ Xe <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    <iframe src="slide.jsp" style="width: 100%;
                            height: 540px;
                            border: none;
                            background: transparent;
                            padding: 0;
                            margin: 0;"
                            allowtransparency="true"></iframe>
                </div>
            </section>


            <jsp:include page="/includes/customer/footer.jsp" />



            <!-- loader -->
            <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


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
            <script src="js/google-map.js"></script>
            <script src="js/main.js"></script>

        </body>
        <script>
            function openModal(name, description, price, imageSrc) {
                document.getElementById('accessoryName').textContent = name;
                document.getElementById('accessoryDescription').textContent = description;
                document.getElementById('accessoryPrice').textContent = price;
                document.getElementById('accessoryImage').src = 'images/' + imageSrc;
                var modal = document.getElementById('myModal');
                modal.style.display = 'flex';
                setTimeout(function() {
                    modal.classList.add('show-modal');
                }, 10);
            }
            function closeModal() {
                var modal = document.getElementById('myModal');
                modal.classList.remove('show-modal');
                setTimeout(function() {
                    modal.style.display = 'none';
                }, 300);
            }

            window.onclick = function (event) {
                var modal = document.getElementById("myModal");
                if (event.target === modal) {
                    closeModal();
                }
            }
            window.onkeydown = function (event) {
                var modal = document.getElementById("myModal");
                if (event.key === "Escape" || event.key === "Esc") {
                    closeModal();
                }
            }
        </script>
        <script>
            function redirectToBooking(event, motorcycleId) {
                event.preventDefault(); // Prevent the default anchor behavior
                window.top.location.href = 'booking?motorcycleid=' + motorcycleId;// Redirect to the booking page
            }
        </script>
        <script>
            // AJAX for Favorites
            function checkFavoriteStatus(motorcycleId) {
                fetch('favorite?action=check&motorcycleId=' + motorcycleId, { method: 'POST' })
                .then(res => res.json())
                .then(data => {
                    if(data.status === 'success') {
                        var icon = document.getElementById('fav-icon');
                        var btn = document.getElementById('fav-btn');
                        if(data.isFavorite) {
                            btn.style.background = '#28a745';
                            btn.style.borderColor = '#28a745';
                            btn.style.color = '#ffffff';
                            icon.className = 'fa-solid fa-cart-arrow-down';
                            icon.style.color = '#ffffff';
                            icon.style.transform = 'scale(1.15)';
                            btn.classList.add('added');
                            var textEl = document.getElementById('fav-text');
                            if(textEl) textEl.innerText = 'Đã thêm vào giỏ';
                        } else {
                            btn.style.background = '#c4a14b';
                            btn.style.borderColor = '#c4a14b';
                            btn.style.color = '#ffffff';
                            icon.className = 'fa-solid fa-cart-plus';
                            icon.style.color = '#ffffff';
                            icon.style.transform = 'scale(1)';
                            btn.classList.remove('added');
                            var textEl = document.getElementById('fav-text');
                            if(textEl) textEl.innerText = 'Thêm vào giỏ hàng';
                        }
                    }
                });
            }

            function toggleFavorite(motorcycleId) {
                var btn = document.getElementById('fav-btn');
                var isFav = btn.classList.contains('added');
                var action = isFav ? 'remove' : 'add';
                
                fetch('favorite?action=' + action + '&motorcycleId=' + motorcycleId, { method: 'POST' })
                .then(res => res.json())
                .then(data => {
                    if(data.status === 'success') {
                        checkFavoriteStatus(motorcycleId);
                        window.postMessage('fav_updated', '*');
                    } else if(data.status === 'unauthorized') {
                        window.location.href = 'login.jsp';
                    }
                });
            }

            // Kiểm tra khách có đủ điều kiện viết feedback không
            function checkReviewEligibility(motorcycleId) {
                fetch('feedback?action=checkEligible&motorcycleId=' + motorcycleId)
                .then(res => res.json())
                .then(data => {
                    if (data.eligible && data.bookingId) {
                        var btn = document.getElementById('write-review-btn');
                        var blockedMsg = document.getElementById('review-blocked-msg');
                        if (btn && blockedMsg) {
                            btn.href = 'feedback?bookingId=' + data.bookingId;
                            btn.style.display = 'inline-flex';
                            blockedMsg.style.display = 'none';
                        }
                    }
                }).catch(() => {});
            }

            function renderStars(score, size) {
                size = size || 18;
                var html = '';
                for (var i = 1; i <= 5; i++) {
                    if (i <= Math.floor(score)) {
                        html += '<i class="fas fa-star" style="color:#f59e0b;font-size:' + size + 'px;"></i>';
                    } else if (i - score < 1 && i - score > 0) {
                        html += '<i class="fas fa-star-half-alt" style="color:#f59e0b;font-size:' + size + 'px;"></i>';
                    } else {
                        html += '<i class="far fa-star" style="color:#e2e8f0;font-size:' + size + 'px;"></i>';
                    }
                }
                return html;
            }

            function fetchReviews(motorcycleId) {
                fetch('feedback?action=getByMotorcycle&motorcycleId=' + motorcycleId)
                .then(res => res.json())
                .then(data => {
                    var container = document.getElementById('reviews-container');

                    if (!data || data.length === 0) {
                        // Rating panel: no data
                        document.getElementById('avg-score').textContent = '—';
                        document.getElementById('avg-stars').innerHTML = renderStars(0, 20);
                        document.getElementById('total-reviews').textContent = 'Chưa có đánh giá nào';
                        document.getElementById('star-bars').innerHTML = '';

                        container.innerHTML =
                            '<div class="col-12 text-center" style="padding:60px 0;">' +
                            '<div style="width:72px;height:72px;background:#f3e7c8;border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">' +
                            '<i class="fas fa-comment-dots" style="font-size:28px;color:#b59349;"></i></div>' +
                            '<h5 style="color:#4a5568;font-weight:700;">Chưa có đánh giá nào</h5>' +
                            '<p style="color:#a0aec0;font-size:14px;">Hãy là người đầu tiên chia sẻ trải nghiệm về xe này!</p>' +
                            '</div>';
                        return;
                    }

                    // === Compute Summary ===
                    var total = data.length;
                    var sumAvg = 0;
                    var counts = {1:0, 2:0, 3:0, 4:0, 5:0};
                    data.forEach(function(fb) {
                        var avg = (fb.productRate + fb.serviceRate) / 2;
                        sumAvg += avg;
                        var rounded = Math.round(avg);
                        if (rounded >= 1 && rounded <= 5) counts[rounded]++;
                    });
                    var overallAvg = (sumAvg / total).toFixed(1);

                    // Rating panel
                    document.getElementById('avg-score').textContent = overallAvg;
                    document.getElementById('avg-stars').innerHTML = renderStars(parseFloat(overallAvg), 22);
                    document.getElementById('total-reviews').textContent = total + ' lượt đánh giá';

                    var barsHtml = '';
                    for (var s = 5; s >= 1; s--) {
                        var pct = total > 0 ? Math.round((counts[s] / total) * 100) : 0;
                        barsHtml +=
                            '<div style="display:flex;align-items:center;gap:8px;margin-bottom:10px;">' +
                            '<span style="font-size:12px;color:#4a5568;font-weight:700;min-width:14px;">' + s + '</span>' +
                            '<i class="fas fa-star" style="color:#f59e0b;font-size:12px;"></i>' +
                            '<div style="flex:1;height:8px;background:#f1f5f9;border-radius:99px;overflow:hidden;">' +
                            '<div class="bar-fill" style="height:100%;width:' + pct + '%;background:linear-gradient(90deg,#f59e0b,#b59349);border-radius:99px;"></div>' +
                            '</div>' +
                            '<span style="font-size:11px;color:#a0aec0;min-width:28px;text-align:right;">' + pct + '%</span>' +
                            '</div>';
                    }
                    document.getElementById('star-bars').innerHTML = barsHtml;

                    // === Render Review Cards (single column in right panel) ===
                    var html = '';
                    data.forEach(function(fb) {
                        var img = fb.customerImage ? fb.customerImage : 'images/avarta.jpg';
                        var name = fb.customerName ? fb.customerName : 'Khách hàng';
                        var avgRate = (fb.productRate + fb.serviceRate) / 2;

                        html += '<div class="col-12 mb-3">';
                        html += '<div style="background:white;border-radius:16px;padding:20px 24px;box-shadow:0 2px 12px rgba(0,0,0,0.06);border-left:4px solid #b59349;transition:transform 0.2s,box-shadow 0.2s;" ' +
                                'onmouseover="this.style.transform=\'translateY(-3px)\';this.style.boxShadow=\'0 8px 24px rgba(181,147,73,0.15)\'" ' +
                                'onmouseout="this.style.transform=\'none\';this.style.boxShadow=\'0 2px 12px rgba(0,0,0,0.06)\'">';

                        // Top row: avatar + name + stars + date
                        html += '<div style="display:flex;align-items:center;gap:14px;margin-bottom:12px;">';
                        html += '<img src="' + img + '" style="width:48px;height:48px;border-radius:50%;object-fit:cover;border:3px solid #f3e7c8;">';
                        html += '<div style="flex:1;">';
                        html += '<div style="display:flex;align-items:center;justify-content:space-between;">';
                        html += '<span style="font-weight:700;color:#1a202c;font-size:15px;">' + name + '</span>';
                        html += '<span style="font-size:11px;color:#a0aec0;"><i class="fas fa-clock" style="margin-right:4px;"></i>' + (fb.feedbackTime || '') + '</span>';
                        html += '</div>';
                        html += '<div style="margin-top:4px;">' + renderStars(avgRate, 14) + '</div>';
                        html += '</div></div>';

                        // Rating badges
                        html += '<div style="display:flex;flex-wrap:wrap;gap:8px;margin-bottom:12px;">';
                        html += '<span style="background:#fef9ec;color:#b59349;border:1px solid #f3e7c8;border-radius:20px;padding:3px 12px;font-size:11px;font-weight:700;">' +
                                '<i class="fas fa-motorcycle" style="margin-right:4px;"></i>Xe: ' + renderStars(fb.productRate, 11) + '</span>';
                        html += '<span style="background:#ecfdf5;color:#059669;border:1px solid #d1fae5;border-radius:20px;padding:3px 12px;font-size:11px;font-weight:700;">' +
                                '<i class="fas fa-headset" style="margin-right:4px;"></i>Dịch vụ: ' + renderStars(fb.serviceRate, 11) + '</span>';
                        html += '</div>';

                        // Comment
                        html += '<p style="color:#4a5568;font-style:italic;font-size:14px;line-height:1.7;margin:0;padding:12px 16px;background:#fafafa;border-radius:10px;">' +
                                '"' + fb.content + '"</p>';
                        html += '</div></div>';
                    });
                    container.innerHTML = html;

                }).catch(function() {
                    document.getElementById('reviews-container').innerHTML =
                        '<div class="col-12 text-center text-muted" style="padding:40px;">Không thể tải đánh giá.</div>';
                });
            }

            document.addEventListener("DOMContentLoaded", function() {
                var mid = '${motorcycleDetail.motorcycleId}';
                if (document.getElementById('fav-btn')) checkFavoriteStatus(mid);
                checkReviewEligibility(mid);
                fetchReviews(mid);
                setInterval(function() { fetchReviews(mid); }, 15000);
            });
        </script>
    </html>

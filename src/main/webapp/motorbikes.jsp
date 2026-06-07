<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <meta charset="UTF-8">
        <title>Danh Sách Xe Máy - SmartRide</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        
        <jsp:include page="/includes/customer/header.jsp" />
        <!-- thanh search -->
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&display=swap');

            .filter-module {
                background: #ffffff;
                margin: 40px auto;
                max-width: 1200px;
                box-sizing: border-box;
                box-shadow: 0 15px 50px rgba(0, 0, 0, 0.08);
                border: 1px solid rgba(0, 0, 0, 0.04);
                border-radius: 20px;
                padding: 24px 32px;
                width: 95%;
                position: relative;
                z-index: 99999;
                overflow: visible !important;
            }

            .xemketqua {
                background: #b59349 !important;
                color: white !important;
                border: 1px solid #b59349 !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                transition: all 0.3s ease !important;
            }

            .xemketqua:hover {
                background: #a38241 !important;
                border-color: #a38241 !important;
                color: white !important;
            }

            .filter-container {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                justify-content: space-between;
                gap: 20px;
            }

            .filter-group {
                position: relative;
                z-index: 9999;
                overflow: visible !important;
            }

            .filter-button {
                padding: 12px 24px;
                border: 1px solid rgba(181, 147, 73, 0.2);
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-weight: 600;
                background: #fcfbf9;
                color: #1a1816;
                cursor: pointer;
                border-radius: 30px;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .filter-button:hover, .filter-button.has-active-filter {
                color: #fff !important;
                background: #b59349;
                border-color: #b59349;
            }

            .filter-options {
                color: #1a1816;
                top: calc(100% + 15px);
                left: 50%;
                transform: translateX(-50%);
                position: absolute;
                z-index: 9999;
                background-color: #fff;
                border: 1px solid rgba(181, 147, 73, 0.15);
                border-radius: 16px;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
                opacity: 0;
                padding: 12px;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                min-width: 220px;
                max-width: 280px;
                display: none;
            }

            .filter-options button {
                width: 100%;
                padding: 10px 16px;
                border: none;
                background: transparent;
                cursor: pointer;
                border-radius: 8px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-weight: 500;
                font-size: 0.95rem;
                transition: all 0.2s ease;
                color: #1a1816;
                text-align: left;
            }

            .filter-options:before {
                border-bottom: 10px solid rgba(181, 147, 73, 0.15);
                border-left: 10px solid transparent;
                border-right: 10px solid transparent;
                content: "";
                left: 50%;
                transform: translateX(-50%);
                position: absolute;
                top: -10px;
            }

            .filter-options:after {
                border-bottom: 10px solid #fff;
                border-left: 10px solid transparent;
                border-right: 10px solid transparent;
                content: "";
                left: 50%;
                transform: translateX(-50%);
                position: absolute;
                top: -9px;
            }

            .filter-options button:hover {
                background-color: rgba(181, 147, 73, 0.08);
                color: #b59349;
            }

            .filter-options button.selected {
                background: rgba(181, 147, 73, 0.1) !important;
                color: #b59349 !important;
                font-weight: 600;
            }

            .show-options {
                display: flex !important;
                flex-direction: column;
                gap: 2px;
                opacity: 1 !important;
            }

            .filter-group .filter-button:after {
                content: ' â–¼';
                font-size: 0.8em;
                opacity: 0.7;
            }
            .filter-group .filter-button.open:after {
                content: ' â–²';
                font-size: 0.8em;
                opacity: 0.7;
            }
            .filter-group .filter-button.xemketqua:after {
                content: none;
            }

            /* Selected Filters Premium Badges Styling */
            .selected-filters {
                margin-top: 20px !important;
                padding: 16px 20px !important;
                background: #fdfcf7 !important;
                border: 1px solid rgba(181, 147, 73, 0.12) !important;
                border-radius: 12px !important;
                display: flex !important;
                flex-wrap: wrap !important;
                align-items: center !important;
                gap: 12px !important;
                animation: fadeIn 0.4s ease-out !important;
            }

            .selected-filters:empty {
                display: none !important;
                padding: 0 !important;
                margin: 0 !important;
                border: none !important;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(4px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .selected-filters h2 {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 14px !important;
                font-weight: 700 !important;
                color: #1a1816 !important;
                margin: 0 !important;
                text-transform: uppercase !important;
                letter-spacing: 0.5px !important;
            }

            .selected-filter {
                background: #ffffff !important;
                border: 1px solid rgba(181, 147, 73, 0.2) !important;
                color: #1a1816 !important;
                padding: 8px 14px !important;
                border-radius: 20px !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 13px !important;
                font-weight: 500 !important;
                display: inline-flex !important;
                align-items: center !important;
                gap: 8px !important;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02) !important;
                transition: all 0.2s ease !important;
            }

            .selected-filter:hover {
                border-color: #b59349 !important;
                color: #b59349 !important;
                transform: translateY(-1px) !important;
            }

            .remove-filter {
                cursor: pointer;
                color: #b59349;
                font-weight: bold;
                margin-left: 4px;
                transition: color 0.2s ease;
            }

            .remove-filter:hover {
                color: #a38241;
            }

            .clear-all-filter {
                background: rgba(181, 147, 73, 0.08) !important;
                border: 1px dashed #b59349 !important;
                color: #b59349 !important;
                padding: 8px 14px !important;
                border-radius: 20px !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 13px !important;
                font-weight: 600 !important;
                cursor: pointer !important;
                transition: all 0.2s ease !important;
            }

            .clear-all-filter:hover {
                background: #b59349 !important;
                color: #fff !important;
            }

            .filter-search input {
                border: 1px solid rgba(181, 147, 73, 0.3) !important;
            }
            .filter-search input:focus {
                border-color: #b59349 !important;
                box-shadow: 0 0 0 0.2rem rgba(181, 147, 73, 0.25) !important;
            }

            .filter-search button:hover {
                opacity: 0.9;
            }

            .button-item-option {
                /* Removed width constraint so it uses flex layout from .show-options */
            }

            /* Search and filter panel */
            .vehicle-filter-shell {
                max-width: 1240px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .filter-module {
                width: 100%;
                max-width: none;
                margin: 0;
                padding: 30px;
                border: 1px solid #ece5d8;
                border-radius: 24px;
                background:
                    radial-gradient(circle at top right, rgba(181, 147, 73, 0.1), transparent 32%),
                    #ffffff;
                box-shadow: 0 18px 55px rgba(42, 34, 24, 0.08);
                z-index: 100;
            }

            .filter-heading {
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 24px;
                margin-bottom: 28px;
            }

            .filter-eyebrow {
                display: block;
                margin-bottom: 5px;
                color: #b59349;
                font-size: 13px;
                font-weight: 800;
                letter-spacing: 1.5px;
                text-transform: uppercase;
            }

            .filter-heading h2 {
                margin: 0;
                color: #1a1816;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 30px;
                font-weight: 800;
                letter-spacing: -0.5px;
            }

            .filter-heading p {
                max-width: 430px;
                margin: 0;
                color: #7a746d;
                font-size: 15px;
                line-height: 1.6;
                text-align: right;
            }

            .filter-search-form {
                display: flex;
                align-items: center;
                background: #ffffff;
                border: 1px solid rgba(181, 147, 73, 0.2) !important;
                border-radius: 100px;
                padding: 6px 6px 6px 0;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.04);
                transition: all 0.3s ease;
                width: 100%;
                margin-bottom: 28px;
            }

            .filter-search-form:focus-within {
                box-shadow: 0 12px 32px rgba(181, 147, 73, 0.15);
                border-color: #b59349 !important;
                transform: translateY(-2px);
            }

            .filter-search-field {
                flex-grow: 1;
                position: relative;
                display: flex;
                align-items: center;
            }

            .filter-search-field .search-icon {
                position: absolute;
                left: 24px;
                color: #b59349;
                font-size: 20px;
                pointer-events: none;
            }

            .filter-search-field input {
                width: 100%;
                height: 56px;
                padding: 0 24px 0 56px;
                border: none !important;
                background: transparent;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 16px;
                color: #1a1816;
                outline: none !important;
                box-shadow: none !important;
            }

            .filter-search-field input::placeholder {
                color: #9e9589;
            }

            .filter-search-submit,
            .filter-apply-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 9px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-weight: 700;
                font-size: 15px;
                border: none;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            .filter-search-submit {
                height: 56px;
                min-width: 150px;
                padding: 0 32px;
                border-radius: 100px;
                box-shadow: 0 4px 14px rgba(181, 147, 73, 0.3);
                background: linear-gradient(135deg, #b59349 0%, #d4b572 100%);
                color: #ffffff;
                margin-left: auto;
            }

            .filter-search-submit:hover,
            .filter-apply-button:hover {
                background: linear-gradient(135deg, #9f7f3e 0%, #c1a25d 100%);
                color: #ffffff;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(181, 147, 73, 0.4);
            }

            .filter-toolbar {
                display: grid;
                grid-template-columns: repeat(5, minmax(0, 1fr)) auto;
                gap: 12px;
                margin-top: 22px;
                padding-top: 22px;
                border-top: 1px solid #eee9e1;
            }

            .filter-group {
                min-width: 0;
                z-index: auto;
            }

            .filter-group:has(.show-options) {
                z-index: 10000;
            }

            .filter-button {
                width: 100%;
                min-height: 62px;
                padding: 10px 14px;
                border: 1px solid #e6ded1;
                border-radius: 14px;
                background: #ffffff;
                justify-content: flex-start;
                gap: 11px;
                text-align: left;
            }

            .filter-button::after {
                content: '\f282' !important;
                margin-left: auto;
                font-family: bootstrap-icons;
                font-size: 13px !important;
                opacity: 0.6 !important;
                transition: transform 0.2s ease;
            }

            .filter-button.open::after {
                content: '\f282' !important;
                transform: rotate(180deg);
            }

            .filter-button-icon {
                display: inline-flex;
                flex: 0 0 36px;
                width: 36px;
                height: 36px;
                align-items: center;
                justify-content: center;
                border-radius: 10px;
                background: #f6f1e7;
                color: #a68440;
                font-size: 17px;
            }

            .filter-button-copy {
                display: flex;
                min-width: 0;
                flex-direction: column;
                gap: 2px;
            }

            .filter-label {
                color: #1a1816;
                font-size: 14px;
                font-weight: 750;
                line-height: 1.2;
            }

            .filter-status {
                overflow: hidden;
                color: #8a847c;
                font-size: 11px;
                font-weight: 500;
                line-height: 1.2;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .filter-button:hover {
                border-color: #cdb47b;
                background: #fdfbf7;
                color: #1a1816 !important;
                transform: translateY(-1px);
            }

            .filter-button.has-active-filter {
                border-color: #b59349;
                background: #f8f2e6;
                color: #1a1816 !important;
                box-shadow: 0 0 0 3px rgba(181, 147, 73, 0.09);
            }

            .filter-button.has-active-filter .filter-button-icon {
                background: #b59349;
                color: #ffffff;
            }

            .filter-options {
                top: calc(100% + 10px);
                left: 0;
                min-width: 100%;
                max-width: 310px;
                max-height: 320px;
                padding: 9px;
                border-radius: 14px;
                overflow-y: auto !important;
                transform: none;
            }

            .filter-options::before,
            .filter-options::after {
                display: none;
            }

            .filter-options button {
                padding: 11px 12px;
            }

            .filter-apply-button {
                min-width: 162px;
                min-height: 62px;
                padding: 0 22px;
                border-radius: 14px;
                box-shadow: 0 10px 22px rgba(181, 147, 73, 0.22);
            }

            .selected-filters {
                margin-top: 18px !important;
                padding: 14px 16px !important;
                border: 1px solid #e9dfcf !important;
                border-radius: 15px !important;
                background: linear-gradient(90deg, #fffdf9 0%, #faf6ee 100%) !important;
                gap: 9px !important;
                min-height: 58px;
            }

            .filter-summary-title {
                display: inline-flex;
                align-items: center;
                gap: 9px;
                margin-right: 4px;
                color: #524a40;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 13px;
                font-weight: 800;
                white-space: nowrap;
            }

            .filter-summary-title i {
                display: inline-flex;
                width: 30px;
                height: 30px;
                align-items: center;
                justify-content: center;
                border-radius: 9px;
                background: #b59349;
                color: #ffffff;
                font-size: 14px;
            }

            .filter-summary-count {
                display: inline-flex;
                min-width: 24px;
                height: 24px;
                align-items: center;
                justify-content: center;
                padding: 0 7px;
                border-radius: 999px;
                background: #eee3cc;
                color: #8a6c31;
                font-size: 11px;
                font-weight: 800;
            }

            .selected-filter {
                padding: 7px 8px 7px 12px !important;
                border-color: #e3d6c0 !important;
                background: #ffffff !important;
                color: #3d3832 !important;
                box-shadow: 0 3px 10px rgba(60, 48, 31, 0.05) !important;
                font-size: 12px !important;
            }

            .selected-filter strong {
                color: #9c7b39;
                font-weight: 800;
            }

            .remove-filter {
                display: inline-flex;
                width: 24px;
                height: 24px;
                align-items: center;
                justify-content: center;
                margin-left: 2px;
                border-radius: 50%;
                background: #f5efe4;
                color: #9c7b39;
                font-size: 15px;
                line-height: 1;
            }

            .remove-filter:hover {
                background: #b59349;
                color: #ffffff;
            }

            .clear-all-filter {
                display: inline-flex !important;
                align-items: center;
                gap: 6px;
                margin-left: auto;
                padding: 7px 10px !important;
                border: 0 !important;
                border-radius: 9px !important;
                background: transparent !important;
                color: #b14e43 !important;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 12px !important;
                font-weight: 700 !important;
                cursor: pointer;
            }

            .clear-all-filter:hover {
                background: #fff0ed !important;
                color: #963a31 !important;
            }

            @media (max-width: 1100px) {
                .filter-toolbar {
                    grid-template-columns: repeat(3, minmax(0, 1fr));
                }

                .filter-apply-button {
                    width: 100%;
                }
            }

            @media (max-width: 768px) {
                .vehicle-filter-shell {
                    padding: 0 12px;
                }

                .filter-module {
                    padding: 22px 16px;
                    border-radius: 18px;
                }

                .filter-heading {
                    align-items: flex-start;
                    flex-direction: column;
                    gap: 8px;
                }

                .filter-heading h2 {
                    font-size: 24px;
                }

                .filter-heading p {
                    text-align: left;
                }

                .filter-search-form {
                    flex-direction: column;
                    border-radius: 20px;
                    padding: 12px;
                }

                .filter-search-field {
                    width: 100%;
                }

                .filter-search-submit {
                    width: 100%;
                }

                .filter-options {
                    right: 0;
                    max-width: none;
                }

                .selected-filters {
                    align-items: flex-start !important;
                }

                .filter-summary-title {
                    width: 100%;
                }

                .clear-all-filter {
                    margin-left: 0;
                }
            }


            .container-haha {
                border-radius: 12px;
                padding: 40px 20px;
                max-width: 1240px;
                margin: 0 auto;
            }
            
            .wrapper.row {
                display: flex !important;
                flex-wrap: wrap !important;
                margin-right: -15px !important;
                margin-left: -15px !important;
                justify-content: center !important;
            }
            
            .wrapper.row > [class*="col-"] {
                padding-right: 15px !important;
                padding-left: 15px !important;
            }
            
            /* Responsive adjustments for motorcycle cards */
            @media (max-width: 991px) {
                .container-haha {
                    padding: 25px 20px;
                }
            }
            
            @media (max-width: 767px) {
                .container-haha {
                    padding: 20px 15px;
                }
                
                .wrapper.row > [class*="col-"] {
                    padding-right: 10px !important;
                    padding-left: 10px !important;
                }
            }

            .box {
                box-shadow: 0 4px 20px rgba(0,0,0,0.04);
                border-radius: 20px;
                border: 1px solid rgba(181, 147, 73, 0.15);
                padding: 28px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: flex-start;
                text-align: center;
                margin: 0;
                background: #fff;
                transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                height: 100%;
                width: 100%;
                overflow: visible;
                min-height: 520px;
                position: relative;
            }

            .box:hover {
                transform: translateY(-12px);
                box-shadow: 0 20px 40px rgba(181, 147, 73, 0.2);
                border-color: rgba(181, 147, 73, 0.4);
            }
            
            .box::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #b59349 0%, #d4a574 100%);
                border-radius: 20px 20px 0 0;
                opacity: 0;
                transition: opacity 0.4s ease;
            }
            
            .box:hover::after {
                opacity: 1;
            }

            .box .banner-image {
                border-radius: 16px;
                margin-bottom: 24px;
                width: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
                background: #f8f8f8;
                padding: 10px;
                transition: transform 0.4s ease;
            }
            
            .box:hover .banner-image {
                transform: scale(1.05);
            }
            
            .box .banner-image a {
                display: block;
                width: 100%;
                transition: transform 0.3s ease;
            }
            
            .box .banner-image img {
                transition: transform 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            }
            
            .box:hover .banner-image img {
                transform: scale(1.08);
            }

            /* Heart favorite button animation */
            @keyframes heartPop {
                0%   { transform: scale(1); }
                40%  { transform: scale(1.35); }
                70%  { transform: scale(0.9); }
                100% { transform: scale(1); }
            }
            .fav-btn-card.favorited i {
                animation: heartPop 0.4s ease;
            }
            .fav-btn-card.favorited {
                background: rgba(254,226,226,0.95) !important;
                box-shadow: 0 2px 12px rgba(239,68,68,0.3) !important;
            }


            .motorcycle.box h2 {
                margin: 24px 0 10px 0 !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 1.5rem !important;
                color: #1a1816 !important;
                font-weight: 800 !important;
                line-height: 1.3 !important;
                transition: color 0.3s ease !important;
            }
            
            .motorcycle.box h2 a {
                color: inherit !important;
                text-decoration: none !important;
                transition: color 0.3s ease !important;
            }
            
            .motorcycle.box:hover h2 a {
                color: #b59349 !important;
            }
            
            .motorcycle.box .category-label {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 600 !important;
                font-size: 0.75rem !important;
                color: #b59349 !important;
                text-transform: uppercase !important;
                letter-spacing: 1.5px !important;
                margin-bottom: 14px !important;
                display: inline-block !important;
                padding: 4px 12px !important;
                background: rgba(181, 147, 73, 0.1) !important;
                border-radius: 20px !important;
                transition: all 0.3s ease !important;
            }
            
            .motorcycle.box:hover .category-label {
                background: rgba(181, 147, 73, 0.2) !important;
                transform: scale(1.05) !important;
            }
            
            .motorcycle.box .price-section {
                margin-bottom: 18px !important;
            }
            
            .motorcycle.box .price-main {
                font-size: 1.4rem !important;
                color: #b59349 !important;
                font-weight: 800 !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
            }
            
            .motorcycle.box .price-unit {
                font-size: 0.9rem !important;
                color: #6c757d !important;
                font-weight: 500 !important;
            }

            .button-wrapper {
                margin-top: auto !important;
                width: 100%;
                display: flex !important;
                gap: 12px;
                padding-top: 20px;
                justify-content: center;
            }
            .btn {
                border: none;
                padding: 12px 24px;
                border-radius: 24px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 0.8rem;
                font-weight: 700;
                letter-spacing: 1px;
                cursor: pointer;
                min-width: 100px;
                min-height: 44px;
                white-space: nowrap;
            }

            .btn + .btn {
                margin-left: 10px;
            }

            .motorcycle.box .button-wrapper a.btn {
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                text-decoration: none !important;
                min-width: 120px !important;
                height: 48px !important;
                padding: 0 24px !important;
                border-radius: 12px !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 0.85rem !important;
                font-weight: 700 !important;
                letter-spacing: 0.5px !important;
                cursor: pointer !important;
                white-space: nowrap !important;
                transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1) !important;
                box-sizing: border-box !important;
                position: relative !important;
                overflow: hidden !important;
            }
            
            .motorcycle.box .button-wrapper a.btn::before {
                content: '' !important;
                position: absolute !important;
                top: 50% !important;
                left: 50% !important;
                width: 0 !important;
                height: 0 !important;
                border-radius: 50% !important;
                background: rgba(255, 255, 255, 0.3) !important;
                transform: translate(-50%, -50%) !important;
                transition: width 0.6s, height 0.6s !important;
            }
            
            .motorcycle.box .button-wrapper a.btn:hover::before {
                width: 300px !important;
                height: 300px !important;
            }
            
            .motorcycle.box .button-wrapper a.outline-huhu {
                background: #ffffff !important;
                color: #b59349 !important;
                border: 2px solid #b59349 !important;
                box-shadow: 0 2px 8px rgba(181, 147, 73, 0.15) !important;
            }
            
            .motorcycle.box .button-wrapper a.outline-huhu:hover {
                transform: translateY(-3px) scale(1.02) !important;
                background: #b59349 !important;
                color: #ffffff !important;
                box-shadow: 0 8px 20px rgba(181, 147, 73, 0.35) !important;
            }
            
            .motorcycle.box .button-wrapper a.fill {
                background: linear-gradient(135deg, #b59349 0%, #d4a574 100%) !important;
                color: #ffffff !important;
                border: 2px solid #b59349 !important;
                box-shadow: 0 4px 12px rgba(181, 147, 73, 0.3) !important;
            }
            
            .motorcycle.box .button-wrapper a.fill:hover {
                transform: translateY(-3px) scale(1.02) !important;
                background: linear-gradient(135deg, #d4a574 0%, #b59349 100%) !important;
                box-shadow: 0 8px 24px rgba(181, 147, 73, 0.45) !important;
                border-color: #d4a574 !important;
            }
            
            .motorcycle.box .button-wrapper a.disabled {
                background: linear-gradient(135deg, #e8e8e8 0%, #d0d0d0 100%) !important;
                color: #999999 !important;
                border: 2px solid #d0d0d0 !important;
                cursor: not-allowed !important;
                pointer-events: none !important;
                box-shadow: none !important;
            }
            
            .motorcycle.box .button-wrapper a.disabled:hover {
                transform: none !important;
            }

            .outline-huhu {
                background: transparent !important;
                color: #b59349 !important;
                border: 1px solid #b59349 !important;
                transition: all .3s ease !important;
                text-decoration: none !important;
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 0.8rem !important;
                letter-spacing: 1px !important;
                border-radius: 24px !important;
                padding: 12px 24px !important;
                box-sizing: border-box !important;
            }

            .outline-huhu:hover {
                transform: scale(1.05) !important;
                background: #b59349 !important;
                color: #ffffff !important;
                text-decoration: none !important;
            }

            .fill {
                background: #b59349 !important;
                color: #fff !important;
                border: 1px solid #b59349 !important;
                transition: all .3s ease !important;
                text-decoration: none !important;
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 0.8rem !important;
                letter-spacing: 1px !important;
                border-radius: 24px !important;
                padding: 12px 24px !important;
                box-sizing: border-box !important;
            }

            .fill:hover {
                transform: scale(1.05) !important;
                background: transparent !important;
                color: #b59349 !important;
                border: 1px solid #b59349 !important;
                text-decoration: none !important;
            }

            .disabled {
                background: #e0e0e0 !important;
                color: #9e9e9e !important;
                border: 1px solid #e0e0e0 !important;
                cursor: not-allowed !important;
            }

            .disabled:hover {
                transform: none !important;
                background: #e0e0e0 !important;
                color: #9e9e9e !important;
            }
            
            /* Modern Pagination Styling */
            .pagination-list {
                display: flex !important;
                gap: 8px !important;
                align-items: center !important;
            }

            .page-link-custom {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                width: 44px !important;
                height: 44px !important;
                border-radius: 14px !important;
                background: #ffffff !important;
                color: #b59349 !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 16px !important;
                text-decoration: none !important;
                border: 1px solid rgba(181, 147, 73, 0.2) !important;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            }

            .page-link-custom:hover {
                background: #b59349 !important;
                color: #ffffff !important;
                box-shadow: 0 6px 16px rgba(181, 147, 73, 0.25) !important;
                transform: translateY(-3px) !important;
                border-color: #b59349 !important;
            }

            .page-link-custom.active {
                background: linear-gradient(135deg, #b59349 0%, #d4b572 100%) !important;
                color: #ffffff !important;
                border: none !important;
                box-shadow: 0 6px 16px rgba(181, 147, 73, 0.35) !important;
                cursor: default !important;
                pointer-events: none !important;
            }
            
            .page-link-custom i {
                font-size: 14px;
            }
            
            /* Custom Return Button */
            .btn-return-custom {
                padding: 10px 24px !important;
                border-radius: 30px !important;
                text-decoration: none !important;
                display: inline-flex !important;
                align-items: center !important;
                gap: 8px !important;
                background: #ffffff !important;
                color: #b59349 !important;
                border: 1px solid rgba(181, 147, 73, 0.3) !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 15px !important;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            }

            .btn-return-custom:hover {
                background: #b59349 !important;
                color: #ffffff !important;
                border-color: #b59349 !important;
                transform: translateY(-2px) !important;
                box-shadow: 0 4px 12px rgba(181, 147, 73, 0.2) !important;
            }
            
            /* Ensure motorcycle cards display properly */
            .motorcycle.box {
                height: 100%;
                display: flex;
                flex-direction: column;
                animation: fadeInUp 0.6s ease-out;
                animation-fill-mode: both;
            }
            
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .motorcycle.box:nth-child(1) { animation-delay: 0.1s; }
            .motorcycle.box:nth-child(2) { animation-delay: 0.2s; }
            .motorcycle.box:nth-child(3) { animation-delay: 0.3s; }
            .motorcycle.box:nth-child(4) { animation-delay: 0.4s; }
            .motorcycle.box:nth-child(5) { animation-delay: 0.5s; }
            .motorcycle.box:nth-child(6) { animation-delay: 0.6s; }
            .motorcycle.box:nth-child(n+7) { animation-delay: 0.7s; }
            
            .motorcycle.box .banner-image a {
                display: block;
                width: 100%;
            }
            
            .motorcycle.box .banner-image img {
                display: block;
                width: 100%;
            }
            
            /* Fix column gutters for motorcycle grid */
            .wrapper.row.mb-4 {
                margin-bottom: 1.5rem;
            }
            
            [class*="col-"].mb-4 {
                margin-bottom: 1.5rem !important;
            }
            
            /* List section styling */
            .list {
                max-width: 1240px;
                margin: 0 auto;
                padding: 40px 20px;
            }
            
            .list-subtitle {
                display: inline-block;
                color: #b59349;
                font-size: 13px;
                font-weight: 800;
                letter-spacing: 2px;
                text-transform: uppercase;
                margin-bottom: 10px;
                font-family: 'Plus Jakarta Sans', sans-serif;
            }
            
            .list h1 {
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 36px;
                font-weight: 800;
                color: #1a1816;
                margin-bottom: 30px;
                letter-spacing: -0.5px;
            }
            
            .no-results-message {
                width: 100%;
                padding: 60px 20px;
                font-size: 18px;
                color: #6c757d;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-weight: 500;
            }
            
            /* Ensure proper Bootstrap grid behavior */
            @media (min-width: 768px) {
                .col-md-6 {
                    flex: 0 0 50%;
                    max-width: 50%;
                }
            }
            
            @media (min-width: 992px) {
                .col-lg-4 {
                    flex: 0 0 33.333333%;
                    max-width: 33.333333%;
                }
            }
            
            @media (max-width: 767px) {
                .col-md-6, .col-lg-4 {
                    flex: 0 0 100%;
                    max-width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/includes/customer/navbar.jsp" />

        <div class="vehicle-filter-shell" style="margin-top: 130px; margin-bottom: 40px; position: relative; z-index: 99; overflow: visible !important;">
            <!-- thanh search -->
            <section style="overflow: visible !important;">
                <div class="filter-module">
                    <div class="filter-heading">
                        <div>
                            <span class="filter-eyebrow">Tìm kiếm nhanh</span>
                            <h2>Tìm chiếc xe phù hợp với bạn</h2>
                        </div>
                        <p>Tìm theo tên xe hoặc kết hợp nhiều tiêu chí để thu hẹp kết quả chính xác hơn.</p>
                    </div>

                    <!-- HÀNG 1: Ô Tìm Kiếm Từ Khóa -->
                    <div class="filter-search-row">
                        <form action="searchMotorcycle" method="get" class="filter-search-form">
                            <div class="filter-search-field">
                                <input id="textSearch" value="${key}" name="textSearch" type="search" placeholder="Nhập tên hoặc dòng xe, ví dụ: Vision, Air Blade..." aria-label="Tìm kiếm xe máy">
                                <i class="bi bi-search search-icon"></i>
                            </div>
                            <button class="filter-search-submit" type="submit">
                                <i class="bi bi-search"></i>
                                <span>Tìm kiếm</span>
                            </button>
                        </form>
                    </div>

                    <!-- HÀNG 2: Các Dropdown Lọc Kết Quả -->
                    <div class="filter-toolbar">
                        <div class="filter-group">
                                <button type="button" class="filter-button price" data-label="Giá thuê" onclick="toggleOptions('priceOptions')">
                                    <span class="filter-button-icon"><i class="bi bi-cash-stack"></i></span>
                                    <span class="filter-button-copy">
                                        <span class="filter-label">Giá thuê</span>
                                        <span class="filter-status">Tất cả mức giá</span>
                                    </span>
                                </button>
                                <div class="filter-options" id="priceOptions">
                                    <c:forEach items="${listPriceRange}" var="o">
                                        <input hidden name="priceRanges" value="${o.minPrice},${o.maxPrice}"/>
                                        <button type="button" data-id="${o.minPrice},${o.maxPrice}" class="button-item-option" onclick="toggleSelection(this)">
                                            <c:if test="${o.minPrice == 0}">
                                                Dưới <fmt:formatNumber value="${o.maxPrice}" type="number" maxFractionDigits="0"/>₫/ngày
                                            </c:if>
                                            <c:if test="${o.minPrice != 0 && o.maxPrice != 0}">
                                                <fmt:formatNumber value="${o.minPrice}" type="number" maxFractionDigits="0"/> - <fmt:formatNumber value="${o.maxPrice}" type="number" maxFractionDigits="0"/>₫/ngày
                                            </c:if>

                                            <c:if test="${o.maxPrice == 0}">
                                                Từ <fmt:formatNumber value="${o.minPrice}" type="number" maxFractionDigits="0"/>₫/ngày
                                            </c:if>
                                        </button>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="filter-group">
                                <button type="button" class="filter-button" data-label="Hãng xe" onclick="toggleOptions('brandOptions')">
                                    <span class="filter-button-icon"><i class="bi bi-award"></i></span>
                                    <span class="filter-button-copy">
                                        <span class="filter-label">Hãng xe</span>
                                        <span class="filter-status">Tất cả hãng</span>
                                    </span>
                                </button>
                                <div class="filter-options" id="brandOptions">
                                    <c:forEach items="${listBrand}" var="o">
                                        <input hidden name="brands" value="${o.brandID}" id="searchBrand">
                                        <button type="button" class="button-item-option" data-id="${o.brandID}"
                                                 onclick="toggleSelection(this)">${o.brandName}</button>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="filter-group">
                                <button type="button" class="filter-button" data-label="Loại xe" onclick="toggleOptions('categoryOptions')">
                                    <span class="filter-button-icon"><i class="bi bi-grid"></i></span>
                                    <span class="filter-button-copy">
                                        <span class="filter-label">Loại xe</span>
                                        <span class="filter-status">Tất cả loại xe</span>
                                    </span>
                                </button>
                                <div class="filter-options" id="categoryOptions">
                                    <c:forEach items="${categories}" var="o">
                                        <input hidden name="categories" value="${o.categoryID}" id="searchCategory">
                                        <button type="button" class="button-item-option" data-id="${o.categoryID}"
                                                 onclick="toggleSelection(this)">${o.categoryName}</button>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="filter-group">
                                <button type="button" class="filter-button" data-label="Phân khối" onclick="toggleOptions('massOptions')">
                                    <span class="filter-button-icon"><i class="bi bi-speedometer2"></i></span>
                                    <span class="filter-button-copy">
                                        <span class="filter-label">Phân khối</span>
                                        <span class="filter-status">Tất cả dung tích</span>
                                    </span>
                                </button>
                                <div class="filter-options" id="massOptions">
                                    <% 
                                        java.util.List<String> listDisp = (java.util.List<String>) application.getAttribute("listDisplacement");
                                        if(listDisp != null) {
                                            java.util.Collections.sort(listDisp, new java.util.Comparator<String>() {
                                                public int compare(String s1, String s2) {
                                                    int num1 = extract(s1);
                                                    int num2 = extract(s2);
                                                    if(num1 != num2) return Integer.compare(num1, num2);
                                                    if(s1 == null) return -1;
                                                    if(s2 == null) return 1;
                                                    return s1.compareTo(s2);
                                                }
                                                int extract(String s) {
                                                    if(s == null) return 0;
                                                    String n = s.replaceAll("[^0-9]", "");
                                                    return n.isEmpty() ? 0 : Integer.parseInt(n);
                                                }
                                            });
                                        }
                                    %>
                                    <c:forEach items="${listDisplacement}" var="o">
                                        <input hidden name="displacements" value="${o}" id="searchDisplacement">
                                        <button type="button" class="button-item-option" data-id="${o}"
                                                 onclick="toggleSelection(this)">${o}</button>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="filter-group">
                                <button type="button" class="filter-button" data-label="Nhu cầu" onclick="toggleOptions('needOptions')">
                                    <span class="filter-button-icon"><i class="bi bi-signpost-split"></i></span>
                                    <span class="filter-button-copy">
                                        <span class="filter-label">Nhu cầu</span>
                                        <span class="filter-status">Mọi mục đích</span>
                                    </span>
                                </button>
                                <div class="filter-options" id="needOptions">
                                    <c:forEach items="${listDemand}" var="o">
                                        <input hidden name="demands" value="${o.demandId}" id="searchDemand">
                                        <button type="button" class="button-item-option" data-id="${o.demandId}" onclick="toggleSelection(this)">${o.demand}</button>
                                    </c:forEach>
                                </div>
                            </div>

                        <button type="button" class="filter-apply-button" onclick="showResults()" style="display: none;">
                            <i class="bi bi-sliders2"></i>
                            <span>Áp dụng bộ lọc</span>
                        </button>
                    </div>

                    <div class="selected-filters" id="selectedFilters">
                        <!-- Selected filters will be displayed here -->
                    </div>
                </div>
                <!-- SMART ASSISTANT BANNER -->
                <div class="container" style="margin-top: 40px; margin-bottom: 20px;">
                    <div style="background: linear-gradient(135deg, #1a1816 0%, #362f27 100%); border-radius: 24px; padding: 40px; color: white; box-shadow: 0 20px 40px rgba(0,0,0,0.15); position: relative; overflow: hidden;">
                        <!-- Decorative circle -->
                        <div style="position: absolute; top: -50px; right: -50px; width: 200px; height: 200px; background: radial-gradient(circle, rgba(181,147,73,0.3) 0%, rgba(255,255,255,0) 70%); border-radius: 50%;"></div>
                        
                        <div class="row align-items-center position-relative" style="z-index: 1;">
                            <div class="col-lg-6 mb-4 mb-lg-0">
                                <h3 style="font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800; font-size: 2rem; margin-bottom: 15px; color: #b59349;">
                                    <i class="bi bi-stars"></i> Trợ Lý SmartRide
                                </h3>
                                <p style="font-size: 1.1rem; color: #e0e0e0; margin-bottom: 0;">Bạn dự định khám phá những địa điểm tuyệt đẹp nào tại Đà Nẵng? Hệ thống sẽ gợi ý cho bạn chiếc xe hoàn hảo nhất!</p>
                            </div>
                            <div class="col-lg-6">
                                <form action="searchCriteria" method="get" onsubmit="return handleSmartSearch(event, this)">
                                    <div class="d-flex gap-2">
                                        <div class="flex-grow-1 position-relative">
                                            <i class="bi bi-geo-alt position-absolute" style="left: 15px; top: 50%; transform: translateY(-50%); color: #b59349; font-size: 1.2rem; pointer-events: none;"></i>
                                            <select name="locations" class="form-select form-select-lg" style="border-radius: 12px; border: none; background: #ffffff; color: #1a1816; font-weight: 500; font-family: 'Plus Jakarta Sans', sans-serif; box-shadow: 0 5px 15px rgba(0,0,0,0.1); cursor: pointer; padding-left: 45px; height: 56px;" required>
                                                <option value="" selected disabled>-- Chọn địa điểm du lịch --</option>
                                                <c:forEach items="${listLocations}" var="loc">
                                                    <option value="${loc.locationId}">${loc.locationName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn" style="background: #b59349; color: white; border-radius: 12px; font-weight: 700; padding: 0 30px; height: 56px; white-space: nowrap; font-family: 'Plus Jakarta Sans', sans-serif; box-shadow: 0 5px 15px rgba(181,147,73,0.4); transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)';" onmouseout="this.style.transform='translateY(0)';">
                                            Gợi ý ngay <i class="bi bi-magic ms-1"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                function handleSmartSearch(e, form) {
                    e.preventDefault();
                    
                    const btn = form.querySelector('button');
                    btn.disabled = true;
                    btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang xử lý...';
                    
                    setTimeout(() => {
                        form.submit();
                    }, 1000);
                }
                </script>

                <div class="list">
                    <div style="text-align: center; margin-top: 40px;">
                        <span class="list-subtitle animate__animated animate__fadeIn">Bộ Sưu Tập Xe</span>
                        <c:choose>
                            <c:when test="${not empty param.locations and param.locations != 'all'}">
                                <c:set var="locName" value="" />
                                <c:forEach items="${listLocations}" var="loc">
                                    <c:if test="${loc.locationId == param.locations}">
                                        <c:set var="locName" value="${loc.locationName}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${not empty locName}">
                                    <h1 class="animate__animated animate__backInDown">Gợi ý xe cho <span style="color: #b59349;">${locName}</span></h1>
                                </c:if>
                                <c:if test="${empty locName}">
                                    <h1 class="animate__animated animate__backInDown">Danh Sách Xe Máy</h1>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <h1 class="animate__animated animate__backInDown">Danh Sách Xe Máy</h1>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="container-haha animate__animated animate__zoomIn">
                        <div class="wrapper row" id="motorcycleContent">
                            <c:if test="${not empty noResults}">
                                <div class="text-center no-results-message">
                                    Không có mẫu xe nào phù hợp với tìm kiếm của bạn.
                                </div>
                            </c:if>

                            <c:forEach var="motorbike" items="${motorcycles}">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="motorcycle box h-100 position-relative">
                                        <!-- Favorite Button -->
                                        <button onclick="toggleFavQuick('${motorbike.motorcycleId}', this, event)" class="fav-btn-card" style="position:absolute;top:12px;right:12px;border-radius:50%;width:36px;height:36px;display:flex;align-items:center;justify-content:center;z-index:10;border:none;padding:0;background:rgba(255,255,255,0.92);backdrop-filter:blur(4px);box-shadow:0 2px 10px rgba(0,0,0,0.12);cursor:pointer;transition:transform 0.2s,box-shadow 0.2s;" onmouseover="this.style.transform='scale(1.15)';this.style.boxShadow='0 4px 16px rgba(239,68,68,0.25)';" onmouseout="this.style.transform='scale(1)';this.style.boxShadow='0 2px 10px rgba(0,0,0,0.12)';">
                                            <i class="fa-regular fa-heart" style="color:#94a3b8;font-size:15px;line-height:1;"></i>
                                        </button>
                                        <div class="banner-image">
                                            <a href="motorcycleDetail?id=${motorbike.motorcycleId}"><img src="images/${motorbike.image}" style="width:100%; height:auto; object-fit:contain; max-height: 220px;" alt="${motorbike.model}"/></a>
                                        </div>
                                        <h2><a href="motorcycleDetail?id=${motorbike.motorcycleId}">${motorbike.model}</a></h2>
                                        <div class="category-label">${categoryMap[motorbike.categoryID]}</div>
                                        <div class="price-section">
                                            <c:choose>
                                                <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                    <div style="display: flex; gap: 8px; justify-content: center; align-items: center; margin-bottom: 5px;">
                                                        <span style="font-size: 14px; color: #999; text-decoration: line-through;">
                                                            <fmt:formatNumber value="${priceMap[motorbike.priceListID]}" type="number" maxFractionDigits="0"/>₫
                                                        </span>
                                                        <span style="color: #dc2626; font-size: 12px; font-weight: bold; background: #fee2e2; padding: 2px 6px; border-radius: 4px;">
                                                            -<fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%
                                                        </span>
                                                    </div>
                                                    <div class="price-main">
                                                        <fmt:formatNumber value="${priceMap[motorbike.priceListID] * (1 - activeEvent.discount)}" type="number" maxFractionDigits="0"/>₫<span class="price-unit">/ngày</span>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="price-main">
                                                        <fmt:formatNumber value="${priceMap[motorbike.priceListID]}" type="number" maxFractionDigits="0"/>₫<span class="price-unit">/ngày</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="button-wrapper">
                                            <a href="motorcycleDetail?id=${motorbike.motorcycleId}" class="btn outline-huhu">CHI TIẾT</a>
                                            <c:choose>
                                                <c:when test="${not empty listMA[motorbike.motorcycleId]}">
                                                    <a href="booking?motorcycleid=${motorbike.motorcycleId}" class="btn fill">THUÊ NGAY</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="#" class="btn fill disabled">HẾT XE</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
<div class="row mt-5">
                            <div class="col text-center">
                                <div class="block-27">
                                     <c:choose>
                                         <c:when test="${empty motorcycles}">
                                             <!-- size == 0 ==> nothing here -->
                                         </c:when>
                                         <c:otherwise>
                                             <c:if test="${search != 'default'}">
                                                <div class="reset-filter-container" style="display: flex; justify-content: center; margin-bottom: 25px;">
                                                    <a href="motorcycle" class="btn-return-custom">
                                                        <i class="bi bi-arrow-left"></i> Trở về trang xe máy ban đầu
                                                    </a>
                                                </div>
                                            </c:if>
                                             <div class="pagination-container" style="display: flex; justify-content: center; margin-top: 20px;">
                                                 <ul class="pagination-list" style="display: inline-flex; list-style: none; gap: 8px; justify-content: center; padding: 0;">
                                                     <!-- Nút quay lại (Prev) -->
                                                     <c:if test="${tag > 1}">
                                                         <li>
                                                             <a href="javascript:void(0)" onclick="goToPage(${tag - 1})" class="page-link-custom">&lt;</a>
                                                         </li>
                                                     </c:if>

                                                     <!-- Danh sách trang -->
                                                     <c:forEach begin="1" end="${endP}" var="i">
                                                         <li class="${tag == i ? 'active' : ''}">
                                                             <c:choose>
                                                                 <c:when test="${tag == i}">
                                                                     <span class="page-link-custom active">${i}</span>
                                                                 </c:when>
                                                                 <c:otherwise>
                                                                     <a href="javascript:void(0)" onclick="goToPage(${i})" class="page-link-custom">${i}</a>
                                                                 </c:otherwise>
                                                             </c:choose>
                                                         </li>
                                                     </c:forEach>

                                                     <!-- Nút tiếp theo (Next) -->
                                                     <c:if test="${tag < endP}">
                                                         <li>
                                                             <a href="javascript:void(0)" onclick="goToPage(${tag + 1})" class="page-link-custom">&gt;</a>
                                                         </li>
                                                     </c:if>
                                                 </ul>
                                             </div>
                                         </c:otherwise>
                                     </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section> 

        </div>

    </div>
    <jsp:include page="/includes/customer/footer.jsp" />



    <!-- loader -->



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
                                                 var totalMotorcycles = ${not empty totalMotorcycles ? totalMotorcycles : 9999};
                                                var currentAmount = document.getElementsByClassName("motorcycle").length;
                                                 function updateLoadMoreButton() {
                                                     var btn = document.getElementById("loadMoreBtn");
                                                     if (btn && currentAmount >= totalMotorcycles) {
                                                         btn.style.display = "none";
                                                     }
                                                 }
                                                updateLoadMoreButton();


                                                function loadMoreSearchName() {
                                                    var amount = document.getElementsByClassName("motorcycle").length;
                                                    var searchInput = document.getElementById('textSearch').value;
                                                    $.ajax({
                                                        url: "/MotorcyleHiringProject/loadSearchName",
                                                        type: "GET",
                                                        data: {
                                                            textSearch: searchInput,
                                                            total: amount
                                                        },
                                                        //if received a response from the server
                                                        success: function (res) {
                                                            var row = document.getElementById('motorcycleContent');
                                                            row.innerHTML += res;
                                                            currentAmount = document.getElementsByClassName("motorcycle").length;
                                                            updateLoadMoreButton();
                                                        },

                                                        //If there was no response from the server
                                                        error: function () {
                                                            alert("error");
                                                        }
                                                    });
                                                }
                                                function loadMoreSearchCriteria() {
                                                    var amount = document.getElementsByClassName("motorcycle").length;
                                                    $.ajax({
                                                        url: "/MotorcyleHiringProject/loadSearchCriteria",
                                                        type: "GET",
                                                        data: {
                                                            total: amount
                                                        },
                                                        //if received a response from the server
                                                        success: function (res) {
                                                            var row = document.getElementById('motorcycleContent');
                                                            row.innerHTML += res;
                                                            currentAmount = document.getElementsByClassName("motorcycle").length;
                                                            updateLoadMoreButton();
                                                        },

                                                        //If there was no response from the server
                                                        error: function () {
                                                            alert("error");
                                                        }
                                                    });
                                                }
                                                function loadMore() {
                                                    var amount = document.getElementsByClassName("motorcycle").length;
                                                    $.ajax({
                                                        url: "/MotorcyleHiringProject/load",
                                                        type: "GET",
                                                        data: {
                                                            total: amount
                                                        },
                                                        //if received a response from the server
                                                        success: function (res) {
                                                            var row = document.getElementById('motorcycleContent');
                                                            row.innerHTML += res;
                                                            currentAmount = document.getElementsByClassName("motorcycle").length;
                                                            updateLoadMoreButton();
                                                        },

                                                        //If there was no response from the server
                                                        error: function () {
                                                            alert("error");
                                                        }
                                                    });
                                                }
                                                var currentOpenOptions = null;
                                                function toggleOptions(id) {
                                                    var options = document.getElementById(id);
                                                    var button = options.previousElementSibling;
                                                    if (currentOpenOptions && currentOpenOptions !== options) {
                                                        currentOpenOptions.classList.remove('show-options');
                                                        currentOpenOptions.previousElementSibling.classList.remove('open');
                                                    }

                                                    options.classList.toggle('show-options');
                                                    button.classList.toggle('open');
                                                    currentOpenOptions = options.classList.contains('show-options') ? options : null;
                                                }

                                                function closeOptions(id) {
                                                    var options = document.getElementById(id);
                                                    options.classList.remove('show-options');
                                                }

                                                function toggleSelection(button) {
                                                    button.classList.toggle('selected');
                                                    updateSelectedFilters();
                                                    
                                                    // Auto-close dropdown when an option is selected
                                                    if (currentOpenOptions) {
                                                        currentOpenOptions.classList.remove('show-options');
                                                        currentOpenOptions.previousElementSibling.classList.remove('open');
                                                        currentOpenOptions = null;
                                                    }
                                                    
                                                    // Thêm auto-submit
                                                    showResults();
                                                }

                                                // Auto-close dropdown when clicking outside
                                                document.addEventListener('click', function(event) {
                                                    if (typeof currentOpenOptions !== 'undefined' && currentOpenOptions !== null) {
                                                        var isClickInsideFilter = event.target.closest('.filter-group');
                                                        // if clicked outside any filter group
                                                        if (!isClickInsideFilter) {
                                                            currentOpenOptions.classList.remove('show-options');
                                                            currentOpenOptions.previousElementSibling.classList.remove('open');
                                                            currentOpenOptions = null;
                                                        }
                                                    }
                                                });

                                                function updateSelectedFilters() {
                                                    var selectedButtons = document.querySelectorAll('.filter-options button.selected');
                                                    var selectedFilters = Array.from(selectedButtons).map(function (button) {
                                                        return {
                                                            text: button.textContent.trim(),
                                                            group: button.closest('.filter-group').querySelector('.filter-label').textContent.trim()
                                                        };
                                                    });
                                                    var selectedFiltersContainer = document.getElementById('selectedFilters');
                                                    selectedFiltersContainer.innerHTML = '';
                                                    
                                                    var clearAllButton = null;
                                                    
                                                    if (selectedFilters.length > 0) {
                                                        var header = document.createElement('h2');
                                                        header.textContent = 'Đang lọc theo';
                                                        selectedFiltersContainer.appendChild(header);

                                                        clearAllButton = document.createElement('div');
                                                        clearAllButton.className = 'selected-filter clear-all-filter';
                                                        clearAllButton.innerHTML = '<span>× Bỏ chọn tất cả</span>';
                                                        clearAllButton.onclick = clearAllSelections;
                                                    }
                                                    
                                                    selectedFilters.forEach(function (filter) {
                                                        var filterDiv = document.createElement('div');
                                                        filterDiv.className = 'selected-filter';
                                                        filterDiv.innerHTML = '<span><strong style="color: #9c7b39; font-weight: 800;">' + filter.group + ':</strong> ' + filter.text + '</span><span class="remove-filter" onclick="removeSelectedFilter(this.parentElement, &quot;' + filter.text + '&quot;)">&#10006;</span>';
                                                        selectedFiltersContainer.appendChild(filterDiv);
                                                    });
                                                    
                                                    if (clearAllButton !== null) {
                                                        selectedFiltersContainer.appendChild(clearAllButton);
                                                    }
                                                }

                                                function removeSelectedFilter(filterDiv, text) {
                                                    var filterOptionButtons = document.querySelectorAll('.filter-options button');
                                                    filterOptionButtons.forEach(function (button) {
                                                        if (button.textContent.trim() === text) {
                                                            button.classList.remove('selected');
                                                        }
                                                    });
                                                    filterDiv.remove();
                                                    updateSelectedFilters();
                                                    showResults();
                                                }

                                                function clearAllSelections() {
                                                    var selectedButtons = document.querySelectorAll('.filter-options button.selected');
                                                    selectedButtons.forEach(function (button) {
                                                        button.classList.remove('selected');
                                                    });
                                                    updateSelectedFilters();
                                                    showResults();
                                                }
                                                var currentOpenOptions = null;


                                                function showResults() {
                                                    var selectedBrands = [];
                                                    var selectedCategories = [];
                                                    var selectedDisplacements = [];
                                                    var selectedDemands = [];
                                                    var selectedPriceRanges = [];

                                                    var selectedPriceButton = document.querySelectorAll('#priceOptions .button-item-option.selected');
                                                    selectedPriceButton.forEach(function (button) {
                                                        var priceRange = button.getAttribute('data-id');
                                                        if (priceRange) {
                                                            selectedPriceRanges.push(priceRange);
                                                        }
                                                    });

                                                    var selectedBrandButtons = document.querySelectorAll('#brandOptions .button-item-option.selected');
                                                    selectedBrandButtons.forEach(function (button) {
                                                        var brandID = button.getAttribute('data-id');
                                                        if (brandID) {
                                                            selectedBrands.push(brandID);
                                                        }
                                                    });

                                                    var selectedCategoryButtons = document.querySelectorAll('#categoryOptions .button-item-option.selected');
                                                    selectedCategoryButtons.forEach(function (button) {
                                                        var categoryID = button.getAttribute('data-id');
                                                        if (categoryID) {
                                                            selectedCategories.push(categoryID);
                                                        }
                                                    });

                                                    var selectedDisplacementButtons = document.querySelectorAll('#massOptions .button-item-option.selected');
                                                    selectedDisplacementButtons.forEach(function (button) {
                                                        var displacement = button.getAttribute('data-id');
                                                        if (displacement) {
                                                            selectedDisplacements.push(displacement);
                                                        }
                                                    });

                                                    var selectedDemandButtons = document.querySelectorAll('#needOptions .button-item-option.selected');
                                                    selectedDemandButtons.forEach(function (button) {
                                                        var demandID = button.getAttribute('data-id');
                                                        if (demandID) {
                                                            selectedDemands.push(demandID);
                                                        }
                                                    });

                                                    var url = 'searchCriteria?';
                                                    if (selectedBrands.length > 0) {
                                                        url += 'brands=' + selectedBrands.join('&brands=') + '&';
                                                    }
                                                    if (selectedCategories.length > 0) {
                                                        url += 'categories=' + selectedCategories.join('&categories=') + '&';
                                                    }
                                                    if (selectedDisplacements.length > 0) {
                                                        url += 'displacements=' + selectedDisplacements.join('&displacements=') + '&';
                                                    }
                                                    if (selectedDemands.length > 0) {
                                                        url += 'demands=' + selectedDemands.join('&demands=') + '&';
                                                    }
                                                    if (selectedPriceRanges.length > 0) {
                                                        url += 'priceRanges=' + selectedPriceRanges.join('&priceRanges=') + '&';
                                                    }

                                                    // Remove the trailing '&'
                                                    if (url.endsWith('&')) {
                                                        url = url.slice(0, -1);
                                                    }
                                                    if (url === 'searchCriteria?') {
                                                        url = 'motorcycle';
                                                    }

                                                    fetchAndUpdateGrid(url);
                                                }

                                                function fetchAndUpdateGrid(url) {
                                                    const grid = document.getElementById('motorcycleContent');
                                                    if (grid) {
                                                        grid.style.opacity = '0.5';
                                                        grid.style.transition = 'opacity 0.3s ease';
                                                    }
                                                    
                                                    window.history.pushState({}, '', url);
                                                    
                                                    fetch(url)
                                                        .then(response => response.text())
                                                        .then(html => {
                                                            const parser = new DOMParser();
                                                            const doc = parser.parseFromString(html, 'text/html');
                                                            
                                                            const newContent = doc.getElementById('motorcycleContent');
                                                            if (newContent && grid) {
                                                                grid.innerHTML = newContent.innerHTML;
                                                                grid.style.opacity = '1';
                                                            }
                                                            
                                                            const newPagination = doc.querySelector('.block-27');
                                                            const currentPagination = document.querySelector('.block-27');
                                                            if (newPagination && currentPagination) {
                                                                currentPagination.innerHTML = newPagination.innerHTML;
                                                            }
                                                        })
                                                        .catch(error => {
                                                            console.error('Error fetching results:', error);
                                                            if (grid) grid.style.opacity = '1';
                                                        });
                                                }

                                                function goToPage(index) {
                                                    const urlParams = new URLSearchParams(window.location.search);
                                                    urlParams.set('index', index);
                                                    
                                                    const basePath = window.location.pathname.split('/').pop() || 'motorcycle';
                                                    const url = basePath + '?' + urlParams.toString();
                                                    
                                                    fetchAndUpdateGrid(url);
                                                    
                                                    const listSection = document.querySelector('.list');
                                                    if (listSection) {
                                                        listSection.scrollIntoView({ behavior: 'smooth' });
                                                    }
                                                }
    
                                                document.addEventListener('DOMContentLoaded', function() {
                                                    const params = new URLSearchParams(window.location.search);
                                                    
                                                    function restoreState(paramName, sectionId) {
                                                        if (params.has(paramName)) {
                                                            const values = params.get(paramName).split(',');
                                                            const container = document.getElementById(sectionId);
                                                            if(container) {
                                                                const buttons = container.querySelectorAll('.button-item-option');
                                                                buttons.forEach(btn => {
                                                                    if (values.includes(btn.getAttribute('data-id'))) {
                                                                        btn.classList.add('selected');
                                                                    }
                                                                });
                                                            }
                                                        }
                                                    }
                                                    
                                                    restoreState('priceRanges', 'priceOptions');
                                                    restoreState('brands', 'brandOptions');
                                                    restoreState('categories', 'categoryOptions');
                                                    restoreState('displacements', 'massOptions');
                                                    restoreState('demands', 'needOptions');
                                                    
                                                    updateSelectedFilters();
                                                });


                                                window.addEventListener('popstate', function() {
                                                    fetchAndUpdateGrid(window.location.href);
                                                    
                                                    // Cập nhật lại giao diện bộ lọc tương ứng với URL (khôi phục trạng thái visual)
                                                    const params = new URLSearchParams(window.location.search);
                                                    
                                                    document.querySelectorAll('.button-item-option').forEach(btn => {
                                                        btn.classList.remove('selected');
                                                    });
                                                    
                                                    function restoreState(paramName, sectionId) {
                                                        if (params.has(paramName)) {
                                                            const values = params.get(paramName).split(',');
                                                            const container = document.getElementById(sectionId);
                                                            if(container) {
                                                                const buttons = container.querySelectorAll('.button-item-option');
                                                                buttons.forEach(btn => {
                                                                    if (values.includes(btn.getAttribute('data-id'))) {
                                                                        btn.classList.add('selected');
                                                                    }
                                                                });
                                                            }
                                                        }
                                                    }
                                                    
                                                    restoreState('priceRanges', 'priceOptions');
                                                    restoreState('brands', 'brandOptions');
                                                    restoreState('categories', 'categoryOptions');
                                                    restoreState('displacements', 'massOptions');
                                                    restoreState('demands', 'needOptions');
                                                    
                                                    updateSelectedFilters();
                                                });

</script>
        <script>
            function toggleFavQuick(motorcycleId, btnElement, event) {
                event.preventDefault();
                event.stopPropagation();
                
                var icon = btnElement.querySelector('i');
                var isFav = btnElement.classList.contains('favorited');
                var action = isFav ? 'remove' : 'add';
                
                fetch('favorite?action=' + action + '&motorcycleId=' + motorcycleId, { method: 'POST' })
                .then(res => res.json())
                .then(data => {
                    if(data.status === 'success') {
                        if(action === 'add') {
                            btnElement.classList.add('favorited');
                            icon.className = 'fa-solid fa-heart';
                            icon.style.color = '#ef4444';
                            // Reset animation để trigger lại
                            icon.style.animation = 'none';
                            icon.offsetHeight; // reflow
                            icon.style.animation = 'heartPop 0.4s ease';
                        } else {
                            btnElement.classList.remove('favorited');
                            icon.className = 'fa-regular fa-heart';
                            icon.style.color = '#94a3b8';
                            icon.style.animation = 'none';
                        }
                        var cartBadge = document.getElementById('cart-badge');
                        if (cartBadge && data.totalFavorites !== undefined) {
                            if (data.totalFavorites > 0) {
                                cartBadge.textContent = data.totalFavorites > 99 ? '99+' : data.totalFavorites;
                                cartBadge.style.display = 'block';
                            } else {
                                cartBadge.style.display = 'none';
                            }
                        }
                        if (typeof updateCartBadge === 'function') updateCartBadge();
                    } else if(data.status === 'unauthorized') {
                        window.location.href = 'login.jsp';
                    }
                });
            }
            
            document.addEventListener("DOMContentLoaded", function() {
                var buttons = document.querySelectorAll("button[onclick^='toggleFavQuick']");
                buttons.forEach(function(btn) {
                    var match = btn.getAttribute('onclick').match(/'([^']+)'/);
                    if(match && match[1]) {
                        var mId = match[1];
                        fetch('favorite?action=check&motorcycleId=' + mId, { method: 'POST' })
                        .then(res => res.json())
                        .then(data => {
                            if(data.status === 'success' && data.isFavorite) {
                                var icon = btn.querySelector('i');
                                btn.classList.add('favorited');
                                icon.className = 'fa-solid fa-heart';
                                icon.style.color = '#ef4444';
                            }
                        });
                    }
                });
            });
        </script>
</body>
</html>

<!-- Minor update 2 -->

<!-- Minor update 3 -->

<!-- Minor update 33 -->

<!-- fix patch 9 -->

<!-- fix patch 27 -->

<!-- fix patch 29 -->

<!-- fix patch 30 -->

<!-- fix patch 33 -->

<!-- fix patch 47 -->

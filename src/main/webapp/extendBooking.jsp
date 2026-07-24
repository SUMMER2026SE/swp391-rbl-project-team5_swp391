<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
      
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="author" content="colorlib.com">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Gia hạn xe</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">

        <!-- Font Icon -->
        <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="vendor/nouislider/nouislider.min.css">
        
        <!-- Premium Google Fonts, FontAwesome 6 and Bootstrap Icons for stunning typography and elements -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<!--        
        <link href="assets/bootstrap.min.css" rel="stylesheet"/>
         Custom styles for this template 
        <link href="assets/jumbotron-narrow.css" rel="stylesheet">      -->
        <script src="assets/jquery-1.11.3.min.js"></script>
        
        <!-- Main css -->
        <style>
            /* @extend display-flex; */
            display-flex,
            .form-flex,
            .form-date-group,
            .form-radio-group,
            .steps ul,
            .title,
            .title .step-number,
            .actions ul li a,
            .form-radio-flex,
            .form-find {
                display: flex;
                display: -webkit-flex;
            }

            /* @extend list-type-ulli; */
            list-type-ulli,
            .steps ul,
            .actions ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
            }

            /* roboto-slab-300 - latin */
            @font-face {
                font-family: 'Roboto Slab';
                font-style: normal;
                font-weight: 300;
                src: url("../fonts/roboto-slab/roboto-slab-v7-latin-300.eot");
                /* IE9 Compat Modes */
                src: local("Roboto Slab Light"), local("RobotoSlab-Light"), url("../fonts/roboto-slab/roboto-slab-v7-latin-300.eot?#iefix") format("embedded-opentype"), url("../fonts/roboto-slab/roboto-slab-v7-latin-300.woff2") format("woff2"), url("../fonts/roboto-slab/roboto-slab-v7-latin-300.woff") format("woff"), url("../fonts/roboto-slab/roboto-slab-v7-latin-300.ttf") format("truetype"), url("../fonts/roboto-slab/roboto-slab-v7-latin-300.svg#RobotoSlab") format("svg");
                /* Legacy iOS */
            }

            /* roboto-slab-regular - latin */
            @font-face {
                font-family: 'Roboto Slab';
                font-style: normal;
                font-weight: 400;
                src: url("../fonts/roboto-slab/roboto-slab-v7-latin-regular.eot");
                /* IE9 Compat Modes */
                src: local("Roboto Slab Regular"), local("RobotoSlab-Regular"), url("../fonts/roboto-slab/roboto-slab-v7-latin-regular.eot?#iefix") format("embedded-opentype"), url("../fonts/roboto-slab/roboto-slab-v7-latin-regular.woff2") format("woff2"), url("../fonts/roboto-slab/roboto-slab-v7-latin-regular.woff") format("woff"), url("../fonts/roboto-slab/roboto-slab-v7-latin-regular.ttf") format("truetype"), url("../fonts/roboto-slab/roboto-slab-v7-latin-regular.svg#RobotoSlab") format("svg");
                /* Legacy iOS */
            }

            /* roboto-slab-700 - latin */
            @font-face {
                font-family: 'Roboto Slab';
                font-style: normal;
                font-weight: 700;
                src: url("../fonts/roboto-slab/roboto-slab-v7-latin-700.eot");
                /* IE9 Compat Modes */
                src: local("Roboto Slab Bold"), local("RobotoSlab-Bold"), url("../fonts/roboto-slab/roboto-slab-v7-latin-700.eot?#iefix") format("embedded-opentype"), url("../fonts/roboto-slab/roboto-slab-v7-latin-700.woff2") format("woff2"), url("../fonts/roboto-slab/roboto-slab-v7-latin-700.woff") format("woff"), url("../fonts/roboto-slab/roboto-slab-v7-latin-700.ttf") format("truetype"), url("../fonts/roboto-slab/roboto-slab-v7-latin-700.svg#RobotoSlab") format("svg");
                /* Legacy iOS */
            }

            a:focus,
            a:active {
                text-decoration: none;
                outline: none;
                transition: all 300ms ease 0s;
                -moz-transition: all 300ms ease 0s;
                -webkit-transition: all 300ms ease 0s;
                -o-transition: all 300ms ease 0s;
                -ms-transition: all 300ms ease 0s;
            }

            input,
            select,
            textarea {
                outline: none;
                appearance: unset !important;
                -moz-appearance: unset !important;
                -webkit-appearance: unset !important;
                -o-appearance: unset !important;
                -ms-appearance: unset !important;
            }

            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                appearance: none !important;
                -moz-appearance: none !important;
                -webkit-appearance: none !important;
                -o-appearance: none !important;
                -ms-appearance: none !important;
                margin: 0;
            }

            input:focus,
            select:focus,
            textarea:focus {
                outline: none;
                box-shadow: none !important;
                -moz-box-shadow: none !important;
                -webkit-box-shadow: none !important;
                -o-box-shadow: none !important;
                -ms-box-shadow: none !important;
            }

            input[type=checkbox] {
                appearance: checkbox !important;
                -moz-appearance: checkbox !important;
                -webkit-appearance: checkbox !important;
                -o-appearance: checkbox !important;
                -ms-appearance: checkbox !important;
            }

            input[type=radio] {
                appearance: radio !important;
                -moz-appearance: radio !important;
                -webkit-appearance: radio !important;
                -o-appearance: radio !important;
                -ms-appearance: radio !important;
            }

            .clear {
                clear: both;
            }

            .upload-card-wrapper {
                flex: 1;
                min-width: 0;
                position: relative;
            }
            .upload-card {
                padding: 20px 10px;
                border: 2px dashed #d1d5db;
                border-radius: 12px;
                text-align: center;
                background: #f9fafb;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 140px;
                position: relative;
                overflow: hidden;
                width: 100%;
                box-sizing: border-box;
            }
            .upload-card:hover {
                border-color: #046fd4;
                background: #f0f7ff;
            }
            .upload-card.uploaded {
                border-color: #16a34a;
                background: #f0fdf4;
            }
            .upload-card.uploaded i {
                color: #16a34a !important;
            }
            .upload-card.uploaded .upload-title {
                color: #15803d;
            }
            .upload-card.uploaded .upload-subtitle {
                color: #16a34a;
            }
            .upload-card i {
                font-size: 36px;
                color: #9ca3af;
                margin-bottom: 8px;
                transition: color 0.3s ease;
            }
            .upload-card:hover i {
                color: #046fd4;
            }
            .upload-card .upload-title {
                font-weight: 600;
                color: #374151;
                font-size: 14px;
            }
            .upload-card .upload-subtitle {
                font-size: 12px;
                color: #6b7280;
                margin-top: 4px;
            }
            .image-preview-container {
                width: 100%;
                margin-top: 15px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .img-preview {
                max-width: 100%;
                max-height: 200px;
                object-fit: contain;
                border-radius: 8px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                border: 1px solid #e5e7eb;
            }
            .existing-image-label {
                font-size: 0.85rem;
                color: #6b7280;
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
            }

            h2 {
                font-size: 30px;
                margin: 0px;
            }

            body {
                font-size: 14px;
                line-height: 1.6;
                color: #001973;
                font-weight: 400;
                font-family: 'Roboto Slab';
                margin: 0px;
                background: #f9fafb;
                position: relative;
                padding: 0px;
            }

            .main {
                padding: 0;
                position: relative;
                z-index: 99;
            }

            .container-booking {
                width: 100%;
                max-width: 1400px;
                margin: 0 auto;
                background: #fff;
            }

            fieldset {
                padding: 0px;
                margin: 0px;
                border: none;
                padding-left: 45px;
                padding-right: 55px;
                padding-top: 45px;
            }

            p.desc {
                margin: 0px;
                margin-bottom: 40px;
                color: #555;
            }

            .form-label {
                display: block;
                width: 100%;
                font-size: 16px;
                margin: 5px 0;
            }

            .text-input {
                font-size: 12px;
                color: #999;
                display: block;
                margin-top: 5px;
            }

            .text-input span {
                color: #222;
                font-weight: bold;
            }

            input,
            select {
                width: 100%;
                display: block;
                border: 1px solid #e3dec9;
                border-radius: 8px;
                height: 48px;
                box-sizing: border-box;
                padding: 0 16px;
                color: #5c554e;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.3s ease;
                background-color: #ffffff;
            }
            
            input:focus, select:focus {
                border-color: #b59349;
                outline: none;
                box-shadow: 0 0 0 3px rgba(181, 147, 73, 0.1);
            }

            #steps-uid-0-p-0 .form-row,
            #steps-uid-0-p-0 .form-group,
            #steps-uid-0-p-0 .form-date {
                width: 100%;
            }

            .form-flex {
                display: flex;
                gap: 20px;
                margin: 0;
            }

            .form-flex .form-group {
                flex: 1;
                padding: 0;
            }

            .form-group,
            .form-date {
                margin-bottom: 2px;
                position: relative;
            }

            .form-date-group {
                border: 1px solid transparent;
                border-radius: 5px;
                -moz-border-radius: 5px;
                -webkit-border-radius: 5px;
                -o-border-radius: 5px;
                -ms-border-radius: 5px;
            }

            .form-date-group select {
                border: 1px solid #ebebeb;
                width: 100%;
                box-sizing: border-box;
                appearance: none !important;
                -moz-appearance: none !important;
                -webkit-appearance: none !important;
                -o-appearance: none !important;
                -ms-appearance: none !important;
                position: relative;
                background: 0 0;
                z-index: 10;
                cursor: pointer;
                padding: 0 20px;
                height: 37px;
                font-size: 14px;
                font-family: 'Roboto Slab';
                color: #999;
                box-sizing: border-box;
                background-color: #fff;
                color: #222;
                font-weight: bold;
            }

            .form-date-item {
                position: relative;
                overflow: hidden;
                width: 100px;
                margin-right: 10px;
            }

            .vertical {
                display: block;
                width: 100%;
                overflow: hidden;
                background-color: #effaf4;
            }

            .vertical .steps {
                float: left;
                width: 25%;
            }

            .vertical .content,
            .vertical .actions {
                float: right;
                width: 75%;
            }

            .content {
                min-height: 400px;
                background-color: white;
            }

            .steps ul {
                flex-direction: column;
                -moz-flex-direction: column;
                -webkit-flex-direction: column;
                -o-flex-direction: column;
                -ms-flex-direction: column;
                position: relative;
                padding-left: 40px;
                padding-top: 60px;
            }

            .steps ul li {
                padding-bottom: 30px;
                position: relative;
                z-index: 99;
            }

            .steps ul li a {
                text-decoration: none;
                color: #222;
            }

            .steps ul:after {
                position: absolute;
                content: '';
                width: 2px;
                height: 400px;
                background: #ebebeb;
                left: 64px;
                top: 50%;
                transform: translateY(-50%);
                -moz-transform: translateY(-50%);
                -webkit-transform: translateY(-50%);
                -o-transform: translateY(-50%);
                -ms-transform: translateY(-50%);
                z-index: 9;
            }

            .title {
                align-items: center;
                -moz-align-items: center;
                -webkit-align-items: center;
                -o-align-items: center;
                -ms-align-items: center;
            }

            .title .step-number {
                width: 40px;
                height: 40px;
                align-items: center;
                -moz-align-items: center;
                -webkit-align-items: center;
                -o-align-items: center;
                -ms-align-items: center;
                justify-content: center;
                -moz-justify-content: center;
                -webkit-justify-content: center;
                -o-justify-content: center;
                -ms-justify-content: center;
                border-radius: 50%;
                -moz-border-radius: 50%;
                -webkit-border-radius: 50%;
                -o-border-radius: 50%;
                -ms-border-radius: 50%;
                background: #ebebeb;
                color: #999;
                margin-right: 15px;
                border: 5px solid #fff;
                font-weight: bold;
            }

            .title .step-text {
                font-weight: bold;
                color: #999;
            }

            .current .title .step-number {
                background: linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
                color: #fff;
            }

            .current .title .step-text {
                color: linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
            }

            .content h3 {
                display: none;
            }

            .content,
            .actions {
/*                background: #f8f8f8;*/
                background-color: white;
            }

            .actions {
                padding-bottom: 90px;
            }

            .actions ul {
                padding-left: 45px;
                padding-right: 55px;
            }

            .actions ul .disabled {
                display: none;
            }

            .actions ul li {
                float: right;
            }

            .actions ul li:first-child {
                float: left;
            }

            .actions ul li:first-child a {
                background: #e8e8e8;
                color: #999;
            }

            .actions ul li a {
                width: 140px;
                height: 50px;
                color: #fff;
                background: linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
                align-items: center;
                -moz-align-items: center;
                -webkit-align-items: center;
                -o-align-items: center;
                -ms-align-items: center;
                justify-content: center;
                -moz-justify-content: center;
                -webkit-justify-content: center;
                -o-justify-content: center;
                -ms-justify-content: center;
                text-decoration: none;
            }

            .form-radio-flex {
                flex-wrap: wrap;
                -moz-flex-wrap: wrap;
                -webkit-flex-wrap: wrap;
                -o-flex-wrap: wrap;
                -ms-flex-wrap: wrap;
                margin: 0 -15px;
            }

            .form-radio-flex .form-radio-item {
                padding: 0 15px;
                margin-bottom: 25px;
            }

            .form-radio-flex input {
                width: 0;
                height: 0;
                position: absolute;
                left: -9999px;
            }

            .form-radio-flex input+label {
                margin: 0px;
                width: 223px;
                height: 133px;
                box-sizing: border-box;
                position: relative;
                display: inline-block;
                text-align: center;
                background-color: transparent;
                border: 1px solid transparent;
                text-align: center;
                text-transform: none;
                transition: border-color .15s ease-out, color .25s ease-out, background-color .15s ease-out, box-shadow .15s ease-out;
            }

            .form-radio-flex input+label img {
                width: 100%;
                height: 100%;
            }

            .form-radio-flex input:checked+label {
                border: 1px solid linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
                z-index: 1;
            }

            .form-radio-flex input:focus+label {
                outline: none;
            }

            .form-radio-flex input:hover {
                border: 1px solid linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
            }

            label.error {
                display: block;
                position: relative;
                color: #e53e3e;
                font-size: 12px;
                margin-top: 4px;
            }

            label.error:after {
                font-family: 'Material-Design-Iconic-Font';
                position: absolute;
                content: '\f135';
                right: 5px;
                top: 0;
                font-size: 13px;
                color: #f63726;
                display: none; /* Hide the icon to keep the UI clean with just the red text */
            }

            input.error {
                border: 1px solid #f63726;
            }

            #find_bank {
                padding: 0 55px;
                width: 680px;
                margin-right: 20px;
            }

            #find_bank::-webkit-input-placeholder {
                font-weight: 400;
            }

            #find_bank::-moz-placeholder {
                font-weight: 400;
            }

            #find_bank:-ms-input-placeholder {
                font-weight: 400;
            }

            #find_bank:-moz-placeholder {
                font-weight: 400;
            }

            .submit {
                width: 150px;
                background: #666;
                color: #fff;
                font-weight: 400;
                cursor: pointer;
            }

            .submit:hover {
                background-color: #4d4d4d;
            }

            .form-find {
                position: relative;
                padding-bottom: 70px;
                border-bottom: 1px solid #ebebeb;
            }

            .form-icon {
                position: absolute;
                top: 12px;
                left: 20px;
                font-size: 18px;
                color: #999;
            }

            .choose-bank-desc {
                color: #666;
                margin: 0px;
                padding-top: 30px;
                padding-bottom: 35px;
            }

            #slider-margin {
                height: 9px;
                border: none;
                box-shadow: none;
                -moz-box-shadow: none;
                -webkit-box-shadow: none;
                -o-box-shadow: none;
                -ms-box-shadow: none;
                background: #e8e8e8;
                border-radius: 0px;
                -moz-border-radius: 0px;
                -webkit-border-radius: 0px;
                -o-border-radius: 0px;
                -ms-border-radius: 0px;
                position: relative;
                margin-top: 110px;
            }

            #slider-margin .noUi-marker-horizontal.noUi-marker-large,
            #slider-margin .noUi-marker-horizontal.noUi-marker {
                height: 0px;
            }

            #slider-margin .noUi-connect {
                background: linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
            }

            #slider-margin .noUi-connects {
                border-radius: 0px;
                -moz-border-radius: 0px;
                -webkit-border-radius: 0px;
                -o-border-radius: 0px;
                -ms-border-radius: 0px;
            }

            #slider-margin .noUi-handle {
                width: 15px;
                height: 30px;
                top: -12px;
                background: #e8e8e8;
                outline: none;
                border: none;
                right: -15px;
                border: 1px solid linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
                border-radius: 0px;
            }

            #slider-margin .noUi-handle:after,
            #slider-margin .noUi-handle:before {
                width: 0px;
            }

            #slider-margin .noUi-handle .noUi-tooltip {
                bottom: 33px;
                border: none;
                background: transparent;
                font-size: 16px;
                color: linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
                padding: 0px;
            }

            #slider-margin .noUi-pips {
                width: 96%;
            }

            #slider-margin .noUi-pips .noUi-value {
                top: -50px;
                font-size: 16px;
                color: #666;
            }

            #slider-margin .noUi-pips .noUi-value:before {
                content: '$';
            }

            #slider-margin .noUi-pips .noUi-value-horizontal {
                transform: none;
                -moz-transform: none;
                -webkit-transform: none;
                -o-transform: none;
                -ms-transform: none;
            }

            .your-money {
                font-size: 16px;
                color: #222;
                margin: 0px;
                padding-top: 62px;
            }

            .your-money .money {
                font-size: 28px;
                font-weight: bold;
            }

            @media screen and (max-width: 1024px) {
                .containerbooking {
                    width: calc(100% - 40px);
                    max-width: 100%;
                }

                .vertical .steps,
                .vertical .content,
                .vertical .actions {
                    float: none;
                    width: 100%;
                }

                #find_bank {
                    width: 100%;
                }

                .form-radio-flex input+label {
                    width: 190px;
                    height: 120px;
                }
            }

            @media screen and (max-width: 992px) {
                .content {
                    height: 900px;
                }

                .form-radio-flex input+label {
                    width: 100px;
                    height: 65px;
                }
            }

            @media screen and (max-width: 768px) {

                #steps-uid-0-p-0 .form-row,
                #steps-uid-0-p-0 .form-group,
                #steps-uid-0-p-0 .form-date {
                    width: 100%;
                }

                .form-flex {
                    flex-direction: column;
                    -moz-flex-direction: column;
                    -webkit-flex-direction: column;
                    -o-flex-direction: column;
                    -ms-flex-direction: column;
                    margin: 0px;
                }

                .form-flex .form-group {
                    margin-left: 12px;
                    padding: 0px;
                }

                fieldset,
                .actions ul {
                    padding-left: 30px;
                    padding-right: 30px;
                }

                #slider-margin .noUi-pips {
                    width: 94%;
                }
            }

            @media screen and (max-width: 480px) {

                .form-date-group,
                .form-find {
                    flex-direction: column;
                    -moz-flex-direction: column;
                    -webkit-flex-direction: column;
                    -o-flex-direction: column;
                    -ms-flex-direction: column;
                }

                .content {
                    height: 1050px;
                }

                #find_bank {
                    margin-bottom: 20px;
                }

                .actions ul li a {
                    width: 100px;
                }

                .form-radio-flex {
                    margin: 0 -5px;
                }

                .form-radio-flex .form-radio-item {
                    padding: 0 5px;
                }

                .form-radio-flex input+label {
                    width: 90px;
                    height: 61px;
                }
            }

            .form-enter {
                background-color: #ebebeb;
                border-radius: 5px;
                box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);
                margin: 20px -7px 25px -7px;
                padding: 5px 7px 16px 7px;
            }

            .form-control {
                width: 100%;
                max-width: 600px;
                min-width: 200px;
                max-height: 400px;
                min-height: 100px;
            }

            .form-radio-group {
                justify-content: space-between;
            }

            .form-radio-group label {
                width: 70%;
                display: flex;
            }

            .form-radio-group label input {
                width: 20px;
            }

            .location {
                margin-top: 85px
            }

            select {
                border-radius: 8px;
            }

            .scrollable-vertical {
                width: 100%;
                height: 555px;
                /* border: 1px solid #000; */
                overflow-y: scroll;
                /* Chỉ tạo cuộn dọc */
                overflow-x: hidden;
                /* Ẩn cuộn ngang nếu có */
                padding: 10px;
            }

            .form-box {
                display: inline-flex;
            }

            .form-box,
            .form-box-total {
                background-color: #fff;
                box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);
                margin-bottom: 35px;
                padding: 30px;
                width: 94%;
                border-top: 1px black solid;
            }

            .form-img {
                width: 25%;
                padding: 0 5px;
            }

            .form-img img {
                width: 100%;
            }

            .form-text {
                padding: 0 15px;
                width: 50%;
            }

            .scrollable-vertical h4 {
                margin: 12px 0;
                font-size: 16px;
            }

            .form-doc {
                width: 100%;
            }

            .form-doc p {
                margin-top: 0;
                font-size: 12px;
            }

            .form-doc ul li {
                margin-top: 0;
                font-size: 12px;
            }

            .form-check,
            .price-container {
                width: 25%;
                padding: 0 5px;
            }

            .checkbox-container {
                display: flex;
                align-items: center;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                width: 92%;
                height: 20px;
            }

            .checkbox-container input[type="checkbox"] {
                margin-right: 10px;
                width: 8%;
            }

            .checkbox-container label {
                font-size: 14px;
                font-weight: bold;
                color: #333;
            }

            .form-box label {
                font-weight: bold;
                color: #333;
            }

            .form-check-select {
                text-align: center;
                width: 28%;
                height: 110%;
                margin-right: 6px;
            }

            .form-comf-50 {
                display: inline-block;
                width: 50%;
                flex-wrap: wrap;
                gap: 30px;
            }

            .form-comf-20 {
                display: inline-flex;
                width: 25%;
                flex-wrap: wrap;
                gap: 60px;
            }

            .item-container {
                width: 100%;
                display: flex;
            }

            .form-comf-70 {
                display: inline-flex;
                width: 65%;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: space-between;
            }

            .form-comf-30 {
                display: inline-flex;
                width: 35%;
                justify-content: space-between;
                /* border-left:1px black solid ; */
                /* flex-wrap: wrap; 
              gap: 20px; */
            }

            .form-comf-text {
                margin-bottom: 20px;
            }

            .form-img-bike {
                width: 35%;
                padding: 0 5px;
            }

            .form-img-bike img {
                width: 100%;
                height: 100%;
            }

            .item-total {
                width: 100%;
                display: flex;
                justify-content: space-between;
                border-top: 2px dotted #666;
                margin-top: 15px;
            }

            .price-container {
                text-align: center;
                font-family: Arial, sans-serif;
            }

            .text-period {
                color: gray;
                margin-left: 5px;
                vertical-align: super;
            }

            .main-price {
                font-size: 20px;
                font-weight: unset;
                margin: 0;
/*                display: inline-block;*/
                display: none;
            }

            .price-note {
                font-size: 0.9em;
                color: gray;
                margin: 5px 0 30px 0;
            }

            .rent-button {
                background: linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%);
                color: black;
                border: none;
                padding: 15px 10px;
                font-size: 1em;
                font-weight: bold;
                cursor: pointer;
                border-radius: 2px;
                display: flex;
                width: 100%;
                display: flex;
                justify-content: space-around;
            }

            /*            .rent-button:hover {
                            background-color: #454545;
                            color: white;
                        }*/

            .hidden-next {
                display: block;
            }
            
            .quantity-container {
                display: flex;
                align-items: center;
                width: 100%;
                
/*                justify-content: space-around;*/
                
            }

            .buttonMotor {
                font-size: 16px;
                font-weight: bold;
                text-align: center;
/*                border-radius: 50%; */
/*                border-radius: 5px;*/
                color:white; 
                border-style: none;
            }
            
            #plus{
                background: black;
                height: 20px;
                width: 100%;
                border-bottom: solid;
            }
            #minus{
                background: black;
                height: 20px;
                width: 100%
            }
            #clear{
                background: red;
                height: 40px;
                width: 15%;
            }

            .quantity-container input {
                width: 65%;
                text-align: center;
                border-style: none;
                height: 40px;
            }
            /* Lớp phủ toàn trang */
            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5); /* Nền bán trong suốt */
                display: none; /* Ẩn theo mặc định */
                justify-content: center;
                align-items: center;
                z-index: 9999; /* Đảm bảo nằm trên cùng */
            }
            .overlay.active {
                display: flex; /* Hiển thị lớp phủ khi active */
            }
            .overlay span {
                color: #fff;
                font-size: 24px;
            }
            
            label.error{
                color: #dc3545;
                font-size: 11px;
                font-weight: 600;
                margin-top: 4px;
            }
             .note-star{
                color: red;
             }

            /* --- LUXURY OVERRIDES FOR PREMIUM BOOKING EXPERIENCE --- */
            /* Override disabled input fading */
            input:disabled, select:disabled {
                opacity: 1 !important;
                background-color: #f1f3f5 !important;
                color: #212529 !important;
                border-color: #ced4da !important;
                -webkit-text-fill-color: #212529 !important;
            }
            .form-label {
                color: #212529 !important;
                font-weight: 800 !important;
            }
            input[type="date"], input[type="time"], select, input[type="text"], input[type="email"], input[type="tel"] {
                border: 1px solid #adb5bd !important;
                color: #1a1816 !important;
                font-weight: 700 !important;
            }
            .title .step-text {
                color: #495057 !important;
                font-weight: 800 !important;
            }
            body {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                background-color: transparent !important;
                color: #2b2824 !important;
                font-weight: 500 !important;
            }
            .main {
                padding: 60px 0 !important;
                background: transparent !important;
                
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
            }
            .container-booking {
                width: 100% !important; max-width: 100% !important;
                max-width: 95% !important;
                background: #ffffff !important;
                border-radius: 20px !important;
                box-shadow: 0 25px 60px rgba(0, 0, 0, 0.45) !important;
                overflow: hidden !important;
                position: relative !important;
                border: 1px solid rgba(181, 147, 73, 0.15) !important;
            }
            
            /* Sleek Close/Exit Button */
            .btn-exit-booking { display: none !important;
                position: absolute !important;
                top: 25px !important;
                right: 35px !important;
                background: rgba(26, 24, 22, 0.05) !important;
                border: 1px solid rgba(26, 24, 22, 0.12) !important;
                color: #1a1816 !important;
                padding: 10px 22px !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 13px !important;
                text-transform: uppercase !important;
                letter-spacing: 1px !important;
                border-radius: 30px !important;
                text-decoration: none !important;
                display: inline-flex !important;
                align-items: center !important;
                gap: 8px !important;
                z-index: 1000 !important;
                transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1) !important;
            }
            .btn-exit-booking i {
                font-size: 14px !important;
                font-weight: 800 !important;
            }
            .btn-exit-booking:hover {
                background: #b59349 !important;
                color: #ffffff !important;
                border-color: #b59349 !important;
                box-shadow: 0 4px 15px rgba(181, 147, 73, 0.3) !important;
                transform: translateY(-2px) !important;
            }
            .btn-exit-booking:active {
                transform: translateY(0) scale(0.96) !important;
            }

            /* Step Sidebar Overhaul */
            .vertical {
                background-color: #ffffff !important;
                display: flex !important;
                flex-direction: row !important;
                width: 100% !important;
                min-height: 850px !important;
            }
            .vertical .steps {
                width: 320px !important;
                background-color: #fbfaf8 !important;
                border-right: 1px solid rgba(181, 147, 73, 0.12) !important;
                padding: 50px 30px !important;
                float: none !important;
            }
            .vertical .content {
                flex: 1 !important;
                float: none !important;
                width: auto !important;
                background-color: #ffffff !important;
                padding: 50px 60px 140px 60px !important;
                height: auto !important;
                min-height: 700px !important;
            }
            .vertical .actions {
                position: absolute !important;
                bottom: 0 !important;
                right: 0 !important;
                width: calc(100% - 320px) !important;
                background-color: #ffffff !important;
                border-top: 1px solid rgba(26, 24, 22, 0.05) !important;
                padding: 25px 60px 40px 60px !important;
                float: none !important;
            }
            
            /* Sidebar step text & timeline */
            .steps ul {
                padding-left: 0 !important;
                padding-top: 0 !important;
                display: flex !important;
                flex-direction: column !important;
                gap: 24px !important;
            }
            .steps ul li {
                padding-bottom: 0 !important;
                margin-bottom: 0 !important;
            }
            .steps ul:after {
                display: none !important; /* Hide outdated static timeline line */
            }
            .title {
                display: flex !important;
                align-items: center !important;
            }
            .title .step-number {
                width: 44px !important;
                height: 44px !important;
                border: 2px solid rgba(181, 147, 73, 0.2) !important;
                background: #ffffff !important;
                color: #b59349 !important;
                font-family: 'Poppins', sans-serif !important;
                font-weight: 700 !important;
                font-size: 15px !important;
                margin-right: 18px !important;
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                transition: all 0.3s ease !important;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02) !important;
            }
            .title .step-text {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 14px !important;
                color: #7c766f !important;
                letter-spacing: 0.5px !important;
                text-transform: uppercase !important;
                transition: all 0.3s ease !important;
            }
            
            /* Active step indicators */
            .current .title .step-number {
                background: #b59349 !important;
                color: #ffffff !important;
                border-color: #b59349 !important;
                box-shadow: 0 4px 15px rgba(181, 147, 73, 0.3) !important;
            }
            .current .title .step-text {
                color: #1a1816 !important;
            }
            
            /* Fieldset Header Styling */
            fieldset {
                padding: 0 !important;
                margin: 0 !important;
                border: none !important;
            }
            fieldset h2 {
                font-family: 'Poppins', sans-serif !important;
                font-weight: 800 !important;
                font-size: 28px !important;
                letter-spacing: 0.5px !important;
                color: #1a1816 !important;
                margin-bottom: 8px !important;
            }
            fieldset p.desc {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 14px !important;
                color: #7c766f !important;
                margin-bottom: 35px !important;
            }

            /* Luxury Form Inputs */
            .form-label {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 12px !important;
                text-transform: uppercase !important;
                letter-spacing: 1px !important;
                color: #5c554e !important;
                margin-bottom: 8px !important;
            }
            input[type="date"], input[type="time"], select, input[type="text"], input[type="email"], input[type="tel"] {
                width: 100% !important;
                height: 48px !important;
                border: 1px solid #e3dec9 !important;
                border-radius: 8px !important;
                padding: 0 16px !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 14px !important;
                color: #1a1816 !important;
                font-weight: 600 !important;
                background-color: #fbfaf8 !important;
                box-sizing: border-box !important;
                transition: all 0.3s ease !important;
            }
            input:focus, select:focus {
                border-color: #b59349 !important;
                background-color: #ffffff !important;
                box-shadow: 0 0 0 4px rgba(181, 147, 73, 0.12) !important;
                outline: none !important;
            }
            
            /* Grid Spacing fixes */
            .form-flex {
                display: grid !important;
                grid-template-columns: 1fr 1fr !important;
                gap: 20px 30px !important;
                margin: 0 !important;
            }
            .form-flex .form-group {
                width: 100% !important;
                padding: 0 !important;
                margin: 0 !important;
            }
            .form-row {
                margin-bottom: 25px !important;
            }
            .form-row.location {
                margin-top: 0 !important;
            }

            /* Step Actions Buttons (Prev, Next, Finish) */
            .actions ul {
                display: flex !important;
                justify-content: flex-end !important;
                gap: 15px !important;
                padding: 0 !important;
                margin: 0 !important;
                list-style: none !important;
                width: 100% !important;
            }
            .actions ul li {
                float: none !important;
            }
            .actions ul li.disabled, .actions ul .disabled {
                display: none !important;
            }
            .actions ul li:first-child {
                margin-right: auto !important;
            }
            .actions ul li a {
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                width: 160px !important;
                height: 48px !important;
                border-radius: 8px !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                text-transform: uppercase !important;
                letter-spacing: 1px !important;
                font-size: 13px !important;
                box-shadow: 0 4px 12px rgba(181, 147, 73, 0.12) !important;
                transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1) !important;
                text-decoration: none !important;
            }
            /* Next/Finish button */
            .actions ul li:not(:first-child) a, .actions ul li a[href="#next"], .actions ul li a[href="#finish"] {
                background: #b59349 !important;
                color: #ffffff !important;
                border: 1px solid #b59349 !important;
            }
            .actions ul li:not(:first-child) a:hover, .actions ul li a[href="#next"]:hover, .actions ul li a[href="#finish"]:hover {
                background: #1a1816 !important;
                color: #b59349 !important;
                border-color: #b59349 !important;
                box-shadow: 0 6px 20px rgba(181, 147, 73, 0.35) !important;
                transform: translateY(-2px) !important;
            }
            .actions ul li:not(:first-child) a:active, .actions ul li a[href="#next"]:active, .actions ul li a[href="#finish"]:active {
                transform: translateY(0) scale(0.97) !important;
            }
            /* Prev button */
            .actions ul li:first-child a, .actions ul li a[href="#previous"] {
                background: #f1ede4 !important;
                color: #5c554e !important;
                border: 1px solid #e3dec9 !important;
            }
            .actions ul li:first-child a:hover, .actions ul li a[href="#previous"]:hover {
                background: #e3dec9 !important;
                color: #1a1816 !important;
                border-color: #c9c2ac !important;
                transform: translateY(-2px) !important;
            }
            .actions ul li:first-child a:active, .actions ul li a[href="#previous"]:active {
                transform: translateY(0) scale(0.97) !important;
            }

            /* Responsive Adjustments */
            @media (max-width: 991px) {
                .vertical {
                    flex-direction: column !important;
                }
                .vertical .steps {
                    width: 100% !important;
                    border-right: none !important;
                    border-bottom: 1px solid rgba(181, 147, 73, 0.12) !important;
                    padding: 30px !important;
                }
                .vertical .content {
                    padding: 30px !important;
                }
                .vertical .actions {
                    position: static !important;
                    width: 100% !important;
                    padding: 20px 30px 30px 30px !important;
                }
                .btn-exit-booking { display: none !important;
                    top: 15px !important;
                    right: 15px !important;
                    padding: 6px 14px !important;
                    font-size: 11px !important;
                }
            }

            /* --- WIZARD FORM CONTENT & CARD POLISHING --- */
            
            /* Hide the clunky raw text headers rendered by jquery-steps */
            #signup-form h3 {
                display: none !important;
            }

            /* Product Listing Card Modernization */
            .form-box, .form-box-total {
                background: #ffffff !important;
                border: 1px solid rgba(181, 147, 73, 0.15) !important;
                border-radius: 16px !important;
                box-shadow: 0 8px 30px rgba(26, 24, 22, 0.03) !important;
                margin-bottom: 25px !important;
                padding: 24px !important;
                width: 100% !important;
                box-sizing: border-box !important;
                transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1) !important;
                display: flex !important;
                flex-direction: row !important;
                align-items: center !important;
                gap: 24px !important;
            }
            .form-box:hover {
                border-color: #b59349 !important;
                box-shadow: 0 12px 35px rgba(181, 147, 73, 0.1) !important;
                transform: translateY(-3px) !important;
            }
            .form-img-bike, .form-img {
                width: 200px !important;
                height: 135px !important;
                flex-shrink: 0 !important;
                border-radius: 12px !important;
                overflow: hidden !important;
                background: #fbfaf8 !important;
                border: 1px solid rgba(181, 147, 73, 0.08) !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
            }
            .form-img-bike img, .form-img img {
                width: 100% !important;
                height: 100% !important;
                object-fit: contain !important;
                transition: transform 0.5s cubic-bezier(0.16, 1, 0.3, 1) !important;
            }
            .form-box:hover .form-img-bike img, .form-box:hover .form-img img {
                transform: scale(1.06) !important;
            }
            .form-text {
                flex: 1 !important;
                padding: 0 !important;
                width: auto !important;
            }
            .motor-name {
                font-family: 'Poppins', sans-serif !important;
                font-weight: 700 !important;
                font-size: 20px !important;
                color: #1a1816 !important;
                margin-top: 0 !important;
                margin-bottom: 8px !important;
            }
            .form-doc {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 13px !important;
                color: #6c665f !important;
                line-height: 1.6 !important;
            }
            .form-doc p {
                margin: 0 0 6px 0 !important;
            }
            .form-doc ul {
                margin: 0 !important;
                padding-left: 18px !important;
            }
            .form-doc ul li {
                font-size: 13px !important;
                color: #6c665f !important;
                margin-bottom: 4px !important;
            }

            /* Checkout Dynamic Price Displays */
            .form-check {
                width: 250px !important;
                flex-shrink: 0 !important;
                display: flex !important;
                flex-direction: column !important;
                align-items: flex-end !important;
                justify-content: center !important;
                gap: 12px !important;
                padding: 0 !important;
            }
            .main-price {
                font-family: 'Poppins', sans-serif !important;
                font-weight: 700 !important;
                font-size: 22px !important;
                color: #b59349 !important;
                margin: 0 !important;
                letter-spacing: 0.5px !important;
                text-align: right !important;
                /* Let JS dynamic controls handle the display property naturally */
            }
            .price-note {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 11px !important;
                color: #9c968f !important;
                margin: 0 !important;
                text-align: right !important;
            }

            /* Sleek Quantity Selector (Replaced clunky blue-cyan buttons) */
            .rent-button {
                background: #1a1816 !important;
                border: 1px solid #b59349 !important;
                border-radius: 8px !important;
                padding: 8px 14px !important;
                color: #ffffff !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 12px !important;
                display: inline-flex !important;
                align-items: center !important;
                gap: 12px !important;
                justify-content: space-between !important;
                width: auto !important;
                min-width: 200px !important;
                box-sizing: border-box !important;
            }
            .rent-button a {
                color: #ffffff !important;
                text-decoration: none !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                letter-spacing: 0.5px !important;
            }
            .form-check-select {
                background-color: #ffffff !important;
                border: 1px solid #e3dec9 !important;
                border-radius: 6px !important;
                color: #1a1816 !important;
                font-weight: 700 !important;
                height: 30px !important;
                padding: 0 6px !important;
                width: 65px !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-size: 13px !important;
                cursor: pointer !important;
            }

            /* Accessory Checkbox Containers (Step 3) */
            .checkbox-container {
                display: inline-flex !important;
                align-items: center !important;
                gap: 12px !important;
                background: #fbfaf8 !important;
                border: 1px solid #e3dec9 !important;
                border-radius: 8px !important;
                padding: 8px 16px !important;
                height: 48px !important;
                width: auto !important;
                box-shadow: none !important;
                box-sizing: border-box !important;
            }
            .checkbox-container label {
                font-family: 'Poppins', sans-serif !important;
                font-weight: 700 !important;
                font-size: 14px !important;
                color: #b59349 !important;
                margin: 0 !important;
            }
            .checkbox-container .items-free {
                color: #2e7d32 !important;
            }

            /* Custom Modern Segmented Radios for Gender (Step 4) */
            .form-radio-group {
                display: flex !important;
                gap: 10px !important;
                width: 100% !important;
                height: 48px !important;
                align-items: center !important;
            }
            .form-radio-group label {
                flex: 1 !important;
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                gap: 8px !important;
                background: #fbfaf8 !important;
                border: 1px solid #e3dec9 !important;
                border-radius: 8px !important;
                height: 100% !important;
                cursor: pointer !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                font-weight: 700 !important;
                font-size: 13px !important;
                color: #5c554e !important;
                transition: all 0.3s ease !important;
                margin: 0 !important;
                width: auto !important;
                box-sizing: border-box !important;
            }
            .form-radio-group label:hover {
                border-color: #b59349 !important;
                background: #ffffff !important;
            }
            .form-radio-group label input[type="radio"] {
                width: 16px !important;
                height: 16px !important;
                margin: 0 !important;
                accent-color: #b59349 !important;
                cursor: pointer !important;
            }
            .form-radio-group label:has(input:checked) {
                border-color: #b59349 !important;
                background: #fdfaf2 !important;
                color: #b59349 !important;
                box-shadow: 0 0 0 3px rgba(181, 147, 73, 0.1) !important;
            }

            /* CCCD Document Upload Container Overhaul */
            .form-enter {
                background-color: #fcfbfa !important;
                border: 1px solid rgba(181, 147, 73, 0.22) !important;
                border-radius: 14px !important;
                box-shadow: 0 8px 24px rgba(181, 147, 73, 0.03) !important;
                margin: 25px 0 !important;
                padding: 24px !important;
                box-sizing: border-box !important;
            }
            .form-enter .form-flex {
                display: grid !important;
                grid-template-columns: 2fr 1fr 1fr 2fr !important;
                gap: 20px !important;
                align-items: end !important;
                margin: 0 !important;
                width: 100% !important;
            }
            .form-enter .form-flex > div {
                width: 100% !important;
                padding: 0 !important;
                margin: 0 !important;
            }
            .form-enter .form-flex .form-group {
                width: 100% !important;
                padding: 0 !important;
                margin: 0 !important;
            }
            /* Restructure the inner flexbox for Issued date and Expiry date into columns */
            .form-enter .form-flex > div[style*="display: flex"] {
                display: grid !important;
                grid-template-columns: 1fr 1fr !important;
                gap: 15px !important;
            }
            .form-enter input[type="file"] {
                padding: 10px 14px !important;
                font-size: 13px !important;
                height: 48px !important;
                box-sizing: border-box !important;
                background: #ffffff !important;
                border: 1px solid #e3dec9 !important;
                border-radius: 8px !important;
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                color: #5c554e !important;
                cursor: pointer !important;
            }

            /* Responsive Adjustments for Cards & Steps */
            @media (max-width: 768px) {
                .form-box {
                    flex-direction: column !important;
                    align-items: stretch !important;
                }
                .form-img-bike, .form-img {
                    width: 100% !important;
                    height: 180px !important;
                }
                .form-check {
                    width: 100% !important;
                    align-items: stretch !important;
                }
                .main-price, .price-note {
                    text-align: left !important;
                }
                .form-enter .form-flex {
                    grid-template-columns: 1fr !important;
                    gap: 16px !important;
                }
                .form-enter .form-flex > div[style*="display: flex"] {
                    grid-template-columns: 1fr 1fr !important;
                }
            }
        </style>
        
        <!-- SweetAlert2 for popups and image zoom -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>

    <body>
        <div class="overlay" id="overlay">
            <span>Đang xử lý...</span>
        </div>
        <div class="main">
            <div class="container-booking">
              
                <form method="POST" id="signup-form" class="signup-form" action="">
                    
                    <div >
                        <button type="submit" id="paymentButton" style="display: none"></button>
                        <h3>Ngày giờ</h3>
                        <fieldset>
                            <h2>NGÀY & GIỜ GIA HẠN</h2>
                            <p class="desc">Hãy lựa chọn ngày giờ gia hạn</p>
                            <div class="form-row">
                                <div class="form-flex">
                                    <div class="form-group">
                                        <label for="pickupdate" class="form-label">Bắt đầu gia hạn từ ngày <span class="note-star"> *</span></label>
                                        <input type="date" name="pickupdate" id="pickupdate" value="${startDate}" disabled/>
                                    </div>
                                    <div class="form-group">
                                        <label for="pickuptime" class="form-label">Giờ bắt đầu <span class="note-star"> *</span></label>
                                        <input type="time" name="pickuptime" id="pickuptime" value="${startTime}" disabled/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-flex">
                                    <div class="form-group">
                                        <label for="returndate" class="form-label">Gia hạn đến ngày <span class="note-star"> *</span></label>
                                        <input type="date" name="returndate" id="returndate"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="returntime" class="form-label">Giờ kết thúc <span class="note-star"> *</span></label>
                                        <input type="time" name="returntime" id="returntime"  />
                                    </div>
                                </div>
                            </div>
                            <div class="form-row location">
                                <c:if test="${not empty booking}">
                                    <input type="datetime" id="returndatepre" style="display: none" value="${booking.endDate}">
                                    <input id="bookingid" style="display: none" value="${booking.bookingID}">
                                    <div class="form-flex">
                                    <div class="form-group" style="display: none;">
                                        <label for="pickuplocation" class="form-label">Địa điểm nhận xe <span class="note-star"> *</span></label>
                                        <select name="pickuplocation" id="pickuplocation" class="form-label"  disabled>
                                            <option value="Ga Đà Nẵng-Số 202 đường Hải Phòng" ${booking.deliveryLocation == "Ga Đà Nẵng-202 Đường Hải Phòng" ? 'selected' : ''}>Ga Đà Nẵng-202 Đường Hải Phòng
                                            </option>
                                            <option value="Sân bay quốc tế Đà Nẵng" ${booking.deliveryLocation == "Sân bay quốc tế Đà Nẵng" ? 'selected' : ''}>Sân bay quốc tế Đà Nẵng</option>
                                            <option value="Địa chỉ của bạn" ${booking.deliveryLocation == "Địa chỉ của bạn" ? 'selected' : ''}>Địa chỉ của bạn</option>
                                        </select>
                                    </div>
                                    <div class="form-group" style="width: 100%;">
                                        <label for="returnlocation" class="form-label">Địa điểm trả xe dự kiến <span class="note-star"> *</span></label>
                                        <select name="returnlocation" id="returnlocation" class="form-label" disabled style="width: 100%;">
                                             <option value="Ga Đà Nẵng-Số 202 đường Hải Phòng" ${booking.deliveryLocation == "Ga Đà Nẵng-202 Đường Hải Phòng" ? 'selected' : ''}>Ga Đà Nẵng-202 Đường Hải Phòng
                                            </option>
                                            <option value="Sân bay quốc tế Đà Nẵng" ${booking.deliveryLocation == "Sân bay quốc tế Đà Nẵng" ? 'selected' : ''}>Sân bay quốc tế Đà Nẵng</option>
                                            <option value="Địa chỉ của bạn" ${booking.deliveryLocation == "Địa chỉ của bạn" ? 'selected' : ''}>Địa chỉ của bạn</option>
                                        </select>
                                    </div>
                                </div>
                                </c:if>
                              
                            </div>
                        </fieldset>

                    
                        <h3>Xác nhận</h3>
                        <fieldset>
                            <h2>XÁC NHẬN ĐƠN GIA HẠN</h2>
                            <p class="desc">Hãy xác nhận thông tin và đồng ý với các điều khoản dịch vụ </p>
                            <div class="fieldset-content">
                                <div class="scrollable-vertical">
                                    <div style="background:#fff; border:1px solid #eaeaea; border-radius:12px; padding:20px; margin-bottom:16px;">
                                        <h4 style="margin:0 0 14px; color:#b59349; font-size:13px; text-transform:uppercase; letter-spacing:1px; border-bottom:1px solid #f0f0f0; padding-bottom:10px;">
                                            <i class="bi bi-clock-history"></i> Thời Gian Thuê
                                        </h4>
                                        <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
                                            <div style="display: none;">
                                                <div style="font-size:11px; color:#999; text-transform:uppercase; font-weight:700; margin-bottom:4px;">Bắt đầu gia hạn từ</div>
                                                <div style="font-weight:600; color:#222; font-size:15px;"><span id="pickupdatetext"></span> <span id="pickuptimetext"></span></div>
                                                <div id="pickuploctext" style="font-size:13px; color:#666; margin-top:3px;"></div>
                                            </div>
                                            <div style="grid-column: span 2;">
                                                <div style="font-size:11px; color:#999; text-transform:uppercase; font-weight:700; margin-bottom:4px;">Gia hạn đến (Trả xe)</div>
                                                <div style="font-weight:600; color:#222; font-size:15px;"><span id="returndatetext"></span> <span id="returntimetext"></span></div>
                                                <div id="returnloctext" style="font-size:13px; color:#666; margin-top:3px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <h4>ĐÃ CHỌN XE MÁY</h4>
                                    <div id="savedBikeContainer">
                                        <c:forEach items="${listM}" var="m">
                                            <div class="form-box">
                                                <div class="form-img-bike">
                                                    <label style="width: 100%" for="body-bg"><img src="${empty m.key.image ? 'images/default.jpg' : (m.key.image.startsWith('http') ? m.key.image : 'images/'.concat(m.key.image))}" alt=""></label>
                                                </div>
                                                <div class="form-text">
                                                    <h4 class="motor-name">${m.key.model} ${m.key.displacement} </h4>
                                                    <div class="form-doc description-container" style="box-sizing: border-box;">
                                                        <div class="description-text collapsed" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; transition: all 0.3s;">
                                                            ${m.key.description}
                                                        </div>
                                                        <a href="javascript:void(0)" onclick="const dt = this.previousElementSibling; if(dt.style.display === '-webkit-box'){dt.style.display='block'; this.textContent='Thu gọn';}else{dt.style.display='-webkit-box'; this.textContent='Xem chi tiết';}" style="color:#b59349; font-size:12px; font-weight:600; text-decoration:underline;">Xem chi tiết</a>
                                                    </div>
                                                </div>
                                                <div class="form-check"> 
                                                    <!--                                                        <h2 class="main-price price-day price-current" >₫100000/Ngày</h2>                                                     -->
                                                    <c:forEach items="${listP}" var="p">
                                                        <c:if test="${p.priceListId eq m.key.priceListID}">
                                                            <h2 class="main-price price-day"><fmt:formatNumber value="${p.dailyPriceForDay}" pattern="#,##0"/> VNĐ<small>/ngày</small></h2>
                                                            <h2 class="main-price price-week"><fmt:formatNumber value="${p.dailyPriceForWeek}" pattern="#,##0"/> VNĐ<small>/ngày · gói tuần</small></h2>
                                                            <h2 class="main-price price-month"><fmt:formatNumber value="${p.dailyPriceForMonth}" pattern="#,##0"/> VNĐ<small>/ngày · gói tháng</small></h2>
                                                        </c:if>
                                                    </c:forEach>                                             
                                                    <p class="price-note">Không bao gồm thuế và bảo hiểm</p>                                                    
                                                    <input style="display: none" type="checkbox"  id="daily-checkbox-1" class="option-checkbox">
                                                    <div class="rent-button">                                                     
                                                        <a>Chọn số lượng xe: </a>
                                                        <select class="form-check-select" id="daily-select-1" disabled>
                                                            <option value="${m.value}" selected}>${m.value}</option>
                                                        </select>
                                                    </div>                                                         
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <h4>PHỤ KIỆN ĐI KÈM</h4>
                                    <div id="savedItemsContainer">
                                        <c:forEach items="${listA}" var="a">
                                            <div class="form-box">
                                                <div class="form-img">
                                                    <label for="body-bg"><img src="${empty a.key.accessoryImage ? 'images/default.jpg' : (a.key.accessoryImage.startsWith('http') ? a.key.accessoryImage : 'images/'.concat(a.key.accessoryImage))}" alt=""></label>
                                                </div>
                                                <div class="form-text">
                                                    <h4>${a.key.accessoryName}</h4>
                                                    <div class="form-doc" style="box-sizing: border-box;">
                                                        ${a.key.accessoryDescription}
                                                    </div>
                                                </div>
                                                <div class="form-check">
                                                    <div class="checkbox-container">
                                                        <select class="form-check-select" id="daily-select-${a.key.accessoryId}" disabled>
                                                            <option value="${a.value}" selected}>${a.value}</option>
                                                        </select>
                                                        <c:if test="${a.key.price eq 0}">
                                                            <label for="daily-checkbox" class="items-free">Free</label>
                                                        </c:if>
                                                        <c:if test="${a.key.price ne 0}">
                                                            <label for="daily-checkbox">₫${a.key.price/a.value}00</label>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>                 
                                    </div>
                                    <h4>TỔNG TIỀN</h4>
                                    <div class="form-box-total" id="form-box-total">

                                    </div>
                                    <div class="form-check" style="width: 100% !important; align-items: flex-start !important; margin-top: 15px;">
                                        <div class="checkbox-container">
                                            <input type="checkbox" id="daily-checkbox-term">
                                            <label style="white-space: nowrap;">Đồng ý<a href="policies.jsp" target="_blank"> điều khoản dịch vụ</a></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <h2 id="listpayment" style="display: none"><c:forEach items="${listPM}" var="pm">${pm.paymentAmount},</c:forEach></h2>


                        <h3>Thanh toán</h3>
                        <fieldset>
<!--                            <a onclick="yourFunctionName()">aaaaa</a>-->
                            <h2>THANH TOÁN CỌC</h2>
                            <p class="desc">Hãy thanh toán số tiền cọc theo bên dưới để hoàn thành đơn đặt xe của bạn</p>
                            <iframe id="myIframe" src="sepay_pay.jsp" style="width: 100%; height: 550px; border-style: hidden"></iframe>
                            <button type="button" class="btn btn-warning mt-3" style="width: 100%; padding: 12px; font-weight: bold; font-size: 16px; border-radius: 8px; background-color: #f59e0b; color: white; border: none; cursor: pointer;" onclick="handlePaymentStatus({status: 'success', amount: document.getElementById('dataInput').innerText.replace(/[^\d]/g, ''), time: new Date().getTime()})">
                                <i class="fas fa-magic"></i> DEMO: Bỏ qua thanh toán (Tạo đơn ngay)
                            </button>
                            
                        </fieldset>
                    </div>
                </form>
            </div>

        </div>

        <!-- JS -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/jquery-validation/dist/jquery.validate.min.js"></script>
        <script src="vendor/jquery-validation/dist/additional-methods.min.js"></script>
        <script src="vendor/jquery-steps/jquery.steps.min.js"></script>
        <script src="vendor/minimalist-picker/dobpicker.js"></script>
        <script src="vendor/nouislider/nouislider.min.js"></script>
        <script src="vendor/wnumb/wNumb.js"></script>
        <script>
            let totalI = 0;
            const numberAccessStatesI = {};
            (function ($) {



                $.validator.addMethod("businessHours", function(value, element) {
                    if (!value) return true;
                    const time = value;
                    const hours = parseInt(time.split(':')[0], 10);
                    return hours >= 7 && hours < 23;
                }, "Chỉ nhận/trả xe trong giờ hoạt động (07:00 - 23:00)");

                $.validator.addMethod("minExtensionDate", function(value, element) {
                    if (!value) return true; 
                    const originalReturnDateText = document.getElementById('returndatepre').value;
                    if (!originalReturnDateText) return true;

                    let datePart = originalReturnDateText.split(' ')[0];
                    let returnDatePre = new Date(datePart);
                    returnDatePre.setDate(returnDatePre.getDate() + 1);
                    
                    let minDateObj = new Date(returnDatePre.getFullYear(), returnDatePre.getMonth(), returnDatePre.getDate());
                    let today = new Date();
                    today.setHours(0, 0, 0, 0);
                    if (today > minDateObj) {
                        minDateObj = today;
                    }
                    
                    let selectedDateObj = new Date(value);
                    selectedDateObj = new Date(selectedDateObj.getFullYear(), selectedDateObj.getMonth(), selectedDateObj.getDate());
                    
                    return selectedDateObj >= minDateObj;
                }, "Ngày gia hạn phải lớn hơn ngày cũ và không được nhỏ hơn ngày hiện tại!");

                var form = $("#signup-form");
                form.validate({
                    errorPlacement: function errorPlacement(error, element) {
                        element.after(error);
                    },
                    rules: {
                        email: {
                            email: true
                        },
                        returndate: {
                            required: true,
                            minExtensionDate: true
                        },
                        returntime: {
                            required: true,
                            businessHours: true
                        }
                    },
                    onfocusout: function (element) {
                        $(element).valid();
                    },
                });
                form.children("div").steps({
                    headerTag: "h3",
                    bodyTag: "fieldset",
                    transitionEffect: "fade",
                    stepsOrientation: "vertical",
                    titleTemplate: '<div class="title"><span class="step-number">#index#</span><span class="step-text">#title#</span></div>',
                    labels: {
                        previous: 'Lùi lại',
                        next: 'Tiếp theo',
                        finish: 'Finish',
                        current: '',
                    },
                    onStepChanging: function (event, currentIndex, newIndex) {
                        if (currentIndex === 0) {
                            form.parent().parent().parent().append('<div class="footer footer-' + currentIndex + '"></div>');
                        }
                        if (currentIndex === 1) {
                            form.parent().parent().parent().find('.footer').removeClass('footer-0').addClass('footer-' + currentIndex + '');
                        }
                        if (currentIndex === 2) {
                            form.parent().parent().parent().find('.footer').removeClass('footer-1').addClass('footer-' + currentIndex + '');
                        }
                        if (currentIndex === 3) {
                            form.parent().parent().parent().find('.footer').removeClass('footer-2').addClass('footer-' + currentIndex + '');
                        }
                        if (currentIndex === 4) {
                            form.parent().parent().parent().find('.footer').removeClass('footer-3').addClass('footer-' + currentIndex + '');
                        }
                        if (currentIndex === 5) {
                            form.parent().parent().parent().find('.footer').removeClass('footer-4').addClass('footer-' + currentIndex + '');
                        }

                        // if(currentIndex === 4) {
                        //     form.parent().parent().parent().append('<div class="footer" style="height:752px;"></div>');
                        // }
                        form.validate().settings.ignore = ":disabled,:hidden";
                        
                        if (currentIndex === 0 && newIndex === 1) {
                            if (!form.valid()) return false;
                            
                            var newEndDate = document.getElementById("returndate").value;
                            var newEndTime = document.getElementById("returntime").value;
                            if (newEndDate && newEndTime) {
                                var overlap = false;
                                $.ajax({
                                    url: 'api/check-overlap',
                                    type: 'GET',
                                    async: false,
                                    data: {
                                        bookingId: '${booking.bookingID}',
                                        newEndDate: newEndDate + ' ' + newEndTime
                                    },
                                    success: function(response) {
                                        if (response.overlap) {
                                            overlap = true;
                                            Swal.fire({icon: 'error', title: 'Không thể gia hạn', text: 'Xe đã được khách hàng khác đặt trong khoảng thời gian này.'});
                                        }
                                    }
                                });
                                if (overlap) {
                                    return false;
                                }
                            }
                        }

                        return form.valid();
                    },
                    onFinishing: function (event, currentIndex) {
                        form.validate().settings.ignore = ":disabled";
                        return form.valid();
                    },
                    onFinished: function (event, currentIndex) {
                        
                        var formData = form.serialize();
                      
                        $.ajax({
                        url: 'forgotPassword', // Replace with your servlet URL
                        type: 'POST',
                        data: formData,
                       
                        success: function (response) {
                            // Handle success
                            alert('Submitted successfully');
                            console.log(response);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            // Handle error
                            alert('Submission failed');
                            console.error(textStatus, errorThrown);
                        }
                    });
                    },
                    onStepChanged: function (event, currentIndex, priorIndex) {

                        var nextButton = document.querySelector('.wizard .actions a[href="#next"]');
                        storedFormData = {
                                pickupdate: document.getElementById('pickupdate').value,
                                pickuptime: document.getElementById('pickuptime').value,
                                returndate: document.getElementById('returndate').value,
                                returntime: document.getElementById('returntime').value,
                                pickuplocation: document.getElementById('pickuplocation').value,
                                returnlocation: document.getElementById('returnlocation').value
                        };
                        const pickupDateText = storedFormData.pickupdate;
                        const returnDateText = storedFormData.returndate;

                        // Chuyển các chuỗi ngày thành đối tượng Date (với gia hạn thì tính từ ngày trả xe cũ)
                        const originalReturnDateText = document.getElementById('returndatepre').value;
                        const pickupDate = new Date(originalReturnDateText); // Lấy ngày trả cũ làm mốc bắt đầu tính tiền
                        const returnDate = new Date(returnDateText);

                        // Tính số ngày chênh lệch (số ngày gia hạn)
                        const differenceInTime = returnDate.getTime() - pickupDate.getTime();
                        const differenceInDays = differenceInTime / (1000 * 3600 * 24);
                            
                        if(currentIndex === 0){
                            nextButton.style.pointerEvents = 'auto';
                            nextButton.style.color = 'white';
                            nextButton.style.background = 'linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%)';
                        }

                       if(currentIndex === 2){
                            var finishButton = document.querySelector('.wizard .actions a[href="#finish"]');
                            finishButton.style.display = 'none';
                            // Lấy thẻ h2
                            const datatotalH2 = document.getElementById('dataInput');
                            const datapaymentH2 = document.getElementById('listpayment');
                            // Lấy iframe
                            const iframe = document.getElementById('myIframe');

                            // Truyền dữ liệu từ thẻ h2 vào iframe khi thẻ h2 thay đổi
                            const sendDataToIframe = () => {
                                // Lấy giá trị của thẻ h2
                                const dataTotal = datatotalH2.textContent.replace(/[₫,.]/g, '').trim();
                                const dataPayment = datapaymentH2.textContent.slice(0, -1).split(',').map(item => item.replace(/[₫,.]/g, '').trim());
                                
                                console.log(dataTotal);
                                
                                // Tạo một đối tượng chứa dữ liệu từ cả hai thẻ h2
                                const data = {
                                    dataTotal: dataTotal,
                                    dataPayment: [0],
                                    bookingId: '${booking.bookingID}'
                                };
            
                                // Truyền giá trị vào iframe
                                iframe.contentWindow.postMessage(data, '*');
                            };

                            // Gọi hàm để gửi dữ liệu ngay khi tải trang
                            sendDataToIframe();

                            // Theo dõi sự thay đổi của thẻ h2 và gửi dữ liệu vào iframe
                            const observer = new MutationObserver(sendDataToIframe);

                            observer.observe(datatotalH2, { childList: true, subtree: true });
                       }
                       
                       function changePrice(){
                            var quantityDay = Math.max(1, Math.ceil(differenceInDays));
                            const priceDayElements = document.querySelectorAll('.price-day');
                            const priceWeekElements = document.querySelectorAll('.price-week');
                            const priceMonthElements = document.querySelectorAll('.price-month');
                            
                            priceDayElements.forEach(element => {
                                   element.style.display = "none";
                                   element.classList.remove("price-current");
                            });
                            priceWeekElements.forEach(element => {
                                element.style.display = "none";
                                element.classList.remove("price-current");
                            });
                            priceMonthElements.forEach(element => {
                               element.style.display = "none";
                               element.classList.remove("price-current");
                            });
                            
                            console.log(differenceInDays);
                            
                            if (quantityDay < 7) {
                                
                                priceDayElements.forEach(element => {
                                   element.style.display = "inline-block";
                                   element.classList.add("price-current");
                                });
                            }
                            else if (quantityDay < 30) {
                                
                                priceWeekElements.forEach(element => {
                                   element.style.display = "inline-block";
                                   element.classList.add("price-current");
                                });
                            }
                            else {
                                
                                priceMonthElements.forEach(element => {
                                   element.style.display = "inline-block";
                                   element.classList.add("price-current");
                                });
                            }
                       }                                            
                           
                            
                            
                            
                        
                        
                        if(currentIndex !== 2){
                            const steps = document.querySelectorAll('.wizard ul[role="tablist"] li');
                            steps[2].classList.remove('done');
                            steps[2].classList.add('disabled');
                        }
                                               
                        if (currentIndex === 1) { // Bước thứ tư (index bắt đầu từ 0)
                            const checkbox = document.getElementById('daily-checkbox-term');
                            nextButton.style.pointerEvents = 'none';
                            nextButton.style.background = '#e8e8e8';
                            nextButton.style.color = '#999';
                            
                            // Function to toggle the next button based on the checkbox state
                            checkbox.addEventListener('change', toggleNextButton);
                            // Initial check
                            toggleNextButton();
                          
                            changePrice();
                            // Lấy dữ liệu đã lưu từ localStorage và thêm lại vào savedItemsContainer
                            
                            if (storedFormData) {
                                document.getElementById('pickupdatetext').textContent = storedFormData.pickupdate;
                                document.getElementById('pickuploctext').textContent = storedFormData.pickuplocation;
                                document.getElementById('pickuptimetext').textContent = storedFormData.pickuptime;
                                document.getElementById('returnloctext').textContent = storedFormData.returnlocation;
                                document.getElementById('returndatetext').textContent = storedFormData.returndate;
                                document.getElementById('returntimetext').textContent = storedFormData.returntime;
                            }
                            
                            // Thêm tiêu đề h4 và dữ liệu số lượng với giá tiền vào div cụ thể trong item-container
                            const formBoxTotal = document.getElementById('form-box-total');
                            if (!formBoxTotal) return;
                            formBoxTotal.innerHTML = '';
                            let totalAmount = 0;
                            
                            let tableHtml = `
                                <div style="background: #fff; padding: 20px; border-radius: 12px; border: 1px solid #eee; box-shadow: 0 4px 12px rgba(0,0,0,0.03);">
                                    <table style="width: 100%; border-collapse: collapse; margin-bottom: 0;">
                                        <thead>
                                            <tr style="border-bottom: 2px solid #e0c87a; text-align: left; color: #b59349; font-size: 14px;">
                                                <th style="padding: 12px 10px; font-weight: bold;">Dịch vụ</th>
                                                <th style="padding: 12px 10px; text-align: center; font-weight: bold; width: 12%;">Thời gian</th>
                                                <th style="padding: 12px 10px; text-align: center; font-weight: bold; width: 12%;">Số lượng</th>
                                                <th style="padding: 12px 10px; text-align: right; font-weight: bold; width: 18%;">Đơn giá</th>
                                                <th style="padding: 12px 10px; text-align: right; font-weight: bold; width: 22%;">Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                            `;

                            //calculator motorcycles
                            const savedBikeCal = document.querySelectorAll('#savedBikeContainer .form-box');
                            savedBikeCal.forEach(formBox => { 
                                const selects = formBox.querySelector('.form-check-select');
                                const title = formBox.querySelector('h4').textContent;
                                const priceLabel = formBox.querySelector('.price-current').textContent;
                                const quantity = parseInt(selects.value, 10);
                                let price = 0;

                                if (priceLabel.trim().toLowerCase() !== 'free') {
                                    price = parseInt(priceLabel.replace(/\D/g, ''), 10);
                                }

                                // Quantity là số ngày chênh lệch giữa ngày trả và ngày pickup
                                const quantityDay = Math.max(1, Math.ceil(differenceInDays)); // Đảm bảo quantity ít nhất là 1

                                // Tính tổng giá
                                const totalPrice = quantityDay * price * quantity;
                                totalAmount += totalPrice;
                                
                                let priceLabelDesc = "Ngày";
                                if (quantityDay >= 30) priceLabelDesc = "Tháng (Ưu đãi)";
                                else if (quantityDay >= 7) priceLabelDesc = "Tuần (Ưu đãi)";

                                tableHtml += `
                                    <tr style="border-bottom: 1px dashed #eee;">
                                        <td style="padding: 16px 10px;">
                                            <h4 style="margin: 0 0 6px 0; font-size: 15px; color: #333; font-weight: bold;">` + title + `</h4>
                                            <div style="font-size: 11px; color: #888; display: inline-block; padding: 2px 8px; border-radius: 4px; border: 1px solid #e0c87a; background: #fffdf5;">
                                                Gói áp dụng: <strong style="color: #b59349;">` + priceLabelDesc + `</strong>
                                            </div>
                                        </td>
                                        <td style="padding: 16px 10px; text-align: center; color: #555; font-size: 14px; font-weight: 500;">` + quantityDay + ` Ngày</td>
                                        <td style="padding: 16px 10px; text-align: center; color: #555; font-size: 14px; font-weight: 500;">` + quantity + ` Xe</td>
                                        <td style="padding: 16px 10px; text-align: right; color: #555; font-size: 14px; font-weight: 500;">₫` + price.toLocaleString() + `/Ngày</td>
                                        <td style="padding: 16px 10px; text-align: right; color: #b59349; font-size: 16px; font-weight: bold;">₫` + totalPrice.toLocaleString() + `</td>
                                    </tr>
                                 `;                                 
                            });
                            
                            // Calculator items
                            const savedAsseccCal = document.querySelectorAll('#savedItemsContainer .form-box');
                            savedAsseccCal.forEach(formBox => {                              
                                // Lấy nội dung từ thẻ h4 và label
                                const selects = formBox.querySelector('.form-check-select');
                                const title = formBox.querySelector('h4').textContent;
                                const priceLabel = formBox.querySelector('label[for="daily-checkbox"]').textContent;
                                const quantity = parseInt(selects.value, 10);
                                let price = 0;

                                if (priceLabel.trim().toLowerCase() !== 'free') {
                                    price = parseInt(priceLabel.replace(/\D/g, ''), 10);
                                }

                                // Tính tổng giá
                                const totalPrice = quantity * price;
                                totalAmount += totalPrice;

                                tableHtml += `
                                    <tr style="border-bottom: 1px dashed #eee;">
                                        <td style="padding: 16px 10px;">
                                            <h4 style="margin: 0; font-size: 15px; color: #444; font-weight: bold;">` + title + `</h4>
                                        </td>
                                        <td style="padding: 16px 10px; text-align: center; color: #aaa; font-size: 14px;">-</td>
                                        <td style="padding: 16px 10px; text-align: center; color: #555; font-size: 14px; font-weight: 500;">` + quantity + ` Cái</td>
                                        <td style="padding: 16px 10px; text-align: right; color: #555; font-size: 14px; font-weight: 500;">` + priceLabel + `</td>
                                        <td style="padding: 16px 10px; text-align: right; color: #555; font-size: 15px; font-weight: bold;">₫` + totalPrice.toLocaleString() + `</td>
                                    </tr>
                                 `;
                            });

                            tableHtml += `
                                        </tbody>
                                    </table>
                            `;

                            tableHtml += `
                                    <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:20px; padding-top:15px; border-top:2px solid #e0c87a;">
                                        <h4 style="margin:0; font-size:18px; color:#444; font-weight:bold;">Tổng cộng:</h4>
                                        <h2 id="dataInput" style="margin:0; font-size:24px; color:#b59349; font-weight:800;">₫` + totalAmount.toLocaleString() + `</h2>
                                    </div>
                                </div>
                            `;
                            
                            formBoxTotal.innerHTML = tableHtml;

                           
                            
                             
                        }

                        function toggleNextButton() {
                               const checkbox =document.getElementById('daily-checkbox-term');
                               if (checkbox.checked) {
                                   nextButton.style.pointerEvents = 'auto';
                                   nextButton.style.color = 'white';
                                   nextButton.style.background = 'linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%)';
                               } else {
                                   nextButton.style.pointerEvents = 'none';
                                   nextButton.style.background = '#e8e8e8';
                                   nextButton.style.color = '#999';
                               }
                        }
                        
                        
                        
                        return true;
                    }


                });
                jQuery.extend(jQuery.validator.messages, {
                    required: "",
                    remote: "",
                    email: "",
                    url: "",
                    date: "",
                    dateISO: "",
                    number: "",
                    digits: "",
                    creditcard: "",
                    equalTo: ""
                });

                $.dobPicker({
                    daySelector: '#birth_date',
                    monthSelector: '#birth_month',
                    yearSelector: '#birth_year',
                    dayDefault: '',
                    monthDefault: '',
                    yearDefault: '',
                    minimumAge: 0,
                    maximumAge: 120
                });
                var marginSlider = document.getElementById('slider-margin');
                if (marginSlider != undefined) {
                    noUiSlider.create(marginSlider, {
                        start: [1100],
                        step: 100,
                        connect: [true, false],
                        tooltips: [true],
                        range: {
                            'min': 100,
                            'max': 2000
                        },
                        pips: {
                            mode: 'values',
                            values: [100, 2000],
                            density: 4
                        },
                        format: wNumb({
                            decimals: 0,
                            thousand: '',
                            prefix: '$ ',
                        })
                    });
                    var marginMin = document.getElementById('value-lower'),
                            marginMax = document.getElementById('value-upper');

                    marginSlider.noUiSlider.on('update', function (values, handle) {
                        if (handle) {
                            marginMax.innerHTML = values[handle];
                        } else {
                            marginMin.innerHTML = values[handle];
                        }
                    });
                }





            })(jQuery);
            
            
            document.addEventListener('DOMContentLoaded', () => {
                              
                const requiredFields = [
                    document.getElementById('pickupdate'),
                    document.getElementById('pickuptime'),
                    document.getElementById('returndate'),
                    document.getElementById('returntime'),
                    document.getElementById('pickuplocation'),
                    document.getElementById('returnlocation')
                ];
                
                const returnDatePreInput = document.getElementById("returndatepre");
                const returnTimeInput = document.getElementById("returndate");

                if (returnDatePreInput && returnTimeInput) {
                    let datePart = returnDatePreInput.value.split(' ')[0];
                    let returnDatePre = new Date(datePart);
                    returnDatePre.setDate(returnDatePre.getDate() + 1);

                    let minDateObj = new Date(returnDatePre.getFullYear(), returnDatePre.getMonth(), returnDatePre.getDate());
                    let today = new Date();
                    today.setHours(0, 0, 0, 0);
                    if (today > minDateObj) {
                        minDateObj = today;
                    }

                    let year = minDateObj.getFullYear();
                    let month = (minDateObj.getMonth() + 1).toString().padStart(2, '0');
                    let day = minDateObj.getDate().toString().padStart(2, '0');

                    let minDateStr = year + "-" + month + "-" + day;

                    returnTimeInput.min = minDateStr;
                }   

                
                function checkFields() {
                    var nextButton = document.querySelector('.wizard .actions a[href="#next"]');
                    const allFieldsFilled = requiredFields.every(field => field.value.trim() !== '');
                    if (allFieldsFilled) {
                        nextButton.style.pointerEvents = 'auto';
                        nextButton.style.color = 'white';
                        nextButton.style.background = 'linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%)';
                    } else {
                        nextButton.style.pointerEvents = 'none';
                        nextButton.style.background = '#e8e8e8';
                        nextButton.style.color = '#999';

                         const currentStepIndex = 1;
                         const steps = document.querySelectorAll('.wizard ul[role="tablist"] li');

                         steps.forEach((step, index) => {
                             console.log(index);
                             if (index > currentStepIndex) {
                                 step.classList.remove('done');
                                 step.classList.add('disabled');
                             }
                         });
                    }
                }
                
                
                requiredFields.forEach(field => {
                    field.addEventListener('input', checkFields);
                });
                
               
                // Initial check in case some fields are pre-filled
                checkFields();
                
            });
            
            document.addEventListener('DOMContentLoaded', () => {
                
                storedFormData = {
                        pickupdate: document.getElementById('pickupdate').value,                             
                        returndate: document.getElementById('returndate').value                    
                    };
                const pickupDateText = storedFormData.pickupdate;
                const returnDateText = storedFormData.returndate;
                
                
                // Chuyển các chuỗi ngày thành đối tượng Date (tính từ ngày trả cũ)
                const originalReturnDateText = document.getElementById('returndatepre').value;
                const pickupDate = new Date(originalReturnDateText);
                const returnDate = new Date(returnDateText);
                
                console.log("Original Return (New Pickup): ", pickupDate);
                console.log("New Return: ", returnDateText);
                
                // Tính số ngày chênh lệch (số ngày gia hạn thêm)
                const differenceInTime = returnDate.getTime() - pickupDate.getTime();
                const differenceInDays = differenceInTime / (1000 * 3600 * 24);
                
                
                
            });
            
            function validateForm() {
                const requiredFields = [
                    document.getElementById('first_name'),
                    document.getElementById('last_name'),
                    document.getElementById('email'),
                    document.getElementById('phonenumber'),
                    document.getElementById('address'),
                    document.getElementById('dob'),
                    document.querySelector('input[name="gender"]:checked'),
                    document.getElementById('identityCard'),
                    document.getElementById('issuedon'),
                    document.getElementById('expdate')
                ];

                const allFieldsFilled = requiredFields.every(field => field && field.value.trim() !== '');

                var nextButton = document.querySelector('.wizard .actions a[href="#next"]');
                if (allFieldsFilled) {
                    nextButton.disabled = false;
                    nextButton.style.pointerEvents = 'auto';
                    nextButton.style.color = 'white';
                    nextButton.style.background = 'linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%)';
                } else {
                    nextButton.disabled = true;
                    nextButton.style.pointerEvents = 'none';
                    nextButton.style.background = '#e8e8e8';
                    nextButton.style.color = '#999';
                }
            }

            $("#motorcyclelist").on("change", ".form-check-select", function() {
               toggleBikeNextButton();
            });
            
           function toggleBikeNextButton() {
                var nextButton = document.querySelector('.wizard .actions a[href="#next"]');
                // Kiểm tra nếu có bất kỳ select box nào có giá trị lớn hơn 0
                var anySelected = $(".form-check-select", "#motorcyclelist").toArray().some(function(select) {
                    return parseInt($(select).val()) > 0;
                });

                // Nếu có ít nhất một select box đã chọn, kích hoạt nút "Next"
                if (anySelected) {
                    nextButton.style.pointerEvents = 'auto';
                    nextButton.style.color = 'white';
                    nextButton.style.background = 'linear-gradient(243.4deg, rgb(2, 184, 175) 13%, rgb(4, 111, 212) 98%)';
                    const checkboxContainer = document.getElementById('protection');
                    // Lấy tất cả các checkbox trong div
                    const checkboxes = checkboxContainer.querySelectorAll('.form-check-select');
                    // Lặp qua từng checkbox và lấy thông tin
                    checkboxes.forEach(selectBox => {
                        const quantity = parseInt(selectBox.value);                     
                        const formAccessBox = selectBox.closest('.form-box');
                        if (formAccessBox) {
                            numberAccessStatesI[selectBox.id] = quantity;
                        }
                    });
                    
                } else {
                    nextButton.style.pointerEvents = 'none';
                    nextButton.style.background = '#e8e8e8';
                    nextButton.style.color = '#999';

                     const currentStepIndex = 1;
                     const steps = document.querySelectorAll('.wizard ul[role="tablist"] li');

                     steps.forEach((step, index) => {
                       
                         if (index > currentStepIndex) {
                             step.classList.remove('done');
                             step.classList.add('disabled');
                         }
                     });
                }
            }
                            
            
           

        window.addEventListener('message', (event) => {
            if (event.data === 'activateOverlay') {
                const overlay = document.getElementById('overlay');
                overlay.classList.add('active');
            }
            if(event.data === 'stopOverlay') {
                const overlay = document.getElementById('overlay');
                overlay.classList.remove('active');
            }
            if (event.data && event.data.status === 'success') {
                handlePaymentStatus(event.data);
            }
        });
           // Kiểm tra nếu có dữ liệu nào được gửi từ servlet
        function handlePaymentStatus(data) {
            if (data.status === 'success') {
                ExtendBookingHandler(data);
            }
        }
        
        window.addEventListener('storage', function(event) {
            console.log(event.key);
            if (event.key === 'payment_status') {
                var paymentStatus = JSON.parse(event.newValue);
                handlePaymentStatus(paymentStatus);
            }
        });

       
        function ExtendBookingHandler(dataReturn) {
            var formData = new FormData();
            
//            alert("Thanh toán thành công với mã giao dịch: " + data.txnRef);
             // Lấy các giá trị từ các thẻ <p>
      
            var returnDate = document.getElementById("returndatetext").textContent.trim();
            var returnTime = document.getElementById("returntimetext").textContent.trim();
            var returnTimePre = document.getElementById("returndatepre").value;
            var bookingid = document.getElementById("bookingid").value;
                       
            var data = {     
                bookingid: bookingid,
                returnDate: returnDate + " " + returnTime,
                returnTimePre: returnTimePre,
                amount: dataReturn.amount,
                paymenttime: dataReturn.time            
            };
            
             // Convert object to JSON and append to formData
            formData.append("jsonData", JSON.stringify(data));

            // Gửi dữ liệu tới servlet bằng AJAX
            $.ajax({
                type: "POST",
                url: "extendhandler", // Thay đổi URL tới servlet của bạn
//                data: JSON.stringify(data),              
//                contentType: "application/json",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    console.log("Data sent successfully:", response);
                    if (window.parent) {
                        window.parent.location.reload();
                    } else {
                        window.location.href = 'bookingHistory?status=all';
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error sending data:", error);
                    alert("Có lỗi xảy ra khi gia hạn!");
                }
            });

        
        }

        // Nếu dữ liệu đã có sẵn trong LocalStorage khi trang được tải lại
        var existingStatus = localStorage.getItem('payment_status');
        if (existingStatus) {
            handlePaymentStatus(JSON.parse(existingStatus));
            localStorage.removeItem('payment_status');
        }
        
        
       

        </script>
        <iframe id="myI" src="sepay_return.jsp" style="width: 100%; height: 1000px; display:none;"></iframe>
<!--        <link href="https://pay.SePay VietQR.vn/lib/SePay VietQR/SePay VietQR.css" rel="stylesheet" />
        <script src="https://pay.SePay VietQR.vn/lib/SePay VietQR/SePay VietQR.min.js"></script>-->
         
    </body>

</html>


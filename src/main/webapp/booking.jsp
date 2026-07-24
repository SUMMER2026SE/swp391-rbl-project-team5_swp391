<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
      
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="author" content="colorlib.com">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Thuê xe</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">

        <!-- Font Icon -->
        <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="vendor/nouislider/nouislider.min.css">
        
        <!-- Select2 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
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
                background: #222;
                position: relative;
                padding: 0px;
            }

            .main {
                padding: 50px 0;
                position: relative;
                z-index: 99;
            }

            .container-booking {
                width: 1400px;
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
                border: 1px solid #ebebeb;
                height: 37px;
                box-sizing: border-box;
                padding: 0 20px;
                color: #222;
                font-weight: bold;
                font-size: 14px;
                font-family: 'Roboto Slab';
            }

            #steps-uid-0-p-0 .form-row,
            #steps-uid-0-p-0 .form-group,
            #steps-uid-0-p-0 .form-date {
                width: 1000px;
            }

            .form-flex {
                margin: 0 -10px;
            }

            .form-flex .form-group {
                width: 50%;
                padding: 0 10px;
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
                width: 310px;
            }

            .vertical .content,
            .vertical .actions {
                float: right;
                width: 1090px;
            }

            .content {
                height: 800px;
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
                position: absolute;
                top: 0px;
                right: 0;
            }

            label.error:after {
                font-family: 'Material-Design-Iconic-Font';
                position: absolute;
                content: '\f135';
                right: 20px;
                top: 50px;
                font-size: 13px;
                color: #f63726;
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
            body {
                font-family: 'Plus Jakarta Sans', sans-serif !important;
                background-color: #1a1816 !important;
                color: #2b2824 !important;
                font-weight: 500 !important;
            }
            .main {
                padding: 60px 0 !important;
                background: radial-gradient(circle at top, #2b2824 0%, #121110 100%) !important;
                min-height: 100vh !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
            }
            .container-booking {
                width: 1400px !important;
                max-width: 95% !important;
                background: #ffffff !important;
                border-radius: 20px !important;
                box-shadow: 0 25px 60px rgba(0, 0, 0, 0.45) !important;
                overflow: hidden !important;
                position: relative !important;
                border: 1px solid rgba(181, 147, 73, 0.15) !important;
            }
            
            /* Sleek Close/Exit Button */
            .btn-exit-booking {
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
                .btn-exit-booking {
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
<!--        <div id="navbar-container"></div>-->

        <div class="overlay" id="overlay">
            <span>Đang xử lý...</span>
        </div>
        <div class="main">
          
            <div class="container-booking">
                <!-- Sleek Exit Booking Button -->
                <a href="javascript:void(0)" onclick="let ref = document.referrer; if(ref.includes('login') || ref.includes('register')) { window.location.href='home'; } else if(ref.includes(window.location.host)) { window.location.href=ref; } else { window.location.href='home'; }" class="btn-exit-booking" title="Hủy đặt xe và quay lại">
                    <i class="bi bi-x-lg"></i> Hủy đặt xe
                </a>
              
                <form method="POST" id="signup-form" class="signup-form" action="" onkeydown="return event.key !== 'Enter' || event.target.tagName === 'TEXTAREA';"
                    onsubmit="return false;">
                    
                    <div >
                        <button type="submit" id="paymentButton" style="display: none"></button>
                        <h3>Ngày giờ</h3>
                        <fieldset>
                            <h2>NGÀY & GIỜ</h2>
                            <p class="desc">Hãy lựa chọn ngày giờ và địa điểm bạn muốn giao / trả xe</p>
                            
                            <!-- CAM KẾT GIAO XE -->
                            <div style="background:#f0faf0; border:1px solid #b2dfb2; border-radius:12px; padding:16px 20px; margin-bottom: 24px; display: flex; gap: 15px; align-items: flex-start;">
                                <div style="width: 40px; height: 40px; border-radius: 50%; background: #e8f5e9; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                                    <i class="fas fa-shipping-fast text-green-600 text-lg"></i>
                                </div>
                                <div>
                                    <h4 style="margin:0 0 4px; color:#2e7d32; font-size:14px; font-weight: 700;">Cam kết giao xe đúng hạn!</h4>
                                    <p style="margin:0; font-size:13px; color:#388e3c; line-height: 1.5;">SmartRide cam kết giao xe tận nơi chậm nhất trong <strong>45 phút</strong> kể từ lúc <strong>nhân viên duyệt đơn</strong> (hoặc theo đúng giờ đã hẹn). Nếu giao trễ quá thời gian này, hệ thống sẽ tự động tặng <strong>Mã giảm giá 50.000đ</strong> trực tiếp vào đơn hàng của bạn! <em>*Lưu ý: Vui lòng đặt xe cách thời điểm hiện tại ít nhất 15 phút để chúng tôi kịp chuẩn bị.</em></p>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-flex">
                                    <div class="form-group">
                                        <label for="pickupdate" class="form-label">Ngày nhận xe <span class="note-star"> *</span></label>
                                        <input type="date" name="pickupdate" id="pickupdate" />
                                    </div>
                                    <div class="form-group">
                                        <label for="pickuptime" class="form-label">Giờ nhận xe <span class="note-star"> *</span></label>
                                        <input type="time" name="pickuptime" id="pickuptime"  />
                                        <small style="color: #888; font-size: 12px; margin-top: 5px; display: block;">* Giờ hoạt động: 07:00 - 23:00 (SA=Sáng, CH=Chiều. Ấn <b>A/P</b> hoặc mũi tên lên/xuống để đổi)</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="returndate" class="form-label">Ngày trả xe <span class="note-star"> *</span></label>
                                        <input type="date" name="returndate" id="returndate"  />
                                        <div style="margin-top: 10px; display: flex; flex-wrap: wrap; align-items: center; gap: 8px;">
                                            <button type="button" id="btn-quick-week" style="background: #fff; color: #b59349; border: 1.5px solid #b59349; padding: 5px 14px; font-size: 12px; font-weight: 600; border-radius: 20px; cursor: pointer; transition: all 0.2s;" onclick="setQuickReturnDate(7)">
                                                Thuê 1 Tuần &mdash; Giá ưu đãi hơn so với ngày lẻ
                                            </button>
                                            <button type="button" id="btn-quick-month" style="background: #fff; color: #b59349; border: 1.5px solid #b59349; padding: 5px 14px; font-size: 12px; font-weight: 600; border-radius: 20px; cursor: pointer; transition: all 0.2s;" onclick="setQuickReturnDate(30)">
                                                Thuê 1 Tháng &mdash; Giá ưu đãi tốt nhất
                                            </button>
                                        </div>
                                        <small style="display: block; margin-top: 6px; color: #888; font-size: 11px; font-style: italic;">
                                            💡 Nhấn vào gói để tự động điền ngày trả xe &amp; áp dụng giá ưu đãi ở bước Chọn Xe
                                        </small>
                                    </div>
                                    <div class="form-group">
                                        <label for="returntime" class="form-label">Giờ trả xe <span class="note-star"> *</span></label>
                                        <input type="time" name="returntime" id="returntime" />
                                        <small style="color: #888; font-size: 12px; margin-top: 5px; display: block;">* Giờ hoạt động: 07:00 - 23:00 (SA=Sáng, CH=Chiều. Ấn <b>A/P</b> hoặc mũi tên lên/xuống để đổi)</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div style="background-color: #fef3c7; border-left: 4px solid #f59e0b; padding: 12px 16px; margin: 15px 0; border-radius: 4px;">
                                <p style="margin: 0; font-size: 13.5px; color: #92400e; font-weight: 500; display: flex; align-items: flex-start; gap: 8px;">
                                    <span style="font-size: 16px;">💡</span>
                                    <span><b>Lưu ý giao xe:</b> Miễn phí giao/nhận tận nơi trong bán kính <b>3km</b>. Từ km thứ 4, phụ phí cực rẻ chỉ <b>5.000đ/km</b> (sẽ tự động tính ở bước thanh toán). <br>⛔ Nếu địa chỉ <b>trên 20km</b>, quý khách vui lòng chọn nhận xe tại Cửa hàng hoặc nhập một địa chỉ khác gần hơn.</span>
                                </p>
                            </div>

                            <div class="form-row location">
                                <div class="form-flex">
                                    <div class="form-group">
                                        <label for="pickuplocation" class="form-label">Địa điểm nhận xe <span class="note-star"> *</span></label>
                                        <select name="pickuplocation" id="pickuplocation" class="form-label select2-location" onchange="toggleCustomLocation('pickup')" style="width: 100%;">
                                            <option value="Tại cửa hàng SmartRide - 254 Nguyễn Văn Linh, Thạc Gián, Thanh Khê, Đà Nẵng" data-icon="fa-store" data-highlight="true">Tại cửa hàng SmartRide</option>
                                            <option value="Ga Đà Nẵng - Số 202 đường Hải Phòng" data-icon="fa-map-marker-alt">Ga Đà Nẵng</option>
                                            <option value="Sân bay Quốc tế Đà Nẵng - 132 Phan Đình Phùng" data-icon="fa-map-marker-alt">Sân bay Đà Nẵng</option>
                                            <option value="Bến xe Trung tâm - 33 Tôn Đức Thắng" data-icon="fa-map-marker-alt">Bến xe Trung tâm</option>
                                            <option value="Chợ Hàn - 119 Trần Phú" data-icon="fa-map-marker-alt">Chợ Hàn</option>
                                            <option value="Vincom Plaza - 910A Ngô Quyền" data-icon="fa-map-marker-alt">Vincom Plaza</option>
                                            <option value="Cầu Rồng - Trần Hưng Đạo" data-icon="fa-map-marker-alt">Cầu Rồng</option>
                                            <option value="Ngũ Hành Sơn - Huyền Trân Công Chúa" data-icon="fa-map-marker-alt">Ngũ Hành Sơn</option>
                                            <option value="Lotte Mart - 6 Nại Nam" data-icon="fa-map-marker-alt">Lotte Mart</option>
                                            <option value="Phố đi bộ Bạch Đằng - Bạch Đằng" data-icon="fa-map-marker-alt">Phố đi bộ Bạch Đằng</option>
                                            <option value="Bệnh viện Đà Nẵng - 124 Hải Phòng" data-icon="fa-map-marker-alt">Bệnh viện Đà Nẵng</option>
                                            <option value="Your own address" data-icon="fa-map-location-dot" data-highlight="true">Địa chỉ của bạn (tự nhập)</option>
                                        </select>
                                        <div id="pickup_custom_wrapper" style="display:none; margin-top:8px;">
                                            <div style="display: flex; gap: 10px;">
                                                <input type="text" id="custom_pickup_input" placeholder="Nhập địa chỉ nhận xe của bạn..." style="border:1px solid #ebebeb; padding:10px 15px; border-radius:5px; flex: 1; box-sizing:border-box; font-family:'Montserrat',sans-serif; font-size:14px;" onblur="calcDistance('pickup')" oninput="updateCustomLocation('pickup')" />
                                                <button type="button" onclick="autoGeolocate('pickup')" style="background-color: #4f46e5; color: white; border: none; padding: 0 15px; border-radius: 5px; cursor: pointer; font-weight: bold; white-space: nowrap;"><i class="fas fa-location-crosshairs"></i> Tự động lấy vị trí</button>
                                            </div>
                                            <div id="pickup_distance_info" style="font-size: 12px; color: #64748b; margin-top: 5px;"></div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="returnlocation" class="form-label">Địa điểm trả xe <span class="note-star"> *</span></label>
                                        <select name="returnlocation" id="returnlocation" class="form-label select2-location" onchange="toggleCustomLocation('return')" style="width: 100%;">
                                            <option value="Tại cửa hàng SmartRide - 254 Nguyễn Văn Linh, Thạc Gián, Thanh Khê, Đà Nẵng" data-icon="fa-store" data-highlight="true">Tại cửa hàng SmartRide</option>
                                            <option value="Ga Đà Nẵng - Số 202 đường Hải Phòng" data-icon="fa-map-marker-alt">Ga Đà Nẵng</option>
                                            <option value="Sân bay Quốc tế Đà Nẵng - 132 Phan Đình Phùng" data-icon="fa-map-marker-alt">Sân bay Đà Nẵng</option>
                                            <option value="Bến xe Trung tâm - 33 Tôn Đức Thắng" data-icon="fa-map-marker-alt">Bến xe Trung tâm</option>
                                            <option value="Chợ Hàn - 119 Trần Phú" data-icon="fa-map-marker-alt">Chợ Hàn</option>
                                            <option value="Vincom Plaza - 910A Ngô Quyền" data-icon="fa-map-marker-alt">Vincom Plaza</option>
                                            <option value="Cầu Rồng - Trần Hưng Đạo" data-icon="fa-map-marker-alt">Cầu Rồng</option>
                                            <option value="Ngũ Hành Sơn - Huyền Trân Công Chúa" data-icon="fa-map-marker-alt">Ngũ Hành Sơn</option>
                                            <option value="Lotte Mart - 6 Nại Nam" data-icon="fa-map-marker-alt">Lotte Mart</option>
                                            <option value="Phố đi bộ Bạch Đằng - Bạch Đằng" data-icon="fa-map-marker-alt">Phố đi bộ Bạch Đằng</option>
                                            <option value="Bệnh viện Đà Nẵng - 124 Hải Phòng" data-icon="fa-map-marker-alt">Bệnh viện Đà Nẵng</option>
                                            <option value="Your own address" data-icon="fa-map-location-dot" data-highlight="true">Địa chỉ của bạn (tự nhập)</option>
                                        </select>
                                        <div id="return_custom_wrapper" style="display:none; margin-top:8px;">
                                            <div style="display: flex; gap: 10px;">
                                                <input type="text" id="custom_return_input" placeholder="Nhập địa chỉ trả xe của bạn..." style="border:1px solid #ebebeb; padding:10px 15px; border-radius:5px; flex: 1; box-sizing:border-box; font-family:'Montserrat',sans-serif; font-size:14px;" onblur="calcDistance('return')" oninput="updateCustomLocation('return')" />
                                                <button type="button" onclick="autoGeolocate('return')" style="background-color: #4f46e5; color: white; border: none; padding: 0 15px; border-radius: 5px; cursor: pointer; font-weight: bold; white-space: nowrap;"><i class="fas fa-location-crosshairs"></i> Tự động lấy vị trí</button>
                                            </div>
                                            <div id="return_distance_info" style="font-size: 12px; color: #64748b; margin-top: 5px;"></div>
                                        </div>
                                    </div>
                                    <script>
                                        function toggleCustomLocation(type) {
                                            var select = document.getElementById(type + 'location');
                                            var wrapper = document.getElementById(type + '_custom_wrapper');
                                            var input = document.getElementById('custom_' + type + '_input');
                                            var selectedOption = select.options[select.selectedIndex];
                                            if (selectedOption.text.includes('(tự nhập)')) {
                                                wrapper.style.display = 'block';
                                                input.required = true;
                                            } else {
                                                wrapper.style.display = 'none';
                                                input.required = false;
                                            }
                                        }
                                        function updateCustomLocation(type) {
                                            var select = document.getElementById(type + 'location');
                                            var input = document.getElementById('custom_' + type + '_input');
                                            var selectedOption = select.options[select.selectedIndex];
                                            if (selectedOption.text.includes('(tự nhập)')) {
                                                selectedOption.value = input.value ? input.value : 'Your own address';
                                            }
                                        }
                                    </script>
                                </div>
                            </div>
                        </fieldset>

                        <h3>Xe máy</h3>
                        <fieldset>
                            <h2>CHỌN XE MÁY</h2>
                            <p class="desc">Hãy chọn những chiếc xe tuyệt vời nhất cho hành trình của bạn</p>
                            
                            <div class="fieldset-content">
                                <!-- Banner xe đã chọn realtime -->
                                <div id="bike-selection-banner" style="display:none; background: linear-gradient(135deg,#fdf8ee,#fff8e1); border:1.5px solid #e0c87a; border-radius:10px; padding:10px 16px; margin-bottom:14px; font-size:13px; color:#7a5c00; font-weight:600;">
                                    <i class="bi bi-check-circle-fill" style="color:#b59349;"></i>
                                    Đã chọn: <span id="bike-selection-list"></span>
                                </div>
                                <div class="scrollable-vertical" id="motorcyclelist">
                                    <c:forEach items="${listM}" var="o">
                                        <c:if test="${o.motorcycleId eq chosenmotor}">
                                            <div class="form-box">
                                                <div class="form-img-bike">
                                                    <label style="width: 100%" for="body-bg"><img src="${empty o.image ? 'images/default.jpg' : (o.image.startsWith('http') ? o.image : 'images/'.concat(o.image))}" alt=""></label>
                                                </div>
                                                <div class="form-text">
                                                    <h4 class="motor-name">${o.model} ${o.displacement}</h4>
                                                    <div class="form-doc" style="box-sizing: border-box;">
                                                        ${o.description}
                                                    </div>
                                                </div>
                                                <div class="form-check"> 
                                                    <c:forEach items="${listP}" var="p">
                                                        <c:if test="${p.priceListId eq o.priceListID}">
                                                            <c:choose>
                                                                <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                                    <div style="display: flex; gap: 8px; align-items: baseline;">
                                                                        <fmt:formatNumber var="origDay" value="${p.dailyPriceForDay}" maxFractionDigits="0" groupingUsed="true"/>
                                                                        <span style="text-decoration: line-through; color: #999; font-size: 16px;">₫${origDay}</span>
                                                                        <span style="color: #dc2626; font-size: 14px; font-weight: bold; padding: 2px 6px; background: #fee2e2; border-radius: 4px;">Giảm <fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%</span>
                                                                    </div>
                                                                    <fmt:formatNumber var="discountedDay" value="${p.dailyPriceForDay * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="true" />
                                                                    <fmt:formatNumber var="discountedWeek" value="${p.dailyPriceForWeek * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="true" />
                                                                    <fmt:formatNumber var="discountedMonth" value="${p.dailyPriceForMonth * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="true" />
                                                                    <fmt:formatNumber var="discountedDayRaw" value="${p.dailyPriceForDay * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="false" />
                                                                    <fmt:formatNumber var="discountedWeekRaw" value="${p.dailyPriceForWeek * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="false" />
                                                                    <fmt:formatNumber var="discountedMonthRaw" value="${p.dailyPriceForMonth * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="false" />
                                                                    <h2 class="main-price price-day" data-rawprice="${discountedDayRaw}">₫${discountedDay}/Ngày</h2>
                                                                    <h2 class="main-price price-week" data-rawprice="${discountedWeekRaw}">₫${discountedWeek}/Ngày</h2>
                                                                    <h2 class="main-price price-month" data-rawprice="${discountedMonthRaw}">₫${discountedMonth}/Ngày</h2>
                                                                    <div style="margin-top: 8px; display: flex; flex-direction: column; gap: 4px; align-items: flex-start;">
                                                                        <span style="font-size: 11px; color: #15803d; background: #dcfce7; padding: 2px 6px; border-radius: 4px; font-weight: 600;">Gói Tuần (&ge;7 ngày): ₫${discountedWeek}/ngày</span>
                                                                        <span style="font-size: 11px; color: #6d28d9; background: #ede9fe; padding: 2px 6px; border-radius: 4px; font-weight: 600;">Gói Tháng (&ge;30 ngày): ₫${discountedMonth}/ngày</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:formatNumber var="fmtDay" value="${p.dailyPriceForDay}" maxFractionDigits="0" groupingUsed="true"/>
                                                                    <fmt:formatNumber var="fmtWeek" value="${p.dailyPriceForWeek}" maxFractionDigits="0" groupingUsed="true"/>
                                                                    <fmt:formatNumber var="fmtMonth" value="${p.dailyPriceForMonth}" maxFractionDigits="0" groupingUsed="true"/>
                                                                    <fmt:formatNumber var="rawDay" value="${p.dailyPriceForDay}" maxFractionDigits="0" groupingUsed="false"/>
                                                                    <fmt:formatNumber var="rawWeek" value="${p.dailyPriceForWeek}" maxFractionDigits="0" groupingUsed="false"/>
                                                                    <fmt:formatNumber var="rawMonth" value="${p.dailyPriceForMonth}" maxFractionDigits="0" groupingUsed="false"/>
                                                                    <h2 class="main-price price-day" data-rawprice="${rawDay}">₫${fmtDay}/Ngày</h2>
                                                                    <h2 class="main-price price-week" data-rawprice="${rawWeek}">₫${fmtWeek}/Ngày</h2>
                                                                    <h2 class="main-price price-month" data-rawprice="${rawMonth}">₫${fmtMonth}/Ngày</h2>
                                                                    <div style="margin-top: 8px; display: flex; flex-direction: column; gap: 4px; align-items: flex-start;">
                                                                        <span style="font-size: 11px; color: #15803d; background: #dcfce7; padding: 2px 6px; border-radius: 4px; font-weight: 600;">Gói Tuần (&ge;7 ngày): ₫${fmtWeek}/ngày</span>
                                                                        <span style="font-size: 11px; color: #6d28d9; background: #ede9fe; padding: 2px 6px; border-radius: 4px; font-weight: 600;">Gói Tháng (&ge;30 ngày): ₫${fmtMonth}/ngày</span>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:if>
                                                    </c:forEach>                                             
                                                    <p class="price-note">Không bao gồm thuế và bảo hiểm</p>                                                    
                                                        <input style="display: none" type="checkbox"  id="daily-checkbox-${o.motorcycleId}" class="option-checkbox">
                                                        <div class="rent-button">                                                     
                                                            <c:set var="found" value="false" />
                                                            <c:forEach var="entry" items="${listMA}">
                                                                <c:if test="${entry.key eq o.motorcycleId}">
                                                                    <c:set var="found" value="true" />
                                                                    <a>Chọn số lượng xe: </a>
                                                                    <select class="form-check-select" id="daily-select-${o.motorcycleId}">
                                                                        <c:forEach begin="0" end="${entry.value}" var="i">
                                                                            <option value="${i}" ${i == "1" ? 'selected' : ''}>${i}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${found eq false}">
                                                                <a>Hết xe</a>
                                                            </c:if>
                                                        </div>
                                                </div>                                                         
                                            </div>
                                           
                                        </c:if>
                                    </c:forEach>
                                    <c:forEach items="${listM}" var="o">
                                        <c:if test="${o.motorcycleId ne chosenmotor}">
                                            <div class="form-box">
                                                <div class="form-img-bike">
                                                    <label style="width: 100%" for="body-bg"><img src="${empty o.image ? 'images/default.jpg' : (o.image.startsWith('http') ? o.image : 'images/'.concat(o.image))}" alt=""></label>
                                                </div>
                                                <div class="form-text">
                                                    <h4 class="motor-name">${o.model} ${o.displacement}</h4>
                                                    <div class="form-doc" style="box-sizing: border-box;">
                                                        ${o.description}
                                                    </div>
                                                </div>
                                                <div class="form-check"> 
                                                    <c:forEach items="${listP}" var="p">
                                                        <c:if test="${p.priceListId eq o.priceListID}">
                                                            <c:choose>
                                                                <c:when test="${not empty activeEvent and activeEvent.discount > 0}">
                                                                    <div style="display: flex; gap: 8px; align-items: baseline;">
                                                                        <fmt:formatNumber var="origDay2" value="${p.dailyPriceForDay}" maxFractionDigits="0" groupingUsed="true"/>
                                                                        <span style="text-decoration: line-through; color: #999; font-size: 16px;">₫${origDay2}</span>
                                                                        <span style="color: #dc2626; font-size: 14px; font-weight: bold; padding: 2px 6px; background: #fee2e2; border-radius: 4px;">Giảm <fmt:formatNumber value="${activeEvent.discount * 100}" maxFractionDigits="0"/>%</span>
                                                                    </div>
                                                                    <fmt:formatNumber var="discountedDay" value="${p.dailyPriceForDay * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="true" />
                                                                    <fmt:formatNumber var="discountedWeek" value="${p.dailyPriceForWeek * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="true" />
                                                                    <fmt:formatNumber var="discountedMonth" value="${p.dailyPriceForMonth * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="true" />
                                                                    <fmt:formatNumber var="discountedDayRaw2" value="${p.dailyPriceForDay * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="false" />
                                                                    <fmt:formatNumber var="discountedWeekRaw2" value="${p.dailyPriceForWeek * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="false" />
                                                                    <fmt:formatNumber var="discountedMonthRaw2" value="${p.dailyPriceForMonth * (1 - activeEvent.discount)}" maxFractionDigits="0" groupingUsed="false" />
                                                                    <h2 class="main-price price-day" data-rawprice="${discountedDayRaw2}">₫${discountedDay}/Ngày</h2>
                                                                    <h2 class="main-price price-week" data-rawprice="${discountedWeekRaw2}">₫${discountedWeek}/Ngày</h2>
                                                                    <h2 class="main-price price-month" data-rawprice="${discountedMonthRaw2}">₫${discountedMonth}/Ngày</h2>
                                                                    <div style="margin-top: 8px; display: flex; flex-direction: column; gap: 4px; align-items: flex-start;">
                                                                        <span style="font-size: 11px; color: #15803d; background: #dcfce7; padding: 2px 6px; border-radius: 4px; font-weight: 600;">Gói Tuần (&ge;7 ngày): ₫${discountedWeek}/ngày</span>
                                                                        <span style="font-size: 11px; color: #6d28d9; background: #ede9fe; padding: 2px 6px; border-radius: 4px; font-weight: 600;">Gói Tháng (&ge;30 ngày): ₫${discountedMonth}/ngày</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:formatNumber var="fmtDay2" value="${p.dailyPriceForDay}" maxFractionDigits="0" groupingUsed="true"/>
                                                                    <fmt:formatNumber var="fmtWeek2" value="${p.dailyPriceForWeek}" maxFractionDigits="0" groupingUsed="true"/>
                                                                    <fmt:formatNumber var="fmtMonth2" value="${p.dailyPriceForMonth}" maxFractionDigits="0" groupingUsed="true"/>
                                                                    <fmt:formatNumber var="rawDay2" value="${p.dailyPriceForDay}" maxFractionDigits="0" groupingUsed="false"/>
                                                                    <fmt:formatNumber var="rawWeek2" value="${p.dailyPriceForWeek}" maxFractionDigits="0" groupingUsed="false"/>
                                                                    <fmt:formatNumber var="rawMonth2" value="${p.dailyPriceForMonth}" maxFractionDigits="0" groupingUsed="false"/>
                                                                    <h2 class="main-price price-day" data-rawprice="${rawDay2}">₫${fmtDay2}/Ngày</h2>
                                                                    <h2 class="main-price price-week" data-rawprice="${rawWeek2}">₫${fmtWeek2}/Ngày</h2>
                                                                    <h2 class="main-price price-month" data-rawprice="${rawMonth2}">₫${fmtMonth2}/Ngày</h2>
                                                                    <div style="margin-top: 8px; display: flex; flex-direction: column; gap: 4px; align-items: flex-start;">
                                                                        <span style="font-size: 11px; color: #15803d; background: #dcfce7; padding: 2px 6px; border-radius: 4px; font-weight: 600;">Gói Tuần (&ge;7 ngày): ₫${fmtWeek2}/ngày</span>
                                                                        <span style="font-size: 11px; color: #6d28d9; background: #ede9fe; padding: 2px 6px; border-radius: 4px; font-weight: 600;">Gói Tháng (&ge;30 ngày): ₫${fmtMonth2}/ngày</span>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:if>
                                                    </c:forEach>                                             
                                                    <p class="price-note">Không bao gồm thuế và bảo hiểm</p>                                                                                             
                                                        <input style="display: none" type="checkbox"  id="daily-checkbox-${o.motorcycleId}" class="option-checkbox">
                                                        <div class="rent-button">                                                     
                                                            <c:set var="found" value="false" />
                                                            <c:forEach var="entry" items="${listMA}">
                                                                <c:if test="${entry.key eq o.motorcycleId}">
                                                                    <c:set var="found" value="true" />
                                                                    <a>Chọn số lượng xe: </a>
                                                                    <select class="form-check-select" id="daily-select-${o.motorcycleId}">
                                                                        <c:forEach begin="0" end="${entry.value}" var="i">
                                                                            <option value="${i}">${i}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${found eq false}">
                                                                <a>Hết xe</a>
                                                            </c:if>
                                                        </div>
                                                </div>                                                         
                                            </div>
                                        </c:if>
                                    </c:forEach>                                  
                                </div>
                            </div>
                        </fieldset>

                        <h3>Phụ kiện đi kèm</h3>
                        <fieldset>
                            <h2>PHỤ KIỆN ĐI KÈM</h2>
                            <p class="desc">Hãy chọn những phụ kiện có thể giúp ích cho hành trình của bạn</p>
                            <div class="fieldset-content">
                                <!-- Banner phụ kiện đã chọn realtime -->
                                <div id="acc-selection-banner" style="display:none; background: linear-gradient(135deg,#f0fdf4,#e8fce8); border:1.5px solid #86efac; border-radius:10px; padding:10px 16px; margin-bottom:14px; font-size:13px; color:#166534; font-weight:600;">
                                    <i class="bi bi-bag-check-fill" style="color:#16a34a;"></i>
                                    Phụ kiện đã chọn: <span id="acc-selection-list"></span>
                                </div>
                                <div class="scrollable-vertical" id="protection">
<!--                                <h4>SERVICES</h4>
                                <div class="form-box">
                                    <div class="form-img">
                                        <label for="body-bg"><img src="images/body-bg.jpg" alt=""></label>
                                    </div>
                                    <div class="form-text">
                                        <h4>Xe đi đường dài</h4>
                                        <div class="form-doc" style="box-sizing: border-box;">
                                            <p>Khoản ph&iacute; n&agrave;y sẽ&nbsp;&aacute;p dụng&nbsp;cho c&aacute;c kh&aacute;ch h&agrave;ng
                                                sử dụng xe một trong trường hợp sau:</p>
                                            <ul>
                                                <li>Kh&aacute;ch thu&ecirc; xe đi&nbsp;đường d&agrave;i, ra khỏi nội th&agrave;nh Da Nang</li>
                                                <li>Xe đi phượt&nbsp;c&aacute;c tỉnh hoặc đến c&aacute;c địa h&igrave;nh v&ugrave;ng n&uacute;i.
                                                </li>
                                            </ul>
                                            <p>Lưu &yacute;: Đối với c&aacute;c kh&aacute;ch&nbsp;đi đường d&agrave;i chưa lựa
                                                chọn&nbsp;g&oacute;i ph&aacute;t sinh n&agrave;y, khi trả xe COLORMOTOR sẽ thu bổ sung của
                                                kh&aacute;ch. Để biết th&ecirc;m chi tiết&nbsp;vui l&ograve;ng li&ecirc;n hệ <a
                                                    href="tel:0338023344">0338.02.33.44</a> để được giải đ&aacute;p.</p>
                                        </div>
                                    </div>
                                    <div class="form-check">
                                        <div class="checkbox-container">
                                            <input type="checkbox" id="daily-checkbox-1" class="option-checkbox">
                                            <label for="daily-checkbox">₫50.000/Day</label>
                                        </div>
                                    </div>
                                </div>
                                <h4>PROTECTIONS & COVERAGES</h4>
                                <div class="form-box">
                                    <div class="form-img">
                                        <label for="body-bg"><img src="images/baohiemhonghocxe.png" alt=""></label>
                                    </div>
                                    <div class="form-text">
                                        <h4>Bảo hiểm hỏng hóc 50k/ngày Yamaha Sirius & Honda Vision</h4>
                                        <div class="form-doc" style="box-sizing: border-box;">
                                            <p>Ph&iacute;&nbsp;50.000đ/ng&agrave;y &aacute;p dụng cho d&ograve;ng xe Honda Airblade 125cc
                                                v&agrave; Winner 150cc</p>
                                            <p>Khoản ph&iacute; n&agrave;y sẽ&nbsp;&aacute;p dụng&nbsp;cho c&aacute;c kh&aacute;ch h&agrave;ng
                                                sử dụng xe một trong trường hợp sau:</p>
                                            <ul>
                                                <li>G&oacute;i bảo hiểm &aacute;p dụng cho trường hợp kh&aacute;ch đi chuyển gặp bất kỳ vấn đề
                                                    g&igrave; hư hỏng&nbsp;li&ecirc;n quan đến xe m&aacute;y đang thu&ecirc;, sẽ được chi trả 100%
                                                    số tiền sửa chữa bao gồm cả vấn đề va chạm, tai nạn hư hại về xe.</li>
                                            </ul>
                                            <p>Lưu &yacute;: Đối với c&aacute;c kh&aacute;ch&nbsp;đi đường d&agrave;i n&ecirc;n&nbsp;lựa
                                                chọn&nbsp;g&oacute;i ph&aacute;t sinh n&agrave;y&nbsp;để an to&agrave;n v&agrave; y&ecirc;n
                                                t&acirc;m trong qu&aacute; tr&igrave;nh đi phượt,...</p>
                                        </div>
                                    </div>
                                    <div class="form-check">
                                        <div class="checkbox-container">
                                            <input type="checkbox" id="daily-checkbox-2" class="option-checkbox">
                                            <label for="daily-checkbox">₫50.000/Day</label>
                                        </div>
                                    </div>
                                </div>-->


<!--                                <h4>EQUIPMENTS</h4>-->
                                <c:forEach items="${listA}" var="a">
                                    <div class="form-box">
                                        <div class="form-img">
                                            <label for="body-bg"><img src="${empty a.accessoryImage ? 'images/default.jpg' : (a.accessoryImage.startsWith('http') ? a.accessoryImage : 'images/'.concat(a.accessoryImage))}" alt=""></label>
                                        </div>
                                        <div class="form-text">
                                            <h4>${a.accessoryName}</h4>
                                            <div class="form-doc" style="box-sizing: border-box;">
                                                ${a.accessoryDescription}
                                            </div>
                                        </div>
                                        <div class="form-check">
                                            <div class="checkbox-container">
<!--                                                <input type="checkbox" id="daily-checkbox-${a.accessoryId}" class="option-checkbox">-->
                                                <select class="form-check-select" id="daily-select-${a.accessoryId}"
                                                    data-rawprice="${a.price}">
                                                </select>
                                                <c:if test="${a.price eq 0}">
                                                    <label for="daily-checkbox" class="items-free">Free</label>
                                                </c:if>
                                                <c:if test="${a.price ne 0}">
                                                    <fmt:formatNumber var="fmtAcc" value="${a.price}" maxFractionDigits="0" groupingUsed="true"/>
                                                    <label for="daily-checkbox" data-rawprice="${a.price}">₫${fmtAcc}</label>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>                               
                                </div><!-- end scrollable-vertical protection -->
                            </div><!-- end fieldset-content -->
                        </fieldset>

                        <h3>Khách hàng</h3>
                        <fieldset>
                            <h2>THÔNG TIN CÁ NHÂN</h2>
                            <p class="desc">Hãy xác nhận hoặc cập nhật thông tin của bạn</p>
                            <div class="fieldset-content">
                                <c:if test="${not empty sessionScope.account}">
                                    <a id="accountId"  style="display: none">${account.accountId}</a>
                                   
                                    <div class="form-row">
                                        <div class="form-flex">
                                            <div class="form-group">
                                                <label class="form-label">Họ <span class="note-star"> *</span></label>
                                                <input type="text" name="first_name" id="first_name" value="${account.firstName}" oninput="validateForm()" />
                                              
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Tên <span class="note-star"> *</span></label>
                                                <input type="text" name="last_name" id="last_name" value="${account.lastName}" oninput="validateForm()" />
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <div style="width:100%; margin-bottom:15px; padding:12px; background:#fff1f2; border-left:4px solid #ef4444; border-radius:4px; color:#b91c1c; font-size:13px; font-weight:600; line-height:1.5;">
                                        ⚠️ Vui lòng nhập chính xác Email và Số điện thoại để hệ thống gửi thông báo và hỗ trợ hoàn tiền khi cần thiết.
                                    </div>
                                    <div class="form-row">
                                        <div class="form-flex">
                                            <div class="form-group">
                                                <label for="email" class="form-label">Email <span class="note-star"> *</span></label>
                                                <input type="email" name="email" id="email" value="${account.email}" oninput="validateForm()" />
                                            </div>
                                            <div class="form-group">
                                                <label for="phonenumber" class="form-label">Số điện thoại <span class="note-star"> *</span></label>
                                                <input type="text" name="phonenumber" id="phonenumber" value="${account.phoneNumber}" oninput="validateForm()"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group" style="width: 100%;">
                                            <label for="address" class="form-label">Địa chỉ <span class="note-star"> *</span></label>
                                            <input type="text" name="address" id="address" value="${account.address}" oninput="validateForm()" />
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-flex">
                                            <div class="form-group">
                                                 <label for="birth_date" class="form-label">Ngày sinh <span class="note-star"> *</span></label>
                                                 <input type="date" name="dob" id="dob" value="${account.dob}" oninput="validateForm()" />
                                            </div>
                                            <div class="form-group">
                                                <label for="gender" class="form-label">Giới tính <span class="note-star"> *</span></label>
                                                <div class="form-radio-group">   
                                                    <label><input type="radio" name="gender" value="Không muốn tiết lộ" ${account.gender == 'Không muốn tiết lộ' ? 'checked' : ''} onclick="validateForm()">Bí mật</label>
                                                    <label><input type="radio" name="gender" value="Nam" ${account.gender == 'Nam' ? 'checked' : ''} onclick="validateForm()">Nam</label>
                                                    <label><input type="radio" name="gender" value="Nữ" ${account.gender == 'Nữ' ? 'checked' : ''} onclick="validateForm()">Nữ</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="flag" value="false" />                   
                                    <c:forEach items="${listC}" var="c">
                                        <c:if test="${account.accountId eq c.accountId}">
                                            <p style="display: none" id="customerId">${c.customerId}</p>
                                            <c:set var="flag" value="true" />
                                            <div class="form-enter">
                                                <div class="form-row">
                                                    <div class="form-flex">
                                                        <div class="form-group" style="width: 40%;">
                                                            <label for="drivernumber" class="form-label">CCCD/CMND <span class="note-star"> *</span></label>
                                                            <input type="text" name="drivernumber" id="identityCard" value="${c.identityCard}" onblur="validateForm()"/>
                                                        </div>
                                                        <div style="width: 60%; display: flex; gap: 20px;">
                                                            <div class="form-group" style="width: 50%">
                                                                <label for="issuedon" class="form-label">Ngày cấp <span class="note-star"> *</span></label>
                                                                <input type="date" name="issuedon" id="issuedon" value="${c.issuedOnDate}" oninput="validateForm()"/>
                                                            </div>
                                                            <div class="form-group" style="width: 50%">
                                                                <label for="expdate" class="form-label">Ngày hết hạn <span class="note-star"> *</span></label>
                                                                <input type="date" name="expdate" id="expdate" value="${c.expDate}" oninput="validateForm()"/>
                                                            </div>
                                                        </div>
                                                    </div> <!-- End form-flex for text inputs -->
                                                    
                                                    <div class="form-row" style="margin-top: 25px;">
                                                        <label class="form-label" style="display: block; margin-bottom: 15px; font-weight: 600;">Hình ảnh CCCD/CMND</label>
                                                        <div class="form-flex" style="align-items: flex-start;">
                                                            <c:set var="imagesArr" value="${fn:split(c.identityCardImage, ',')}" />
                                                            
                                                            <div class="upload-card-wrapper" style="flex: 1; min-width: 0;">
                                                                <label for="imageFrontAuth" class="upload-card">
                                                                    <i class="bi bi-person-vcard"></i>
                                                                    <span class="upload-title">Cập nhật mặt trước</span>
                                                                    <span class="upload-subtitle">Nhấn để chọn ảnh mới</span>
                                                                </label>
                                                                <input type="file" name="imageFront" id="imageFrontAuth" style="display: none;" />
                                                                
                                                                <!-- Preview Container (managed by JS) -->
                                                                <div class="image-preview-container" style="display: none;">
                                                                    <span class="existing-image-label">Ảnh mặt trước đã chọn:</span>
                                                                    <img class="img-preview" src="" />
                                                                </div>

                                                                <!-- Existing Image (shows when no new file is chosen) -->
                                                                <c:if test="${not empty imagesArr[0]}">
                                                                    <c:set var="frontUrl" value="${imagesArr[0]}" />
                                                                    <c:if test="${not fn:startsWith(frontUrl, 'http')}"><c:set var="frontUrl" value="upload/${frontUrl}" /></c:if>
                                                                    <div class="image-preview-container existing-image">
                                                                        <span class="existing-image-label">Mặt trước hiện tại:</span>
                                                                        <img src="${frontUrl}" class="img-preview" onerror="this.parentElement.style.display='none';"/>
                                                                    </div>
                                                                </c:if>
                                                            </div>

                                                            <div class="upload-card-wrapper" style="flex: 1; min-width: 0;">
                                                                <label for="imageBackAuth" class="upload-card">
                                                                    <i class="bi bi-credit-card-2-back"></i>
                                                                    <span class="upload-title">Cập nhật mặt sau</span>
                                                                    <span class="upload-subtitle">Nhấn để chọn ảnh mới</span>
                                                                </label>
                                                                <input type="file" name="imageBack" id="imageBackAuth" style="display: none;" />
                                                                
                                                                <!-- Preview Container (managed by JS) -->
                                                                <div class="image-preview-container" style="display: none;">
                                                                    <span class="existing-image-label">Ảnh mặt sau đã chọn:</span>
                                                                    <img class="img-preview" src="" />
                                                                </div>

                                                                <!-- Existing Image (shows when no new file is chosen) -->
                                                                <c:if test="${fn:length(imagesArr) gt 1 and not empty imagesArr[1]}">
                                                                    <c:set var="backUrl" value="${imagesArr[1]}" />
                                                                    <c:if test="${not fn:startsWith(backUrl, 'http')}"><c:set var="backUrl" value="upload/${backUrl}" /></c:if>
                                                                    <div class="image-preview-container existing-image">
                                                                        <span class="existing-image-label">Mặt sau hiện tại:</span>
                                                                        <img src="${backUrl}" class="img-preview" onerror="this.parentElement.style.display='none';"/>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    </div>
                                                </div>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${flag eq false}">
                                        <p style="display: none" id="customerId">Not</p>
                                        <div style="margin-top: 10px; color: red">
                                            <a>*Hãy cung cấp thông tin CCCD/CMND của bạn để tiếp tục</a>
                                        </div>
                                        
                                        <div class="form-enter">
                                            
                                            <div class="form-row">
                                                <div class="form-flex">
                                                    <div class="form-group" style="width: 40%;">
                                                        <label for="drivernumber" class="form-label">CCCD/CMND <span class="note-star"> *</span></label>
                                                        <input type="text" name="drivernumber" id="identityCard" oninput = "validateForm()"/>
                                                    </div>
                                                    <div style="width: 60%; display: flex; gap: 20px;">
                                                        <div class="form-group" style="width: 50%">
                                                            <label for="issuedon" class="form-label">Ngày cấp <span class="note-star"> *</span></label>
                                                            <input type="date" name="issuedon" id="issuedon" oninput="validateForm()"/>
                                                        </div>
                                                        <div class="form-group" style="width: 50%">
                                                            <label for="expdate" class="form-label">Ngày hết hạn <span class="note-star"> *</span></label>
                                                            <input type="date" name="expdate" id="expdate" oninput="validateForm()"/>
                                                        </div>
                                                    </div>
                                                </div> <!-- End form-flex for text inputs -->
                                                
                                                <div class="form-row" style="margin-top: 25px;">
                                                    <label class="form-label" style="display: block; margin-bottom: 15px; font-weight: 600;">Hình ảnh CCCD/CMND <span class="note-star"> *</span></label>
                                                    <div class="form-flex" style="align-items: flex-start;">
                                                        <div class="upload-card-wrapper" style="flex: 1; min-width: 0;">
                                                            <label for="imageFront" class="upload-card">
                                                                <i class="bi bi-person-vcard"></i>
                                                                <span class="upload-title">Tải lên mặt trước</span>
                                                                <span class="upload-subtitle">Nhấn để chọn ảnh</span>
                                                            </label>
                                                            <input type="file" name="imageFront" id="imageFront" style="display: none;" />
                                                            
                                                            <!-- Preview Container (managed by JS) -->
                                                            <div class="image-preview-container" style="display: none;">
                                                                <span class="existing-image-label">Ảnh mặt trước đã chọn:</span>
                                                                <img class="img-preview" src="" />
                                                            </div>
                                                        </div>

                                                        <div class="upload-card-wrapper" style="flex: 1; min-width: 0;">
                                                            <label for="imageBack" class="upload-card">
                                                                <i class="bi bi-credit-card-2-back"></i>
                                                                <span class="upload-title">Tải lên mặt sau</span>
                                                                <span class="upload-subtitle">Nhấn để chọn ảnh</span>
                                                            </label>
                                                            <input type="file" name="imageBack" id="imageBack" style="display: none;" />
                                                            
                                                            <!-- Preview Container (managed by JS) -->
                                                            <div class="image-preview-container" style="display: none;">
                                                                <span class="existing-image-label">Ảnh mặt sau đã chọn:</span>
                                                                <img class="img-preview" src="" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>                                 
                                </c:if>
                            </div>
                        </fieldset>

                        <h3>Xác nhận</h3>
                        <fieldset>
                            <h2>XÁC NHẬN ĐƠN ĐẶT XE</h2>
                            <p class="desc">Hãy kiểm tra kỹ thông tin đơn đặt xe của bạn trước khi thanh toán.</p>
                            <div class="fieldset-content">
                                <div class="scrollable-vertical">

                                    <!-- THỜI GIAN -->
                                    <div style="background:#fff; border:1px solid #eaeaea; border-radius:12px; padding:20px; margin-bottom:16px;">
                                        <h4 style="margin:0 0 14px; color:#b59349; font-size:13px; text-transform:uppercase; letter-spacing:1px; border-bottom:1px solid #f0f0f0; padding-bottom:10px;">
                                            <i class="bi bi-clock-history"></i> Thời Gian Thuê
                                        </h4>
                                        <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
                                            <div>
                                                <div style="font-size:11px; color:#999; text-transform:uppercase; font-weight:700; margin-bottom:4px;">Nhận xe</div>
                                                <div style="font-weight:600; color:#222; font-size:15px;"><span id="pickupdatetext"></span> <span id="pickuptimetext"></span></div>
                                                <div id="pickuploctext" style="font-size:13px; color:#666; margin-top:3px;"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; text-transform:uppercase; font-weight:700; margin-bottom:4px;">Trả xe</div>
                                                <div style="font-weight:600; color:#222; font-size:15px;"><span id="returndatetext"></span> <span id="returntimetext"></span></div>
                                                <div id="returnloctext" style="font-size:13px; color:#666; margin-top:3px;"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- THÔNG TIN KHÁCH HÀNG -->
                                    <div style="background:#fff; border:1px solid #eaeaea; border-radius:12px; padding:20px; margin-bottom:16px;">
                                        <h4 style="margin:0 0 14px; color:#b59349; font-size:13px; text-transform:uppercase; letter-spacing:1px; border-bottom:1px solid #f0f0f0; padding-bottom:10px;">
                                            <i class="bi bi-person-lines-fill"></i> Thông Tin Khách Hàng
                                        </h4>
                                        <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Họ</div>
                                                <div style="font-weight:600;" id="firstnametext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Tên</div>
                                                <div style="font-weight:600;" id="lastnametext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Số điện thoại</div>
                                                <div style="font-weight:600;" id="phonetext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Email</div>
                                                <div style="font-weight:600;" id="emailaddresstext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Địa chỉ</div>
                                                <div style="font-weight:600;" id="addresstext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Ngày sinh</div>
                                                <div style="font-weight:600;" id="birthdaytext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Giới tính</div>
                                                <div style="font-weight:600;" id="gendertext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">CCCD/CMND</div>
                                                <div style="font-weight:600;" id="identityCardtext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Ngày cấp</div>
                                                <div style="font-weight:600;" id="issuedontext"></div>
                                            </div>
                                            <div>
                                                <div style="font-size:11px; color:#999; margin-bottom:3px;">Ngày hết hạn</div>
                                                <div style="font-weight:600;" id="expdatetext"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- DỊCH VỤ ĐÃ CHỌN (xe + phụ kiện + tổng) -->
                                    <div style="background:#faf9f7; border:1px solid #e0d5b7; border-radius:12px; padding:20px; margin-bottom:16px;">
                                        <h4 style="margin:0 0 14px; color:#b59349; font-size:13px; text-transform:uppercase; letter-spacing:1px; border-bottom:1px solid #e0d5b7; padding-bottom:10px;">
                                            <i class="bi bi-receipt"></i> Chi Tiết Dịch Vụ & Tổng Tiền
                                        </h4>
                                        <div id="savedBikeContainer" style="margin-bottom:12px; min-height:20px;"></div>
                                        <div id="savedItemsContainer" style="margin-bottom:12px; min-height:20px;"></div>
                                        <div id="form-box-total"></div>
                                    </div>

                                    <!-- VOUCHER -->
                                    <div style="background:#fff; border:1px solid #eaeaea; border-radius:12px; padding:20px; margin-bottom:16px;">
                                        <h4 style="margin:0 0 14px; color:#b59349; font-size:13px; text-transform:uppercase; letter-spacing:1px; border-bottom:1px solid #f0f0f0; padding-bottom:10px;">
                                            <i class="bi bi-ticket-perforated"></i> Mã Giảm Giá (Voucher)
                                        </h4>
                                        <div style="display:flex; gap:10px; align-items:center;">
                                            <input type="text" id="voucher-code-input" placeholder="Nhập mã voucher..." style="flex:1; padding:10px 14px; border:1.5px solid #ddd; border-radius:8px; font-size:14px; outline:none;" />
                                            <button type="button" id="apply-voucher-btn" onclick="applyVoucher()" style="background:#b59349; color:#fff; border:none; padding:10px 20px; border-radius:8px; font-weight:700; cursor:pointer; font-size:14px; white-space:nowrap;">Áp dụng</button>
                                        </div>
                                        <div id="voucher-msg" style="font-size:13px; margin-top:8px;"></div>
                                        <input type="hidden" id="applied-discount" value="0"/>
                                        <input type="hidden" id="applied-voucher-id" value="0"/>
                                    </div>
                                    
                                    <!-- CAM KẾT GIAO XE -->
                                    <div style="background:#f0faf0; border:1px solid #b2dfb2; border-radius:12px; padding:16px 20px; margin-bottom: 20px; display: flex; gap: 15px; align-items: flex-start;">
                                        <div style="width: 40px; height: 40px; border-radius: 50%; background: #e8f5e9; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                                            <i class="fas fa-shipping-fast text-green-600 text-lg"></i>
                                        </div>
                                        <div>
                                            <h4 style="margin:0 0 4px; color:#2e7d32; font-size:14px; font-weight: 700;">Cam kết giao xe đúng hạn!</h4>
                                            <p style="margin:0; font-size:13px; color:#388e3c; line-height: 1.5;">SmartRide cam kết giao xe tận nơi chậm nhất trong <strong>45 phút</strong> kể từ lúc <strong>nhân viên duyệt đơn</strong> (hoặc theo đúng giờ đã hẹn). Nếu giao trễ quá thời gian này, hệ thống sẽ tự động tặng ngay <strong>Mã giảm giá 50.000đ</strong> đền bù vào đơn hàng của bạn! <em>*Lưu ý: Vui lòng đặt xe cách thời điểm hiện tại ít nhất 15 phút.</em></p>
                                        </div>
                                    </div>

                                    <!-- ĐIỀU KHOẢN -->
                                    <div style="background:#fffbf2; border:1px solid #f0e4b8; border-radius:12px; padding:20px;">
                                        <h4 style="margin:0 0 12px; color:#b59349; font-size:13px; text-transform:uppercase; letter-spacing:1px;">
                                            <i class="bi bi-shield-check"></i> Điều Khoản &amp; Chính Sách
                                        </h4>
                                        <ul style="font-size:13px; color:#555; margin:0 0 14px; padding-left:18px; line-height:2;">
                                            <li>Người thuê phải có <strong>bằng lái xe hợp lệ</strong> và đủ <strong>18 tuổi</strong> trở lên.</li>
                                            <li>Xuất trình <strong>CCCD/Hộ chiếu</strong> khi nhận xe.</li>
                                            <li>Xe được giao đúng địa điểm và thời gian đã chọn. Trả muộn tính phí thêm.</li>
                                            <li>Tiền cọc hoàn trả khi trả xe đúng hạn và nguyên vẹn.</li>
                                            <li>Hủy miễn phí <strong>trước 24 giờ</strong> nhận xe. Hoàn tiền trong 7 ngày làm việc.</li>
                                        </ul>
                                        <div style="margin-bottom:14px;">
                                            <button type="button" onclick="document.getElementById('terms-modal').style.display='flex'"
                                                style="background:none; border:none; padding:0; color:#b59349; font-size:13px; font-weight:600; cursor:pointer; text-decoration:underline;">
                                                <i class="fas fa-file-contract"></i> Xem đầy đủ Chính sách &amp; Điều khoản →
                                            </button>
                                        </div>
                                        <label style="display:flex; align-items:center; gap:10px; cursor:pointer; font-size:14px; font-weight:600; color:#333;">
                                            <input type="checkbox" id="daily-checkbox-term" style="width:18px; height:18px; accent-color:#b59349; cursor:pointer;" />
                                            <span>Tôi đã đọc và đồng ý với <span style="color:#b59349; text-decoration:underline; cursor:pointer;" onclick="document.getElementById('terms-modal').style.display='flex'">Điều khoản dịch vụ</span> &amp; 
                                            <span style="color:#3b82f6; text-decoration:underline; cursor:pointer;" onclick="document.getElementById('contract-modal').style.display='flex'">Hợp đồng thuê xe</span></span>
                                        </label>
                                    </div>

                                </div>
                            </div>
                        </fieldset>
                        
                        <h3>Thanh toán cọc</h3>
                        <fieldset>
                            <h2 style="margin-bottom:20px;">PHƯƠNG THỨC THANH TOÁN</h2>
                            <p class="desc" style="margin-bottom:24px;">Vui lòng chọn hình thức thanh toán cho đơn đặt xe của bạn.</p>


                            <div id="payment-method-container" style="max-width:540px; margin:0 auto; display:flex; flex-direction:column; gap:0;">

                                <!-- Deposit Summary Card -->
                                <div style="background:linear-gradient(135deg,#1a1a2e 0%,#16213e 60%,#0f3460 100%);border-radius:20px;padding:28px 28px 22px;margin-bottom:22px;position:relative;overflow:hidden;">
                                    <div style="position:absolute;top:-30px;right:-30px;width:130px;height:130px;background:rgba(181,147,73,0.12);border-radius:50%;"></div>
                                    <div style="position:absolute;bottom:-20px;left:40px;width:80px;height:80px;background:rgba(181,147,73,0.08);border-radius:50%;"></div>
                                    <div style="font-size:11px;color:#b59349;font-weight:700;text-transform:uppercase;letter-spacing:2.5px;margin-bottom:10px;position:relative;">Số tiền đặt cọc</div>
                                    <div id="deposit-summary-amount" style="font-size:40px;font-weight:900;color:#fff;margin-bottom:5px;position:relative;letter-spacing:-1px;">—</div>
                                    <div id="deposit-summary-label" style="font-size:13px;color:rgba(255,255,255,0.5);position:relative;">Đang tính toán...</div>
                                    <div style="margin-top:18px;padding-top:14px;border-top:1px solid rgba(255,255,255,0.08);display:flex;gap:24px;position:relative;">
                                        <span style="font-size:11px;color:rgba(255,255,255,0.4);">Thanh toán bảo mật</span>
                                        <span style="font-size:11px;color:rgba(255,255,255,0.4);">Hoàn cọc nếu huỷ đúng hạn</span>
                                    </div>
                                </div>

                                <!-- Label section -->
                                <div style="font-size:11px;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:1.5px;margin-bottom:12px;">Phương thức thanh toán</div>

                                <!-- Option: Tiền mặt -->
                                <label id="lbl-cash" onclick="highlightPayment('cash')" style="display:flex;align-items:center;padding:18px 20px;border:2px solid #e5e7eb;border-radius:14px;cursor:pointer;background:#fff;margin-bottom:10px;transition:border 0.2s,background 0.2s;">
                                    <input type="radio" name="payment_method" value="cash" checked style="display:none;">
                                    <div style="flex:1;">
                                        <div style="font-size:15px;font-weight:700;color:#0f172a;">Tiền mặt</div>
                                        <div style="font-size:12px;color:#94a3b8;margin-top:3px;font-weight:400;">Thanh toán trực tiếp khi nhận xe</div>
                                    </div>
                                    <div id="check-cash" style="width:20px;height:20px;border-radius:50%;border:2px solid #b59349;background:#b59349;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:12px;color:#fff;font-weight:900;line-height:1;">&#10003;</div>
                                </label>

                                <!-- Option: Chuyển khoản -->
                                <label id="lbl-transfer" onclick="highlightPayment('transfer')" style="display:flex;align-items:center;padding:18px 20px;border:2px solid #e5e7eb;border-radius:14px;cursor:pointer;background:#fff;margin-bottom:18px;transition:border 0.2s,background 0.2s;">
                                    <input type="radio" name="payment_method" value="transfer" style="display:none;">
                                    <div style="flex:1;">
                                        <div style="font-size:15px;font-weight:700;color:#0f172a;">
                                            Chuyển khoản / Mã QR
                                            <span style="margin-left:8px;background:#f0fdf4;color:#15803d;font-size:10px;font-weight:700;padding:2px 7px;border-radius:4px;vertical-align:middle;letter-spacing:0.5px;">TỰ ĐỘNG</span>
                                        </div>
                                        <div style="font-size:12px;color:#94a3b8;margin-top:3px;font-weight:400;">Quét QR — hệ thống xác nhận tức thì qua SePay</div>
                                    </div>
                                    <div id="check-transfer" style="width:20px;height:20px;border-radius:50%;border:2px solid #e2e8f0;background:transparent;flex-shrink:0;"></div>
                                </label>

                                <!-- Bank info đã bị ẩn theo yêu cầu để tránh khách CK nhầm -->

                                <!-- CTA Button -->
                                <button type="button" onclick="confirmPaymentMethod()" style="width:100%;padding:16px;background:linear-gradient(135deg,#b59349,#d4aa5f);color:#fff;border:none;border-radius:12px;font-size:15px;font-weight:700;cursor:pointer;letter-spacing:0.3px;box-shadow:0 4px 14px rgba(181,147,73,0.28);">
                                    Xác nhận thanh toán
                                </button>

                                <!-- Fine print -->
                                <div style="text-align:center;margin-top:12px;font-size:11px;color:#cbd5e1;">
                                    Giao dịch được mã hoá SSL 256-bit &bull; Thông tin bảo mật tuyệt đối
                                </div>

                            </div>

                            <script>
                            function highlightPayment(method) {
                                var lblCash     = document.getElementById('lbl-cash');
                                var lblTransfer = document.getElementById('lbl-transfer');
                                var chkCash     = document.getElementById('check-cash');
                                var chkTransfer = document.getElementById('check-transfer');
                                var bankInfo    = document.getElementById('bank-info-preview');
                                if (!lblCash || !lblTransfer) return;

                                if (method === 'cash') {
                                    document.querySelector('input[value="cash"]').checked = true;
                                    lblCash.style.border     = '2px solid #b59349';
                                    lblCash.style.background = '#fffbeb';
                                    lblTransfer.style.border     = '2px solid #e5e7eb';
                                    lblTransfer.style.background = '#fff';
                                    chkCash.style.background = '#b59349';
                                    chkCash.style.border     = '2px solid #b59349';
                                    chkCash.innerHTML        = '&#10003;';
                                    chkCash.style.color      = '#fff';
                                    chkTransfer.style.background = 'transparent';
                                    chkTransfer.style.border     = '2px solid #e2e8f0';
                                    chkTransfer.innerHTML        = '';
                                } else {
                                    document.querySelector('input[value="transfer"]').checked = true;
                                    lblTransfer.style.border     = '2px solid #b59349';
                                    lblTransfer.style.background = '#fffbeb';
                                    lblCash.style.border     = '2px solid #e5e7eb';
                                    lblCash.style.background = '#fff';
                                    chkTransfer.style.background = '#b59349';
                                    chkTransfer.style.border     = '2px solid #b59349';
                                    chkTransfer.innerHTML        = '&#10003;';
                                    chkTransfer.style.color      = '#fff';
                                    chkTransfer.style.display    = 'flex';
                                    chkTransfer.style.alignItems = 'center';
                                    chkTransfer.style.justifyContent = 'center';
                                    chkTransfer.style.fontSize   = '12px';
                                    chkTransfer.style.fontWeight = '900';
                                    chkCash.style.background = 'transparent';
                                    chkCash.style.border     = '2px solid #e2e8f0';
                                    chkCash.innerHTML        = '';
                                }
                            }

                            function syncDepositSummary() {
                                var dataEl     = document.getElementById('dataInput');
                                var summaryAmt = document.getElementById('deposit-summary-amount');
                                var summaryLbl = document.getElementById('deposit-summary-label');
                                if (!dataEl || !summaryAmt) return;
                                var methodCash = document.getElementById('check-cash') && document.getElementById('check-cash').style.background === 'rgb(181, 147, 73)';
                                var rawAmt = dataEl.getAttribute(methodCash ? 'data-full-amount' : 'data-amount');
                                var amt = rawAmt ? parseInt(rawAmt) : 0;
                                
                                // Update title and button
                                var titleBox = summaryAmt.previousElementSibling;
                                var submitBtn = document.querySelector('#payment-method-container button');
                                
                                if (methodCash) {
                                    if (titleBox) titleBox.textContent = 'TỔNG TIỀN (KHI NHẬN XE)';
                                    summaryLbl.textContent = 'Thanh toán tiền mặt khi nhận xe';
                                    if (submitBtn) submitBtn.textContent = 'Xác nhận đặt xe (Thanh toán sau)';
                                } else {
                                    if (titleBox) titleBox.textContent = 'SỐ TIỀN ĐẶT CỌC';
                                    try {
                                        var h4 = dataEl.parentElement ? dataEl.parentElement.querySelector('h4') : null;
                                        summaryLbl.textContent = h4 ? h4.textContent.trim() : 'Cần đặt cọc (50% theo ngày):';
                                    } catch(e) {}
                                    if (submitBtn) submitBtn.textContent = 'Xác nhận thanh toán';
                                }

                                if (amt > 0) {
                                    summaryAmt.textContent = '&#8363;' + amt.toLocaleString('vi-VN');
                                }
                            }
                            window.syncDepositSummary = syncDepositSummary;
                            document.addEventListener('DOMContentLoaded', function() {
                                highlightPayment('cash');
                                setTimeout(syncDepositSummary, 500);
                            });
                            </script>


                            <!-- ===== AI VERIFY ERROR BOX ===== -->

                            <div id="ai-verify-error-box" style="display:none; max-width:480px; margin:10px auto 0 auto;"></div>

                            <!-- ===== SEPAY QR PAYMENT UI ===== -->
                            <div id="sepay-payment-section" style="display:none; max-width:480px; margin:0 auto; font-family:'Plus Jakarta Sans',sans-serif; position: relative;">
                                <!-- Close Button -->
                                <button type="button" onclick="closeQrPayment()" style="position: absolute; top: -10px; right: -10px; background: #ef4444; color: white; border: none; width: 32px; height: 32px; border-radius: 50%; font-weight: bold; cursor: pointer; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 10; display: flex; align-items: center; justify-content: center; font-size: 16px;" title="Đóng và thanh toán sau">
                                    <i class="fas fa-times"></i>
                                </button>
                                
                                <!-- Countdown Timer -->
                                <div style="text-align:center; margin-bottom:18px;">
                                    <div style="display:inline-flex; align-items:center; gap:8px; background:#fff3f3; border:1.5px solid #f87171; border-radius:12px; padding:8px 20px;">
                                        <span style="font-size:14px; color:#ef4444; font-weight:600;">⏱ Thời gian còn lại:</span>
                                        <span id="sepay-countdown" style="font-size:22px; font-weight:800; color:#ef4444; min-width:56px; display:inline-block; text-align:center;">10:00</span>
                                    </div>
                                </div>

                                <!-- QR Code Image -->
                                <div style="text-align:center; background:#fff; border:2px solid #e5e7eb; border-radius:16px; padding:20px; margin-bottom:18px;">
                                    <img id="sepay-qr-img" src="" alt="QR SePay" style="width:220px; height:220px; border-radius:8px; display:block; margin:0 auto;">
                                    <div style="margin-top:12px;">
                                        <div style="font-size:13px; color:#666; margin-bottom:4px;">Ngân hàng: <strong>MBBank (MBB)</strong></div>
                                        <div style="font-size:13px; color:#666; margin-bottom:4px;">Số tài khoản: <strong>0943515000</strong></div>
                                        <div style="font-size:13px; color:#666;">Số tiền: <strong id="sepay-amount-text" style="color:#b59349;"></strong></div>
                                    </div>
                                </div>

                                <!-- Transfer note -->
                                <div style="background:#f0fdf4; border:1.5px solid #86efac; border-radius:12px; padding:14px 18px; margin-bottom:18px; text-align:center;">
                                    <div style="font-size:13px; color:#16a34a; font-weight:600; margin-bottom:4px;">📋 Nội dung chuyển khoản:</div>
                                    <div id="sepay-transfer-note" style="font-size:17px; font-weight:800; color:#15803d; letter-spacing:1px;"></div>
                                    <div style="font-size:11px; color:#666; margin-top:4px;">Vui lòng ghi đúng nội dung để hệ thống xác nhận tự động</div>
                                </div>

                                <!-- Status -->
                                <div id="sepay-status" style="text-align:center; padding:12px; border-radius:10px; background:#fef9c3; color:#92400e; font-weight:600; font-size:14px;">
                                    ⏳ Đang chờ thanh toán...
                                </div>

                                <!-- Dev test button (remove in production) -->
                                <div style="text-align:center; margin-top:12px;">
                                    <button type="button" onclick="simulatePaymentSuccess()" style="background:#6b7280; color:#fff; border:none; padding:8px 18px; border-radius:8px; cursor:pointer; font-size:12px; opacity:0.6;">
                                        [Dev] Giả lập thanh toán thành công
                                    </button>
                                </div>
                            </div>

                            <!-- Hiển thị khi chưa tạo QR -->
                            <!-- sepay-placeholder removed -->
                        </fieldset>
                    </div>
                </form>
            </div>

        </div>

        <!-- MODAL HỢP ĐỒNG THUÊ XE PREVIEW -->
        <div id="contract-modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.65); z-index:99999; align-items:center; justify-content:center; padding:20px; box-sizing:border-box;">
            <div style="background:#fff; border-radius:12px; max-width:850px; width:100%; height:90vh; overflow:hidden; display:flex; flex-direction:column; box-shadow:0 24px 60px rgba(0,0,0,0.3);">
                <div style="padding:16px 24px; border-bottom:1px solid #eee; display:flex; align-items:center; justify-content:space-between; background:#fafafa;">
                    <div>
                        <h3 style="margin:0; color:#3b82f6; font-size:18px;"><i class="fas fa-file-signature"></i> Hợp Đồng Thuê Xe (Bản xem trước)</h3>
                        <p style="margin:4px 0 0; font-size:12px; color:#777;">Hợp đồng thực tế sẽ có đầy đủ thông tin của bạn sau khi thanh toán cọc.</p>
                    </div>
                    <button type="button" onclick="document.getElementById('contract-modal').style.display='none'"
                        style="background:#f1f5f9; border:none; width:34px; height:34px; border-radius:50%; font-size:18px; cursor:pointer; color:#475569; transition: background 0.2s;">&times;</button>
                </div>
                <div style="flex:1; width:100%; overflow:hidden;">
                    <iframe src="contract.jsp?id=preview" style="width:100%; height:100%; border:none;"></iframe>
                </div>
                <div style="padding:14px 24px; border-top:1px solid #eee; display:flex; justify-content:flex-end; background:#fafafa;">
                    <button type="button" onclick="document.getElementById('daily-checkbox-term').checked=true; document.getElementById('contract-modal').style.display='none'; if(typeof toggleNextButton==='function') toggleNextButton();"
                        style="padding:10px 24px; background:#3b82f6; color:#fff; border:none; border-radius:8px; font-size:14px; font-weight:700; cursor:pointer; box-shadow: 0 4px 6px -1px rgba(59, 130, 246, 0.5);">Đã đọc &amp; Đồng ý</button>
                </div>
            </div>
        </div>

        <!-- MODAL ĐIỀU KHOẢN SMARTRIDE -->
        <div id="terms-modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.55); z-index:99999; align-items:center; justify-content:center; padding:20px; box-sizing:border-box;">
            <div style="background:#fff; border-radius:16px; max-width:720px; width:100%; max-height:85vh; overflow:hidden; display:flex; flex-direction:column; box-shadow:0 24px 60px rgba(0,0,0,0.25);">
                <div style="padding:20px 24px; border-bottom:1px solid #f0e4b8; display:flex; align-items:center; justify-content:space-between; background:#fffbf2;">
                    <div>
                        <h3 style="margin:0; color:#b59349; font-size:18px;">🛡️ Chính sách &amp; Điều khoản SmartRide</h3>
                        <p style="margin:4px 0 0; font-size:12px; color:#888;">Vui lòng đọc kỹ trước khi xác nhận đặt xe</p>
                    </div>
                    <button type="button" onclick="document.getElementById('terms-modal').style.display='none'"
                        style="background:#f3f4f6; border:none; width:34px; height:34px; border-radius:50%; font-size:18px; cursor:pointer; color:#555;">✕</button>
                </div>
                <div style="overflow-y:auto; padding:24px; flex:1; font-size:14px; color:#444; line-height:1.8;">
                    <h4 style="color:#b59349; margin:0 0 6px;">1. Giới thiệu</h4>
                    <p>Chào mừng bạn đến với <strong>SmartRide</strong>! Chúng tôi cung cấp dịch vụ cho thuê xe máy nhằm giúp bạn dễ dàng di chuyển và khám phá. Vui lòng đọc kỹ các điều khoản dưới đây.</p>
                    <hr style="border:none; border-top:1px solid #f0e4b8; margin:14px 0;">
                    <h4 style="color:#b59349; margin:0 0 6px;">2. Đăng ký và Tài khoản</h4>
                    <p><strong>Đăng ký Tài khoản:</strong> Người dùng phải đăng ký tài khoản hợp lệ để sử dụng dịch vụ.<br>
                    <strong>Bảo mật Tài khoản:</strong> Người dùng tự chịu trách nhiệm bảo mật thông tin tài khoản.</p>
                    <hr style="border:none; border-top:1px solid #f0e4b8; margin:14px 0;">
                    <h4 style="color:#b59349; margin:0 0 6px;">3. Điều khoản Thuê xe</h4>
                    <p><strong>Điều kiện:</strong> Có bằng lái hợp lệ, đủ 18 tuổi trở lên. Xuất trình CCCD/Hộ chiếu khi nhận xe.<br>
                    <strong>Đặt xe:</strong> Sau khi đặt, khách nhận xác nhận qua email với thông tin chi tiết.<br>
                    <strong>Thanh toán:</strong> Hoàn thành thanh toán trước khi nhận xe. Chấp nhận SePay VietQR, thẻ tín dụng/ghi nợ.</p>
                    <hr style="border:none; border-top:1px solid #f0e4b8; margin:14px 0;">
                    <h4 style="color:#b59349; margin:0 0 6px;">4. Sử dụng Xe</h4>
                    <p><strong>An toàn:</strong> Tuân thủ luật giao thông, đội mũ bảo hiểm khi lái xe.<br>
                    <strong>Phạm vi di chuyển:</strong> Không được phép tự ý lái xe ra khỏi phạm vi bán kính 50km tính từ cửa hàng (chỉ giới hạn trong Đà Nẵng, Hội An và phụ cận) nếu không có sự đồng ý trước của SmartRide.<br>
                    <strong>Bảo quản:</strong> Chịu trách nhiệm xe suốt thời gian thuê. Hư hại phải báo cáo ngay.<br>
                    <strong>Trả xe:</strong> Đúng giờ, đúng địa điểm. <strong>Trả muộn bị tính phí thêm.</strong></p>
                    <hr style="border:none; border-top:1px solid #f0e4b8; margin:14px 0;">
                    <h4 style="color:#b59349; margin:0 0 6px;">5. Phụ phí & Bồi thường (Áp dụng lúc trả xe)</h4>
                    <p><strong>Phạt trả muộn:</strong> Trả xe quá giờ quy định mà không gia hạn trước sẽ bị tính phí phụ thu (VD: 50,000đ/giờ). Quá 6 tiếng tính thành 1 ngày thuê.<br>
                    <strong>Hư hỏng, xước xát:</strong> Mọi vết xước, móp méo vỏ xe, hoặc hư hỏng linh kiện phát sinh (được đối chiếu dựa trên ảnh chụp lúc giao xe) sẽ được định giá và yêu cầu bồi thường trực tiếp.<br>
                    <strong>Xăng xe:</strong> Khách hàng cần trả xe với mức xăng tối thiểu bằng mức xăng lúc nhận xe, nếu thiếu sẽ phụ thu tiền đổ bù.</p>
                    <hr style="border:none; border-top:1px solid #f0e4b8; margin:14px 0;">
                    <h4 style="color:#b59349; margin:0 0 6px;">6. Bảo hiểm &amp; Trách nhiệm</h4>
                    <p><strong>Bảo hiểm:</strong> SmartRide cung cấp bảo hiểm cơ bản cho xe thuê.<br>
                    <strong>Trách nhiệm:</strong> Người thuê chịu trách nhiệm pháp lý với mọi hành động khi sử dụng xe.</p>
                    <hr style="border:none; border-top:1px solid #f0e4b8; margin:14px 0;">
                    <h4 style="color:#b59349; margin:0 0 6px;">7. Hủy Bỏ &amp; Hoàn Tiền</h4>
                    <p><strong>Hủy miễn phí:</strong> Trước 24 giờ so với thời gian nhận xe.<br>
                    <strong>Hoàn tiền:</strong> Xử lý trong vòng <strong>7 ngày làm việc</strong> sau khi xác nhận hủy.</p>
                    <hr style="border:none; border-top:1px solid #f0e4b8; margin:14px 0;">
                    <h4 style="color:#b59349; margin:0 0 6px;">8. Quyền riêng tư</h4>
                    <p>SmartRide cam kết bảo vệ thông tin cá nhân và không chia sẻ cho bên thứ ba ngoài mục đích dịch vụ.</p>
                    <hr style="border:none; border-top:1px solid #f0e4b8; margin:14px 0;">
                    <h4 style="color:#b59349; margin:0 0 6px;">9. Liên hệ</h4>
                    <p>Mọi thắc mắc về điều khoản, vui lòng liên hệ qua email hoặc số điện thoại trên website. Chi tiết đầy đủ tại <a href="policies.jsp" target="_blank" style="color:#b59349; font-weight:600;">trang Chính sách</a>.</p>
                </div>
                <div style="padding:14px 24px; border-top:1px solid #f0e4b8; display:flex; justify-content:flex-end; gap:10px; background:#fafafa;">
                    <button type="button" onclick="document.getElementById('terms-modal').style.display='none'"
                        style="padding:10px 20px; background:#f3f4f6; border:none; border-radius:8px; font-size:14px; cursor:pointer; color:#555; font-weight:600;">Đóng</button>
                    <button type="button" onclick="document.getElementById('daily-checkbox-term').checked=true; document.getElementById('terms-modal').style.display='none'; if(typeof toggleNextButton==='function') toggleNextButton();"
                        style="padding:10px 24px; background:#b59349; color:#fff; border:none; border-radius:8px; font-size:14px; font-weight:700; cursor:pointer;">✓ Đã đọc &amp; Đồng ý</button>
                </div>
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
            // Unused navbar fetch commented out to prevent console error
            /*
            fetch('includes/navbar2.jsp')  // Sử dụng đường dẫn tương đối
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();
            })
            .then(html => {
                const container = document.getElementById('navbar-container');
                const shadowRoot = container.attachShadow({ mode: 'open' });

                // Thêm liên kết tới thư viện Bootstrap Icons
                const link = document.createElement('link');
                link.rel = 'stylesheet';
                link.href = 'https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css';
                shadowRoot.appendChild(link);

                const template = document.createElement('template');
                template.innerHTML = html;

                // Copy các thẻ link và script từ template vào shadow DOM
                const linksAndScripts = template.content.querySelectorAll('link, script');
                linksAndScripts.forEach(element => {
                    shadowRoot.appendChild(element.cloneNode(true));
                });

                // Copy nội dung chính vào shadow DOM
                shadowRoot.appendChild(template.content.cloneNode(true));
            })
            .catch(error => {
                console.error('Fetch error:', error);
            });
            */
            
            let totalI = 0;
            const numberAccessStatesI = {};
            (function ($) {



                var form = $("#signup-form");
                
                // minAdvanceTime validation removed per user request

                $.validator.addMethod("businessHours", function(value, element) {
                    if (!value) return true;
                    var parts = value.split(':');
                    if (parts.length < 2) return true;
                    var hour = parseInt(parts[0], 10);
                    var minute = parseInt(parts[1], 10);
                    if (hour < 7 || hour > 23 || (hour === 23 && minute > 0)) {
                        return false;
                    }
                    return true;
                }, "Chỉ nhận/trả xe trong giờ hoạt động (07:00 - 23:00)");

                form.validate({
                    errorPlacement: function errorPlacement(error, element) {
                        element.before(error);
                    },
                    rules: {
                        email: {
                            email: true
                        },
                        pickuptime: {
                            businessHours: true
                        },
                        returntime: {
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
                        finish: 'Kết thúc',
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

                        // ===== VALIDATE: Không cho đặt xe trong quá khứ =====
                        if (currentIndex === 0 && newIndex > 0) {
                            var pickupDateVal = document.getElementById('pickupdate').value;
                            var pickupTimeVal = document.getElementById('pickuptime').value || '00:00';
                            if (pickupDateVal) {
                                var pickupDateTime = new Date(pickupDateVal + 'T' + pickupTimeVal + ':00');
                                var now = new Date();
                                if (pickupDateTime <= now) {
                                    // Hiển thị lỗi dưới ô ngày nhận xe
                                    var errEl = document.getElementById('pickup-past-error');
                                    if (!errEl) {
                                        errEl = document.createElement('div');
                                        errEl.id = 'pickup-past-error';
                                        errEl.style.cssText = 'color:#dc2626; font-size:13px; margin-top:6px; font-weight:600;';
                                        document.getElementById('pickupdate').parentNode.appendChild(errEl);
                                    }
                                    errEl.textContent = '⚠️ Ngày & giờ nhận xe phải ở tương lai, không thể đặt xe trong quá khứ!';
                                    document.getElementById('pickupdate').style.borderColor = '#dc2626';
                                    return false;
                                } else {
                                    var errEl2 = document.getElementById('pickup-past-error');
                                    if (errEl2) errEl2.remove();
                                    document.getElementById('pickupdate').style.borderColor = '';
                                }
                            }
                        }
                        // ===== VALIDATE: CMND/CCCD cho khách mới =====
                        if (currentIndex === 3 && newIndex > 3) {
                            var cusIdElem = document.getElementById('customerId');
                            var customerId = cusIdElem ? cusIdElem.textContent.trim() : 'Not';
                            if (customerId === 'Not' || customerId === '') {
                                var imgFront = document.getElementById('imageFront');
                                var imgBack = document.getElementById('imageBack');
                                if (!imgFront || !imgFront.files || imgFront.files.length === 0 || !imgBack || !imgBack.files || imgBack.files.length === 0) {
                                    if (typeof Swal !== 'undefined') {
                                        Swal.fire({
                                            icon: 'warning',
                                            title: 'Thiếu thông tin',
                                            text: 'Vui lòng tải lên cả mặt trước và mặt sau CCCD/CMND để tiếp tục!',
                                            confirmButtonColor: '#b59349'
                                        });
                                    } else {
                                        alert('Vui lòng tải lên cả mặt trước và mặt sau CCCD/CMND để tiếp tục!');
                                    }
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
                        // Gọi trực tiếp hàm xử lý thanh toán thay vì gửi AJAX nhầm sang forgotPassword
                        confirmPaymentMethod();
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

                        // Chuyển các chuỗi ngày thành đối tượng Date
                        const pickupDate = new Date(pickupDateText);
                        const returnDate = new Date(returnDateText);

                        // Tính số ngày chênh lệch
                        const differenceInTime = returnDate.getTime() - pickupDate.getTime();
                        const differenceInDays = differenceInTime / (1000 * 3600 * 24);
                            
                        if(currentIndex === 0){
                            nextButton.style.pointerEvents = 'auto';
                            nextButton.style.color = '';
                            nextButton.style.background = ''; nextButton.style.opacity = '1';
                        }
                        if (currentIndex === 1) {
//                            nextButton.style.pointerEvents = 'none';
//                            nextButton.style.background = ''; nextButton.style.opacity = '0.5';
//                            nextButton.style.color = '';
                            
                            toggleBikeNextButton();
                            changePrice();
                           
                       }
                        if(currentIndex === 5){
                             var finishButton = document.querySelector('.wizard .actions a[href="#finish"]');
                             if (finishButton && finishButton.parentElement) {
                                 finishButton.parentElement.style.display = 'none';
                             }
                             
                             document.getElementById('payment-method-container').style.display = 'flex';
                             document.getElementById('sepay-payment-section').style.display = 'none';

                             // Reset lại nút xác nhận (tránh kẹt ở trạng thái "Đang xử lý...")
                             var paymentBtn = document.querySelector('#payment-method-container button');
                             if (paymentBtn) {
                                 paymentBtn.innerHTML = 'Xác nhận thanh toán';
                                 paymentBtn.style.opacity = '1';
                                 paymentBtn.style.pointerEvents = 'auto';
                             }

                             // Tính ngay số tiền cọc — không chờ timeout
                             (function() {
                                 // Thử đọc từ dataInput (bước Xác nhận đã tính sẵn)
                                 var dataEl = document.getElementById('dataInput');
                                 var summaryAmt = document.getElementById('deposit-summary-amount');
                                 var summaryLbl = document.getElementById('deposit-summary-label');
                                 if (!summaryAmt) return;

                                 var amt = 0;
                                 var lbl = '';

                                 if (dataEl) {
                                     var raw = dataEl.getAttribute('data-amount');
                                     if (raw) amt = parseInt(raw) || 0;
                                     try {
                                         var h4 = dataEl.parentElement ? dataEl.parentElement.querySelector('h4') : null;
                                         if (h4) lbl = h4.textContent.trim();
                                     } catch(e) {}
                                 }

                                 // Fallback: tính thẳng từ ngày + giá nếu dataInput chưa có
                                 if (amt === 0) {
                                     var pickup = document.getElementById('pickupdate') ? document.getElementById('pickupdate').value : '';
                                     var ret    = document.getElementById('returndate') ? document.getElementById('returndate').value : '';
                                     if (pickup && ret) {
                                         var s = new Date(pickup), e = new Date(ret);
                                         var days = Math.max(1, Math.ceil((e - s) / (1000*60*60*24)));
                                         var rate = days >= 30 ? 0.20 : (days >= 7 ? 0.30 : 0.50);
                                         var pct  = Math.round(rate * 100);
                                         var plan = days >= 30 ? 'theo tháng' : (days >= 7 ? 'theo tuần' : 'theo ngày');

                                         // Tổng tiền từ các xe đã chọn
                                         var total = 0;
                                         document.querySelectorAll('#savedBikeContainer .form-box').forEach(function(fb) {
                                             var qty = parseInt((fb.querySelector('.form-check-select') || {}).value) || 0;
                                             var priceEl = days >= 30 ? fb.querySelector('.price-month')
                                                         : days >= 7  ? fb.querySelector('.price-week')
                                                         : fb.querySelector('.price-day');
                                             var price = priceEl ? (parseInt(priceEl.dataset.rawprice) || 0) : 0;
                                             total += qty * price * days;
                                         });
                                         // Voucher
                                         var disc = parseInt((document.getElementById('applied-discount') || {}).value) || 0;
                                         var final = Math.max(0, total - disc);
                                         amt = Math.round(final * rate);
                                         lbl = 'Cần đặt cọc (' + pct + '% ' + plan + ')';
                                     }
                                 }

                                 if (amt > 0) {
                                     summaryAmt.textContent = '₫' + amt.toLocaleString('vi-VN');
                                     if (lbl) summaryLbl.textContent = lbl;
                                 }
                             })();
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
                            
                            if(quantityDay >= 1 && quantityDay <= 7){
                                
                                priceDayElements.forEach(element => {
                                   element.style.display = "inline-block";
                                   element.classList.add("price-current");
                                });
                            }
                            else if(quantityDay >= 8 && quantityDay <= 30){
                                
                                priceWeekElements.forEach(element => {
                                   element.style.display = "inline-block";
                                   element.classList.add("price-current");
                                });
                            }
                            else if(quantityDay >= 30){
                                
                                priceMonthElements.forEach(element => {
                                   element.style.display = "inline-block";
                                   element.classList.add("price-current");
                                });
                            }
                       }

                        if (currentIndex === 3) {
                            validateForm();
//                            nextButton.style.pointerEvents = 'auto';
//                            nextButton.style.color = '';
//                            nextButton.style.background = ''; nextButton.style.opacity = '1';
                        }
                        
                        if (currentIndex === 2) {
                            nextButton.style.pointerEvents = 'auto';
                            nextButton.style.color = '';
                            nextButton.style.background = ''; nextButton.style.opacity = '1';
                            let sum = 0;
                            const checkboxMotorContainer = document.getElementById('motorcyclelist');
                            const selectBoxes = checkboxMotorContainer.querySelectorAll('.form-check-select');

                            // Lặp qua từng select box và lấy thông tin nếu giá trị lớn hơn 0
                            selectBoxes.forEach(selectBox => {
                                const quantity = parseInt(selectBox.value);
                                if (quantity > 0) {
                                   sum += quantity;
                                }
                            });
                            
                            if(sum !== totalI){
                                totalI = sum;
                                const checkboxContainer = document.getElementById('protection');
                                // Đặt max và min cho các input có class 'form-check-select'
                                checkboxContainer.querySelectorAll('.form-check-select').forEach(input => {
                                    const label = input.nextElementSibling;
                                    let max = sum * 2;
                                    const min = 0;
                                    
                                    if (label.classList.contains('items-free')) {
                                        max = sum;
                                    }
                                    createOptions(input, min, max);
                                    
                                });
                                
                                if (numberAccessStatesI) {
                                    console.log(Object.keys(numberAccessStatesI).length !== 0);
                                    if(Object.keys(numberAccessStatesI).length !== 0){
                                        Object.keys(numberAccessStatesI).forEach(numberId => {
                                            const numberSelect = document.querySelector(`#protection #` + numberId);
                                            if (numberSelect) {
                                               
                                                const value = typeof numberAccessStatesI[numberId] === 'number' && !isNaN(numberAccessStatesI[numberId]) ? numberAccessStatesI[numberId] : 0;
                                                numberSelect.value = value;

                                            }
                                        });
                                    }
                                }                        
                                
                            }
                          
//                        
                            // Hàm tạo các tùy chọn cho thẻ <select>
                            function createOptions(selectElement, min, max) {
                                selectElement.innerHTML = ''; // Xóa các tùy chọn cũ nếu có
                                for (let i = min; i <= max; i++) {
                                    const option = document.createElement('option');
                                    option.value = i;
                                    option.text = i;
                                    selectElement.appendChild(option);
                                }
                            }
                            
                            
                        }
                        
                        if(currentIndex !== 5){
                            const steps = document.querySelectorAll('.wizard ul[role="tablist"] li');
                            steps[5].classList.remove('done');
                            steps[5].classList.add('disabled');
                        }
                        
                        if (currentIndex === 4) { // Bước thứ tư (index bắt đầu từ 0)
                            const checkbox = document.getElementById('daily-checkbox-term');
                            nextButton.style.pointerEvents = 'none';
                            nextButton.style.background = ''; nextButton.style.opacity = '0.5';
                            nextButton.style.color = '';
                            
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

                            //Add motorcycle have chosen
                            const savedBikeContainer = document.getElementById('savedBikeContainer');
                            savedBikeContainer.innerHTML = '';

                     
                            const numberMotorStates = {};


                            const checkboxMotorContainer = document.getElementById('motorcyclelist');

                            //tất cả các select box trong div
                            const selectBoxes = checkboxMotorContainer.querySelectorAll('.form-check-select');

                            // Lặp qua từng select box và lấy thông tin nếu giá trị lớn hơn 0
                            selectBoxes.forEach(selectBox => {
                                const quantity = parseInt(selectBox.value);
                                if (quantity > 0) {
                                    const formMotorBox = selectBox.closest('.form-box');
                                    if (formMotorBox) {
                                        // Clone và lưu thông tin giá vào data attribute để tính đúng sau
                                        const priceCurrentEl = formMotorBox.querySelector('.main-price.price-current') || formMotorBox.querySelector('.main-price');
                                        const rawPrice = priceCurrentEl ? (priceCurrentEl.dataset.rawprice || '') : '';
                                        const cloneBox = formMotorBox.cloneNode(true);
                                        cloneBox.dataset.activeprice = rawPrice;
                                        savedBikeContainer.insertAdjacentHTML('beforeend', cloneBox.outerHTML);
                                        numberMotorStates[selectBox.id] = quantity;
                                    }
                                }
                            });

                             // Hiển thị các giá trị đã lưu trong numberMotorStates
                            if (numberMotorStates) {
                                Object.keys(numberMotorStates).forEach(numberId => {
                                    const numberSelect = document.querySelector(`#savedBikeContainer #` + numberId);
                                    if (numberSelect) {
                                        numberSelect.value = numberMotorStates[numberId];
                                        numberSelect.disabled = true;  // Nếu bạn muốn vô hiệu hóa các select box đã được lưu
                                    }
                                });
                            }
                            
                            //Add assecc item have chosen
                            const savedItemsContainer = document.getElementById('savedItemsContainer');
                            savedItemsContainer.innerHTML = ''; // Clear any previous 

                            const numberAccessStates = {};


                            const checkboxContainer = document.getElementById('protection');

                            // Lấy tất cả các checkbox trong div
                            const checkboxes = checkboxContainer.querySelectorAll('.form-check-select');

                            // Lặp qua từng checkbox và lấy thông tin
                            checkboxes.forEach(selectBox => {
                                const quantity = parseInt(selectBox.value);
                                if (quantity > 0) {
                                    const formAccessBox = selectBox.closest('.form-box');
                                    if (formAccessBox) {
                                        savedItemsContainer.insertAdjacentHTML('beforeend', formAccessBox.outerHTML);
                                        numberAccessStates[selectBox.id] = quantity;
                                    }
                                }
                            });
                            if (numberAccessStates) {
                                Object.keys(numberAccessStates).forEach(numberId => {
                                    const numberSelect = document.querySelector(`#savedItemsContainer #` + numberId);
                                    if (numberSelect) {
                                        numberSelect.value = numberAccessStates[numberId];
                                        numberSelect.disabled = true;  // Nếu bạn muốn vô hiệu hóa các select box đã được lưu
                                    }
                                });
                            }
                            

                          
                            
                            formData = {
                                first_name: document.getElementById('first_name').value,
                                last_name: document.getElementById('last_name').value,
                                email: document.getElementById('email').value,
                                phonenumber: document.getElementById('phonenumber').value,
                                address: document.getElementById('address').value,                           
                                dob: document.getElementById('dob').value,                          
                                gender: document.querySelector('input[name="gender"]:checked') ? document.querySelector('input[name="gender"]:checked').value : '',
                                identityCard : document.getElementById("identityCard").value,
                                issuedon : document.getElementById("issuedon").value,
                                expdate : document.getElementById("expdate").value                              
                            };

                            if (formData) {
                                document.getElementById('firstnametext').textContent = formData.first_name;
                                document.getElementById('lastnametext').textContent = formData.last_name;
                                document.getElementById('emailaddresstext').textContent = formData.email;
                                document.getElementById('phonetext').textContent = formData.phonenumber;
                                document.getElementById('addresstext').textContent = formData.address;                         
                                document.getElementById('birthdaytext').textContent = formData.dob;    
                                document.getElementById('gendertext').textContent = formData.gender;
                                document.getElementById('identityCardtext').textContent = formData.identityCard;
                                document.getElementById('issuedontext').textContent = formData.issuedon;   
                                document.getElementById('expdatetext').textContent = formData.expdate;   
                            }
                            // Thêm tiêu đề h4 và dữ liệu số lượng với giá tiền vào div cụ thể trong item-container
                            buildStep5Table();
                        }

                        // Hàm toàn cục: có thể gọi lại bất kỳ lúc nào (VD: sau khi áp voucher)
                        window.buildStep5Table = function() {
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
                            const  savedBikeCal = document.querySelectorAll('#savedBikeContainer .form-box');
                            savedBikeCal.forEach(formBox => { 
                                 const selects = formBox.querySelector('.form-check-select');
                                 const title = formBox.querySelector('h4') ? formBox.querySelector('h4').textContent.trim() : '?';
                                 const quantity = parseInt(selects ? selects.value : 0, 10) || 0;

                                 // Quantity là số ngày chênh lệch giữa ngày trả và ngày pickup
                                 const quantityDay = Math.max(1, Math.ceil(differenceInDays)); // Đảm bảo quantity ít nhất là 1

                                 // Động chọn giá dựa trên số ngày thuê
                                 let price = 0;
                                 let priceLabelDesc = "Ngày";
                                 if (quantityDay >= 30) {
                                     const priceEl = formBox.querySelector('.price-month');
                                     if (priceEl) price = parseInt(priceEl.dataset.rawprice, 10) || 0;
                                     priceLabelDesc = "Tháng (Ưu đãi)";
                                 } else if (quantityDay >= 7) {
                                     const priceEl = formBox.querySelector('.price-week');
                                     if (priceEl) price = parseInt(priceEl.dataset.rawprice, 10) || 0;
                                     priceLabelDesc = "Tuần (Ưu đãi)";
                                 } else {
                                     const priceEl = formBox.querySelector('.price-day');
                                     if (priceEl) price = parseInt(priceEl.dataset.rawprice, 10) || 0;
                                     priceLabelDesc = "Ngày";
                                 }

                                 // Fallback nếu không tìm thấy thẻ giá
                                 if (price === 0) {
                                     const activePrice = formBox.dataset.activeprice;
                                     if (activePrice && activePrice !== '') price = parseInt(activePrice, 10) || 0;
                                 }

                                 // Tính tổng giá
                                 const totalPrice = quantityDay * price * quantity;
                                 totalAmount += totalPrice;

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
                                 // Lấy nội dung từ thẻ h4 và data-rawprice
                                 const selects = formBox.querySelector('.form-check-select');
                                 const title = formBox.querySelector('h4') ? formBox.querySelector('h4').textContent.trim() : '?';
                                 const quantity = parseInt(selects ? selects.value : 0, 10) || 0;
                                 let price = 0;

                                 // Đọc raw price từ data attribute (chính xác nhất)
                                 const rawPriceAttr = selects ? selects.dataset.rawprice : null;
                                 if (rawPriceAttr && rawPriceAttr !== '0') {
                                     price = parseInt(rawPriceAttr, 10) || 0;
                                 } else {
                                     const priceLabel = formBox.querySelector('label[data-rawprice]');
                                     if (priceLabel) price = parseInt(priceLabel.dataset.rawprice, 10) || 0;
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
                                        <td style="padding: 16px 10px; text-align: right; color: #555; font-size: 14px; font-weight: 500;">₫` + price.toLocaleString() + `</td>
                                        <td style="padding: 16px 10px; text-align: right; color: #555; font-size: 15px; font-weight: bold;">₫` + totalPrice.toLocaleString() + `</td>
                                    </tr>
                                 `;
                            });

                            tableHtml += `
                                        </tbody>
                                    </table>
                            `;

                            // Tính phí giao nhận (3km đầu miễn phí, từ km 4 tính 5k/km)
                            const distanceMap = {
                                "Tại cửa hàng SmartRide - 254 Nguyễn Văn Linh, Thạc Gián, Thanh Khê, Đà Nẵng": 0,
                                "Ga Đà Nẵng - Số 202 đường Hải Phòng": 0,
                                "Bệnh viện Đà Nẵng - 124 Hải Phòng": 1,
                                "Chợ Hàn - 119 Trần Phú": 2,
                                "Phố đi bộ Bạch Đằng - Bạch Đằng": 2,
                                "Sân bay Quốc tế Đà Nẵng - 132 Phan Đình Phùng": 3,
                                "Cầu Rồng - Trần Hưng Đạo": 3,
                                "Vincom Plaza - 910A Ngô Quyền": 4,
                                "Lotte Mart - 6 Nại Nam": 5,
                                "Bến xe Trung tâm - 33 Tôn Đức Thắng": 6,
                                "Ngũ Hành Sơn - Huyền Trân Công Chúa": 12,
                                "Your own address": 8 // Mặc định 8km cho địa chỉ tự nhập
                            };

                            let pickupLoc = document.getElementById('pickuplocation') ? document.getElementById('pickuplocation').value : '';
                            let returnLoc = document.getElementById('returnlocation') ? document.getElementById('returnlocation').value : '';
                            
                            let distPickup = 0;
                            if (distanceMap[pickupLoc] === undefined) {
                                let datasetDist = document.getElementById('custom_pickup_input').dataset.dist;
                                distPickup = datasetDist ? parseFloat(datasetDist) : (pickupLoc ? 8 : 0);
                            } else {
                                distPickup = distanceMap[pickupLoc];
                            }
                            
                            let distReturn = 0;
                            if (distanceMap[returnLoc] === undefined) {
                                let datasetDist = document.getElementById('custom_return_input').dataset.dist;
                                distReturn = datasetDist ? parseFloat(datasetDist) : (returnLoc ? 8 : 0);
                            } else {
                                distReturn = distanceMap[returnLoc];
                            }
                            
                            // Tổng khoảng cách cần giao + nhận (chỉ tính 1 chiều đi từ cửa hàng)
                            let totalDistance = parseFloat((distPickup + distReturn).toFixed(1));
                            
                            // Công thức: 3km đầu Free. Từ km 4: 5k/km.
                            let deliveryFee = 0;
                            if (totalDistance > 3) {
                                deliveryFee = Math.ceil(totalDistance - 3) * 5000;
                            }
                            window.calculatedDeliveryFee = deliveryFee;
                            
                            // Cộng phí giao xe vào tổng
                            totalAmount += deliveryFee;

                            // Apply voucher discount if any
                            const appliedDiscount = parseInt(document.getElementById('applied-discount').value) || 0;
                            const finalAmount = Math.max(0, totalAmount - appliedDiscount);

                            let totalFooterHtml = '';
                            // Tính % cọc theo gói thuê
                            const rentalDaysForDeposit = Math.max(1, Math.ceil(differenceInDays));
                            let depositRate, depositPlanLabel;
                            if (rentalDaysForDeposit >= 30) {
                                depositRate = 0.20; // 20% cho thuê theo tháng
                                depositPlanLabel = 'theo tháng';
                            } else if (rentalDaysForDeposit >= 7) {
                                depositRate = 0.30; // 30% cho thuê theo tuần
                                depositPlanLabel = 'theo tuần';
                            } else {
                                depositRate = 0.50; // 50% cho thuê theo ngày
                                depositPlanLabel = 'theo ngày';
                            }
                            const depositPercent = Math.round(depositRate * 100);
                            const depositAmount = Math.round(finalAmount * depositRate);

                            // Hiển thị dòng Phí giao xe nếu có
                            let deliveryHtml = '';
                            if (totalDistance > 0) {
                                if (deliveryFee === 0) {
                                    deliveryHtml = `
                                        <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:6px;">
                                            <span style="font-size:14px; color:#6b7280; font-weight:500;"><i class="fas fa-motorcycle" style="color:#6b7280; font-size:12px; margin-right:4px;"></i> Phí giao/nhận xe (` + totalDistance + `km):</span>
                                            <span style="font-size:15px; color:#16a34a; font-weight:700;">Miễn phí</span>
                                        </div>
                                    `;
                                } else {
                                    deliveryHtml = `
                                        <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:6px;">
                                            <span style="font-size:14px; color:#6b7280; font-weight:500;"><i class="fas fa-motorcycle" style="color:#6b7280; font-size:12px; margin-right:4px;"></i> Phí giao/nhận xe (` + totalDistance + `km):</span>
                                            <span style="font-size:15px; color:#333; font-weight:600;">₫` + deliveryFee.toLocaleString() + `</span>
                                        </div>
                                    `;
                                }
                            }

                            if (appliedDiscount > 0) {
                                // Giá gốc gạch ngang + dòng giảm + giá sau giảm
                                totalFooterHtml = `
                                    <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:10px; padding-top:10px; border-top:2px solid #e0c87a;">
                                        <h4 style="margin:0; font-size:16px; color:#888;">Tạm tính:</h4>
                                        <span style="font-size:18px; color:#aaa; text-decoration:line-through; font-weight:600;">₫` + (totalAmount - deliveryFee).toLocaleString() + `</span>
                                    </div>
                                    ` + deliveryHtml + `
                                    <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:6px;">
                                        <span style="font-size:14px; color:#16a34a; font-weight:600;">🎉 Voucher giảm:</span>
                                        <span style="font-size:15px; color:#16a34a; font-weight:700;">-₫` + appliedDiscount.toLocaleString() + `</span>
                                    </div>
                                    <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:10px; padding-top:10px; border-top:1px dashed #e0c87a;">
                                        <h4 style="margin:0; font-size:16px; color:#333; font-weight:600;">Tổng thanh toán:</h4>
                                        <h4 id="true-total-amount" style="margin:0; font-size:16px; color:#333; font-weight:600;">₫` + finalAmount.toLocaleString('vi-VN') + `</h4>
                                    </div>
                                    <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:10px; padding-top:10px; border-top:2px solid #b59349;">
                                        <div style="margin:0;">
                                            <h4 style="margin:0 0 4px 0; font-size:17px; color:#333; font-weight:700;">Thanh toán trước (` + depositPercent + `% ` + depositPlanLabel + `):</h4>
                                            <span style="font-size:12px; color:#92400e; font-weight:500; background:#fef3c7; border:1px solid #f59e0b; border-radius:4px; padding:2px 7px; display:inline-block;">💵 Hoặc thanh toán <b>100%</b> bằng Tiền mặt khi nhận xe</span>
                                        </div>
                                        <h2 id="dataInput" data-amount="` + depositAmount + `" style="margin:0; font-size:26px; color:#b59349; font-weight:700;">₫` + depositAmount.toLocaleString('vi-VN') + `</h2>
                                    </div>
                                `;
                            } else {
                                totalFooterHtml = `
                                    <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:10px; padding-top:10px; border-top:1px dashed #e0c87a;">
                                        <h4 style="margin:0; font-size:16px; color:#888;">Tạm tính:</h4>
                                        <span style="font-size:16px; color:#333; font-weight:600;">₫` + (totalAmount - deliveryFee).toLocaleString() + `</span>
                                    </div>
                                    ` + deliveryHtml + `
                                    <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:10px; padding-top:10px; border-top:1px dashed #e0c87a;">
                                        <h4 style="margin:0; font-size:16px; color:#333; font-weight:600;">Tổng thanh toán:</h4>
                                        <h4 id="true-total-amount" style="margin:0; font-size:16px; color:#333; font-weight:600;">₫` + finalAmount.toLocaleString('vi-VN') + `</h4>
                                    </div>
                                    <div style="display:flex; justify-content:space-between; width:100%; align-items:center; margin-top:10px; padding-top:10px; border-top:2px solid #b59349;">
                                        <div style="margin:0;">
                                            <h4 style="margin:0 0 4px 0; font-size:17px; color:#333; font-weight:700;">Thanh toán trước (` + depositPercent + `% ` + depositPlanLabel + `):</h4>
                                            <span style="font-size:12px; color:#92400e; font-weight:500; background:#fef3c7; border:1px solid #f59e0b; border-radius:4px; padding:2px 7px; display:inline-block;">💵 Hoặc thanh toán <b>100%</b> bằng Tiền mặt khi nhận xe</span>
                                        </div>
                                        <h2 id="dataInput" data-amount="` + depositAmount + `" style="margin:0; font-size:26px; color:#b59349; font-weight:700;">₫` + depositAmount.toLocaleString('vi-VN') + `</h2>
                                    </div>
                                `;
                            }

                            tableHtml += totalFooterHtml + `</div>`; // close wrapper div
                            
                            formBoxTotal.innerHTML = tableHtml;
                        }

                        function toggleNextButton() {
                               const checkbox =document.getElementById('daily-checkbox-term');
                               if (checkbox.checked) {
                                   nextButton.style.pointerEvents = 'auto';
                                   nextButton.style.color = '';
                                   nextButton.style.background = ''; nextButton.style.opacity = '1';
                               } else {
                                   nextButton.style.pointerEvents = 'none';
                                   nextButton.style.background = ''; nextButton.style.opacity = '0.5';
                                   nextButton.style.color = '';
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
                
                // Function to format date to YYYY-MM-DD
                const formatDate = (date) => {
                    const d = new Date(date);
                    let month = '' + (d.getMonth() + 1);
                    let day = '' + d.getDate();
                    const year = d.getFullYear();

                    if (month.length < 2) month = '0' + month;
                    if (day.length < 2) day = '0' + day;

                    return [year, month, day].join('-');
                };
                
                const pickupdate = requiredFields[0];
                const returndate = requiredFields[2];
                // Set the min attribute for pickupdate
                const today = new Date();
                // today.setDate(today.getDate() + 1); // Minimum pick-up date is tomorrow
                pickupdate.min = formatDate(today);
                returndate.min = formatDate(today);
                
                pickupdate.addEventListener('change', () => {
                    const pickupdateValue = new Date(pickupdate.value);
                    pickupdateValue.setDate(pickupdateValue.getDate() + 1); // Minimum return date is one day after pick-up date
                    returndate.min = formatDate(pickupdateValue);

                    // Nếu ngày trả đang nhỏ hơn ngày nhận + 1 thì tự điền lại ngày trả (KHÔNG đụng ngày nhận)
                    if (returndate.value && new Date(returndate.value) < new Date(returndate.min)) {
                        returndate.value = formatDate(pickupdateValue);
                        returndate.dispatchEvent(new Event('change'));
                    }
                });
                
                // Không tự đổi ngày nhận khi người dùng sửa ngày trả — để tránh confuse
                returndate.addEventListener('change', () => {
                    // Chỉ cảnh báo nếu ngày trả trước ngày nhận, không tự đổi ngày nhận
                    if (returndate.value && pickupdate.value && new Date(returndate.value) <= new Date(pickupdate.value)) {
                        const afterPickup = new Date(pickupdate.value);
                        afterPickup.setDate(afterPickup.getDate() + 1);
                        returndate.value = formatDate(afterPickup);
                    }
                });

                // Initialize the values if they are empty
                if (!pickupdate.value) {
                    pickupdate.value = formatDate(today);
                }

                if (!returndate.value) {
                    const defaultReturnDate = new Date(pickupdate.value);
                    defaultReturnDate.setDate(defaultReturnDate.getDate() + 1);
                    returndate.value = formatDate(defaultReturnDate);
                }
                
                function checkFields() {
                    var nextButton = document.querySelector('.wizard .actions a[href="#next"]');
                    const allFieldsFilled = requiredFields.every(field => field.value.trim() !== '');
                    if (allFieldsFilled) {
                        nextButton.style.pointerEvents = 'auto';
                        nextButton.style.color = '';
                        nextButton.style.background = ''; nextButton.style.opacity = '1';
                    } else {
                        nextButton.style.pointerEvents = 'none';
                        nextButton.style.background = ''; nextButton.style.opacity = '0.5';
                        nextButton.style.color = '';

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
                    field.addEventListener('change', checkFields);
                });
                
               
                // Initial check in case some fields are pre-filled
                checkFields();
                
                // Image preview for CCCD/CMND
                document.querySelectorAll('input[type="file"][name^="image"]').forEach(fileInput => {
                    fileInput.addEventListener('click', function() {
                        if (fileInput.files && fileInput.files.length > 0) {
                            fileInput._prevFile = fileInput.files[0];
                        }
                    });

                    fileInput.addEventListener('change', function(event) {
                        if (!fileInput.files || fileInput.files.length === 0) {
                            if (fileInput._isManualClear) {
                                fileInput._prevFile = null;
                                fileInput._isManualClear = false;
                            } else if (fileInput._prevFile) {
                                // User clicked Cancel, restore old file
                                try {
                                    const dt = new DataTransfer();
                                    dt.items.add(fileInput._prevFile);
                                    fileInput.files = dt.files;
                                } catch (e) { console.error("DataTransfer error", e); }
                            }
                        }

                        const file = fileInput.files[0];
                        const wrapper = fileInput.closest('.upload-card-wrapper');
                        const card = wrapper.querySelector('.upload-card');
                        const cardTitle = card ? card.querySelector('.upload-title') : null;
                        const cardSubtitle = card ? card.querySelector('.upload-subtitle') : null;
                        const cardIcon = card ? card.querySelector('i') : null;
                        const dynamicPreviewContainer = wrapper.querySelector('.image-preview-container:not(.existing-image)');
                        const existingPreviewContainer = wrapper.querySelector('.existing-image');

                        if (file) {
                            fileInput._prevFile = file;
                            // Mark card as uploaded (green state)
                            if (card) card.classList.add('uploaded');
                            if (cardIcon) { cardIcon.className = 'bi bi-check-circle-fill'; }
                            if (cardTitle) cardTitle.textContent = '✓ Đã chọn: ' + file.name.substring(0, 20) + (file.name.length > 20 ? '...' : '');
                            if (cardSubtitle) cardSubtitle.textContent = 'Nhấn để thay đổi ảnh';

                            const reader = new FileReader();
                            reader.onload = function(e) {
                                if (dynamicPreviewContainer) {
                                    const img = dynamicPreviewContainer.querySelector('.img-preview');
                                    img.src = e.target.result;
                                    dynamicPreviewContainer.style.display = 'flex';
                                    dynamicPreviewContainer.style.position = 'relative';
                                    
                                    // Add click to view fullscreen
                                    img.style.cursor = 'zoom-in';
                                    img.onclick = function(ev) {
                                        ev.stopPropagation();
                                        ev.preventDefault();
                                        if (typeof Swal !== 'undefined') {
                                            Swal.fire({
                                                imageUrl: img.src,
                                                imageAlt: 'Preview',
                                                width: 'auto',
                                                showConfirmButton: false,
                                                showCloseButton: true,
                                                padding: '1em',
                                                background: 'transparent',
                                                backdrop: 'rgba(0,0,0,0.8)'
                                            });
                                        }
                                    };
                                    
                                    // Add clear button if not exists
                                    let clearBtn = dynamicPreviewContainer.querySelector('.clear-btn');
                                    if (!clearBtn) {
                                        clearBtn = document.createElement('button');
                                        clearBtn.className = 'clear-btn';
                                        clearBtn.innerHTML = '&times;';
                                        clearBtn.type = 'button';
                                        clearBtn.title = 'Xóa ảnh';
                                        clearBtn.style.position = 'absolute';
                                        clearBtn.style.top = '-10px';
                                        clearBtn.style.right = '-10px';
                                        clearBtn.style.background = '#dc2626';
                                        clearBtn.style.color = 'white';
                                        clearBtn.style.border = 'none';
                                        clearBtn.style.borderRadius = '50%';
                                        clearBtn.style.width = '24px';
                                        clearBtn.style.height = '24px';
                                        clearBtn.style.lineHeight = '1';
                                        clearBtn.style.cursor = 'pointer';
                                        clearBtn.style.boxShadow = '0 2px 4px rgba(0,0,0,0.2)';
                                        clearBtn.style.display = 'flex';
                                        clearBtn.style.alignItems = 'center';
                                        clearBtn.style.justifyContent = 'center';
                                        clearBtn.style.fontSize = '18px';
                                        clearBtn.style.fontWeight = 'bold';
                                        clearBtn.style.zIndex = '10';
                                        
                                        clearBtn.onclick = function(ev) {
                                            ev.stopPropagation();
                                            ev.preventDefault();
                                            fileInput._isManualClear = true;
                                            fileInput.value = '';
                                            fileInput.dispatchEvent(new Event('change'));
                                        };
                                        dynamicPreviewContainer.appendChild(clearBtn);
                                    }
                                }
                                if (existingPreviewContainer) {
                                    existingPreviewContainer.style.display = 'none';
                                }
                            };
                            reader.readAsDataURL(file);
                        } else {
                            if (fileInput._isManualClear) {
                                fileInput._isManualClear = false;
                                fileInput._prevFile = null;
                            } else if (fileInput._prevFile) {
                                const dt = new DataTransfer();
                                dt.items.add(fileInput._prevFile);
                                fileInput.files = dt.files;
                                return;
                            }
                            // Reset card state
                            if (card) card.classList.remove('uploaded');
                            if (cardIcon) { cardIcon.className = fileInput.name === 'imageFront' ? 'bi bi-person-vcard' : 'bi bi-credit-card-2-back'; }
                            if (cardTitle) cardTitle.textContent = (fileInput.name === 'imageFront' ? 'Mặt trước CCCD/CMND' : 'Mặt sau CCCD/CMND');
                            if (cardSubtitle) cardSubtitle.textContent = 'Nhấn để tải ảnh lên';
                            if (dynamicPreviewContainer) dynamicPreviewContainer.style.display = 'none';
                            if (existingPreviewContainer) existingPreviewContainer.style.display = 'flex';
                        }
                    });
                });
                
                // Add event listeners to validate form on image change
                const frontInputsAll = document.querySelectorAll('input[name="imageFront"]');
                const backInputsAll = document.querySelectorAll('input[name="imageBack"]');
                frontInputsAll.forEach(input => input.addEventListener('change', validateForm));
                backInputsAll.forEach(input => input.addEventListener('change', validateForm));
                
                // Add zoom capability to all existing images
                document.querySelectorAll('.existing-image .img-preview').forEach(function(img) {
                    img.style.cursor = 'zoom-in';
                    img.onclick = function(ev) {
                        ev.stopPropagation();
                        ev.preventDefault();
                        if (typeof Swal !== 'undefined') {
                            Swal.fire({
                                imageUrl: img.src,
                                imageAlt: 'Preview',
                                width: 'auto',
                                showConfirmButton: false,
                                showCloseButton: true,
                                padding: '1em',
                                background: 'transparent',
                                backdrop: 'rgba(0,0,0,0.8)'
                            });
                        }
                    };
                });
                
            });
            
            document.addEventListener('DOMContentLoaded', () => {
                
                storedFormData = {
                        pickupdate: document.getElementById('pickupdate').value,                             
                        returndate: document.getElementById('returndate').value                    
                    };
                const pickupDateText = storedFormData.pickupdate;
                const returnDateText = storedFormData.returndate;
                
                
                // Chuyển các chuỗi ngày thành đối tượng Date
                const pickupDate = new Date(pickupDateText);
                const returnDate = new Date(returnDateText);
                
                console.log(pickupDate);
                console.log(returnDateText);
                
                // Tính số ngày chênh lệch
                const differenceInTime = returnDate.getTime() - pickupDate.getTime();
                const differenceInDays = differenceInTime / (1000 * 3600 * 24);
                
                
                
            });
            
            function validateIdentityCard() {
                const identityCard = document.getElementById('identityCard');
                return identityCard.value.length === 12;
            }
            
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
                const identityCardValid = validateIdentityCard();
                
                let filesValid = true;
                const custIdEl = document.getElementById('customerId');
                if (custIdEl && custIdEl.textContent.trim() === 'Not') {
                    const frontFile = document.getElementById('imageFront');
                    const backFile = document.getElementById('imageBack');
                    filesValid = (frontFile && frontFile.files.length > 0) && (backFile && backFile.files.length > 0);
                }
                
                var nextButton = document.querySelector('.wizard .actions a[href="#next"]');
                if (allFieldsFilled && identityCardValid && filesValid) {
                    nextButton.disabled = false;
                    nextButton.style.pointerEvents = 'auto';
                    nextButton.style.color = '';
                    nextButton.style.background = ''; nextButton.style.opacity = '1';
                } else {
                    nextButton.disabled = true;
                    nextButton.style.pointerEvents = 'none';
                    nextButton.style.background = ''; nextButton.style.opacity = '0.5';
                    nextButton.style.color = '';
                    
                    const currentStepIndex = 3;
                    const steps = document.querySelectorAll('.wizard ul[role="tablist"] li');

                    steps.forEach((step, index) => {

                        if (index > currentStepIndex) {
                            step.classList.remove('done');
                            step.classList.add('disabled');
                        }
                    });
                }
            }

            $("#motorcyclelist").on("change", ".form-check-select", function() {
               toggleBikeNextButton();
            });
            
           

            function updateSelectedBikesBanner() {
                const pickupInput = document.getElementById('pickupdate').value;
                const returnInput = document.getElementById('returndate').value;
                let activeBadgeText = "";
                if (pickupInput && returnInput) {
                    const start = new Date(pickupInput);
                    const end = new Date(returnInput);
                    const differenceInDays = Math.abs(end - start) / (1000 * 3600 * 24);
                    var quantityDay = Math.max(1, Math.ceil(differenceInDays));
                    if(quantityDay >= 30) {
                        activeBadgeText = " (Gói Tháng)";
                    } else if(quantityDay >= 7) {
                        activeBadgeText = " (Gói Tuần)";
                    }
                }
                
                const selectedBikesText = [];
                const selectBoxes = document.querySelectorAll('#motorcyclelist .form-check-select');
                selectBoxes.forEach(selectBox => {
                    const quantity = parseInt(selectBox.value);
                    if (quantity > 0) {
                        const formMotorBox = selectBox.closest('.form-box');
                        if (formMotorBox) {
                            const bikeName = formMotorBox.querySelector('.motor-name').textContent;
                            selectedBikesText.push(quantity + "x " + bikeName + activeBadgeText);
                        }
                    }
                });
                
                const banner = document.getElementById('selected-bikes-banner');
                const listSpan = document.getElementById('selected-bikes-list');
                if (selectedBikesText.length > 0) {
                    listSpan.textContent = selectedBikesText.join(", ");
                    banner.style.display = 'block';
                } else {
                    banner.style.display = 'none';
                }
            }

            function toggleBikeNextButton() {
                var nextButton = document.querySelector('.wizard .actions a[href="#next"]');
                // Kiểm tra nếu có bất kỳ select box nào có giá trị lớn hơn 0
                var anySelected = $(".form-check-select", "#motorcyclelist").toArray().some(function(select) {
                    return parseInt($(select).val()) > 0;
                });

                // Nếu có ít nhất một select box đã chọn, kích hoạt nút "Next"
                if (anySelected) {
                    nextButton.style.pointerEvents = 'auto';
                    nextButton.style.color = '';
                    nextButton.style.background = ''; nextButton.style.opacity = '1';
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
                    nextButton.style.background = ''; nextButton.style.opacity = '0.5';
                    nextButton.style.color = '';

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
                            
            function incrementQuantity(motorcycleId) {
                var checkbox = document.getElementById('daily-checkbox-' + motorcycleId);
                var quantityInput = document.getElementById('daily-quantity-' + motorcycleId);
                quantityInput.value = parseInt(quantityInput.value) + 1;
                if (!checkbox.checked) {
                    checkbox.checked = true;
                    checkbox.parentElement.style.borderColor = '#28a745';
                }
                toggleBikeNextButton();
            }

            function decrementQuantity(motorcycleId) {
                var checkbox = document.getElementById('daily-checkbox-' + motorcycleId);
                var quantityInput = document.getElementById('daily-quantity-' + motorcycleId);
                if (quantityInput.value > 0) {
                    quantityInput.value = parseInt(quantityInput.value) - 1;
                    if(parseInt(quantityInput.value) === 0){
                        checkbox.checked = false;
                        checkbox.parentElement.style.borderColor = '';
                    }
                }
                toggleBikeNextButton();

            }
            
            function clearQuantity(motorcycleId) {
                var checkbox = document.getElementById('daily-checkbox-' + motorcycleId);
                var quantityInput = document.getElementById('daily-quantity-' + motorcycleId);              
                checkbox.checked = false;
                checkbox.parentElement.style.borderColor = '';
                quantityInput.value = 0;   
                toggleBikeNextButton();
            }
            
            function confirmPaymentMethod() {
            // Xóa thông báo lỗi AI cũ (nếu có) khi người dùng thử lại
            var aiErrBox = document.getElementById('ai-verify-error-box');
            if (aiErrBox) { aiErrBox.innerHTML = ''; aiErrBox.style.display = 'none'; }

            var method = document.querySelector('input[name="payment_method"]:checked').value;
            var dataH2 = document.getElementById('dataInput');
            // Ưu tiên đọc từ data-amount (số nguyên thuần, không bị ảnh hưởng locale)
            // Fallback: parse từ text nếu không có attribute
            var amount = 0;
            if (dataH2) {
                var attrAmt = dataH2.getAttribute('data-amount');
                if (attrAmt && !isNaN(parseInt(attrAmt))) {
                    amount = parseInt(attrAmt);
                } else {
                    amount = parseInt(dataH2.textContent.replace(/[^0-9]/g, '').trim()) || 0;
                }
            }

            var btn = document.querySelector('#payment-method-container button');
            if(btn) {
                btn.innerHTML = 'Đang xử lý...';
                btn.style.opacity = '0.7';
                btn.style.pointerEvents = 'none';
            }

            var onSuccess = function(response) {
                document.getElementById('payment-method-container').style.display = 'none';
                if (method === 'cash') {
                    if (typeof Swal !== 'undefined') {
                        Swal.fire({
                            toast: true,
                            position: 'top-end',
                            icon: 'success',
                            title: 'Đặt xe thành công!',
                            showConfirmButton: false,
                            timer: 2000,
                            timerProgressBar: true
                        });
                    } else {
                        alert('Đặt xe thành công!');
                    }
                    setTimeout(function() {
                        var ctxPath = '${pageContext.request.contextPath}';
                        var bid = (response && response.bookingId) ? response.bookingId : (window._cashBookingId ? window._cashBookingId : '');
                        window.location.href = ctxPath + (ctxPath.endsWith('/') ? '' : '/') + 'bookingHistoryDetail?bookingId=' + bid + '&autoContract=1';
                    }, 2000);
                } else {
                    if (!window._sepayBookingId) window._sepayBookingId = 'BK' + (Date.now() % 100000).toString().padStart(5, '0') + Math.floor(Math.random() * 1000).toString().padStart(3, '0');
                    var bookingId = window._sepayBookingId;
                    
                    var sepaySection = document.getElementById('sepay-payment-section');
                    if (sepaySection) sepaySection.style.display = 'block';
                    
                    var pLabel = document.getElementById('sepay-placeholder');
                    if (pLabel) pLabel.style.display = 'none';
                    
                    document.getElementById('sepay-transfer-note').textContent = bookingId;
                    document.getElementById('sepay-amount-text').textContent = amount.toLocaleString('vi-VN') + ' ₫';
                    
                    var qrUrl = 'https://img.vietqr.io/image/MB-0943515000-compact2.png?amount=' + amount + '&addInfo=' + encodeURIComponent(bookingId) + '&accountName=SMARTRIDE';
                    document.getElementById('sepay-qr-img').src = qrUrl;
                    
                    if (window.sepayInterval) clearInterval(window.sepayInterval);
                    if (window.sepayPollInterval) clearInterval(window.sepayPollInterval);
                    
                    var timeLeft = 10 * 60;
                    var countdownEl = document.getElementById('sepay-countdown');
                    
                    window.sepayInterval = setInterval(function() {
                        timeLeft--;
                        var min = Math.floor(timeLeft / 60);
                        var sec = timeLeft % 60;
                        if (countdownEl) countdownEl.textContent = String(min).padStart(2,'0') + ':' + String(sec).padStart(2,'0');
                        if (timeLeft <= 60 && countdownEl) countdownEl.style.color = '#dc2626';
                        if (timeLeft <= 0) {
                            clearInterval(window.sepayInterval);
                            clearInterval(window.sepayPollInterval);
                            var st = document.getElementById('sepay-status');
                            if (st) { st.innerHTML = '❌ Hết thời gian thanh toán.'; st.style.background = '#fee2e2'; st.style.color = '#dc2626'; }
                        }
                    }, 1000);
                    
                    var ctxPath = '${pageContext.request.contextPath}';
                    window.sepayPollInterval = setInterval(function() {
                        fetch(ctxPath + '/check-payment-status?bookingId=' + bookingId)
                            .then(function(r) { return r.json(); })
                            .then(function(d) {
                                if (d.status === 'paid') {
                                    clearInterval(window.sepayInterval);
                                    clearInterval(window.sepayPollInterval);
                                    var st = document.getElementById('sepay-status');
                                    if (st) { 
                                        st.innerHTML = '✅ Thanh toán thành công! Hệ thống sẽ tự động chuyển hướng...<br><a href="' + ctxPath + '/bookingHistoryDetail?bookingId=' + bookingId + '" style="display:inline-block;margin-top:10px;padding:8px 16px;background:#16a34a;color:#fff;border-radius:4px;text-decoration:none;">Xem đơn hàng ngay</a>'; 
                                        st.style.background = '#dcfce7'; 
                                        st.style.color = '#16a34a'; 
                                    }
                                    
                                    if (typeof Swal !== 'undefined') {
                                        Swal.fire({
                                            toast: true,
                                            position: 'top-end',
                                            icon: 'success',
                                            title: 'Thanh toán thành công!',
                                            showConfirmButton: false,
                                            timer: 3000,
                                            timerProgressBar: true
                                        });
                                    }
                                    
                                    setTimeout(function() { window.location.href = ctxPath + (ctxPath.endsWith('/') ? '' : '/') + 'bookingHistoryDetail?bookingId=' + bookingId + '&autoContract=1'; }, 3000);
                                }
                            }).catch(function() {});
                    }, 5000);
                }
            };

            var onError = function(errMsg, aiErrorData) {
                if(btn) {
                    btn.innerHTML = 'Xác nhận thanh toán';
                    btn.style.opacity = '1';
                    btn.style.pointerEvents = 'auto';
                }
                // Nếu là lỗi AI với chi tiết từng trường
                if (aiErrorData && aiErrorData.fieldErrors && aiErrorData.fieldErrors.length > 0) {
                    var errHtml = '<div style="background:#fff; border:2px solid #dc2626; border-radius:14px; overflow:hidden; margin-top:16px; box-shadow:0 4px 20px rgba(220,38,38,0.15);">';
                    errHtml += '<div style="background:#dc2626; padding:14px 18px; color:#fff; font-weight:800; font-size:15px; display:flex; align-items:center; gap:10px;">';
                    errHtml += '<i class="fas fa-shield-alt"></i> Xác thực CCCD/CMND thất bại</div>';
                    errHtml += '<div style="padding:16px 18px;">';
                    errHtml += '<p style="color:#7f1d1d; font-size:13px; margin:0 0 12px 0; font-weight:600;">Hệ thống AI phát hiện thông tin <strong>không khớp</strong> với ảnh giấy tờ. Vui lòng kiểm tra và sửa lại:</p>';
                    errHtml += '<ul style="margin:0; padding-left:18px; list-style:none;">';
                    aiErrorData.fieldErrors.forEach(function(fe) {
                        errHtml += '<li style="background:#fee2e2; border:1px solid #fca5a5; border-radius:8px; padding:10px 14px; margin-bottom:8px; color:#991b1b; font-size:13px; font-weight:600;">' + fe + '</li>';
                    });
                    errHtml += '</ul>';
                    if (!aiErrorData.idMatch) {
                        errHtml += '<div style="margin-top:10px; padding:10px; background:#fff7ed; border-radius:8px; border:1px solid #fed7aa; color:#9a3412; font-size:12px;"><i class="fas fa-info-circle me-1"></i>Vui lòng kiểm tra lại số CCCD/CMND bạn đã nhập ở bước 4.</div>';
                    }
                    if (!aiErrorData.nameMatch) {
                        errHtml += '<div style="margin-top:8px; padding:10px; background:#fff7ed; border-radius:8px; border:1px solid #fed7aa; color:#9a3412; font-size:12px;"><i class="fas fa-info-circle me-1"></i>Vui lòng kiểm tra lại Họ và tên bạn đã nhập ở bước 4 (kể cả dấu, chính tả).</div>';
                    }
                    if (aiErrorData.doeValid === false) {
                        errHtml += '<div style="margin-top:8px; padding:10px; background:#fff7ed; border-radius:8px; border:1px solid #fed7aa; color:#9a3412; font-size:12px;"><i class="fas fa-calendar-times me-1"></i>CCCD/CMND đã hết hạn. Vui lòng dùng giấy tờ còn hiệu lực.</div>';
                    }
                    errHtml += '</div></div>';

                    // Hiển thị trong phần step 5 thay vì alert popup
                    var aiErrBox = document.getElementById('ai-verify-error-box');
                    if (aiErrBox) {
                        aiErrBox.innerHTML = errHtml;
                        aiErrBox.style.display = 'block';
                        aiErrBox.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    } else if (typeof Swal !== 'undefined') {
                        var listHtml = aiErrorData.fieldErrors.map(function(e) { return '<li style="text-align:left; margin-bottom:6px;">' + e + '</li>'; }).join('');
                        Swal.fire({ icon: 'error', title: 'Xác thực CCCD thất bại', html: '<ul>' + listHtml + '</ul>' });
                    }
                } else {
                    if (typeof Swal !== 'undefined') {
                        var titleStr = aiErrorData && aiErrorData.status === 'error' ? 'Không thể đặt xe' : 'Lỗi';
                        Swal.fire({ 
                            icon: 'error', 
                            title: titleStr, 
                            text: errMsg,
                            showCancelButton: true,
                            confirmButtonText: '<i class="fas fa-undo"></i> Quay lại Bước 2',
                            cancelButtonText: 'Đóng'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                var stepsObj = $('#booking-form').children("div");
                                stepsObj.steps("previous");
                                stepsObj.steps("previous");
                                stepsObj.steps("previous");
                            }
                        });
                    } else {
                        alert('Lỗi: ' + errMsg);
                    }
                }
            };

            if (method === 'cash') {
                if (!window._cashBookingId) {
                    // timestamp 5 ký tự cuối + 3 số random → khớp format backend
                    window._cashBookingId = 'BK' + (Date.now() % 100000).toString().padStart(5, '0') + Math.floor(Math.random() * 1000).toString().padStart(3, '0');
                }
                var bookingId = window._cashBookingId;
                BookingHandler({ action: 'finish', bookingId: bookingId, method: 'CASH', amount: amount, time: formatDateVN() }, onSuccess, onError);
            } else {
                if (!window._sepayBookingId) {
                    // timestamp 5 ký tự cuối + 3 số random → khớp format backend
                    window._sepayBookingId = 'BK' + (Date.now() % 100000).toString().padStart(5, '0') + Math.floor(Math.random() * 1000).toString().padStart(3, '0');
                }
                var bookingId = window._sepayBookingId;
                BookingHandler({ action: 'create_only', bookingId: bookingId, method: 'SEPAY', amount: amount, time: formatDateVN() }, onSuccess, onError);
            }
        }

        window.addEventListener('message', (event) => {
            if (event.data === 'activateOverlay') {
                const overlay = document.getElementById('overlay');
                overlay.classList.add('active');
//                
//                // Thực hiện các hành động cần thiết tại đây, ví dụ: tắt overlay sau 3 giây
//                setTimeout(() => {
//                    overlay.classList.remove('active');
//                }, 30000000);
            }
            if(event.data === 'stopOverlay') {
                const overlay = document.getElementById('overlay');
                overlay.classList.remove('active');
            }
        });
           // Kiểm tra nếu có dữ liệu nào được gửi từ servlet
        function handlePaymentStatus(data) {
            if (data.status === 'success') {
                BookingHandler(data);
            }
        }
        
        window.addEventListener('storage', function(event) {
            console.log(event.key);
            if (event.key === 'payment_status') {
                var paymentStatus = JSON.parse(event.newValue);
                handlePaymentStatus(paymentStatus);
            }
        });

        
        function collectAccessoryData() {
            const accessories = [];
            const savedItemsContainer = document.getElementById('savedItemsContainer');
            // Lặp qua tất cả các phần tử có class "form-box"
            savedItemsContainer.querySelectorAll('.form-box').forEach(box => {
                const select = box.querySelector('.form-check-select');
                const quantity = parseInt(select.value);
                const id = select.id.split('-').pop();  // Lấy accessoryId từ id của select box
                const priceLabel = box.querySelector('.form-check .checkbox-container label');
                const priceText = priceLabel ? priceLabel.textContent : '0';
                const price = priceText.includes('Free') ? 0 : parseInt(priceText.replace(/[^0-9]/g, ''), 10);
                // Nếu số lượng lớn hơn 0, thêm vào danh sách
                if (quantity > 0) {
                    accessories.push({
                        id: id,
                        quantity: quantity.toString(),
                        price: parseInt(price)
                    });
                }
            });

            return accessories;
        }
        function formatDateVN() {
            var d = new Date();
            var yyyy = d.getFullYear();
            var mm = String(d.getMonth() + 1).padStart(2, '0');
            var dd = String(d.getDate()).padStart(2, '0');
            var hh = String(d.getHours()).padStart(2, '0');
            var mi = String(d.getMinutes()).padStart(2, '0');
            var ss = String(d.getSeconds()).padStart(2, '0');
            return yyyy + mm + dd + hh + mi + ss;
        }

        function simulatePaymentSuccess() {
            var bookingId = document.getElementById('sepay-transfer-note').textContent.trim();
            var amountText = document.getElementById('sepay-amount-text').textContent;
            var amount = amountText ? amountText.replace(/[^0-9]/g, '') : '0';
            
            if (!bookingId || bookingId === 'BK...') {
                alert("Chưa có mã đơn hàng hợp lệ!");
                return;
            }
            
            var btn = event.currentTarget || event.srcElement;
            if (btn) {
                btn.innerHTML = "Đang giả lập...";
                btn.style.opacity = "1";
            }
            
            var ctxPath = '${pageContext.request.contextPath}';
            fetch(ctxPath + '/sepay-webhook', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'bookingId=' + encodeURIComponent(bookingId) + '&amount=' + encodeURIComponent(amount)
            })
            .then(r => r.json())
            .then(data => {
                if(data.success) {
                    if (btn) btn.innerHTML = "Đã gửi Webhook!";
                    console.log("Giả lập webhook thành công!");
                } else {
                    if (btn) btn.innerHTML = "Lỗi giả lập!";
                }
            })
            .catch(e => {
                console.error("Lỗi:", e);
                if (btn) btn.innerHTML = "Lỗi kết nối!";
            });
        }

        function closeQrPayment() {
            if (window.sepayInterval) clearInterval(window.sepayInterval);
            if (window.sepayPollInterval) clearInterval(window.sepayPollInterval);
            var ctxPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1));
            window.location.href = ctxPath + '/bookingHistory?status=pending';
        }

        function BookingHandler(dataReturn, onSuccess, onError) {
            var formData = new FormData();
            
//            alert("Thanh toán thành công với mã giao dịch: " + data.txnRef);
             // Lấy các giá trị từ các thẻ <p>
            var pickupDate = document.getElementById("pickupdatetext").textContent.trim();
            var pickupTime = document.getElementById("pickuptimetext").textContent.trim();
            var pickupLocation = document.getElementById("pickuploctext").textContent.trim();
            var returnLocation = document.getElementById("returnloctext").textContent.trim();
            var returnDate = document.getElementById("returndatetext").textContent.trim();
            var returnTime = document.getElementById("returntimetext").textContent.trim();
            var accountId = document.getElementById("accountId").textContent.trim();
            var fistname = document.getElementById("firstnametext").textContent.trim();
            var lastname = document.getElementById("lastnametext").textContent.trim();
            var phone = document.getElementById("phonetext").textContent.trim();
            var email = document.getElementById("emailaddresstext").textContent.trim();
            var address = document.getElementById("addresstext").textContent.trim();
            var dob = document.getElementById("birthdaytext").textContent.trim();
            var gender = document.getElementById("gendertext").textContent.trim();
            var customerId = document.getElementById("customerId").textContent.trim();
            var identityCard = document.getElementById("identityCard").value;
            var issuedon = document.getElementById("issuedon").value;
            var expdate = document.getElementById("expdate").value;
            var totalEl = document.getElementById("true-total-amount");
            var total = totalEl ? totalEl.textContent.trim() : document.getElementById("dataInput").textContent.trim();
            
            
            // Chuyển các chuỗi ngày thành đối tượng Date
            const pickupD = new Date(pickupDate);
            const returnD = new Date(returnDate);

            // Tính số ngày chênh lệch
            const differenceInTime = returnD.getTime() - pickupD.getTime();
            const quantityDay = differenceInTime / (1000 * 3600 * 24);
            
            const bikeDetails = [];

            const checkboxMotorContainer = document.getElementById('savedBikeContainer');

            // tất cả các select box trong div
            const selectBoxes = checkboxMotorContainer.querySelectorAll('.form-check-select');

            // Lặp qua từng select box và lấy thông tin nếu giá trị lớn hơn 0
            selectBoxes.forEach(selectBox => {
                const quantity = parseInt(selectBox.value);
                if (quantity > 0) {
                    const formMotorBox = selectBox.closest('.form-box');
                    if (formMotorBox) {
                        const bikeName = formMotorBox.querySelector('.motor-name').textContent;
                        const bikePrice = formMotorBox.querySelector('.price-current').textContent;
                        const price = parseInt(bikePrice.replace(/[^0-9]/g, ''), 10);
                        const totalPrice = quantityDay * price;
//                        const price = priceLabel ? priceLabel.textContent.replace(/[^0-9]/g, '') : 0;
                        // Lưu từng chiếc xe theo số lượng
                        for (let i = 0; i < quantity; i++) {                                                                                    
                            bikeDetails.push({ name: bikeName, price: totalPrice.toString() });
                        }
                    }
                }
            });
            const accessoriesData = collectAccessoryData();

            console.log(bikeDetails);
            console.log(accessoriesData);
            console.log(fistname);
            let deliveryFee = window.calculatedDeliveryFee || 0;
            
            if (deliveryFee > 0) {
                pickupLocation += " (Phí giao xe: " + deliveryFee + "đ)";
            }

            var data = {
                pickupDate: pickupDate + " " + pickupTime,
                pickupLocation: pickupLocation,
                returnLocation: returnLocation,
                returnDate: returnDate + " " + returnTime,
                accountId: accountId,          
                fistname : fistname,
                lastname : lastname, 
                phone : phone,
                email : email,
                address: address,
                dob: dob,
                gender: gender,
                customerId : customerId,
                identityCard : identityCard,
                issuedon : issuedon,
                expdate : expdate,
                bikeDetails: bikeDetails,
                accessories: accessoriesData,
                total : total,
                amount: dataReturn && dataReturn.amount ? dataReturn.amount : parseInt(document.getElementById("dataInput").textContent.replace(/[^0-9]/g, '').trim()) || 0,
                paymentMethod: dataReturn && dataReturn.method ? dataReturn.method : 'SEPAY',
                paymenttime: dataReturn && dataReturn.time ? dataReturn.time : formatDateVN(),
                voucherId: document.getElementById('applied-voucher-id').value || '0'
            };
            
            if (dataReturn && dataReturn.action) {
                formData.append("action", dataReturn.action);
            }
            if (dataReturn && dataReturn.bookingId) {
                data.bookingId = dataReturn.bookingId;
            }
            
             // Convert object to JSON and append to formData
            formData.append("jsonData", JSON.stringify(data));

            // Add files to formData
            var frontInputs = document.querySelectorAll('input[name="imageFront"]');
            for (var i = 0; i < frontInputs.length; i++) {
                if (frontInputs[i].files && frontInputs[i].files.length > 0) {
                    formData.append("fileFront", frontInputs[i].files[0]);
                    break;
                }
            }
            var backInputs = document.querySelectorAll('input[name="imageBack"]');
            for (var i = 0; i < backInputs.length; i++) {
                if (backInputs[i].files && backInputs[i].files.length > 0) {
                    formData.append("fileBack", backInputs[i].files[0]);
                    break;
                }
            }
            // Gửi dữ liệu tới servlet bằng AJAX
            $.ajax({
                type: "POST",
                url: dataReturn && dataReturn.action ? "bookinghandler?action=" + dataReturn.action : "bookinghandler",
//                data: JSON.stringify(data),              
//                contentType: "application/json",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    console.log("Data sent successfully:", response);
                    if (typeof response === 'string') {
                        try {
                            response = JSON.parse(response);
                        } catch (e) {
                            console.error("Lỗi parse JSON:", e, response);
                            if (typeof onError === 'function') onError("Lỗi hệ thống: Phản hồi không hợp lệ.", response);
                            return;
                        }
                    }
                    if (response && (response.status === 'error' || response.status === 'ai_error')) {
                        if (typeof onError === 'function') onError(response.message || "Lỗi khi xử lý", response);
                        return;
                    }
                    if (typeof onSuccess === 'function') {
                        onSuccess(response);
                    } else if (!dataReturn || dataReturn.action !== 'create_only') {
                        window.location.href = 'home';
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error sending data:", error);
                    if (typeof onError === 'function') onError("Lỗi kết nối máy chủ");
                }
            });
        }

        // Nếu dữ liệu đã có sẵn trong LocalStorage khi trang được tải lại
        var existingStatus = localStorage.getItem('payment_status');
        if (existingStatus) {
            handlePaymentStatus(JSON.parse(existingStatus));
            localStorage.removeItem('payment_status');
        }
        
        
       

        // ===== VOUCHER FUNCTIONS =====
        function applyVoucher() {
            const code = document.getElementById('voucher-code-input').value.trim();
            const msgEl = document.getElementById('voucher-msg');
            if (!code) {
                msgEl.style.color = '#dc2626';
                msgEl.textContent = 'Vui lòng nhập mã voucher';
                return;
            }
            msgEl.style.color = '#6b7280';
            msgEl.textContent = 'Đang kiểm tra...';

            fetch('applyVoucher', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'code=' + encodeURIComponent(code)
            })
            .then(r => r.json())
            .then(data => {
                if (data.valid) {
                    document.getElementById('applied-voucher-id').value = data.voucherId;
                    document.getElementById('applied-discount').value = data.discount;
                    msgEl.style.color = '#16a34a';
                    msgEl.innerHTML = '✅ Áp dụng thành công! Giảm <strong>₫' + Number(data.discount).toLocaleString('vi-VN') + '</strong>'
                        + (data.description ? ' — ' + data.description : '');

                    // Lock voucher: 1 đơn hàng chỉ 1 voucher
                    const btn = document.getElementById('apply-voucher-btn');
                    const inp = document.getElementById('voucher-code-input');
                    if (btn) {
                        btn.textContent = '✓ Đã áp dụng';
                        btn.style.background = '#16a34a';
                        btn.disabled = true;
                        btn.style.opacity = '0.7';
                        btn.style.cursor = 'not-allowed';
                    }
                    if (inp) {
                        inp.disabled = true;
                        inp.style.background = '#f0fdf4';
                        inp.style.borderColor = '#16a34a';
                    }

                    // Re-render bảng tổng kết để hiện giá gạch ngang + giá mới
                    if (typeof buildStep5Table === 'function') buildStep5Table();
                } else {
                    msgEl.style.color = '#dc2626';
                    msgEl.textContent = '✗ ' + data.message;
                    resetVoucher();
                }
            })
            .catch(() => {
                msgEl.style.color = '#dc2626';
                msgEl.textContent = 'Lỗi kết nối, vui lòng thử lại';
            });
        }

        function resetVoucher() {
            document.getElementById('applied-voucher-id').value = '0';
            document.getElementById('applied-discount').value = '0';
            const btn = document.getElementById('apply-voucher-btn');
            if (btn) {
                btn.textContent = 'Áp dụng';
                btn.style.background = '#b59349';
            }
        }
        </script>
        <iframe id="myI" src="sepay_return.jsp" style="width: 100%; height: 1000px; display:none;"></iframe>
<!--        <link href="https://pay.SePay VietQR.vn/lib/SePay VietQR/SePay VietQR.css" rel="stylesheet" />
        <script src="https://pay.SePay VietQR.vn/lib/SePay VietQR/SePay VietQR.min.js"></script>-->
         
        <!-- Pre-fill from hero booking widget -->
        <script>
        (function() {
            try {
                var startDate = sessionStorage.getItem('hs_startDate');
                var endDate   = sessionStorage.getItem('hs_endDate');
                var pickup    = sessionStorage.getItem('hs_pickup');
                var returnL   = sessionStorage.getItem('hs_returnLoc');
                if (!startDate) return;

                // Fill date fields (split datetime-local → date + time)
                function splitDT(dtStr) {
                    if (!dtStr) return {date:'', time:''};
                    var parts = dtStr.split('T');
                    return { date: parts[0] || '', time: parts[1] ? parts[1].substring(0,5) : '' };
                }
                var sd = splitDT(startDate);
                var ed = splitDT(endDate);

                var pickupDateEl  = document.getElementById('pickupdate');
                var pickupTimeEl  = document.getElementById('pickuptime');
                var returnDateEl  = document.getElementById('returndate');
                var returnTimeEl  = document.getElementById('returntime');
                var pickupLocEl   = document.getElementById('pickuplocation');
                var returnLocEl   = document.getElementById('returnlocation');

                if (pickupDateEl && sd.date) pickupDateEl.value = sd.date;
                if (pickupTimeEl && sd.time) pickupTimeEl.value = sd.time;
                if (returnDateEl && ed.date) returnDateEl.value = ed.date;
                if (returnTimeEl && ed.time) returnTimeEl.value = ed.time;

                // Set location selects (match value or fallback to custom option)
                function setSelectValue(sel, val, type) {
                    if (!sel || !val) return;
                    var found = false;
                    for (var i = 0; i < sel.options.length; i++) {
                        if (sel.options[i].value.toLowerCase().indexOf(val.substring(0,8).toLowerCase()) >= 0) {
                            sel.selectedIndex = i; 
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        for (var j = 0; j < sel.options.length; j++) {
                            if (sel.options[j].text.includes('(tự nhập)')) {
                                sel.selectedIndex = j;
                                break;
                            }
                        }
                        var customInput = document.getElementById('custom_' + type + '_input');
                        if (customInput) {
                            customInput.style.display = 'block';
                            customInput.required = true;
                            customInput.value = val;
                            sel.options[sel.selectedIndex].value = val;
                        }
                    }
                }
                setSelectValue(pickupLocEl, pickup, 'pickup');
                setSelectValue(returnLocEl, returnL, 'return');

                // Clear so it doesn't re-apply on back navigation
                sessionStorage.removeItem('hs_startDate');
                sessionStorage.removeItem('hs_endDate');
                sessionStorage.removeItem('hs_pickup');
                sessionStorage.removeItem('hs_returnLoc');

                // Auto-advance logic has been removed as per user request
                // setTimeout(function() {
                //     var nextBtn = document.querySelector('a[href="#next"]') ||
                //                   document.querySelector('.actions a[href*="next"]') ||
                //                   document.querySelector('.wizard-next-btn') ||
                //                   document.querySelector('[data-action="next"]');
                //     if (nextBtn) nextBtn.click();
                // }, 800);

            } catch(ex) {}
        })();
        </script>

        <script>
        // ===== GÓI TUẦN / THÁNG QUICK SELECT + REAL-TIME PRICING =====
        window.activePackage = null;

        // â”€â”€â”€ Hàm tính giá real-time khi ngày thay đổi â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        window.updatePricingFromDates = function() {
            var pickupInput = document.getElementById('pickupdate');
            var returnInput = document.getElementById('returndate');
            if (!pickupInput || !returnInput || !pickupInput.value || !returnInput.value) return;

            var start = new Date(pickupInput.value);
            var end   = new Date(returnInput.value);
            if (isNaN(start) || isNaN(end) || end <= start) return;

            var diffDays = Math.max(1, Math.ceil((end - start) / (1000 * 60 * 60 * 24)));

            // 1. Cập nhật hiển thị giá ở bước 2 (price-day / price-week / price-month)
            var priceDayEls   = document.querySelectorAll('.price-day');
            var priceWeekEls  = document.querySelectorAll('.price-week');
            var priceMonthEls = document.querySelectorAll('.price-month');

            priceDayEls.forEach(function(el)   { el.style.display = 'none'; el.classList.remove('price-current'); });
            priceWeekEls.forEach(function(el)  { el.style.display = 'none'; el.classList.remove('price-current'); });
            priceMonthEls.forEach(function(el) { el.style.display = 'none'; el.classList.remove('price-current'); });

            if (diffDays >= 30) {
                priceMonthEls.forEach(function(el) { el.style.display = 'inline-block'; el.classList.add('price-current'); });
            } else if (diffDays >= 7) {
                priceWeekEls.forEach(function(el)  { el.style.display = 'inline-block'; el.classList.add('price-current'); });
            } else {
                priceDayEls.forEach(function(el)   { el.style.display = 'inline-block'; el.classList.add('price-current'); });
            }

            // 2. Cập nhật badge nút tuần/tháng
            if (diffDays === 7)       { window.activePackage = 'week';  updateQuickButtonsStyle(7); }
            else if (diffDays === 30) { window.activePackage = 'month'; updateQuickButtonsStyle(30); }
            else                      { window.activePackage = null;    updateQuickButtonsStyle(0); }

            // 3. Rebuild bảng tổng tiền bước 5 nếu đang hiển thị (real-time deposit recalc)
            if (typeof window.buildStep5Table === 'function') {
                var step5El = document.getElementById('form-box-total');
                if (step5El && step5El.closest('.body') && step5El.closest('.body').style.display !== 'none') {
                    window.buildStep5Table();
                }
            }
        };

        // â”€â”€â”€ Quick select ngày â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        function setQuickReturnDate(days, autoEvent) {
            var pickupInput = document.getElementById('pickupdate');
            var returnInput = document.getElementById('returndate');
            if (!pickupInput || !pickupInput.value) {
                alert('Vui lòng chọn Ngày nhận xe trước!');
                return;
            }

            // Toggle tắt nếu click lại nút đang chọn → reset về ngày nhận + 1 (gói ngày)
            if (!autoEvent) {
                var clickedPackage = days === 7 ? 'week' : (days === 30 ? 'month' : null);
                if (window.activePackage === clickedPackage) {
                    window.activePackage = null;
                    updateQuickButtonsStyle(0);
                    // Reset ngày trả về pickup + 1 ngày
                    var resetDate = new Date(pickupInput.value);
                    resetDate.setDate(resetDate.getDate() + 1);
                    var ry = resetDate.getFullYear();
                    var rm = String(resetDate.getMonth() + 1).padStart(2, '0');
                    var rd = String(resetDate.getDate()).padStart(2, '0');
                    returnInput.value = ry + '-' + rm + '-' + rd;
                    returnInput.dispatchEvent(new Event('change'));
                    return;
                } else {
                    window.activePackage = clickedPackage;
                }
            }

            var date = new Date(pickupInput.value);
            date.setDate(date.getDate() + days);
            var yyyy = date.getFullYear();
            var mm = String(date.getMonth() + 1).padStart(2, '0');
            var dd = String(date.getDate()).padStart(2, '0');
            returnInput.value = yyyy + '-' + mm + '-' + dd;
            updateQuickButtonsStyle(days);
            returnInput.dispatchEvent(new Event('change'));
        }

        function updateQuickButtonsStyle(days) {
            var btnWeek  = document.getElementById('btn-quick-week');
            var btnMonth = document.getElementById('btn-quick-month');
            if (btnWeek) {
                btnWeek.style.background = (days === 7)  ? '#b59349' : '#fff';
                btnWeek.style.color      = (days === 7)  ? '#fff'    : '#b59349';
            }
            if (btnMonth) {
                btnMonth.style.background = (days === 30) ? '#b59349' : '#fff';
                btnMonth.style.color      = (days === 30) ? '#fff'    : '#b59349';
            }
        }

        // â”€â”€â”€ Gắn listener real-time vào input ngày â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        function bindPickupListener() {
            var pickupInput = document.getElementById('pickupdate');
            var returnInput = document.getElementById('returndate');
            if (!pickupInput || pickupInput._pkBound) return;
            pickupInput._pkBound = true;

            // Đổi ngày nhận: nếu đang bật gói thì cập nhật ngày trả theo gói, sau đó tính lại giá
            pickupInput.addEventListener('change', function() {
                if (window.activePackage === 'week') {
                    setQuickReturnDate(7, true);
                } else if (window.activePackage === 'month') {
                    setQuickReturnDate(30, true);
                } else {
                    // Không có gói → chỉ recalc giá theo ngày hiện tại
                    window.updatePricingFromDates();
                }
            });

            // Đổi ngày trả: tính lại giá real-time
            if (returnInput) {
                returnInput.addEventListener('change', function() {
                    window.updatePricingFromDates();
                });
            }
        }

        // Gắn listener ngay khi DOM sẵn sàng
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', bindPickupListener);
        } else {
            bindPickupListener();
        }
        </script>

        <script>
        // ===== FIX NÚT BACK TRÌNH DUYỆT =====
        // Thay vì văng ra trang đăng nhập, nhấn Back sẽ lùi 1 bước trong wizard
        (function() {
            // Đẩy state vào history để bẫy sự kiện popstate
            history.pushState({ wizardStep: true }, '', window.location.href);
            window.addEventListener('popstate', function(event) {
                // Tìm nút "Previous" của jQuery Steps và click
                var prevBtn = document.querySelector('.wizard .actions a[href="#previous"]');
                if (prevBtn) {
                    prevBtn.click();
                    // Đẩy lại state để tiếp tục bẫy lần sau
                    history.pushState({ wizardStep: true }, '', window.location.href);
                }
            });
        })();

        // ===== FIX GIÁ TIỀN NaN Ở BƯỚC XÁC NHẬN =====
        // Khi bước xác nhận được hiển thị, tính lại tổng tiền
        document.addEventListener('DOMContentLoaded', function() {
            // Hook vào onStepChanged để recalculate khi vào bước 4 (Xác nhận)
            var origStepChanged = null;
            var checkInterval = setInterval(function() {
                var wizard = $('#signup-form > div');
                if (wizard.length && wizard.data('steps')) {
                    clearInterval(checkInterval);
                    wizard.on('stepChanged', function(event, currentIndex, priorIndex) {
                        if (currentIndex === 4) { // Bước Xác nhận (index 4)
                            recalcTotalOnConfirm();
                        }
                    });
                }
            }, 300);
        });

        function recalcTotalOnConfirm() {
            var pickupDate = document.getElementById('pickupdate') ? document.getElementById('pickupdate').value : '';
            var returnDate = document.getElementById('returndate') ? document.getElementById('returndate').value : '';
            if (!pickupDate || !returnDate) return;

            var start = new Date(pickupDate);
            var end   = new Date(returnDate);
            var diffMs   = Math.abs(end - start);
            var diffDays = Math.max(1, Math.ceil(diffMs / (1000 * 60 * 60 * 24)));

            // Tính tổng xe
            var bikeTotal = 0;
            document.querySelectorAll('#motorcyclelist .form-check-select').forEach(function(sel) {
                var qty = parseInt(sel.value) || 0;
                if (qty > 0) {
                    var box = sel.closest('.form-box');
                    if (box) {
                        // Lấy giá theo gói đang active (tuần/tháng/ngày)
                        var priceEl = null;
                        if (diffDays >= 30)      priceEl = box.querySelector('.price-month');
                        else if (diffDays >= 7)  priceEl = box.querySelector('.price-week');
                        else                     priceEl = box.querySelector('.price-day');
                        if (priceEl) {
                            var priceText = priceEl.textContent.replace(/[^0-9]/g, '');
                            var unitPrice = parseInt(priceText) * 100 || 0;
                            bikeTotal += qty * unitPrice * diffDays;
                        }
                    }
                }
            });

            // Tính tổng phụ kiện
            var accTotal = 0;
            document.querySelectorAll('.accessory-checkbox:checked').forEach(function(cb) {
                var row = cb.closest('tr') || cb.closest('.accessory-row');
                if (row) {
                    var qtyEl    = row.querySelector('.accessory-quantity');
                    var priceEl  = row.querySelector('.accessory-price');
                    if (qtyEl && priceEl) {
                        var qty   = parseInt(qtyEl.value) || 1;
                        var price = parseInt(priceEl.textContent.replace(/[^0-9]/g,'')) * 100 || 0;
                        accTotal += qty * price * diffDays;
                    }
                }
            });

            var total = bikeTotal + accTotal;
            var totalEl = document.getElementById('totaltext');
            var finalTotalInput = document.getElementById('finalTotal');
            var daysTotalInput  = document.getElementById('daysTotal');

            if (totalEl) {
                totalEl.textContent = '₫' + total.toLocaleString('vi-VN');
            }
            if (finalTotalInput) finalTotalInput.value = total;
            if (daysTotalInput)  daysTotalInput.value  = diffDays;
        }
        </script>

        <script>
        // ===== REALTIME BANNER XE ĐÃ CHỌN =====
        function updateBikeBanner() {
            var items = [];
            var selects = document.querySelectorAll('#motorcyclelist .form-check-select');
            selects.forEach(function(sel) {
                var qty = parseInt(sel.value) || 0;
                if (qty > 0) {
                    var box = sel.closest('.form-box');
                    if (box) {
                        var nameEl = box.querySelector('.motor-name');
                        if (nameEl) items.push(qty + ' x ' + nameEl.textContent.trim());
                    }
                }
            });
            var banner = document.getElementById('bike-selection-banner');
            var list   = document.getElementById('bike-selection-list');
            if (banner && list) {
                if (items.length > 0) {
                    list.innerHTML = items.map(function(item) {
                        return '<span style="display:inline-block; padding: 3px 10px; margin-right: 6px; margin-top: 4px; margin-bottom: 4px; background: #fff; border: 1px solid #e0c87a; border-radius: 6px; color: #b59349; font-weight: 600; font-size: 13px; box-shadow: 0 1px 2px rgba(0,0,0,0.02);">' + item + '</span>';
                    }).join('');
                    banner.style.display = 'block';
                } else {
                    banner.style.display = 'none';
                }
            }
        }

        // ===== REALTIME BANNER PHỤ KIỆN ĐÃ CHỌN =====
        function updateAccBanner() {
            var items = [];
            var selects = document.querySelectorAll('#protection .form-check-select');
            selects.forEach(function(sel) {
                var qty = parseInt(sel.value) || 0;
                if (qty > 0) {
                    var box = sel.closest('.form-box');
                    if (box) {
                        var nameEl = box.querySelector('h4');
                        if (nameEl) items.push(qty + ' x ' + nameEl.textContent.trim());
                    }
                }
            });
            var banner = document.getElementById('acc-selection-banner');
            var list   = document.getElementById('acc-selection-list');
            if (banner && list) {
                if (items.length > 0) {
                    list.innerHTML = items.map(function(item) {
                        return '<span style="display:inline-block; padding: 3px 10px; margin-right: 6px; margin-top: 4px; margin-bottom: 4px; background: #fff; border: 1px solid #16a34a; border-radius: 6px; color: #15803d; font-weight: 600; font-size: 13px; box-shadow: 0 1px 2px rgba(0,0,0,0.02);">' + item + '</span>';
                    }).join('');
                    banner.style.display = 'block';
                } else {
                    banner.style.display = 'none';
                }
            }
        }

        // Hook vào các select box để update banner realtime
        $(document).ready(function() {
            // Trigger cập nhật ngay khi load trang để xử lý các xe được pre-select
            updateBikeBanner();
            updateAccBanner();

            // Sử dụng jQuery event delegation để bắt chính xác event khi elements bị re-render bởi jquery-steps
            $(document).on('change', '.form-check-select', function(e) {
                var inMoto = $(this).closest('#motorcyclelist').length > 0;
                var inAcc  = $(this).closest('#protection').length > 0;
                if (inMoto) updateBikeBanner();
                if (inAcc)  updateAccBanner();
            });
        });

        // Voucher được xử lý qua hàm applyVoucher() ở script phía trên (kết nối servlet /applyVoucher → database)
        </script>
    <!-- Select2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        
        <script>
        window.deliveryFee = 0;
        
        function toggleCustomLocation(type) {
            var select = document.getElementById(type + 'location');
            var wrapper = document.getElementById(type + '_custom_wrapper');
            var input = document.getElementById('custom_' + type + '_input');
            if (select.value === 'Your own address') {
                wrapper.style.display = 'block';
                input.required = true;
            } else {
                wrapper.style.display = 'none';
                input.required = false;
                document.getElementById(type + '_distance_info').innerHTML = '';
            }
            recalculateDeliveryFee();
        }
        
        function autoGeolocate(type) {
            if (navigator.geolocation) {
                var btn = event.currentTarget;
                var oldHtml = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                
                navigator.geolocation.getCurrentPosition(function(position) {
                    var lat = position.coords.latitude;
                    var lon = position.coords.longitude;
                    
                    fetch('https://nominatim.openstreetmap.org/reverse?format=json&lat=' + lat + '&lon=' + lon + '&accept-language=vi')
                    .then(response => response.json())
                    .then(data => {
                        btn.innerHTML = oldHtml;
                        var address;
                        if (data && data.display_name) {
                            address = data.display_name.replace(/ Ward/g, '').replace(/ District/g, '');
                        } else {
                            // Fallback: dùng tọa độ khi không lấy được tên địa chỉ
                            address = lat.toFixed(5) + ', ' + lon.toFixed(5);
                        }
                        document.getElementById('custom_' + type + '_input').value = address;
                        updateCustomLocation(type);
                        processDistance(lat, lon, type);
                    })
                    .catch(error => {
                        console.error('Error reverse geocoding:', error);
                        btn.innerHTML = oldHtml;
                        // Fallback: dùng tọa độ thay vì báo lỗi cứng
                        var fallbackAddress = lat.toFixed(5) + ', ' + lon.toFixed(5);
                        document.getElementById('custom_' + type + '_input').value = fallbackAddress;
                        updateCustomLocation(type);
                        processDistance(lat, lon, type);
                    });
                }, function(error) {
                    btn.innerHTML = oldHtml;
                    Swal.fire({icon: 'error', title: 'Lỗi định vị', text: 'Vui lòng cho phép trình duyệt truy cập vị trí của bạn.'});
                }, { timeout: 10000 });
            } else {
                Swal.fire({icon: 'warning', title: 'Không hỗ trợ', text: 'Trình duyệt của bạn không hỗ trợ định vị.'});
            }
        }
        
        function calcDistance(type) {
            var address = document.getElementById('custom_' + type + '_input').value;
            if (!address || address.trim() === '') return;
            
            var info = document.getElementById(type + '_distance_info');
            info.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang tính khoảng cách...';
            
            fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(address + ', Đà Nẵng, Việt Nam') + '&accept-language=vi&limit=1')
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data && data.length > 0) {
                    processDistance(parseFloat(data[0].lat), parseFloat(data[0].lon), type);
                } else {
                    info.innerHTML = '<span style="color:#ef4444;"><i class="fas fa-exclamation-circle"></i> Không tìm thấy địa chỉ này, vui lòng thử lại.</span>';
                    var inputEl = document.getElementById('custom_' + type + '_input');
                    if (inputEl) inputEl.dataset.dist = "8";
                    if (type === 'pickup') window._pickupFee = 25000;
                    else window._returnFee = 25000;
                    recalculateDeliveryFee();
                    updateTotal();
                }
            })
            .catch(function() {
                info.innerHTML = '<span style="color:#ef4444;"><i class="fas fa-exclamation-circle"></i> Lỗi tính khoảng cách.</span>';
                var inputEl = document.getElementById('custom_' + type + '_input');
                if (inputEl) inputEl.dataset.dist = "8";
                if (type === 'pickup') window._pickupFee = 25000;
                else window._returnFee = 25000;
                recalculateDeliveryFee();
                updateTotal();
            });
        }

        // Tọa độ cửa hàng SmartRide
        var SHOP_LAT = 16.0609, SHOP_LON = 108.2057;

        function haversineKm(lat1, lon1, lat2, lon2) {
            var R = 6371;
            var dLat = (lat2 - lat1) * Math.PI / 180;
            var dLon = (lon2 - lon1) * Math.PI / 180;
            var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                    Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                    Math.sin(dLon/2) * Math.sin(dLon/2);
            return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        }

        // Lưu phí giao từng loại
        window._pickupFee  = 0;
        window._returnFee  = 0;

        function processDistance(lat, lon, type) {
            var km  = haversineKm(SHOP_LAT, SHOP_LON, lat, lon);
            var fee = 0;
            if (km > 20) {
                // Không nhận đơn
                var info = document.getElementById(type + '_distance_info');
                info.innerHTML = '<span style="color:#ef4444;"><i class="fas fa-ban"></i> Khoảng cách <strong>' + km.toFixed(1) + ' km</strong> – vượt quá 20km, hệ thống không nhận đơn.</span>';
                if (type === 'pickup') window._pickupFee = 0;
                else window._returnFee = 0;
                recalculateDeliveryFee();
                return;
            }
            if (km > 3) {
                fee = Math.ceil(km - 3) * 5000;
            }
            var feeStr = fee > 0 ? fee.toLocaleString('vi-VN') + 'đ' : 'Miễn phí';
            var color  = fee > 0 ? '#d97706' : '#16a34a';
            var icon   = fee > 0 ? 'fa-motorcycle' : 'fa-check-circle';

            var info = document.getElementById(type + '_distance_info');
            info.innerHTML =
                '<span style="color:' + color + '; font-weight:600;">'+
                '<i class="fas ' + icon + '"></i> '+
                'Khoảng cách: <strong>' + km.toFixed(1) + ' km</strong>. '+
                'Phụ phí giao: <strong>' + feeStr + '</strong></span>';

            // Lưu vào dataset để updateTotal() tính lại giá trị chính xác
            var inputEl = document.getElementById('custom_' + type + '_input');
            if (inputEl) {
                inputEl.dataset.dist = km.toFixed(1);
            }

            if (type === 'pickup') window._pickupFee = fee;
            else window._returnFee = fee;
            recalculateDeliveryFee();
            updateTotal();
        }

        function recalculateDeliveryFee() {
            window.deliveryFee = (window._pickupFee || 0) + (window._returnFee || 0);
            // Cập nhật hiển thị tổng phụ phí nếu có element
            var el = document.getElementById('delivery-fee-display');
            if (el) {
                el.textContent = window.deliveryFee > 0
                    ? window.deliveryFee.toLocaleString('vi-VN') + 'đ'
                    : 'Miễn phí';
            }
        }


        </script>
    <!-- CONTRACT SAMPLE MODAL -->
    <div id="contract-sample-modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.7); z-index:10000; align-items:center; justify-content:center; backdrop-filter:blur(4px);" onclick="if(event.target===this)this.style.display='none'">
        <div style="background:#f1f5f9; width:95%; max-width:850px; height:90vh; border-radius:8px; display:flex; flex-direction:column; box-shadow:0 10px 40px rgba(0,0,0,0.5); overflow:hidden;">
            
            <!-- Header Toolbar -->
            <div style="background:#333639; padding:12px 20px; display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #222;">
                <div style="display:flex; align-items:center; gap:12px; color:#fff;">
                    <i class="fas fa-file-pdf" style="color:#ef4444; font-size:20px;"></i>
                    <span style="font-family:sans-serif; font-size:14px; letter-spacing:0.5px;">Hop_dong_thue_xe_SmartRide.pdf</span>
                </div>
                <button onclick="document.getElementById('contract-sample-modal').style.display='none'" style="background:transparent; border:none; color:#a1a1aa; cursor:pointer; font-size:20px; transition:color 0.2s;" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='#a1a1aa'"><i class="fas fa-times"></i></button>
            </div>

            <!-- PDF Viewer Body -->
            <div style="flex-grow:1; overflow-y:auto; padding:30px; display:flex; justify-content:center; align-items:flex-start; background:#525659; scrollbar-width:thin;">
                <!-- A4 Paper -->
                <div style="background:#fff; width:100%; max-width:700px; padding:50px 60px; box-shadow:0 5px 15px rgba(0,0,0,0.2); font-family:'Times New Roman', Times, serif; color:#000; line-height:1.5;">
                    
                    <!-- National Header -->
                    <div style="text-align:center; margin-bottom:30px;">
                        <div style="font-weight:bold; font-size:16px;">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</div>
                        <div style="font-weight:bold; font-size:15px; text-decoration:underline;">Độc lập - Tự do - Hạnh phúc</div>
                    </div>

                    <!-- Contract Title -->
                    <div style="text-align:center; margin-bottom:30px;">
                        <h2 style="font-size:22px; font-weight:bold; margin:0;">HỢP ĐỒNG THUÊ XE MÁY</h2>
                        <div style="font-style:italic; font-size:14px;">(Bản điện tử / Hợp đồng mẫu)</div>
                    </div>

                    <div style="font-size:15px; text-align:justify;">
                        <p style="margin-bottom:15px;">Hôm nay, ngày <span id="modal-date">...</span>, tại Đà Nẵng, chúng tôi gồm có:</p>

                        <div style="font-weight:bold; margin-top:20px; font-size:16px;">BÊN A (BÊN CHO THUÊ): CỬA HÀNG XE MÁY SMARTRIDE</div>
                        <ul style="list-style-type:none; padding-left:0; margin-top:10px; margin-bottom:20px;">
                            <li>- <b>Địa chỉ:</b> 254 Nguyễn Văn Linh, Thạc Gián, Thanh Khê, Đà Nẵng</li>
                            <li>- <b>Điện thoại:</b> 0987.654.321</li>
                            <li>- <b>Đại diện:</b> Ông Nguyễn Văn A (Quản lý cửa hàng)</li>
                        </ul>

                        <div style="font-weight:bold; font-size:16px;">BÊN B (BÊN THUÊ XE): <span style="text-transform:uppercase;" id="modal-customer-name">[TÊN KHÁCH HÀNG]</span></div>
                        <ul style="list-style-type:none; padding-left:0; margin-top:10px; margin-bottom:20px;">
                            <li>- <b>CCCD/CMND/Hộ chiếu số:</b> <span id="modal-customer-cccd">[SỐ CCCD]</span></li>
                            <li>- <b>Điện thoại liên hệ:</b> <span id="modal-customer-phone">[SỐ ĐIỆN THOẠI]</span></li>
                        </ul>

                        <p>Sau khi bàn bạc, hai bên thống nhất ký kết Hợp đồng thuê xe máy với các điều khoản sau đây:</p>

                        <p style="font-weight:bold; margin-top:20px; margin-bottom:5px;">ĐIỀU 1: ĐỐI TƯỢNG HỢP ĐỒNG</p>
                        <p>Bên A đồng ý cho Bên B thuê xe máy. Chi tiết về loại xe, biển số, đơn giá và thời gian thuê được ghi nhận chi tiết tại Hóa đơn điện tử hoặc Biên bản bàn giao xe đính kèm.</p>

                        <p style="font-weight:bold; margin-top:20px; margin-bottom:5px;">ĐIỀU 2: TRÁCH NHIỆM BÊN A</p>
                        <p>1. Giao xe đúng loại, đúng thời gian và địa điểm đã thỏa thuận.<br>
                        2. Cung cấp đầy đủ giấy tờ xe (bản sao công chứng) và 02 mũ bảo hiểm.<br>
                        3. Hỗ trợ cứu hộ 24/7 nếu xe gặp sự cố kỹ thuật không do lỗi của Bên B.</p>

                        <p style="font-weight:bold; margin-top:20px; margin-bottom:5px;">ĐIỀU 3: TRÁCH NHIỆM BÊN B</p>
                        <p>1. Sử dụng xe đúng mục đích, chấp hành nghiêm chỉnh luật giao thông đường bộ.<br>
                        2. Không tự ý lái xe ra khỏi phạm vi bán kính 50km tính từ cửa hàng khi chưa được sự đồng ý của Bên A.<br>
                        3. Không tự ý cầm cố, thế chấp, giao xe cho bên thứ ba.<br>
                        4. Chịu trách nhiệm bồi thường 100% chi phí sửa chữa theo báo giá chính hãng nếu xảy ra va quệt, hư hỏng do lỗi cố ý hoặc vô ý của Bên B.</p>

                        <p style="font-weight:bold; margin-top:20px; margin-bottom:5px;">ĐIỀU 4: ĐIỀU KHOẢN CHUNG</p>
                        <p>Hợp đồng điện tử này có giá trị pháp lý tương đương bản giấy. Việc Bên B xác nhận thanh toán đặt cọc qua website SmartRide được xem là Bên B đã đọc, hiểu rõ và đồng ý ký kết toàn bộ các điều khoản của Hợp đồng này.</p>

                        <!-- Signatures -->
                        <div style="display:flex; justify-content:space-between; margin-top:50px; text-align:center;">
                            <div style="width:45%;">
                                <div style="font-weight:bold;">ĐẠI DIỆN BÊN B</div>
                                <div style="font-style:italic; font-size:13px; color:#555;">(Xác nhận điện tử qua hệ thống)</div>
                                <div style="margin-top:60px; font-weight:bold; text-transform:uppercase;" id="modal-customer-sign">[TÊN KHÁCH HÀNG]</div>
                            </div>
                            <div style="width:45%;">
                                <div style="font-weight:bold;">ĐẠI DIỆN BÊN A</div>
                                <div style="font-style:italic; font-size:13px; color:#555;">(Đã ký đóng dấu)</div>
                                <div style="margin-top:60px; font-weight:bold;">SMARTRIDE</div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            
            <!-- Notice bar at bottom -->
            <div style="background:#fffbeb; padding:12px 20px; border-top:1px solid #fde68a; display:flex; justify-content:space-between; align-items:center;">
                <div style="font-size:13px; color:#92400e; display:flex; align-items:center; gap:8px;">
                    <i class="fas fa-info-circle"></i> Bản hợp đồng chính thức sẽ được gửi kèm chi tiết xe vào Email sau khi bạn thanh toán.
                </div>
                <button onclick="document.getElementById('contract-sample-modal').style.display='none'" style="background:#b59349; color:#fff; border:none; padding:8px 24px; border-radius:6px; font-weight:bold; cursor:pointer;">Đóng</button>
            </div>

        </div>
    </div>

    <script>
        function openContractModal() {
            // Get values from form
            let fName = document.getElementById('first_name') ? document.getElementById('first_name').value.trim() : '';
            let lName = document.getElementById('last_name') ? document.getElementById('last_name').value.trim() : '';
            let fullName = (fName + ' ' + lName).trim() || '[CHƯA NHẬP TÊN]';
            
            let phone = document.getElementById('phonenumber') ? document.getElementById('phonenumber').value.trim() : '';
            phone = phone || '[CHƯA NHẬP SĐT]';
            
            let cccd = document.getElementById('identityCard') ? document.getElementById('identityCard').value.trim() : '';
            cccd = cccd || '[CHƯA NHẬP CCCD]';

            // Set current date
            let today = new Date();
            let dateStr = today.getDate() + ' tháng ' + (today.getMonth() + 1) + ' năm ' + today.getFullYear();

            // Populate modal
            document.getElementById('modal-customer-name').innerText = fullName;
            document.getElementById('modal-customer-sign').innerText = fullName;
            document.getElementById('modal-customer-phone').innerText = phone;
            document.getElementById('modal-customer-cccd').innerText = cccd;
            document.getElementById('modal-date').innerText = dateStr;

            // Show modal
            document.getElementById('contract-sample-modal').style.display = 'flex';
        }

</body>

</html>


<!-- Minor update 5 -->

<!-- Minor update 7 -->

<!-- Minor update 27 -->

<!-- fix patch 12 -->

<!-- fix patch 20 -->

<!-- fix patch 39 -->

<!-- fix patch 40 -->

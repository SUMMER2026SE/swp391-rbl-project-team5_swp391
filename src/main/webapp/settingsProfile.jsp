<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Quản lý thông tin cá nhân</title>
        <!-- Tailwind CSS -->
        <link href="https://www.loopple.com/css/vendor/tailwind.min.css" rel="stylesheet">
        <link href="https://www.loopple.com/css/tailwind/app.css?v=1.0.0" rel="stylesheet">
        <link href="" id="google-font-url" rel="stylesheet">
        <!-- CSS Links -->
        <link href="css/sidebarProfile.css" rel="stylesheet">

        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <link href="https://demos.creative-tim.com/soft-ui-dashboard-tailwind/assets/css/nucleo-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/Loopple/loopple-public-assets@main/soft-ui-dashboard-tailwind/css/soft-ui-dashboard-tailwind.css">
    </head>
    <style>
        .security-item:hover {
            background-color: lightgrey;
        }

        /* Simplified Sidebar */
        .sidebar-item {
            padding: 0.75rem 1rem !important;
            margin: 0.2rem 1rem !important;
            display: flex !important;
            align-items: center !important;
            border-radius: 0.5rem !important;
            transition: all 0.2s ease !important;
            color: #1e293b !important; /* Dark Slate-800 for absolute contrast */
            font-weight: 700 !important; /* Bold, highly readable */
            font-size: 0.95rem !important; /* Slightly larger */
            text-decoration: none !important;
        }
        .sidebar-item:hover {
            background-color: #f1f5f9 !important;
            color: #0f172a !important; /* Slate-900 */
        }
        .sidebar-item.active {
            background-color: #fdf8eb !important; /* very light gold */
            color: #854d0e !important; /* Deep Golden Amber for maximum readability */
            font-weight: 800 !important;
        }
        .icon-box {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            margin-right: 1rem !important;
            width: 32px !important;
            height: 32px !important;
            border-radius: 0.5rem !important;
            background-color: #e2e8f0 !important; /* Deeper gray for contrast */
            color: #334155 !important; /* Slate-700 */
            transition: all 0.2s ease !important;
        }
        .sidebar-item.active .icon-box {
            background-color: #b59349 !important;
            color: #ffffff !important;
        }
        .nav-text {
            font-size: 0.95rem !important;
        }
        .sidebar-heading {
            padding-left: 1.5rem !important;
            font-weight: 800 !important;
            text-transform: uppercase !important;
            font-size: 0.8rem !important; /* Slightly larger */
            color: #475569 !important; /* Slate-600 */
            margin-top: 1.5rem !important;
            margin-bottom: 0.5rem !important;
            letter-spacing: 0.05em !important;
        }
    </style>
    <jsp:include page="/includes/customer/header.jsp" />
    <jsp:include page="/includes/customer/navbar.jsp" />
    <body class="  font-body " data-framework="tailwind">
        <div class="builder-container builder-container-preview font-body">
            <jsp:include page="/includes/customer/sidebarProfile.jsp">
                <jsp:param name="activePage" value="security"/>
            </jsp:include>
            <div class="ease-soft-in-out xl:ml-68.5 relative h-full max-h-screen rounded-xl transition-all duration-200"
                 id="panel">
                <div class="w-full px-6 py-6 mx-auto drop-zone loopple-min-height-78vh text-slate-500">
                    <div style="padding-top: 8%; width: 96%;" class="pt-8 mx-auto removable">
                        <div class="flex flex-wrap -mx-3 drop-zone">
                            <div class="w-full max-w-full px-3 mb-4">
                                <div class="relative flex flex-col h-full min-w-0 break-words bg-white border-0 shadow-soft-xl rounded-2xl bg-clip-border overflow-hidden">
                                    
                                    <!-- Main Content container -->
                                    <div class="p-8">
                                        <div class="mb-8 pb-6 border-b border-slate-100">
                                            <h3 class="text-2xl font-bold text-slate-800">Mật khẩu & Bảo mật</h3>
                                            <p class="text-slate-500 font-medium mt-1">Thiết lập mật khẩu và bảo vệ an toàn cho tài khoản của bạn</p>
                                            <c:if test="${not empty requestScope.mess}">
                                                <p class="text-emerald-500 text-sm mt-2"><i class="fas fa-check-circle mr-1"></i> ${mess}</p>
                                            </c:if>
                                            <c:if test="${not empty requestScope.errorProfile}">
                                                <p class="text-rose-500 text-sm mt-2"><i class="fas fa-exclamation-circle mr-1"></i> ${requestScope.errorProfile}</p>
                                            </c:if>
                                        </div>

                                        <!-- Security Actions -->
                                        <div>
                                            <a href="changepassword" style="text-decoration:none;" class="flex items-center justify-between p-4 bg-slate-50 hover:bg-slate-100 border border-slate-200 transition-colors rounded-xl cursor-pointer">
                                                <div class="flex items-center space-x-4">
                                                    <div style="background-color: #e2e8f0; color: #475569; width: 48px; height: 48px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                                                        <i class="fas fa-key text-lg"></i>
                                                    </div>
                                                    <div>
                                                        <p class="text-lg font-bold text-slate-800 mb-0">Đổi mật khẩu</p>
                                                        <p class="text-sm text-slate-500 mb-0">Cập nhật mật khẩu định kỳ để duy trì tính bảo mật</p>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- Footer -->

        <script src="https://demos.creative-tim.com/soft-ui-dashboard-tailwind/assets/js/plugins/chartjs.min.js"></script>
        <script src="https://demos.creative-tim.com/soft-ui-dashboard-tailwind/assets/js/plugins/perfect-scrollbar.min.js"
        async=""></script>
        <script async="" defer="" src="https://buttons.github.io/buttons.js"></script>
        <script
            src="https://cdn.jsdelivr.net/gh/Loopple/loopple-public-assets@main/soft-ui-dashboard-tailwind/js/soft-ui-dashboard-tailwind.js"
        async=""></script>
            </div> <!-- #panel -->
        </div> <!-- .builder-container -->
    </body>
</html>

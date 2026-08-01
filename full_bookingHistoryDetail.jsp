<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="utf-8">
        <title>Chi tiß║┐t lß╗ïch sß╗¡ thu├¬ xe</title>
        <!-- Tailwind CSS & Google Fonts -->
        <link href="https://www.loopple.com/css/vendor/tailwind.min.css" rel="stylesheet">
        <link href="https://www.loopple.com/css/tailwind/app.css?v=1.0.0" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebarProfile.css?v=3" rel="stylesheet">
        <style>
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(8px); }
                to { opacity: 1; transform: translateY(0); }
            }
            .animate-fadeIn {
                animation: fadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    
    <c:if test="${param.layout != 'modal'}">
        <jsp:include page="/includes/customer/header.jsp" />
        <jsp:include page="/includes/customer/navbar.jsp" />
    </c:if>
    
    <body class="font-body" data-framework="tailwind">
        <!-- CSS Links -->
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <link href="https://demos.creative-tim.com/soft-ui-dashboard-tailwind/assets/css/nucleo-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/Loopple/loopple-public-assets@main/soft-ui-dashboard-tailwind/css/soft-ui-dashboard-tailwind.css">
        
        <div class="${param.layout == 'modal' ? '' : 'font-body'} font-body">
            <c:if test="${param.layout != 'modal'}">
                <jsp:include page="/includes/customer/sidebarProfile.jsp">
                    <jsp:param name="activePage" value="bookingHistoryDetail"/>
                </jsp:include>
            </c:if>

            <!-- Main Panel Content -->
            <div class="${param.layout == 'modal' ? 'w-full' : 'ease-soft-in-out xl:ml-68.5'} relative h-full rounded-xl transition-all duration-200" id="panel">
                <div class="${param.layout == 'modal' ? 'p-0' : 'w-full max-w-6xl px-6 py-6 mx-auto min-h-[78vh]'} text-gray-500">
                    <div class="relative flex flex-col flex-auto min-w-0 ${param.layout == 'modal' ? 'p-0 shadow-none' : 'p-6 mx-auto mt-28 shadow-blur border-0 bg-white/80'} w-full overflow-hidden break-words rounded-2xl bg-clip-border mb-4 animate-fadeIn">
                        
                        <!-- Header -->
                        <div class="flex flex-wrap items-center justify-between gap-4 border-b border-gray-100 pb-5 mb-6">
                            <div>
                                <h3 class="text-2xl font-bold text-gray-800 flex items-center">
                                    <i class="fas fa-file-invoice mr-2.5 text-yellow-500"></i> Chi tiß║┐t Booking
                                </h3>
                                <p class="text-gray-400 text-sm font-medium mt-1">Xem th├┤ng tin ─æß║╖t xe, hß║ín trß║ú v├á thß╗▒c hiß╗çn thao t├íc gia hß║ín hoß║╖c hß╗ºy ─æ╞ín.</p>
                            </div>
                            <c:choose>
                                <c:when test="${statusBooking == 'Chß╗¥ x├íc nhß║¡n' && not empty payment}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold bg-green-50 text-green-700 border border-green-200">
                                        <i class="fas fa-check-circle"></i> ─É├ú cß╗ìc: <fmt:formatNumber value="${payment.paymentAmount}" pattern="#,##0" />─æ
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold ${statusBooking == 'Chß╗¥ x├íc nhß║¡n' ? 'bg-yellow-50 text-yellow-600' : (statusBooking == '─É├ú x├íc nhß║¡n' ? 'bg-green-50 text-green-600' : 'bg-red-50 text-red-600')}">
                                        <span class="w-1.5 h-1.5 rounded-full ${statusBooking == 'Chß╗¥ x├íc nhß║¡n' ? 'bg-yellow-500' : (statusBooking == '─É├ú x├íc nhß║¡n' ? 'bg-green-500' : 'bg-red-500')}"></span>
                                        ${booking.statusBooking}
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Success / Fail Messages -->
                        <c:if test="${not empty sessionScope.cancelSuccess}">
                            <div class="mb-6 p-4 bg-green-50 border border-green-100 text-green-600 rounded-xl text-sm font-semibold flex items-center gap-2">
                                <i class="fas fa-check-circle text-base"></i>
                                <span>${sessionScope.cancelSuccess}</span>
                            </div>
                            <c:remove var="cancelSuccess" scope="session"/>
                        </c:if>
                        <c:if test="${not empty sessionScope.cancelFail}">
                            <div class="mb-6 p-4 bg-red-50 border border-red-100 text-red-600 rounded-xl text-sm font-semibold flex items-center gap-2">
                                <i class="fas fa-exclamation-circle text-base"></i>
                                <span>${sessionScope.cancelFail}</span>
                            </div>
                            <c:remove var="cancelFail" scope="session"/>
                        </c:if>

                        <!-- Date Variables Parsing -->
                        <c:set var="bookingDate" value="${booking.bookingDate}" />
                        <c:set var="bookingYear" value="${fn:substring(bookingDate, 0, 4)}" />
                        <c:set var="bookingMonth" value="${fn:substring(bookingDate, 5, 7)}" />
                        <c:set var="bookingDay" value="${fn:substring(bookingDate, 8, 10)}" />
                        <c:set var="bookingHour" value="${fn:substring(bookingDate, 11, 13)}" />
                        <c:set var="bookingMinute" value="${fn:substring(bookingDate, 14, 16)}" />

                        <c:set var="startDate" value="${booking.startDate}" />
                        <c:set var="startYear" value="${fn:substring(startDate, 0, 4)}" />
                        <c:set var="startMonth" value="${fn:substring(startDate, 5, 7)}" />
                        <c:set var="startDay" value="${fn:substring(startDate, 8, 10)}" />
                        <c:set var="startHour" value="${fn:substring(startDate, 11, 13)}" />
                        <c:set var="startMinute" value="${fn:substring(startDate, 14, 16)}" />

                        <c:set var="endDate" value="${booking.endDate}" />
                        <c:set var="endYear" value="${fn:substring(endDate, 0, 4)}" />
                        <c:set var="endMonth" value="${fn:substring(endDate, 5, 7)}" />
                        <c:set var="endDay" value="${fn:substring(endDate, 8, 10)}" />
                        <c:set var="endHour" value="${fn:substring(endDate, 11, 13)}" />
                        <c:set var="endMinute" value="${fn:substring(endDate, 14, 16)}" />

                        <!-- Content Grid: Premium Layout -->
                        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
                            
                            <!-- Column 1: Lß╗ïch tr├¼nh -->
                            <div class="flex flex-col h-full">
                                <!-- Card: Lß╗ïch tr├¼nh -->
                                <div class="bg-white border border-gray-100 shadow-sm rounded-2xl p-6 relative overflow-hidden flex-1">
                                    <div class="absolute top-0 right-0 w-48 h-48 bg-yellow-50 rounded-bl-full -z-0 opacity-50"></div>
                                    <h4 class="text-lg font-extrabold text-gray-800 mb-5 flex items-center relative z-10">
                                        <i class="fas fa-route text-yellow-500 mr-3 text-xl"></i> Lß╗ïch tr├¼nh thu├¬ xe
                                    </h4>
                                    
                                    <div class="flex items-center justify-between relative z-10 mb-6 bg-gray-50/50 p-4 rounded-xl border border-gray-100">
                                        <!-- Start Date -->
                                        <div class="text-center w-5/12">
                                            <p class="text-xs text-gray-400 font-bold uppercase tracking-wider mb-2">Nhß║¡n xe</p>
                                            <div class="bg-white border border-gray-200 shadow-sm rounded-xl py-3 px-2">
                                                <p class="text-yellow-600 font-black text-xl mb-1">${startHour}:${startMinute}</p>
                                                <p class="text-gray-600 text-xs font-bold">${startDay}-${startMonth}-${startYear}</p>
                                            </div>
                                        </div>
                                        
                                        <!-- Divider -->
                                        <div class="w-2/12 flex flex-col items-center justify-center opacity-60">
                                            <div class="w-full h-[2px] bg-gray-300 border-dashed border-b-2"></div>
                                            <i class="fas fa-motorcycle text-gray-400 text-lg bg-gray-50 px-2 -mt-3.5"></i>
                                        </div>
                                        
                                        <!-- End Date -->
                                        <div class="text-center w-5/12">
                                            <p class="text-xs text-gray-400 font-bold uppercase tracking-wider mb-2">Trß║ú xe</p>
                                            <div class="bg-white border border-gray-200 shadow-sm rounded-xl py-3 px-2">
                                                <p class="text-green-600 font-black text-xl mb-1">${endHour}:${endMinute}</p>
                                                <p class="text-gray-600 text-xs font-bold">${endDay}-${endMonth}-${endYear}</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="space-y-5 relative z-10">
                                        <div class="flex items-start gap-4">
                                            <div class="w-10 h-10 rounded-full bg-yellow-50 flex items-center justify-center shrink-0 mt-0.5">
                                                <i class="fas fa-map-marker-alt text-yellow-500 text-lg"></i>
                                            </div>
                                            <div>
                                                <p class="text-xs text-gray-400 font-bold uppercase mb-1">Nhß║¡n xe</p>
                                                <p class="text-base text-gray-800 font-bold leading-relaxed mb-0.5">${booking.deliveryLocation}</p>
                                                <p class="text-sm text-yellow-600 font-semibold"><i class="far fa-clock mr-1"></i> ${booking.startDate}</p>
                                            </div>
                                        </div>
                                        <div class="flex items-start gap-4">
                                            <div class="w-10 h-10 rounded-full bg-green-50 flex items-center justify-center shrink-0 mt-0.5">
                                                <i class="fas fa-flag-checkered text-green-500 text-lg"></i>
                                            </div>
                                            <div>
                                                <p class="text-xs text-gray-400 font-bold uppercase mb-1">Trß║ú xe</p>
                                                <p class="text-base text-gray-800 font-bold leading-relaxed mb-0.5">${booking.returnedLocation}</p>
                                                <p class="text-sm text-green-600 font-semibold"><i class="far fa-clock mr-1"></i> ${booking.endDate}</p>
                                            </div>
                                        </div>
                                        <c:if test="${statusBooking == '─É├ú x├íc nhß║¡n'}">
                                            <div class="mt-6 pt-5 border-t border-gray-100 flex items-center gap-4">
                                                <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center shrink-0">
                                                    <i class="fas fa-truck text-blue-500 text-lg"></i>
                                                </div>
                                                <div>
                                                    <p class="text-xs text-gray-400 font-bold uppercase mb-1">Trß║íng th├íi giao xe</p>
                                                    <p class="text-base text-blue-700 font-black">${booking.deliveryStatus}</p>
                                                </div>
                                            </div>
                                        </c:if>

                                        <c:if test="${(statusBooking eq '─É├ú x├íc nhß║¡n' or booking.deliveryStatus eq '─Éang giao') and not fn:containsIgnoreCase(booking.deliveryLocation, 'Tß║íi cß╗¡a h├áng')}">
                                            <div class="mt-6 pt-5 border-t border-gray-100 flex items-center gap-4">
                                                <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center shrink-0">
                                                    <i class="fas fa-motorcycle text-blue-500 text-lg"></i>
                                                </div>
                                                <div class="w-full">
                                                    <p class="text-xs text-gray-400 font-bold uppercase mb-1">Dß╗▒ kiß║┐n giao xe</p>
                                                    <div id="delivery-estimate-history" style="display:none; margin-top:8px; padding:10px 14px; border-radius:8px; background:#f0faf0; border:1px solid #b2dfb2; font-size:13px; color:#2e7d32;">
                                                        <i class="fas fa-spinner fa-spin mr-1"></i> ─Éang t├¡nh to├ín thß╗¥i gian...
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <script>
                                            (function() {
                                                var startDateStr = "${booking.startDate}"; 
                                                var parsedStr = startDateStr.replace(/-/g, '/').replace('.0', '');
                                                var targetTime = new Date(parsedStr);
                                                var now = new Date();
                                                
                                                var diffMs = targetTime - now;
                                                var diffMins = Math.floor(diffMs / 60000);
                                                
                                                var estBox = document.getElementById('delivery-estimate-history');
                                                estBox.style.display = 'block';
                                                
                                                if (diffMins > 0) {
                                                    estBox.innerHTML = '<i class="fas fa-clock text-blue-500 mr-1"></i> <strong>Thß╗¥i gian giao xe dß╗▒ kiß║┐n c├▓n:</strong> <span class="text-lg font-bold text-blue-700 ml-1">' + diffMins + ' ph├║t</span><br><span class="text-xs text-gray-500 mt-1 block">T├ái xß║┐ ─æang chuß║⌐n bß╗ï xe v├á sß║╜ ─æß║┐n ─æ├║ng giß╗¥.</span>';
                                                    estBox.style.background = '#eff6ff';
                                                    estBox.style.borderColor = '#bfdbfe';
                                                    estBox.style.color = '#1e3a8a';
                                                } else {
                                                    var lateMins = Math.abs(diffMins);
                                                    if (lateMins <= 45) {
                                                        estBox.innerHTML = '<i class="fas fa-exclamation-triangle text-orange-500 mr-1"></i> <strong>T├ái xß║┐ ─æang ─æß║┐n trß╗à:</strong> ' + lateMins + ' ph├║t.<br><span class="text-xs text-gray-600 mt-1 block">Mong qu├╜ kh├ích th├┤ng cß║úm chß╗¥ trong gi├óy l├ít. Nß║┐u qu├í 45 ph├║t, SmartRide sß║╜ gß╗¡i tß║╖ng m├ú giß║úm gi├í ─æß╗ün b├╣!</span>';
                                                        estBox.style.background = '#fff7ed';
                                                        estBox.style.borderColor = '#fed7aa';
                                                        estBox.style.color = '#9a3412';
                                                    } else {
                                                        estBox.innerHTML = '<i class="fas fa-gift text-red-600 mr-1 text-lg"></i> <strong>Rß║Ñt xin lß╗ùi v├¼ sß╗▒ cß╗æ giao xe trß╗à qu├í 45 ph├║t!</strong><br><p class="mt-2 text-gray-700">─Éß╗â ─æß╗ün b├╣ trß║úi nghiß╗çm kh├┤ng tß╗æt n├áy, hß╗ç thß╗æng ─æang tß╗▒ ─æß╗Öng gß╗¡i m├ú giß║úm gi├í 50,000─æ ─æß╗ün b├╣ v├áo <strong>Hß╗Öp th╞░ Th├┤ng b├ío</strong> cß╗ºa bß║ín. Vui l├▓ng kiß╗âm tra chu├┤ng th├┤ng b├ío nh├⌐!</p>';
                                                        estBox.style.background = '#fef2f2';
                                                        estBox.style.borderColor = '#fecaca';
                                                        estBox.style.color = '#991b1b';
                                                    }
                                                }
                                            })();
                                            </script>
                                        </c:if>
                                        <c:if test="${statusBooking == '─É├ú hß╗ºy' && not empty cancellation}">
                                            <div class="mt-6 pt-5 border-t border-gray-100 flex items-start gap-4">
                                                <div class="w-10 h-10 rounded-full bg-red-50 flex items-center justify-center shrink-0">
                                                    <i class="fas fa-times-circle text-red-500 text-lg"></i>
                                                </div>
                                                <div>
                                                    <p class="text-xs text-gray-400 font-bold uppercase mb-1">L├╜ do hß╗ºy ─æ╞ín</p>
                                                    <p class="text-base text-red-700 font-medium">${cancellation.note}</p>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Column 2: Chi tiß║┐t xe -->
                            <div class="flex flex-col h-full">
                                
                                <!-- Card: Chi tiß║┐t Xe -->
                                <div class="bg-white border border-gray-100 shadow-sm rounded-2xl p-6 relative overflow-hidden flex-1">
                                    <h4 class="text-lg font-extrabold text-gray-800 mb-5 flex items-center">
                                        <i class="fas fa-motorcycle text-yellow-500 mr-3 text-xl"></i> Chi tiß║┐t ph╞░╞íng tiß╗çn
                                    </h4>
                                    
                                    <div class="space-y-3 mb-5">
                                        <div class="flex justify-between items-center text-sm">
                                            <span class="text-gray-500 font-medium">M├ú ─æ╞ín h├áng:</span>
                                            <span class="font-bold text-gray-800 bg-gray-100 px-2 py-1 rounded">#${booking.bookingID}</span>
                                        </div>
                                        <div class="flex justify-between items-center text-sm">
                                            <span class="text-gray-500 font-medium">Thß╗¥i gian tß║ío:</span>
                                            <span class="font-semibold text-gray-700">${bookingDay}-${bookingMonth}-${bookingYear} ${bookingHour}:${bookingMinute}</span>
                                        </div>
                                        <div class="flex justify-between items-center text-sm">
                                            <span class="text-gray-500 font-medium">Tß╗òng sß╗æ l╞░ß╗úng xe:</span>
                                            <span class="font-bold text-yellow-600 bg-yellow-50 px-2.5 py-1 rounded-md border border-yellow-100">${fn:length(booking.listBookingDetails)} xe</span>
                                        </div>
                                    </div>
                                    
                                    <div class="bg-gray-50 border border-gray-200 rounded-xl p-5">
                                        <p class="text-xs text-gray-500 font-bold uppercase tracking-wider mb-3">C├íc ph╞░╞íng tiß╗çn ─æ├ú thu├¬</p>
                                        <div class="flex flex-wrap gap-2.5">
                                            <c:forEach var="entry" items="${motorcycleDetails}" varStatus="loop">
                                                <div class="bg-white border border-gray-200 shadow-sm text-gray-800 px-3 py-1.5 rounded-lg text-sm font-bold flex items-center gap-2">
                                                    <span>${entry.key}</span>
                                                    <span class="bg-green-100 text-green-700 px-1.5 py-0.5 rounded text-xs">x${entry.value}</span>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Column 3: Tß╗òng kß║┐t thanh to├ín -->
                            <div class="flex flex-col h-full">
                                <!-- Card: Tß╗òng kß║┐t thanh to├ín -->
                                <div class="bg-gray-900 rounded-2xl p-6 relative overflow-hidden text-white shadow-xl shadow-gray-900/10 flex-1">
                                    <div class="absolute -right-6 -top-6 w-40 h-40 bg-white/5 rounded-full blur-3xl"></div>
                                    <div class="absolute -left-6 -bottom-6 w-32 h-32 bg-yellow-500/20 rounded-full blur-2xl"></div>
                                    
                                    <h4 class="text-lg font-extrabold text-white mb-5 flex items-center relative z-10">
                                        <i class="fas fa-file-invoice-dollar text-yellow-400 mr-3 text-xl"></i> Tß╗òng kß║┐t thanh to├ín
                                    </h4>
                                    
                                    <div class="space-y-4 relative z-10">
                                        <div class="flex justify-between items-end border-b border-white/10 pb-5">
                                            <div>
                                                <p class="text-gray-400 text-xs font-bold uppercase tracking-widest mb-1">Tß╗òng tiß╗ün thu├¬ xe</p>
                                                <p class="text-3xl font-black text-white tracking-tight" id="total-price">
                                                    <c:set var="total" value="0"/>
                                                    <c:forEach items="${booking.listBookingDetails}" var="detail">
                                                        <c:set var="total" value="${total + detail.totalPrice}"/>
                                                    </c:forEach>
                                                    <c:set var="total" value="${total + (booking.deliveryFee != null ? booking.deliveryFee : 0)}" />
                                                    <fmt:formatNumber value="${total}" pattern="#,##0" /> VN─É
                                                </p>
                                            </div>
                                        </div>
                                        <div class="flex justify-between items-center pt-1 border-b border-white/10 pb-4">
                                            <div>
                                                <c:set var="paidAmount" value="${empty payment ? 0 : payment.paymentAmount}" />
                                                <p class="text-gray-400 text-xs font-bold uppercase tracking-widest mb-1.5">Tiß╗ün cß╗ìc (${paidAmount > 0 ? '─É├ú thanh to├ín' : 'Ch╞░a thanh to├ín'})</p>
                                                <p class="text-2xl font-bold ${paidAmount > 0 ? 'text-green-400' : 'text-yellow-400'}" id="amount-paid">
                                                    <fmt:formatNumber value="${paidAmount}" pattern="#,##0" /> VN─É
                                                </p>
                                            </div>
                                            <div class="w-12 h-12 rounded-full ${paidAmount > 0 ? 'bg-green-500/20 border-green-500/30 text-green-400' : 'bg-yellow-500/20 border-yellow-500/30 text-yellow-400'} flex items-center justify-center border">
                                                <i class="fas ${paidAmount > 0 ? 'fa-check' : 'fa-clock'} text-lg"></i>
                                            </div>
                                        </div>
                                        <div class="flex justify-between items-center pt-1">
                                            <div>
                                                <p class="text-gray-400 text-xs font-bold uppercase tracking-widest mb-1.5">Sß╗æ tiß╗ün cß║ºn thanh to├ín th├¬m</p>
                                                <p class="text-xl font-bold text-rose-400">
                                                    <fmt:formatNumber value="${total - paidAmount}" pattern="#,##0" /> VN─É
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>

                        <!-- Mini Extension Info Link -->
                        <div class="mb-8 text-right relative z-50">
                            <button type="button" class="inline-flex items-center gap-1.5 text-sm font-bold text-yellow-600 hover:text-yellow-700 transition-colors border-b border-dashed border-yellow-600/50 pb-0.5 cursor-pointer bg-transparent border-0 outline-none" onclick="openExtension()">
                                <i class="fas fa-info-circle"></i> Xem th├┤ng tin gia hß║ín lß╗ïch tr├¼nh
                            </button>
                        </div>

                        <!-- Detail Actions Buttons -->
                        <div class="flex flex-wrap items-center justify-end gap-3 pt-5 border-t border-gray-100 relative z-50">
                            <c:if test="${statusBooking == 'Chß╗¥ x├íc nhß║¡n'}">
                                <button type="button" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-sm transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #ef4444" onclick="openCancellation()">
                                    <i class="fas fa-times-circle"></i> Hß╗ºy ─æ╞ín h├áng
                                </button>
                            </c:if>
                            <c:if test="${statusBooking != '─É├ú hß╗ºy'}">
                                <button type="button" id="pay-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #10b981">
                                    <i class="fas fa-wallet"></i> Thanh to├ín ngay
                                </button>
                            </c:if>
                            <c:if test="${statusBooking != '─É├ú hß╗ºy' && booking.deliveryStatus != '─É├ú trß║ú'}">
                                <button type="button" id="extension" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #3b82f6" onclick="openExtensionForm()">
                                    <i class="fas fa-calendar-plus"></i> Gia hß║ín thß╗¥i gian
                                </button>
                            </c:if>
                            <c:if test="${statusBooking == '─É├ú hß╗ºy' || booking.deliveryStatus == '─É├ú trß║ú'}">
                                <button type="button" id="rebook-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #f59e0b" onclick="openBooking()">
                                    <i class="fas fa-redo"></i> ─Éß║╖t thu├¬ xe lß║íi
                                </button>
                            </c:if>
                            <button type="button" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #1e293b" onclick="closeDetail()">
                                <i class="fas fa-chevron-left"></i> Quay vß╗ü danh s├ích
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Modal -->
        <div id="payment-modal" style="display: none; z-index: 9999;" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-65 p-4 transition-all duration-300">
            <div class="bg-white rounded-2xl shadow-xl border border-gray-100 w-full max-w-4xl overflow-hidden p-6 relative animate-fadeIn">
                <span class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 cursor-pointer text-2xl font-bold font-sans" onclick="closePaymentModal()">&times;</span>
                <div class="flex items-center gap-3 mb-4 pb-3 border-b border-gray-100">
                    <div class="w-10 h-10 bg-green-50 rounded-lg flex items-center justify-center text-green-500">
                        <i class="fas fa-wallet text-base"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-800">Thanh to├ín ─æ╞ín h├áng #${booking.bookingID}</h3>
                </div>
                <div class="w-full relative" style="height: 580px;">
                    <iframe id="paymentIframe" src="sepay_pay.jsp" style="width: 100%; height: 100%; border: none; border-radius: 12px;"></iframe>
                    <!-- Overlay for iframe communications -->
                    <div id="payment-loading" style="display: none; z-index: 10000;" class="absolute inset-0 bg-white/85 flex flex-col items-center justify-center gap-3">
                        <div class="w-10 h-10 border-4 border-yellow-500 border-t-transparent rounded-full animate-spin"></div>
                        <p class="text-gray-600 text-sm font-semibold">─Éang kß║┐t nß╗æi cß╗òng thanh to├ín SePay VietQR...</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cancellation Modal -->
        <div id="cancellation-info" style="display: none; z-index: 9999;" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-65 p-4 transition-all duration-300">
            <div class="bg-white rounded-2xl shadow-xl border border-gray-100 w-full max-w-xl overflow-hidden p-6 relative animate-fadeIn">
                <span class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 cursor-pointer text-2xl font-bold" onclick="closeCancellation()">&times;</span>
                <div class="text-center">
                    <div class="w-12 h-12 bg-red-50 rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-exclamation-triangle text-red-500 text-lg"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-800 mb-2">X├íc Nhß║¡n Hß╗ºy ─É╞ín</h3>
                    <p class="text-gray-500 text-sm mb-4">Bß║ín c├│ chß║»c chß║»n muß╗æn hß╗ºy ─æ╞ín n├áy hay kh├┤ng? <br><span class="font-semibold text-gray-700">SMARTRIDE</span> muß╗æn biß║┐t l├╜ do hß╗ºy ─æ╞ín cß╗ºa bß║ín.</p>
                </div>
                <form id="cancel-form" action="cancelbooking" method="get" class="space-y-4">
                    <input type="hidden" id="bookingId" name="bookingId" value="${booking.bookingID}">
                    <div>
                        <textarea required name="cancelreason" id="cancelReason" rows="4" class="w-full border border-gray-200 rounded-xl p-3 text-sm focus:outline-none focus:ring-2 focus:ring-yellow-500 bg-gray-50" placeholder="Nhß║¡p l├╜ do hß╗ºy ─æ╞ín cß╗ºa bß║ín..."></textarea>
                    </div>
                    <div class="flex items-center justify-end gap-3 pt-4 border-t border-gray-100">
                        <button type="button" class="px-5 py-2 border border-gray-200 rounded-xl text-gray-500 hover:bg-gray-50 font-bold text-sm transition-colors cursor-pointer" onclick="closeCancellation()">─É├│ng</button>
                        <button type="submit" class="px-5 py-2 bg-red-500 hover:bg-red-600 text-white rounded-xl font-bold text-sm shadow-md shadow-red-500/10 transition-colors cursor-pointer">Gß╗¡i y├¬u cß║ºu hß╗ºy</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Extension Info Modal -->
        <div id="extension-info" style="display: none; z-index: 9999;" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-65 p-4 transition-all duration-300">
            <div class="bg-white rounded-2xl shadow-xl border border-gray-100 w-full max-w-xl overflow-hidden p-6 relative animate-fadeIn">
                <span class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 cursor-pointer text-2xl font-bold" onclick="closeExtension()">&times;</span>
                <div class="flex items-center gap-3 mb-6 pb-4 border-b border-gray-100">
                    <div class="w-10 h-10 bg-yellow-50 rounded-lg flex items-center justify-center text-yellow-500">
                        <i class="fas fa-calendar-plus text-base"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-800">Th├┤ng tin gia hß║ín</h3>
                </div>
                <c:choose>
                    <c:when test="${extension == null}">
                        <div class="text-center py-8">
                            <p class="text-gray-400 italic">Kh├┤ng c├│ th├┤ng tin gia hß║ín n├áo cho booking n├áy.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="space-y-4">
                            <div class="grid grid-cols-2 gap-4">
                                <div class="bg-gray-50 p-3.5 rounded-xl border border-gray-100">
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-1">M├ú ─æß║╖t xe</span>
                                    <span class="text-sm font-bold text-gray-700">#${extension.bookingID}</span>
                                </div>
                                <div class="bg-gray-50 p-3.5 rounded-xl border border-gray-100">
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-1">Ng├áy gia hß║ín</span>
                                    <span class="text-sm font-semibold text-gray-700">
                                        <c:set var="extensionDate" value="${extension.extensionDate}" />
                                        <c:set var="extYear" value="${fn:substring(extensionDate, 0, 4)}" />
                                        <c:set var="extMonth" value="${fn:substring(extensionDate, 5, 7)}" />
                                        <c:set var="extDay" value="${fn:substring(extensionDate, 8, 10)}" />
                                        <c:set var="extHour" value="${fn:substring(extensionDate, 11, 13)}" />
                                        <c:set var="extMinute" value="${fn:substring(extensionDate, 14, 16)}" />
                                        ${extDay}-${extMonth}-${extYear} ${extHour}:${extMinute}
                                    </span>
                                </div>
                            </div>
                            
                            <div class="bg-gray-50 p-3.5 rounded-xl border border-gray-100 space-y-2">
                                <div class="flex justify-between items-center text-sm border-b border-gray-200/50 pb-2">
                                    <span class="text-gray-500 font-medium">Hß║ín trß║ú tr╞░ß╗¢c ─æ├│:</span>
                                    <span class="font-semibold text-gray-700">
                                        <c:set var="previousEndDate" value="${extension.previousEndDate}" />
                                        <c:set var="prevYear" value="${fn:substring(previousEndDate, 0, 4)}" />
                                        <c:set var="prevMonth" value="${fn:substring(previousEndDate, 5, 7)}" />
                                        <c:set var="prevDay" value="${fn:substring(previousEndDate, 8, 10)}" />
                                        <c:set var="prevHour" value="${fn:substring(previousEndDate, 11, 13)}" />
                                        <c:set var="prevMinute" value="${fn:substring(previousEndDate, 14, 16)}" />
                                        ${prevDay}-${prevMonth}-${prevYear} ${prevHour}:${prevMinute}
                                    </span>
                                </div>
                                <div class="flex justify-between items-center text-sm pt-1">
                                    <span class="text-gray-500 font-medium">Hß║ín trß║ú mß╗¢i:</span>
                                    <span class="font-bold text-yellow-600">
                                        <c:set var="newEndDate" value="${extension.newEndDate}" />
                                        <c:set var="newYear" value="${fn:substring(newEndDate, 0, 4)}" />
                                        <c:set var="newMonth" value="${fn:substring(newEndDate, 5, 7)}" />
                                        <c:set var="newDay" value="${fn:substring(newEndDate, 8, 10)}" />
                                        <c:set var="newHour" value="${fn:substring(newEndDate, 11, 13)}" />
                                        <c:set var="newMinute" value="${fn:substring(newEndDate, 14, 16)}" />
                                        ${newDay}-${newMonth}-${newYear} ${newHour}:${newMinute}
                                    </span>
                                </div>
                            </div>

                            <div class="grid grid-cols-2 gap-4">
                                <div class="bg-gray-50 p-3.5 rounded-xl border border-gray-100">
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-1">Ph├¡ gia hß║ín</span>
                                    <span class="text-sm font-bold text-green-600">
                                        <fmt:formatNumber value="${extension.extensionFee}" pattern="#,##0" /> VN─É
                                    </span>
                                </div>
                                <div class="bg-gray-50 p-3.5 rounded-xl border border-gray-100">
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-1">Tß╗òng tiß╗ün mß╗¢i</span>
                                    <span class="text-sm font-bold text-yellow-600">
                                        <c:set var="total" value="${total + extension.extensionFee}" />
                                        <fmt:formatNumber value="${total}" pattern="#,##0" /> VN─É
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="flex justify-end pt-6 mt-6 border-t border-gray-100">
                    <button type="button" class="px-5 py-2 hover:bg-gray-900 text-white rounded-xl font-bold text-sm shadow-md transition-colors cursor-pointer border-0" style="background-color: #1f2937;" onclick="closeExtension()">─Éß╗ông ├╜</button>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                togglePayButton();
                
                // Add event listener for pay-btn click
                const payBtn = document.getElementById("pay-btn");
                if (payBtn) {
                    payBtn.addEventListener("click", openPaymentModal);
                }
                
                // Clean up previous storage status on load
                localStorage.removeItem('payment_status');
                
                // Storage listener for payment success callback
                window.addEventListener('storage', function(event) {
                    if (event.key === 'payment_status') {
                        const paymentStatus = JSON.parse(event.newValue);
                        if (paymentStatus && paymentStatus.status === 'success') {
                            handleSuccessPayment(paymentStatus);
                        }
                    }
                });

                // Auto open payment modal if requested
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('autoPay') === 'true' && document.getElementById("pay-btn")) {
                    setTimeout(openPaymentModal, 300);
                }
            });
            function togglePayButton() {
                const payButton = document.getElementById("pay-btn");
                if (!payButton) return;
                
                const amountPaid = parseFloat("${paidAmount}") || 0;
                const totalPrice = (parseFloat("${total}") || 0);
                
                if (amountPaid < totalPrice) {
                    payButton.style.display = "inline-flex";
                } else {
                    payButton.style.display = "none";
                }
            }

            function openPaymentModal() {
                const modal = document.getElementById('payment-modal');
                if (modal) {
                    modal.style.display = 'flex';
                    
                    const iframe = document.getElementById('paymentIframe');
                    iframe.onload = function() {
                        const amountPaid = parseFloat("${paidAmount}") || 0;
                        const totalPrice = (parseFloat("${total}") || 0);
                        
                        // Send data to iframe
                        const data = {
                            dataTotal: totalPrice,
                            dataPayment: amountPaid > 0 ? [amountPaid] : [],
                            bookingId: '${booking.bookingID}'
                        };
                        iframe.contentWindow.postMessage(data, '*');
                    };
                    // Force set src to trigger onload
                    if (!iframe.src.includes('sepay_pay.jsp')) {
                        iframe.src = "sepay_pay.jsp";
                    } else {
                        // If already loaded, trigger onload manually by resetting src
                        const currentSrc = iframe.src;
                        iframe.src = '';
                        iframe.src = currentSrc;
                    }
                }
            }

            function closePaymentModal() {
                const modal = document.getElementById('payment-modal');
                if (modal) {
                    modal.style.display = 'none';
                    // Reset iframe source to avoid state issues on reopening
                    const iframe = document.getElementById('paymentIframe');
                    if (iframe) {
                        iframe.src = "sepay_pay.jsp";
                    }
                }
            }

            function handleSuccessPayment(paymentStatus) {
                // Post payment info to backend
                const bookingId = "${booking.bookingID}";
                const params = new URLSearchParams();
                params.append("bookingId", bookingId);
                params.append("paymentTime", paymentStatus.time);
                params.append("amount", paymentStatus.amount);
                
                fetch("bookingHistoryDetail", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: params.toString()
                })
                .then(response => response.json())
                .then(data => {
                    if (data.status === "success") {
                        // Remove status from localStorage
                        localStorage.removeItem('payment_status');
                        
                        // Close modal
                        closePaymentModal();
                        
                        // Show success alert and reload
                        alert("Thanh to├ín th├ánh c├┤ng! Hß╗ç thß╗æng sß║╜ cß║¡p nhß║¡t trß║íng th├íi ─æ╞ín h├áng cß╗ºa bß║ín.");
                        window.location.reload();
                    } else {
                        alert("Lß╗ùi khi cß║¡p nhß║¡t thanh to├ín: " + data.message);
                    }
                })
                .catch(err => {
                    console.error("Lß╗ùi:", err);
                    alert("─É├ú xß║úy ra lß╗ùi trong qu├í tr├¼nh cß║¡p nhß║¡t thanh to├ín.");
                });
            }

            // Listen for iframe postMessages to activate/stop overlays
            window.addEventListener('message', (event) => {
                const loadingOverlay = document.getElementById('payment-loading');
                if (loadingOverlay) {
                    if (event.data === 'activateOverlay') {
                        loadingOverlay.style.display = 'flex';
                    } else if (event.data === 'stopOverlay') {
                        loadingOverlay.style.display = 'none';
                    }
                }
            });

            function openExtensionForm() {
                const modal = document.getElementById("extend-form-modal");
                if (modal) {
                    modal.style.display = 'flex';
                    const iframe = document.getElementById('extend-iframe');
                    if (iframe && !iframe.src.includes('extend?bookingid=')) {
                        iframe.src = "extend?bookingid=${booking.bookingID}&_t=" + new Date().getTime();
                    }
                }
            }

            function closeExtensionFormModal() {
                const modal = document.getElementById("extend-form-modal");
                if (modal) {
                    modal.style.display = 'none';
                }
            }
            function openExtension() {
                const extInfo = document.getElementById('extension-info');
                if (extInfo) extInfo.style.display = 'flex';
            }
            
            function closeExtension() {
                const extInfo = document.getElementById('extension-info');
                if (extInfo) extInfo.style.display = 'none';
            }
            
            function closeDetail() {
                window.location.href = 'bookingHistory?status=all';
            }

            function openCancellation() {
                const cancelInfo = document.getElementById('cancellation-info');
                if (cancelInfo) cancelInfo.style.display = 'flex';
            }

            function closeCancellation() {
                const cancelInfo = document.getElementById('cancellation-info');
                if (cancelInfo) cancelInfo.style.display = 'none';
            }
            
            function openBooking() {
                window.location.href = 'booking';
            }

            // click outside to dismiss modals
            window.addEventListener('click', function (event) {
                const extension = document.getElementById("extension-info");
                const cancellation = document.getElementById("cancellation-info");
                const payment = document.getElementById("payment-modal");
                const extendFormModal = document.getElementById("extend-form-modal");

                if (event.target === extension) {
                    extension.style.display = "none";
                }
                if (event.target === extendFormModal) {
                    closeExtensionFormModal();
                }
                if (event.target === cancellation) {
                    cancellation.style.display = "none";
                }
                if (event.target === payment) {
                    closePaymentModal();
                }
            });

            // ESC to dismiss modals
            window.addEventListener('keydown', function (event) {
                const extension = document.getElementById("extension-info");
                const cancellation = document.getElementById("cancellation-info");
                const payment = document.getElementById("payment-modal");
                if (event.key === "Escape" || event.key === "Esc") {
                    if (extension) extension.style.display = "none";
                    if (cancellation) cancellation.style.display = "none";
                    if (payment) closePaymentModal();
                    closeExtensionFormModal();
                }
            });
        </script>

        <!-- Modal for Extend Booking Form -->
        <div id="extend-form-modal" class="hidden items-center justify-center p-4" style="position: fixed; inset: 0; background-color: rgba(0,0,0,0.6); backdrop-filter: blur(4px); z-index: 999999;">
            <div class="bg-white rounded-2xl w-full max-w-6xl max-h-[90vh] shadow-2xl relative flex flex-col overflow-hidden animate-fade-in-up">
                <!-- Header -->
                <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between bg-gray-50/80">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center">
                            <i class="fas fa-calendar-plus text-lg"></i>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold text-gray-800">Gia hß║ín thß╗¥i gian thu├¬ xe</h3>
                            <p class="text-sm text-gray-500 font-medium">Ho├án tß║Ñt gia hß║ín nhanh ch├│ng qua SmartRide</p>
                        </div>
                    </div>
                    <button onclick="closeExtensionFormModal()" class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200 text-gray-400 hover:text-gray-600 transition-colors">
                        <i class="fas fa-times text-lg"></i>
                    </button>
                </div>
                <!-- Body (iframe) -->
                <div class="flex-1 w-full bg-gray-50 overflow-hidden relative" style="min-height: 75vh;">
                    <iframe id="extend-iframe" src="" class="w-full h-full border-none absolute inset-0" title="Gia Hß║ín Xe"></iframe>
                </div>
            </div>
        </div>

        <%-- ========== REAL-TIME GPS TRACKING (chß║íy khi xe ─æang ─æ╞░ß╗úc giao cho kh├ích) ========== --%>
        <c:if test="${statusBooking == '─É├ú x├íc nhß║¡n' && booking.deliveryStatus == '─É├ú giao'}">
        <script>
        (function() {
            var BOOKING_ID    = '${booking.bookingID}';
            var CUSTOMER_NAME = '${sessionScope.account.userName}';
            var MOTOR_NAME    = '${booking.motorcycle.model}';
            var PHONE         = '${sessionScope.account.phone}';
            var CTX           = '${pageContext.request.contextPath}';
            var watchId       = null;
            var indicator     = null;

            // Tß║ío indicator nhß╗Å ß╗ƒ g├│c m├án h├¼nh
            function createIndicator() {
                indicator = document.createElement('div');
                indicator.id = 'gps-track-indicator';
                indicator.innerHTML = '<span style="display:inline-block;width:8px;height:8px;border-radius:50%;background:#22c55e;margin-right:6px;animation:gpsPulse 1.5s infinite;"></span>─Éang chia sß║╗ vß╗ï tr├¡';
                indicator.style.cssText = 'position:fixed;bottom:18px;right:18px;z-index:99999;background:rgba(0,0,0,0.75);color:#fff;font-size:12px;padding:7px 14px;border-radius:20px;display:flex;align-items:center;font-family:sans-serif;';
                var style = document.createElement('style');
                style.textContent = '@keyframes gpsPulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:0.5;transform:scale(1.3)}}';
                document.head.appendChild(style);
                document.body.appendChild(indicator);
            }

            function setIndicator(text, color) {
                if (!indicator) return;
                indicator.innerHTML = '<span style="display:inline-block;width:8px;height:8px;border-radius:50%;background:' + color + ';margin-right:6px;"></span>' + text;
            }

            // Gß╗¡i tß╗ìa ─æß╗Ö l├¬n server
            function sendLocation(lat, lon) {
                var fd = new URLSearchParams();
                fd.append('bookingId',    BOOKING_ID);
                fd.append('lat',          lat);
                fd.append('lon',          lon);
                fd.append('customerName', CUSTOMER_NAME);
                fd.append('vehicleName',  MOTOR_NAME);
                fd.append('phone',        PHONE);
                fetch(CTX + '/api/update-location', { 
                    method: 'POST', 
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: fd.toString() 
                })
                .then(function(r){ return r.json(); })
                .then(function(d){
                    if (d.ok) setIndicator('─Éang chia sß║╗ vß╗ï tr├¡', '#22c55e');
                    else      setIndicator('Lß╗ùi gß╗¡i vß╗ï tr├¡', '#ef4444');
                })
                .catch(function(){ setIndicator('Mß║Ñt kß║┐t nß╗æi', '#f59e0b'); });
            }

            // Bß║»t ─æß║ºu watch
            function startTracking() {
                if (!navigator.geolocation) {
                    alert("─Éiß╗çn thoß║íi cß╗ºa bß║ín kh├┤ng hß╗ù trß╗ú GPS.");
                    return;
                }
                createIndicator();
                setIndicator('─Éang kß║┐t nß╗æi GPS...', '#f59e0b');
                watchId = navigator.geolocation.watchPosition(
                    function(pos) {
                        var alertBox = document.getElementById('gps-warning-banner');
                        if (alertBox) alertBox.remove();
                        sendLocation(pos.coords.latitude, pos.coords.longitude);
                    },
                    function(err) {
                        setIndicator('Ch╞░a cß║Ñp quyß╗ün GPS', '#ef4444');
                        if (!document.getElementById('gps-warning-banner')) {
                            var banner = document.createElement('div');
                            banner.id = 'gps-warning-banner';
                            banner.style.cssText = 'position:fixed;top:0;left:0;width:100%;background:#ef4444;color:white;text-align:center;padding:15px;z-index:999999;font-weight:bold;box-shadow:0 4px 6px rgba(0,0,0,0.1);';
                            banner.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Bß║«T BUß╗ÿC: Bß║ín ─æang trong thß╗¥i gian thu├¬ xe. Vui l├▓ng bß║¡t Vß╗ï tr├¡ (GPS) tr├¬n tr├¼nh duyß╗çt ─æß╗â tiß║┐p tß╗Ñc!';
                            document.body.prepend(banner);
                        }
                    },
                    { enableHighAccuracy: true, timeout: 15000, maximumAge: 10000 }
                );
            }

            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', startTracking);
            } else {
                startTracking();
            }

            window.addEventListener('beforeunload', function() {
                if (watchId !== null) navigator.geolocation.clearWatch(watchId);
            });
        })();
        </script>
        </c:if>
    </body>
</html>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
        <meta charset="utf-8">
        <title>Chi tiết lịch sử thuê xe</title>
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
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                                    <i class="fas fa-file-invoice mr-2.5 text-yellow-500"></i> Chi tiết Booking
                                </h3>
                                <p class="text-gray-400 text-sm font-medium mt-1">Xem thông tin đặt xe, hạn trả và thực hiện thao tác gia hạn hoặc hủy đơn.</p>
                            </div>
                            <c:choose>
                                <c:when test="${statusBooking == 'Chờ xác nhận' && not empty payment}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold bg-green-50 text-green-700 border border-green-200">
                                        <i class="fas fa-check-circle"></i> Đã cọc: <fmt:formatNumber value="${payment.paymentAmount}" pattern="#,##0" />đ
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold ${statusBooking == 'Chờ xác nhận' ? 'bg-yellow-50 text-yellow-600' : (statusBooking == 'Đã xác nhận' ? 'bg-green-50 text-green-600' : 'bg-red-50 text-red-600')}">
                                        <span class="w-1.5 h-1.5 rounded-full ${statusBooking == 'Chờ xác nhận' ? 'bg-yellow-500' : (statusBooking == 'Đã xác nhận' ? 'bg-green-500' : 'bg-red-500')}"></span>
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
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
                            
                            <!-- Column 1: Lịch trình -->
                            <div class="flex flex-col h-full">
                                <!-- Card: Lịch trình -->
                                <div class="bg-white border border-gray-100 shadow-sm rounded-2xl p-6 relative overflow-hidden flex-1">
                                    <div class="absolute top-0 right-0 w-48 h-48 bg-yellow-50 rounded-bl-full -z-0 opacity-50"></div>
                                    <h4 class="text-lg font-extrabold text-gray-800 mb-5 flex items-center relative z-10">
                                        <i class="fas fa-route text-yellow-500 mr-3 text-xl"></i> Lịch trình thuê xe
                                    </h4>
                                    
                                    <div class="flex items-center justify-between relative z-10 mb-6 bg-gray-50/50 p-4 rounded-xl border border-gray-100">
                                        <!-- Start Date -->
                                        <div class="text-center w-5/12">
                                            <p class="text-xs text-gray-400 font-bold uppercase tracking-wider mb-2">Nhận xe</p>
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
                                            <p class="text-xs text-gray-400 font-bold uppercase tracking-wider mb-2">Trả xe</p>
                                            <div class="bg-white border border-gray-200 shadow-sm rounded-xl py-3 px-2">
                                                <p class="text-green-600 font-black text-xl mb-1">${endHour}:${endMinute}</p>
                                                <p class="text-gray-600 text-xs font-bold">${endDay}-${endMonth}-${endYear}</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="space-y-5 relative z-10">
                                          <!-- Trạng thái tổng quan luôn hiện -->
                                          <div class="flex items-center gap-4">
                                              <div class="w-10 h-10 rounded-full bg-gray-50 flex items-center justify-center shrink-0 border border-gray-200">
                                                  <i class="fas fa-clipboard-list text-gray-600 text-lg"></i>
                                              </div>
                                              <div>
                                                  <p class="text-xs text-gray-400 font-bold uppercase mb-1">Trạng thái đơn hàng</p>
                                                  <p class="text-base text-gray-800 font-black">${statusBooking}</p>
                                              </div>
                                          </div>

                                          <c:if test="${(statusBooking eq 'Đã xác nhận' or booking.deliveryStatus eq 'Đang giao') and not fn:containsIgnoreCase(booking.deliveryLocation, 'Tại cửa hàng')}">
                                              <div class="flex items-center gap-4 mt-4 pt-4 border-t border-gray-100">
                                                  <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center shrink-0">
                                                      <i class="fas fa-motorcycle text-blue-500 text-lg"></i>
                                                  </div>
                                                  <div class="w-full">
                                                      <p class="text-xs text-gray-400 font-bold uppercase mb-1">Dự kiến giao xe</p>
                                                      <div id="delivery-estimate-history" style="display:none; margin-top:8px; padding:10px 14px; border-radius:8px; background:#f0faf0; border:1px solid #b2dfb2; font-size:13px; color:#2e7d32;">
                                                          <i class="fas fa-spinner fa-spin mr-1"></i> Đang tính toán thời gian...
                                                      </div>
                                                  </div>
                                              </div>
                                              
                                              <script>
                                              (function() {
                                                  // Target delivery time = booking startDate
                                                  // Format from JSP: yyyy-MM-dd HH:mm:ss.S (or similar)
                                                  var startDateStr = "${booking.startDate}"; 
                                                  // Safari/iOS fixes for date parsing (replace dashes with slashes)
                                                  var parsedStr = startDateStr.replace(/-/g, '/').replace('.0', '');
                                                  var targetTime = new Date(parsedStr);
                                                  var now = new Date();
                                                  
                                                  // Calculate difference in minutes
                                                  var diffMs = targetTime - now;
                                                  var diffMins = Math.floor(diffMs / 60000);
                                                  
                                                  var estBox = document.getElementById('delivery-estimate-history');
                                                  estBox.style.display = 'block';
                                                  
                                                  if (diffMins > 0) {
                                                      // Still have time
                                                      estBox.innerHTML = '<i class="fas fa-clock text-blue-500 mr-1"></i> <strong>Thời gian giao xe dự kiến còn:</strong> <span class="text-lg font-bold text-blue-700 ml-1">' + diffMins + ' phút</span><br><span class="text-xs text-gray-500 mt-1 block">Tài xế đang chuẩn bị xe và sẽ đến đúng giờ.</span>';
                                                      estBox.style.background = '#eff6ff';
                                                      estBox.style.borderColor = '#bfdbfe';
                                                      estBox.style.color = '#1e3a8a';
                                                  } else {
                                                      var lateMins = Math.abs(diffMins);
                                                      if (lateMins <= 45) {
                                                          // Late but within 45 mins limit
                                                          estBox.innerHTML = '<i class="fas fa-exclamation-triangle text-orange-500 mr-1"></i> <strong>Tài xế đang đến trễ:</strong> ' + lateMins + ' phút.<br><span class="text-xs text-gray-600 mt-1 block">Mong quý khách thông cảm chờ trong giây lát. Nếu quá 45 phút, SmartRide sẽ gửi tặng mã giảm giá đền bù!</span>';
                                                          estBox.style.background = '#fff7ed';
                                                          estBox.style.borderColor = '#fed7aa';
                                                          estBox.style.color = '#9a3412';
                                                      } else {
                                                          // Late > 45 mins! Show Voucher!
                                                          estBox.innerHTML = '<i class="fas fa-gift text-red-600 mr-1 text-lg"></i> <strong>Rất xin lỗi vì sự cố giao xe trễ quá 45 phút!</strong><br><p class="mt-2 text-gray-700">Để đền bù trải nghiệm không tốt này, hệ thống đang tự động gửi mã giảm giá 50,000đ đền bù vào <strong>Hộp thư Thông báo</strong> của bạn. Vui lòng kiểm tra chuông thông báo nhé!</p>';
                                                          estBox.style.background = '#fef2f2';
                                                          estBox.style.borderColor = '#fecaca';
                                                          estBox.style.color = '#991b1b';
                                                      }
                                                  }
                                              })();
                                              </script>
                                          </c:if>

                                          <c:if test="${false}">
                                              <!-- GPS DEMO BLOCK -->
                                              <div class="mt-4 pt-4 border-t border-gray-100">
                                                  <div class="p-5 bg-gradient-to-r from-blue-50 to-indigo-50 border border-blue-100 rounded-2xl relative overflow-hidden">
                                                      <div class="absolute top-0 right-0 w-24 h-24 bg-blue-100 rounded-bl-full -z-0 opacity-50"></div>
                                                      <h4 class="text-blue-800 font-bold mb-2 flex items-center relative z-10"><i class="fas fa-location-arrow mr-2"></i> Trình theo dõi GPS (Bản Demo)</h4>
                                                      <p class="text-xs text-blue-600 mb-4 relative z-10">Vui lòng bấm nút dưới đây để bật chia sẻ vị trí liên tục lên màn hình Staff.</p>
                                                      
                                                      <button id="btnStartGps" onclick="toggleDemoGps()" class="w-full py-3 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-bold shadow-md transition-all flex items-center justify-center gap-2 relative z-10">
                                                          <i class="fas fa-play"></i> BẮT ĐẦU PHÁT VỊ TRÍ
                                                      </button>
                                                      <div id="gpsStatusBox" class="hidden mt-3 p-3 bg-white rounded-xl border border-blue-100 text-sm relative z-10">
                                                          <div class="flex items-center gap-2 text-green-600 font-bold mb-1">
                                                              <span class="relative flex h-3 w-3">
                                                                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
                                                                <span class="relative inline-flex rounded-full h-3 w-3 bg-green-500"></span>
                                                              </span>
                                                              Đang phát tín hiệu GPS...
                                                          </div>
                                                          <div class="text-xs text-gray-500 font-mono mt-1" id="gpsCoords">Lat: --, Lon: --</div>
                                                      </div>
                                                  </div>
                                              </div>

                                              <script>
                                              let gpsWatchId = null;
                                              let wakeLock = null;

                                              async function requestWakeLock() {
                                                  try {
                                                      if ('wakeLock' in navigator) {
                                                          wakeLock = await navigator.wakeLock.request('screen');
                                                      }
                                                  } catch (err) {
                                                      console.error("Wake Lock error:", err.message);
                                                  }
                                              }

                                              function toggleDemoGps() {
                                                  const btn = document.getElementById('btnStartGps');
                                                  const statusBox = document.getElementById('gpsStatusBox');
                                                  
                                                  if (gpsWatchId !== null) {
                                                      navigator.geolocation.clearWatch(gpsWatchId);
                                                      gpsWatchId = null;
                                                      if (wakeLock !== null) wakeLock.release().then(() => wakeLock = null);
                                                      
                                                      btn.innerHTML = '<i class="fas fa-play"></i> BẮT ĐẦU PHÁT VỊ TRÍ';
                                                      btn.className = "w-full py-3 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-bold shadow-md transition-all flex items-center justify-center gap-2 relative z-10";
                                                      statusBox.classList.add('hidden');
                                                      return;
                                                  }
                                                  
                                                  if (navigator.geolocation) {
                                                      requestWakeLock();
                                                      btn.innerHTML = '<i class="fas fa-stop"></i> DỪNG PHÁT VỊ TRÍ';
                                                      btn.className = "w-full py-3 rounded-xl bg-red-600 hover:bg-red-700 text-white font-bold shadow-md transition-all flex items-center justify-center gap-2 relative z-10";
                                                      statusBox.classList.remove('hidden');
                                                      
                                                      gpsWatchId = navigator.geolocation.watchPosition(function(position) {
                                                          const lat = position.coords.latitude.toFixed(6);
                                                          const lon = position.coords.longitude.toFixed(6);
                                                          document.getElementById('gpsCoords').innerText = 'Lat: ' + lat + '\nLon: ' + lon;
                                                          
                                                          let fd = new FormData();
                                                          fd.append('bookingId', '');
                                                          fd.append('lat', lat);
                                                          fd.append('lon', lon);
                                                          fd.append('customerName', '');
                                                          
                                                          fetch('/api/update-location', {
                                                              method: 'POST',
                                                              body: fd
                                                          }).catch(e => console.error(e));
                                                          
                                                      }, function(error) {
                                                          Swal.fire({icon: 'error', title: 'Lỗi GPS', text: 'Vui lòng bật vị trí (Location) trên điện thoại và tải lại trang!'});
                                                          toggleDemoGps();
                                                      }, {
                                                          enableHighAccuracy: true,
                                                          maximumAge: 0,
                                                          timeout: 5000
                                                      });
                                                  } else {
                                                      Swal.fire({icon: 'error', title: 'Không hỗ trợ', text: 'Trình duyệt không hỗ trợ định vị GPS.'});
                                                  }
                                              }

                                              document.addEventListener("visibilitychange", function() {
                                                  if (document.visibilityState === 'visible' && gpsWatchId !== null && wakeLock === null) {
                                                      requestWakeLock();
                                                  }
                                              });
                                              </script>
                                          </c:if>

                                          <c:if test="${false}">
                                              <div class="mt-4 pt-4 border-t border-gray-100 flex items-start gap-4">
                                                  <div class="w-10 h-10 rounded-full bg-red-50 flex items-center justify-center shrink-0">
                                                      <i class="fas fa-times-circle text-red-500 text-lg"></i>
                                                  </div>
                                                  <div>
                                                      <p class="text-xs text-gray-400 font-bold uppercase mb-1">Lý do hủy đơn</p>
                                                      <p class="text-base text-red-700 font-medium"></p>
                                                  </div>
                                              </div>
                                          </c:if>
                                      </div>
                                  </div>
                              </div>
                              </div>
                          </div>

                          <!-- Mini Extension Info Link --><!-- Mini Extension Info Link -->
                        <div class="mb-8 text-right relative z-50">
                            <button type="button" class="inline-flex items-center gap-1.5 text-sm font-bold text-yellow-600 hover:text-yellow-700 transition-colors border-b border-dashed border-yellow-600/50 pb-0.5 cursor-pointer bg-transparent border-0 outline-none" onclick="openExtension()">
                                <i class="fas fa-info-circle"></i> Xem thông tin gia hạn lịch trình
                            </button>
                        </div>

                        <!-- Detail Actions Buttons -->
                        <div class="flex flex-wrap items-center justify-end gap-3 pt-5 border-t border-gray-100 relative z-50">
                            <!-- Nút Bật Định Vị GPS (Chỉ hiện khi xe đang trong quá trình được sử dụng) -->
                            <c:if test="${statusBooking == 'Đang thuê' || (statusBooking == 'Đã xác nhận' && booking.deliveryStatus == 'Đã giao')}">
                                <c:set var="allVehicles" value=""/>
                                <c:forEach var="plate" items="${motorcyclePlates}" varStatus="loop">
                                    <c:set var="allVehicles" value="${allVehicles}${plate}${!loop.last ? ', ' : ''}"/>
                                </c:forEach>
                                <button type="button" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90 animate-pulse" style="background-color: #ef4444" onclick="window.open('${pageContext.request.contextPath}/gpsDemo.jsp?bookingId=${booking.bookingID}&customerName=${sessionScope.account.userName}&phone=${sessionScope.account.phoneNumber}&vehicleName=' + encodeURIComponent('${allVehicles}'), '_blank')">
                                    <i class="fas fa-map-marker-alt"></i> Bật Định Vị
                                </button>
                            </c:if>

                            <c:if test="${statusBooking == 'Chờ xác nhận'}">
                                <button type="button" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-sm transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #ef4444" onclick="openCancellation()">
                                    <i class="fas fa-times-circle"></i> Hủy đơn hàng
                                </button>
                            </c:if>
                            <c:if test="${statusBooking != 'Đã hủy'}">
                                <button type="button" id="pay-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #10b981">
                                    <i class="fas fa-wallet"></i> Thanh toán ngay
                                </button>
                                <button type="button" id="contract-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #4f46e5" onclick="openContractModal()">
                                    <i class="fas fa-file-contract"></i> Xem hợp đồng
                                </button>
                                <c:if test="${false}">
                                    <button type="button" id="invoice-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #10b981" onclick="openInvoiceModal()">
                                        <i class="fas fa-file-invoice-dollar"></i> Xem Biên lai
                                    </button>
                                </c:if>
                            </c:if>
                            <c:if test="${statusBooking != 'Đã hủy' && booking.deliveryStatus != 'Đã trả'}">
                                <button type="button" id="extension" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #3b82f6" onclick="openExtensionForm()">
                                    <i class="fas fa-calendar-plus"></i> Gia hạn thời gian
                                </button>
                            </c:if>
                            <c:if test="${statusBooking == 'Đã hủy' || booking.deliveryStatus == 'Đã trả'}">
                                <button type="button" id="rebook-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #f59e0b" onclick="openBooking()">
                                    <i class="fas fa-redo"></i> Đặt thuê xe lại
                                </button>
                            </c:if>
                            <button type="button" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #1e293b" onclick="closeDetail()">
                                <i class="fas fa-chevron-left"></i> Quay về danh sách
                            </button>
                        </div>
                        </div>

                        <!-- Chat Section -->
                        <div class="mt-8 pt-6 border-t border-gray-100" id="chat-section">
                            <h3 class="text-lg font-bold text-gray-800 mb-4 flex items-center gap-2">
                                <i class="fas fa-comments text-blue-500"></i> Trao đổi với Cửa hàng
                            </h3>
                            <div class="bg-gray-50/80 rounded-2xl border border-gray-200 overflow-hidden flex flex-col shadow-inner" style="height: 450px;">
                                <div id="chat-messages-container" class="flex-1 p-5 overflow-y-auto flex flex-col gap-3">
                                    <div class="text-center text-gray-400 text-sm italic mt-4">Đang tải tin nhắn...</div>
                                </div>
                                <div class="p-4 bg-white border-t border-gray-200">
                                    <div class="flex gap-3">
                                        <input type="text" id="chat-input" class="flex-1 bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 focus:outline-none focus:bg-white focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all" placeholder="Nhập nội dung cần hỗ trợ..." onkeypress="if(event.key==='Enter') sendChatMessage()">
                                        <button onclick="sendChatMessage()" class="bg-blue-600 hover:bg-blue-700 shadow-md shadow-blue-600/20 text-white px-6 py-3 rounded-xl font-bold transition-all flex items-center gap-2">
                                            <i class="fas fa-paper-plane"></i> Gửi
                                        </button>
                                    </div>
                                </div>
                            </div>
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
                    <h3 class="text-xl font-bold text-gray-800">Thanh toán đơn hàng #${booking.bookingID}</h3>
                </div>
                <div class="w-full relative" style="height: 580px;">
                    <iframe id="paymentIframe" src="sepay_pay.jsp" style="width: 100%; height: 100%; border: none; border-radius: 12px;"></iframe>
                    <!-- Overlay for iframe communications -->
                    <div id="payment-loading" style="display: none; z-index: 10000;" class="absolute inset-0 bg-white/85 flex flex-col items-center justify-center gap-3">
                        <div class="w-10 h-10 border-4 border-yellow-500 border-t-transparent rounded-full animate-spin"></div>
                        <p class="text-gray-600 text-sm font-semibold">Đang kết nối cổng thanh toán SePay VietQR...</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contract Modal -->
        <div id="contract-modal" style="display: none; z-index: 9999;" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-65 p-4 transition-all duration-300">
            <div class="bg-white rounded-2xl shadow-xl border border-gray-100 w-full max-w-4xl overflow-hidden p-6 relative animate-fadeIn" style="height: 85vh; display: flex; flex-direction: column;">
                <span class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 cursor-pointer text-2xl font-bold font-sans" onclick="closeContractModal()">&times;</span>
                <div class="flex justify-between items-center mb-4 pb-3 border-b border-gray-100">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-indigo-50 rounded-lg flex items-center justify-center text-indigo-500">
                            <i class="fas fa-file-contract text-base"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-800">Hợp đồng điện tử #${booking.bookingID}</h3>
                    </div>
                    <div class="pr-8">
                        <button class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-bold text-sm shadow-md transition-colors mr-2" onclick="downloadContractPDF()">
                            <i class="fas fa-file-download"></i> Tải PDF
                        </button>
                        <button class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-bold text-sm shadow-md transition-colors" onclick="document.getElementById('contractIframe').contentWindow.print()">
                            <i class="fas fa-print"></i> In hợp đồng
                        </button>
                        
                        <!-- Include html2pdf.js -->
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
                        <script>
                            function downloadContractPDF() {
                                const iframe = document.getElementById('contractIframe');
                                const element = iframe.contentWindow.document.getElementById('contract-content') || iframe.contentWindow.document.body;
                                const opt = {
                                  margin:       [0, 0, 0, 0],
                                  filename:     'HopDongThueXe_${booking.bookingID}.pdf',
                                  image:        { type: 'jpeg', quality: 0.98 },
                                  html2canvas:  { scale: 2, useCORS: true },
                                  jsPDF:        { unit: 'in', format: 'a4', orientation: 'portrait' }
                                };
                                html2pdf().set(opt).from(element).save();
                            }
                        </script>
                    </div>
                </div>
                <div class="w-full relative flex-1">
                    <iframe id="contractIframe" src="contract.jsp?id=${booking.bookingID}" style="width: 100%; height: 100%; border: 1px solid #eee; border-radius: 8px;"></iframe>
                </div>
            </div>
        </div>

        <script>
            function openInvoiceModal() {
                const modal = document.getElementById('invoice-modal');
                if (modal) {
                    modal.style.display = 'flex';
                    const iframe = document.getElementById('invoiceIframe');
                    if (iframe && iframe.src === '') {
                        iframe.src = 'invoice.jsp?bookingId=';
                    }
                }
            }
            function closeInvoiceModal() {
                const modal = document.getElementById('invoice-modal');
                if (modal) modal.style.display = 'none';
            }
            
            function openContractModal() {
                const modal = document.getElementById('contract-modal');
                if (modal) modal.style.display = 'flex';
            }
            function closeContractModal() {
                const modal = document.getElementById('contract-modal');
                if (modal) modal.style.display = 'none';
            }
        </script>

        <!-- Cancellation Modal -->
        <div id="cancellation-info" style="display: none; z-index: 9999;" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-65 p-4 transition-all duration-300">
            <div class="bg-white rounded-2xl shadow-xl border border-gray-100 w-full max-w-xl overflow-hidden p-6 relative animate-fadeIn">
                <span class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 cursor-pointer text-2xl font-bold" onclick="closeCancellation()">&times;</span>
                <div class="text-center">
                    <div class="w-12 h-12 bg-red-50 rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-exclamation-triangle text-red-500 text-lg"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Xác Nhận Hủy Đơn</h3>
                    <p class="text-gray-500 text-sm mb-4">Bạn có chắc chắn muốn hủy đơn này hay không? <br><span class="font-semibold text-gray-700">SMARTRIDE</span> muốn biết lý do hủy đơn của bạn.</p>
                </div>
                <form id="cancel-form" action="cancelbooking" method="get" class="space-y-4">
                    <input type="hidden" id="bookingId" name="bookingId" value="${booking.bookingID}">
                    <div>
                        <textarea required name="cancelreason" id="cancelReason" rows="4" class="w-full border border-gray-200 rounded-xl p-3 text-sm focus:outline-none focus:ring-2 focus:ring-yellow-500 bg-gray-50" placeholder="Nhập lý do hủy đơn của bạn..."></textarea>
                    </div>
                    <div class="flex items-center justify-end gap-3 pt-4 border-t border-gray-100">
                        <button type="button" class="px-5 py-2 border border-gray-200 rounded-xl text-gray-500 hover:bg-gray-50 font-bold text-sm transition-colors cursor-pointer" onclick="closeCancellation()">Đóng</button>
                        <button type="submit" class="px-5 py-2 bg-red-500 hover:bg-red-600 text-white rounded-xl font-bold text-sm shadow-md shadow-red-500/10 transition-colors cursor-pointer">Gửi yêu cầu hủy</button>
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
                    <h3 class="text-xl font-bold text-gray-800">Thông tin gia hạn</h3>
                </div>
                <c:choose>
                    <c:when test="${extension == null}">
                        <div class="text-center py-8">
                            <p class="text-gray-400 italic">Không có thông tin gia hạn nào cho booking này.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="space-y-4">
                            <div class="grid grid-cols-2 gap-4">
                                <div class="bg-gray-50 p-3.5 rounded-xl border border-gray-100">
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-1">Mã đặt xe</span>
                                    <span class="text-sm font-bold text-gray-700">#${extension.bookingID}</span>
                                </div>
                                <div class="bg-gray-50 p-3.5 rounded-xl border border-gray-100">
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-1">Ngày gia hạn</span>
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
                                    <span class="text-gray-500 font-medium">Hạn trả trước đó:</span>
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
                                    <span class="text-gray-500 font-medium">Hạn trả mới:</span>
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
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-1">Phí gia hạn</span>
                                    <span class="text-sm font-bold text-green-600">
                                        <fmt:formatNumber value="${extension.extensionFee}" pattern="#,##0" /> VNĐ
                                    </span>
                                </div>
                                <div class="bg-gray-50 p-3.5 rounded-xl border border-gray-100">
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-1">Tổng tiền mới</span>
                                    <span class="text-sm font-bold text-yellow-600">
                                        <c:set var="total" value="${total + extension.extensionFee}" />
                                        <fmt:formatNumber value="${total}" pattern="#,##0" /> VNĐ
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="flex justify-end pt-6 mt-6 border-t border-gray-100">
                    <button type="button" class="px-5 py-2 hover:bg-gray-900 text-white rounded-xl font-bold text-sm shadow-md transition-colors cursor-pointer border-0" style="background-color: #1f2937;" onclick="closeExtension()">Đồng ý</button>
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
                
                // Auto open contract modal if requested (after successful payment)
                if (urlParams.get('autoContract') === '1') {
                    setTimeout(openContractModal, 800);
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
                        Swal.fire({icon: 'success', title: 'Thành công!', text: 'Thanh toán thành công! Hệ thống sẽ cập nhật trạng thái đơn hàng của bạn.'}).then(() => { window.location.reload(); });
                    } else {
                        Swal.fire({icon: 'error', title: 'Thất bại', text: "Lỗi khi cập nhật thanh toán: " + data.message});
                    }
                })
                .catch(err => {
                    console.error("Lỗi:", err);
                    Swal.fire({icon: 'error', title: 'Lỗi', text: "Đã xảy ra lỗi trong quá trình cập nhật thanh toán."});
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
                const invoice = document.getElementById("invoice-modal");

                if (event.target === extension) {
                    extension.style.display = "none";
                }
                if (event.target === extendFormModal) {
                    closeExtensionFormModal();
                }
                if (event.target === invoice) {
                    closeInvoiceModal();
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
                            <h3 class="text-xl font-bold text-gray-800">Gia hạn thời gian thuê xe</h3>
                            <p class="text-sm text-gray-500 font-medium">Hoàn tất gia hạn nhanh chóng qua SmartRide</p>
                        </div>
                    </div>
                    <button onclick="closeExtensionFormModal()" class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200 text-gray-400 hover:text-gray-600 transition-colors">
                        <i class="fas fa-times text-lg"></i>
                    </button>
                </div>
                <!-- Body (iframe) -->
                <div class="flex-1 w-full bg-gray-50 overflow-hidden relative" style="min-height: 75vh;">
                    <iframe id="extend-iframe" src="" class="w-full h-full border-none absolute inset-0" title="Gia Hạn Xe"></iframe>
                </div>
            </div>
        </div>

        <%-- ========== REAL-TIME GPS TRACKING (chi chay khi xe dang duoc giao cho khach) ========== --%>
        <c:if test="${statusBooking == 'Đã xác nhận' && booking.deliveryStatus == 'Đã giao'}">
        <script>
        (function() {
            var BOOKING_ID    = '${booking.bookingID}';
            var CUSTOMER_NAME = '${sessionScope.account.userName}';
            var CTX           = '${pageContext.request.contextPath}';
            var watchId       = null;
            var indicator     = null;

            // Tao indicator nho o goc man hinh
            function createIndicator() {
                indicator = document.createElement('div');
                indicator.id = 'gps-track-indicator';
                indicator.innerHTML = '<span style="display:inline-block;width:8px;height:8px;border-radius:50%;background:#22c55e;margin-right:6px;animation:gpsPulse 1.5s infinite;"></span>Dang chia se vi tri';
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

            // Gui toa do len server
            function sendLocation(lat, lon) {
                var fd = new FormData();
                fd.append('bookingId',    BOOKING_ID);
                fd.append('lat',          lat);
                fd.append('lon',          lon);
                fd.append('customerName', CUSTOMER_NAME);
                fetch(CTX + '/api/update-location', { method: 'POST', body: fd })
                    .then(function(r){ return r.json(); })
                    .then(function(d){
                        if (d.ok) setIndicator('Dang chia se vi tri', '#22c55e');
                        else      setIndicator('Loi gui vi tri', '#ef4444');
                    })
                    .catch(function(){ setIndicator('Mat ket noi', '#f59e0b'); });
            }

            // Bat dau watch
            function startTracking() {
                if (!navigator.geolocation) {
                    Swal.fire({icon: 'error', title: 'Lỗi GPS', text: "Điện thoại của bạn không hỗ trợ GPS. Yêu cầu đổi thiết bị!"});
                    return;
                }
                createIndicator();
                setIndicator('Đang kết nối GPS...', '#f59e0b');
                watchId = navigator.geolocation.watchPosition(
                    function(pos) {
                        // Xóa cảnh báo nếu có
                        var alertBox = document.getElementById('gps-warning-banner');
                        if (alertBox) alertBox.remove();
                        sendLocation(pos.coords.latitude, pos.coords.longitude);
                    },
                    function(err) {
                        setIndicator('Chưa cấp quyền GPS', '#ef4444');
                        // Tạo banner cảnh báo to đùng
                        if (!document.getElementById('gps-warning-banner')) {
                            var banner = document.createElement('div');
                            banner.id = 'gps-warning-banner';
                            banner.style.cssText = 'position:fixed;top:0;left:0;width:100%;background:#ef4444;color:white;text-align:center;padding:15px;z-index:999999;font-weight:bold;box-shadow:0 4px 6px rgba(0,0,0,0.1);';
                            banner.innerHTML = '<i class="fas fa-exclamation-triangle"></i> BẮT BUỘC: Bạn đang trong thời gian thuê xe. Vui lòng cấp quyền Truy cập Vị trí (GPS) trên trình duyệt để tiếp tục sử dụng dịch vụ!';
                            document.body.prepend(banner);
                            Swal.fire({icon: 'warning', title: 'BẮT BUỘC BẬT ĐỊNH VỊ!', text: "Hệ thống phát hiện bạn đã từ chối quyền Truy cập Vị trí. Theo chính sách an toàn, bạn buộc phải cho phép trang web này lấy vị trí của bạn."});
                        }
                    },
                    { enableHighAccuracy: true, timeout: 15000, maximumAge: 10000 }
                );
            }

            // Khi trang load xong -> tu dong bat dau
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', startTracking);
            } else {
                startTracking();
            }

            // Khi dong tab -> dung watchPosition
            window.addEventListener('beforeunload', function() {
                if (watchId !== null) navigator.geolocation.clearWatch(watchId);
            });
        })();
        </script>
        </c:if>
        
        <script>
        // ========================== CHAT LOGIC ==========================
        let chatInterval = null;
        let bId = '${booking.bookingID}';

        function loadChatMessages() {
            if(!bId) return;
            
            fetch('${pageContext.request.contextPath}/api/chat?bookingId=' + bId)
            .then(r => r.json())
            .then(data => {
                let html = '';
                data.forEach(msg => {
                    let isCustomer = msg.senderRole === 'CUSTOMER';
                    let align = isCustomer ? 'flex-end' : 'flex-start';
                    let bgColor = isCustomer ? '#2563eb' : '#ffffff';
                    let textColor = isCustomer ? 'white' : '#1f2937';
                    let borderClass = isCustomer ? 'rounded-tl-2xl rounded-tr-2xl rounded-bl-2xl rounded-br-sm' : 'rounded-tl-2xl rounded-tr-2xl rounded-br-2xl rounded-bl-sm border border-gray-200 shadow-sm';
                    
                    html += `
                    <div class="flex flex-col mb-1" style="align-items: \${align};">
                        <div class="text-[10px] text-gray-400 mb-1 px-1 font-medium">\${msg.senderName} • \${msg.sentAt}</div>
                        <div class="px-4 py-2.5 max-w-[85%] break-words \${borderClass}" style="background-color: \${bgColor}; color: \${textColor};">
                            \${msg.message}
                        </div>
                    </div>`;
                });
                
                let container = $('#chat-messages-container');
                let shouldScroll = container[0].scrollHeight - container.scrollTop() <= container.outerHeight() + 50;
                
                container.html(html);
                
                if (shouldScroll || data.length === 0) {
                    container.scrollTop(container[0].scrollHeight);
                }
            })
            .catch(console.error);
        }

        function sendChatMessage() {
            var msgInput = $('#chat-input');
            var text = msgInput.val().trim();
            
            if(!text || !bId) return;
            
            msgInput.val(''); // clear early
            
            fetch('${pageContext.request.contextPath}/api/chat', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({ bookingId: bId, message: text })
            })
            .then(r => r.json())
            .then(data => {
                if(data.status === 'success') {
                    loadChatMessages(); // reload immediately
                }
            })
            .catch(console.error);
        }

        $(document).ready(function() {
            loadChatMessages();
            chatInterval = setInterval(loadChatMessages, 3000);
            
            var urlParams = new URLSearchParams(window.location.search);
            if(urlParams.get('openChat') === 'true') {
                setTimeout(function() {
                    document.getElementById('chat-section').scrollIntoView({behavior: 'smooth', block: 'center'});
                    $('#chat-input').focus();
                }, 1000);
            }
        });
        </script>
    </body>
</html>


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

                        <!-- Giao xe banner -->
                        <c:if test="${statusBooking eq 'Đã xác nhận' and booking.deliveryStatus ne 'Đã giao' and booking.deliveryStatus ne 'Đã trả' and not fn:containsIgnoreCase(booking.deliveryLocation, 'Tại cửa hàng')}">
                            <div class="mb-6 w-full animate-fadeIn">
                                <div id="delivery-estimate-history" style="display:none; padding:16px 20px; border-radius:16px; font-size:14px; box-shadow: 0 4px 15px rgba(0,0,0,0.03);">
                                    <i class="fas fa-spinner fa-spin mr-1"></i> Đang tính toán thời gian giao xe dự kiến...
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
                                    estBox.innerHTML = '<div class="flex items-center gap-4"><div class="w-12 h-12 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center shrink-0 text-xl"><i class="fas fa-clock"></i></div><div><strong class="text-blue-900 text-base">Thời gian giao xe dự kiến còn:</strong> <span class="text-xl font-bold text-blue-700 ml-1">' + diffMins + ' phút</span><br><span class="text-sm text-blue-700 mt-1 block">Tài xế đang chuẩn bị xe và sẽ đến đúng giờ.</span></div></div>';
                                    estBox.style.background = '#eff6ff';
                                    estBox.style.border = '1px solid #bfdbfe';
                                } else {
                                    var lateMins = Math.abs(diffMins);
                                    if (lateMins <= 45) {
                                        estBox.innerHTML = '<div class="flex items-center gap-4"><div class="w-12 h-12 rounded-full bg-orange-100 text-orange-600 flex items-center justify-center shrink-0 text-xl"><i class="fas fa-exclamation-triangle"></i></div><div><strong class="text-orange-900 text-base">Tài xế đang đến trễ:</strong> <span class="text-lg font-bold text-orange-700">' + lateMins + ' phút</span>.<br><span class="text-sm text-orange-800 mt-1 block">Mong quý khách thông cảm chờ trong giây lát. Nếu quá 45 phút, SmartRide sẽ gửi tặng mã giảm giá đền bù!</span></div></div>';
                                        estBox.style.background = '#fff7ed';
                                        estBox.style.border = '1px solid #fed7aa';
                                    } else {
                                        estBox.innerHTML = '<div class="flex items-center gap-4"><div class="w-12 h-12 rounded-full bg-red-100 text-red-600 flex items-center justify-center shrink-0 text-xl"><i class="fas fa-exclamation-circle"></i></div><div><strong class="text-red-900 text-base">Giao xe trễ quá 45 phút!</strong><br><p class="mt-1 text-sm text-red-800">Hệ thống đã tự động gửi mã đền bù vào <strong>Hộp thư Thông báo</strong> của bạn. Vui lòng kiểm tra chuông thông báo nhé!</p></div></div>';
                                        estBox.style.background = '#fef2f2';
                                        estBox.style.border = '1px solid #fecaca';
                                        if (!window.lateVoucherTriggered) {
                                            window.lateVoucherTriggered = true;
                                            fetch('notification?action=triggerLateVoucher&bookingId=' + encodeURIComponent('${booking.bookingID}'), { method: 'POST' })
                                            .then(() => { if(typeof fetchNotifications === 'function') fetchNotifications(); });
                                        }
                                    }
                                }
                            })();
                            </script>
                        </c:if>

                        <!-- Content Grid: Premium Layout -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
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
                                        <div class="flex items-start gap-4">
                                            <div class="w-10 h-10 rounded-full bg-yellow-50 flex items-center justify-center shrink-0 mt-0.5">
                                                <i class="fas fa-map-marker-alt text-yellow-500 text-lg"></i>
                                            </div>
                                            <div>
                                                <p class="text-xs text-gray-400 font-bold uppercase mb-1">Nhận xe</p>
                                                <p class="text-base text-gray-800 font-bold leading-relaxed mb-0.5" id="delivery-location-text">${booking.deliveryLocation}</p>
                                                <p class="text-sm text-yellow-600 font-semibold"><i class="far fa-clock mr-1"></i> ${booking.startDate}</p>
                                            </div>
                                        </div>
                                        <div class="flex items-start gap-4">
                                            <div class="w-10 h-10 rounded-full bg-green-50 flex items-center justify-center shrink-0 mt-0.5">
                                                <i class="fas fa-flag-checkered text-green-500 text-lg"></i>
                                            </div>
                                            <div>
                                                <p class="text-xs text-gray-400 font-bold uppercase mb-1">Trả xe</p>
                                                <p class="text-base text-gray-800 font-bold leading-relaxed mb-0.5" id="return-location-text">${booking.returnedLocation}</p>
                                                <p class="text-sm text-green-600 font-semibold"><i class="far fa-clock mr-1"></i> ${booking.endDate}</p>
                                            </div>
                                        </div>
                                        <c:if test="${statusBooking == 'Đã xác nhận'}">
                                            <div class="mt-6 pt-5 border-t border-gray-100 flex items-center gap-4">
                                                <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center shrink-0">
                                                    <i class="fas fa-truck text-blue-500 text-lg"></i>
                                                </div>
                                                <div>
                                                    <p class="text-xs text-gray-400 font-bold uppercase mb-1">Trạng thái giao xe</p>
                                                    <p class="text-base text-blue-700 font-black">${booking.deliveryStatus}</p>
                                                </div>
                                            </div>
                                        </c:if>


                                        <c:if test="${statusBooking == 'Đã hủy' && not empty cancellation}">
                                            <div class="mt-6 pt-5 border-t border-gray-100 flex items-start gap-4">
                                                <div class="w-10 h-10 rounded-full bg-red-50 flex items-center justify-center shrink-0">
                                                    <i class="fas fa-times-circle text-red-500 text-lg"></i>
                                                </div>
                                                <div>
                                                    <p class="text-xs text-gray-400 font-bold uppercase mb-1">Lý do hủy đơn</p>
                                                    <p class="text-base text-red-700 font-medium">${cancellation.note}</p>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <!-- Column 4: Định vị GPS -->
                            <div class="flex flex-col h-full">
                                <div class="bg-white border border-gray-100 shadow-sm rounded-2xl p-6 relative overflow-hidden flex-1">
<!-- GPS DEMO BLOCK -->
                                              <c:if test="${booking.deliveryStatus == 'Đã giao'}">
                                                  <div class="mt-4 pt-4 border-t border-gray-100">
                                                      <div class="p-5 bg-gradient-to-r from-blue-50 to-indigo-50 border border-blue-100 rounded-2xl relative overflow-hidden">
                                                          <div class="absolute top-0 right-0 w-24 h-24 bg-blue-100 rounded-bl-full -z-0 opacity-50"></div>
                                                          <h4 class="text-blue-800 font-bold mb-2 flex items-center relative z-10"><i class="fas fa-location-arrow mr-2"></i> Trình theo dõi GPS</h4>
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
                                              </c:if>
                                              <c:if test="${booking.deliveryStatus != 'Đã giao'}">
                                                  <div class="mt-4 pt-4 border-t border-gray-100 h-full flex flex-col items-center justify-center text-center opacity-60">
                                                      <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mb-3">
                                                          <i class="fas fa-location-arrow text-gray-400 text-2xl"></i>
                                                      </div>
                                                      <p class="text-sm font-bold text-gray-500 mb-1">Chưa khả dụng</p>
                                                      <p class="text-xs text-gray-400 px-4">Tính năng phát GPS chỉ khả dụng khi bạn đang trong quá trình thuê xe (Đã nhận xe).</p>
                                                  </div>
                                              </c:if>

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
                                                      
                                                      let fdStop = new FormData();
                                                      fdStop.append('action', 'stop');
                                                      fdStop.append('bookingId', '${booking.bookingID}');
                                                      fetch('${pageContext.request.contextPath}/api/update-location', {
                                                          method: 'POST',
                                                          body: fdStop
                                                      });
                                                      
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
                                                          fd.append('bookingId', '${booking.bookingID}');
                                                          fd.append('lat', lat);
                                                          fd.append('lon', lon);
                                                          fd.append('customerName', '${account.lastName} ${account.firstName}');
                                                          fd.append('vehicleName', 'Motorcycle #${not empty booking.listBookingDetails ? booking.listBookingDetails[0].motorcycleDetailID : "Unknown"}');
                                                          fd.append('phone', '${account.phoneNumber}');
                                                          
                                                          fetch('${pageContext.request.contextPath}/api/update-location', {
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
                                <script>
                                // Dịch "Your own address" → tiếng Việt và định dạng phí giao xe
                                (function() {
                                    function cleanLoc(el) {
                                        if (!el) return;
                                        var t = el.textContent || el.innerText;
                                        // Thay "Your own address" → "Địa chỉ tự nhập"
                                        t = t.replace(/Your own address/gi, 'Địa chỉ tự nhập');
                                        // Thay "(Phí giao xe: 25000d)" → "(Phí giao: 25.000đ)"
                                        t = t.replace(/\(Phí giao xe:\s*([\d]+)d?\)/gi, function(_, n) {
                                            return '(Phí giao: ' + parseInt(n).toLocaleString('vi-VN') + 'đ)';
                                        });
                                        el.textContent = t;
                                    }
                                    document.addEventListener('DOMContentLoaded', function() {
                                        cleanLoc(document.getElementById('delivery-location-text'));
                                        cleanLoc(document.getElementById('return-location-text'));
                                    });
                                })();
                                </script>
                                </div>
                            </div>
                            <!-- Column 2: Chi tiết xe -->
                            <div class="flex flex-col h-full">
                                
                                <!-- Card: Chi tiết Xe -->
                                <div class="bg-white border border-gray-100 shadow-sm rounded-2xl p-6 relative overflow-hidden flex-1">
                                    <h4 class="text-lg font-extrabold text-gray-800 mb-5 flex items-center">
                                        <i class="fas fa-motorcycle text-yellow-500 mr-3 text-xl"></i> Chi tiết phương tiện
                                    </h4>
                                    
                                    <div class="space-y-3 mb-5">
                                        <div class="flex justify-between items-center text-sm">
                                            <span class="text-gray-500 font-medium">Mã đơn hàng:</span>
                                            <span class="font-bold text-gray-800 bg-gray-100 px-2 py-1 rounded">#${booking.bookingID}</span>
                                        </div>
                                        <div class="flex justify-between items-center text-sm">
                                            <span class="text-gray-500 font-medium">Thời gian tạo:</span>
                                            <span class="font-semibold text-gray-700">${bookingDay}-${bookingMonth}-${bookingYear} ${bookingHour}:${bookingMinute}</span>
                                        </div>
                                        <div class="flex justify-between items-center text-sm">
                                            <span class="text-gray-500 font-medium">Tổng số lượng xe:</span>
                                            <span class="font-bold text-yellow-600 bg-yellow-50 px-2.5 py-1 rounded-md border border-yellow-100">${fn:length(booking.listBookingDetails)} xe</span>
                                        </div>
                                    </div>
                                    
                                    <div class="bg-gray-50 border border-gray-200 rounded-xl p-5">
                                        <p class="text-xs text-gray-500 font-bold uppercase tracking-wider mb-3">Các phương tiện đã thuê</p>
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
                            <!-- Column 3: Tổng kết thanh toán -->
                            <div class="flex flex-col h-full">
                                <!-- Card: Tổng kết thanh toán -->
                                <div class="bg-gray-900 rounded-2xl p-6 relative overflow-hidden text-white shadow-xl shadow-gray-900/10 flex-1">
                                    <div class="absolute -right-6 -top-6 w-40 h-40 bg-white/5 rounded-full blur-3xl"></div>
                                    <div class="absolute -left-6 -bottom-6 w-32 h-32 bg-yellow-500/20 rounded-full blur-2xl"></div>
                                    
                                    <h4 class="text-lg font-extrabold text-white mb-5 flex items-center relative z-10">
                                        <i class="fas fa-file-invoice-dollar text-yellow-400 mr-3 text-xl"></i> Tổng kết thanh toán
                                    </h4>
                                    
                                    <div class="space-y-4 relative z-10">
                                        <div class="flex justify-between items-end border-b border-white/10 pb-5">
                                            <div>
                                                <p class="text-gray-400 text-xs font-bold uppercase tracking-widest mb-1">Tổng tiền thuê xe</p>
                                                <p class="text-3xl font-black text-white tracking-tight" id="total-price">
                                                    <c:set var="total" value="0"/>
                                                    <c:forEach items="${booking.listBookingDetails}" var="detail">
                                                        <c:set var="total" value="${total + detail.totalPrice}"/>
                                                    </c:forEach>
                                                    <c:set var="total" value="${total + booking.deliveryFee}" />
                                                    <fmt:formatNumber value="${total}" pattern="#,##0" /> VNĐ
                                                </p>
                                            </div>
                                        </div>
                                        <div class="flex justify-between items-center pt-1 border-b border-white/10 pb-4">
                                            <div>
                                                <c:set var="paidAmount" value="0" />
                                                <c:if test="${not empty payment}">
                                                    <c:set var="paidAmount" value="${payment.paymentAmount}" />
                                                </c:if>
                                                <p class="text-gray-400 text-xs font-bold uppercase tracking-widest mb-1.5">Tiền cọc (${paidAmount > 0 ? 'Đã thanh toán' : 'Chưa thanh toán'})</p>
                                                <p class="text-2xl font-bold ${paidAmount > 0 ? 'text-green-400' : 'text-yellow-400'}" id="amount-paid">
                                                    <fmt:formatNumber value="${paidAmount}" pattern="#,##0" /> VNĐ
                                                </p>
                                            </div>
                                            <div class="w-12 h-12 rounded-full ${paidAmount > 0 ? 'bg-green-500/20 border-green-500/30 text-green-400' : 'bg-yellow-500/20 border-yellow-500/30 text-yellow-400'} flex items-center justify-center border">
                                                <i class="fas ${paidAmount > 0 ? 'fa-check' : 'fa-clock'} text-lg"></i>
                                            </div>
                                        </div>
                                        <div class="flex justify-between items-center pt-1">
                                            <div>
                                                <p class="text-gray-400 text-xs font-bold uppercase tracking-widest mb-1.5">Số tiền cần thanh toán thêm</p>
                                                <p class="text-xl font-bold text-rose-400">
                                                    <fmt:formatNumber value="${total - paidAmount}" pattern="#,##0" /> VNĐ
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>

                        <!-- Gửi khiếu nại (Report) khi Admin từ chối/Hủy -->
                        <c:if test="${statusBooking == 'Đã hủy'}">
                            <div class="mb-6 bg-white border border-red-100 shadow-sm rounded-2xl p-6 relative overflow-hidden animate-fadeIn">
                                <h4 class="text-lg font-extrabold text-red-800 mb-4 flex items-center">
                                    <i class="fas fa-headset text-red-500 mr-3 text-xl"></i> Hỗ trợ & Khiếu nại (Report)
                                </h4>
                                <div class="bg-red-50 border border-red-100 rounded-xl p-4 flex flex-col gap-3 h-[400px]">
                                    <div id="chat-messages" class="flex-1 overflow-y-auto flex flex-col gap-3 pr-2 scrollbar-thin scrollbar-thumb-red-200">
                                        <!-- Default Welcome / Cancel Reason Message -->
                                        <c:choose>
                                            <c:when test="${not empty cancellation}">
                                                <div class="bg-white p-3.5 rounded-xl shadow-sm border border-red-50 self-start max-w-[90%] animate-fadeIn">
                                                    <p class="text-base font-medium text-gray-800 leading-relaxed">Đơn hàng của bạn đã bị hủy. Lý do: <strong class="text-red-600">${cancellation.note}</strong></p>
                                                    <span class="text-xs text-gray-500 mt-2 block font-medium">Hệ thống CSKH SmartRide</span>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-white p-3.5 rounded-xl shadow-sm border border-red-50 self-start max-w-[90%] animate-fadeIn">
                                                    <p class="text-base font-medium text-gray-800 leading-relaxed">Rất tiếc vì đơn hàng của bạn đã bị hủy. Nếu bạn cần hỗ trợ thêm hoặc muốn khiếu nại về quyết định này, vui lòng gửi tin nhắn cho Admin tại đây. Chúng tôi sẽ phản hồi sớm nhất có thể!</p>
                                                    <span class="text-xs text-gray-400 mt-2 block font-medium">Hệ thống CSKH SmartRide</span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <form id="chat-form" onsubmit="sendChatMessage(event)" class="flex gap-3 mt-2 shrink-0">
                                        <input type="text" id="chat-input" required placeholder="Nhập nội dung khiếu nại của bạn..." class="flex-1 border border-gray-300 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-red-400 focus:ring-1 focus:ring-red-400 bg-white">
                                        <button type="submit" id="chat-submit-btn" class="text-white rounded-xl px-5 flex items-center justify-center shadow-md transition-colors font-bold cursor-pointer disabled:opacity-50" style="background-color: #7c3aed;">
                                            Gửi <i class="fas fa-paper-plane ml-2"></i>
                                        </button>
                                    </form>
                                </div>
                                <script>
                                    const chatBookingId = '${booking.bookingID}';
                                    const chatApiUrl = '${pageContext.request.contextPath}/api/chat';
                                    const chatMessagesBox = document.getElementById('chat-messages');
                                    let lastMessageId = 0;

                                    function fetchChatMessages() {
                                        fetch(chatApiUrl + '?bookingId=' + chatBookingId)
                                            .then(response => response.json())
                                            .then(messages => {
                                                if (messages.length > 0) {
                                                    // Only append new messages
                                                    messages.forEach(msg => {
                                                        if (msg.messageId > lastMessageId) {
                                                            appendMessageToUI(msg);
                                                            lastMessageId = msg.messageId;
                                                        }
                                                    });
                                                }
                                            })
                                            .catch(console.error);
                                    }

                                    function appendMessageToUI(msg) {
                                        const div = document.createElement('div');
                                        div.className = 'max-w-[75%] px-4 py-2.5 shadow-sm flex flex-col ' + 
                                            (msg.senderRole === 'CUSTOMER' ? 'self-end text-white' : 'self-start text-gray-900');
                                        div.style.backgroundColor = msg.senderRole === 'CUSTOMER' ? '#7c3aed' : '#e4e6eb';
                                        div.style.borderRadius = msg.senderRole === 'CUSTOMER' ? '20px 20px 4px 20px' : '20px 20px 20px 4px';
                                        
                                        const p = document.createElement('p');
                                        p.className = 'text-[15px] leading-relaxed break-words';
                                        p.textContent = msg.message;
                                        
                                        const span = document.createElement('span');
                                        span.className = 'text-[10px] mt-1 block ' + (msg.senderRole === 'CUSTOMER' ? 'text-indigo-100 text-right' : 'text-gray-500');
                                        span.textContent = msg.senderRole === 'CUSTOMER' ? msg.sentAt : 'Admin • ' + msg.sentAt;
                                        
                                        div.appendChild(p);
                                        div.appendChild(span);
                                        chatMessagesBox.appendChild(div);
                                        chatMessagesBox.scrollTop = chatMessagesBox.scrollHeight;
                                    }

                                    function sendChatMessage(event) {
                                        event.preventDefault();
                                        const input = document.getElementById('chat-input');
                                        const btn = document.getElementById('chat-submit-btn');
                                        const message = input.value.trim();
                                        if (!message) return;

                                        input.disabled = true;
                                        btn.disabled = true;

                                        fetch(chatApiUrl, {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ bookingId: chatBookingId, message: message })
                                        })
                                        .then(response => response.json())
                                        .then(data => {
                                            input.disabled = false;
                                            btn.disabled = false;
                                            if (data.status === 'success') {
                                                input.value = '';
                                                fetchChatMessages(); // instantly fetch to show the new message
                                            } else {
                                                alert('Lỗi: ' + data.error);
                                            }
                                        })
                                        .catch(err => {
                                            input.disabled = false;
                                            btn.disabled = false;
                                            alert('Lỗi kết nối khi gửi tin nhắn.');
                                        });
                                    }

                                    // Auto fetch every 10 seconds and on load
                                    document.addEventListener('DOMContentLoaded', () => {
                                        fetchChatMessages();
                                        setInterval(fetchChatMessages, 10000);
                                        
                                        const urlParams = new URLSearchParams(window.location.search);
                                        if (urlParams.get('openChat') === 'true') {
                                            setTimeout(() => {
                                                const chatBox = document.getElementById('chat-messages');
                                                if (chatBox) chatBox.scrollIntoView({ behavior: 'smooth', block: 'center' });
                                            }, 300);
                                        }
                                    });
                                </script>
                            </div>
                        </c:if>

                        <!-- Mini Extension Info Link -->
                        <div class="mb-8 text-right relative z-50">
                            <button type="button" class="inline-flex items-center gap-1.5 text-sm font-bold text-yellow-600 hover:text-yellow-700 transition-colors border-b border-dashed border-yellow-600/50 pb-0.5 cursor-pointer bg-transparent border-0 outline-none" onclick="openExtension()">
                                <i class="fas fa-info-circle"></i> Xem thông tin gia hạn lịch trình
                            </button>
                        </div>

                        <!-- Detail Actions Buttons -->
                        <div class="flex flex-wrap items-center justify-end gap-3 pt-5 border-t border-gray-100 relative z-50">
                            <c:if test="${statusBooking == 'Chờ xác nhận'}">
                                <button type="button" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-sm transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #ef4444" onclick="openCancellation()">
                                    <i class="fas fa-times-circle"></i> Hủy đơn hàng
                                </button>
                            </c:if>
                            
                            <c:if test="${statusBooking == 'Đã xác nhận' && booking.deliveryStatus == 'Đã giao'}">
                                <button type="button" class="px-4 py-2 rounded-xl font-bold text-sm shadow-sm transition-all duration-200 cursor-pointer flex items-center gap-2 hover:shadow-md hover:-translate-y-0.5 animate-pulse" style="background-color: #dc2626; color: white;" onclick="openSosModal()">
                                    <i class="fas fa-exclamation-triangle text-lg"></i> 
                                    <span>SOS Khẩn Cấp</span>
                                </button>
                            </c:if>
                            <c:if test="${statusBooking != 'Đã hủy'}">
                                <button type="button" id="pay-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #10b981">
                                    <i class="fas fa-wallet"></i> Thanh toán ngay
                                </button>
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
                            <button type="button" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #059669" onclick="document.getElementById('contract-modal').style.display='flex'">
                                <i class="fas fa-file-contract"></i> Xem Hợp Đồng
                            </button>
                            <button type="button" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #1e293b" onclick="closeDetail()">
                                <i class="fas fa-chevron-left"></i> Quay về danh sách
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- HỢP ĐỒNG THUÊ XE MODAL -->
        <div id="contract-modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.65); z-index:99999; align-items:center; justify-content:center; padding:20px; box-sizing:border-box;">
            <div style="background:#fff; border-radius:12px; max-width:850px; width:100%; height:90vh; overflow:hidden; display:flex; flex-direction:column; box-shadow:0 24px 60px rgba(0,0,0,0.3);">
                <div style="padding:16px 24px; border-bottom:1px solid #eee; display:flex; align-items:center; justify-content:space-between; background:#fafafa;">
                    <div>
                        <h3 style="margin:0; color:#059669; font-size:18px;"><i class="fas fa-file-signature"></i> Hợp Đồng Thuê Xe Điện Tử</h3>
                        <p style="margin:4px 0 0; font-size:12px; color:#777;">Hợp đồng được lập dựa trên sự đồng ý của bạn lúc đặt xe.</p>
                    </div>
                    <button type="button" onclick="document.getElementById('contract-modal').style.display='none'"
                        style="background:#f1f5f9; border:none; width:34px; height:34px; border-radius:50%; font-size:18px; cursor:pointer; color:#475569; transition: background 0.2s;">&times;</button>
                </div>
                <div style="flex:1; width:100%; overflow:hidden;">
                    <iframe src="contract.jsp?id=${booking.bookingID}" style="width:100%; height:100%; border:none;"></iframe>
                </div>
                <div style="padding:14px 24px; border-top:1px solid #eee; display:flex; justify-content:flex-end; gap:10px; background:#fafafa;">
                    <button type="button" onclick="document.getElementById('contract-modal').style.display='none'"
                        style="padding:10px 24px; background:#e2e8f0; color:#334155; border:none; border-radius:8px; font-size:14px; font-weight:700; cursor:pointer;">Đóng</button>
                    <button type="button" onclick="window.open('contract.jsp?id=${booking.bookingID}&print=1', '_blank')"
                        style="padding:10px 24px; background:#059669; color:#fff; border:none; border-radius:8px; font-size:14px; font-weight:700; cursor:pointer; box-shadow: 0 4px 6px -1px rgba(5, 150, 105, 0.5);"><i class="fas fa-print"></i> In / Tải về PDF</button>
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
                        <textarea required name="cancelreason" id="cancelReason" rows="4" class="w-full border border-gray-200 rounded-xl p-3 text-sm focus:outline-none focus:ring-2 focus:ring-yellow-500 bg-gray-50 mb-3" placeholder="Nhập lý do hủy đơn của bạn..."></textarea>
                        <input type="text" name="bankinfo" id="bankInfo" class="w-full border border-gray-200 rounded-xl p-3 text-sm focus:outline-none focus:ring-2 focus:ring-yellow-500 bg-gray-50" placeholder="Số tài khoản ngân hàng để hoàn tiền (Không bắt buộc)">
                        <p class="text-xs text-gray-400 mt-1 ml-1">* Nếu bạn đã đặt cọc, vui lòng cung cấp STK để chúng tôi hoàn tiền.</p>
                    </div>
                    <div class="flex items-center justify-end gap-3 pt-4 border-t border-gray-100">
                        <button type="button" class="px-5 py-2 rounded-xl font-bold text-sm transition-colors cursor-pointer" style="background-color: #f3f4f6; color: #4b5563; border: 1px solid #d1d5db;" onclick="closeCancellation()">Đóng</button>
                        <button type="submit" class="px-5 py-2 rounded-xl font-bold text-sm transition-colors cursor-pointer" style="background-color: #ef4444; color: white; border: none; box-shadow: 0 4px 6px -1px rgba(239, 68, 68, 0.2);">Gửi yêu cầu hủy</button>
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
                
                // Auto open contract modal if requested (from email link)
                if (urlParams.get('autoContract') === '1') {
                    setTimeout(() => {
                        document.getElementById('contract-modal').style.display='flex';
                    }, 500);
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
                        alert("Thanh toán thành công! Hệ thống sẽ cập nhật trạng thái đơn hàng của bạn.");
                        window.location.reload();
                    } else {
                        alert("Lỗi khi cập nhật thanh toán: " + data.message);
                    }
                })
                .catch(err => {
                    console.error("Lỗi:", err);
                    alert("Đã xảy ra lỗi trong quá trình cập nhật thanh toán.");
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
                // Handle payment success from sepay_pay.jsp iframe
                if (event.data && event.data.status === 'success') {
                    closePaymentModal();
                    if (typeof Swal !== 'undefined') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Thanh toán thành công!',
                            text: 'Đơn hàng của bạn đã được ghi nhận. Vui lòng xem Hợp Đồng Điện Tử bên dưới.',
                            showCancelButton: true,
                            confirmButtonColor: '#059669',
                            cancelButtonColor: '#1e293b',
                            confirmButtonText: '<i class="fas fa-file-contract"></i> Xem Hợp Đồng',
                            cancelButtonText: 'Đóng'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                document.getElementById('contract-modal').style.display='flex';
                            } else {
                                window.location.reload();
                            }
                        });
                    } else {
                        alert('Thanh toán thành công!');
                        document.getElementById('contract-modal').style.display='flex';
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

        <!-- Modal for SOS Request -->
        <c:if test="${statusBooking == 'Đã xác nhận' && booking.deliveryStatus == 'Đã giao'}">
        <div id="sos-modal" class="hidden items-center justify-center p-4" style="position: fixed; inset: 0; background-color: rgba(0,0,0,0.6); backdrop-filter: blur(4px); z-index: 999999;">
            <div class="bg-white rounded-2xl w-full max-w-lg shadow-2xl relative flex flex-col overflow-hidden animate-fade-in-up p-6">
                <div class="flex items-center gap-3 text-red-600 border-b border-red-100 pb-4 mb-4">
                    <i class="fas fa-exclamation-triangle text-3xl"></i>
                    <h3 class="text-xl font-bold">Gửi yêu cầu Cứu hộ (SOS)</h3>
                </div>
                <p class="text-gray-600 text-sm mb-4">Hệ thống sẽ tự động lấy vị trí hiện tại của bạn cho SmartRide. Hãy cho chúng tôi biết vấn đề bạn đang gặp phải.</p>
                <textarea id="sos-note" rows="3" class="w-full border border-gray-300 rounded-xl p-3 text-sm focus:outline-none focus:ring-2 focus:ring-red-400 mb-4" placeholder="Ví dụ: Xe lủng lốp, không nổ máy được..."></textarea>
                <div class="flex justify-end gap-3 pt-6 border-t border-gray-100">
                    <button type="button" class="px-5 py-2 rounded-xl font-bold transition-colors" style="background-color: #f3f4f6; color: #4b5563; border: 1px solid #d1d5db;" onclick="closeSosModal()">Hủy</button>
                    <button type="button" onclick="sendSosRequest()" class="px-5 py-2 rounded-xl font-bold shadow-md transition-colors flex items-center gap-2" style="background-color: #dc2626; color: white;">
                        <i class="fas fa-paper-plane"></i> Gửi yêu cầu ngay
                    </button>
                </div>
            </div>
        </div>
        <script>
            function openSosModal() {
                const modal = document.getElementById("sos-modal");
                if (modal) { modal.style.display = 'flex'; modal.classList.remove('hidden'); }
            }
            function closeSosModal() {
                const modal = document.getElementById("sos-modal");
                if (modal) { modal.style.display = 'none'; modal.classList.add('hidden'); }
            }
            function sendSosRequest() {
                const note = document.getElementById('sos-note').value;
                if (!note) {
                    alert('Vui lòng nhập lý do gặp sự cố!');
                    return;
                }
                if (!navigator.geolocation) {
                    alert("Trình duyệt không hỗ trợ định vị. Không thể gửi SOS.");
                    return;
                }
                document.body.style.cursor = 'wait';
                navigator.geolocation.getCurrentPosition(function(pos) {
                    const lat = pos.coords.latitude;
                    const lng = pos.coords.longitude;
                    const fd = new URLSearchParams();
                    fd.append('bookingId', '${booking.bookingID}');
                    fd.append('lat', lat);
                    fd.append('lng', lng);
                    fd.append('note', note);
                    fetch('${pageContext.request.contextPath}/api/sos', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: fd.toString()
                    }).then(r => r.json()).then(data => {
                        document.body.style.cursor = 'default';
                        if(data.status === 'success') {
                            alert('Gửi yêu cầu cứu hộ thành công! Vị trí đã được gửi, Đội ngũ SmartRide đang đến.');
                            closeSosModal();
                        } else {
                            alert('Lỗi: ' + data.message);
                        }
                    }).catch(e => {
                        document.body.style.cursor = 'default';
                        alert('Lỗi kết nối. Hãy thử lại.');
                    });
                }, function(err) {
                    document.body.style.cursor = 'default';
                    alert("Không thể lấy vị trí hiện tại. Vui lòng cấp quyền vị trí cho trình duyệt!");
                }, { enableHighAccuracy: true, timeout: 10000 });
            }

            document.addEventListener('DOMContentLoaded', function() {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('openSos') === 'true') {
                    setTimeout(openSosModal, 300);
                }
            });
        </script>
        </c:if>

        <%-- ========== REAL-TIME GPS TRACKING (chạy khi xe đang được giao cho khách) ========== --%>
        <c:if test="${statusBooking == 'Đã xác nhận' && booking.deliveryStatus == 'Đã giao'}">
        <script>
        (function() {
            var BOOKING_ID    = '${booking.bookingID}';
            var CUSTOMER_NAME = '${sessionScope.account.userName}';
            var MOTOR_NAME    = '${booking.motorcycle.model}';
            var PHONE         = '${sessionScope.account.phone}';
            var CTX           = '${pageContext.request.contextPath}';
            var watchId       = null;
            var indicator     = null;

            // Tạo indicator nhỏ ở góc màn hình
            function createIndicator() {
                indicator = document.createElement('div');
                indicator.id = 'gps-track-indicator';
                indicator.innerHTML = '<span style="display:inline-block;width:8px;height:8px;border-radius:50%;background:#22c55e;margin-right:6px;animation:gpsPulse 1.5s infinite;"></span>Đang chia sẻ vị trí';
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

            // Gửi tọa độ lên server
            function sendLocation(lat, lon) {
                lastLat = lat; lastLon = lon;
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
                    if (d.ok) setIndicator('Đang chia sẻ vị trí', '#22c55e');
                    else      setIndicator('Lỗi gửi vị trí', '#ef4444');
                })
                .catch(function(){ setIndicator('Mất kết nối', '#f59e0b'); });
            }

            // Bắt đầu watch
            function startTracking() {
                if (!navigator.geolocation) {
                    alert("Điện thoại của bạn không hỗ trợ GPS.");
                    return;
                }
                createIndicator();
                setIndicator('Đang kết nối GPS...', '#f59e0b');
                watchId = navigator.geolocation.watchPosition(
                    function(pos) {
                        var alertBox = document.getElementById('gps-warning-banner');
                        if (alertBox) alertBox.remove();
                        sendLocation(pos.coords.latitude, pos.coords.longitude);
                    },
                    function(err) {
                        setIndicator('Chưa cấp quyền GPS', '#ef4444');
                        if (!document.getElementById('gps-warning-banner')) {
                            var banner = document.createElement('div');
                            banner.id = 'gps-warning-banner';
                            banner.style.cssText = 'position:fixed;top:0;left:0;width:100%;background:#ef4444;color:white;text-align:center;padding:15px;z-index:999999;font-weight:bold;box-shadow:0 4px 6px rgba(0,0,0,0.1);';
                            banner.innerHTML = '<i class="fas fa-exclamation-triangle"></i> BẮT BUỘC: Bạn đang trong thời gian thuê xe. Vui lòng bật Vị trí (GPS) trên trình duyệt để tiếp tục!';
                            document.body.prepend(banner);
                        }
                    },
                    { enableHighAccuracy: true, timeout: 15000, maximumAge: 10000 }
                );
            }

            var lastLat = null, lastLon = null;
            var heartbeatInterval = null;

            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', startTracking);
            } else {
                startTracking();
            }

            // Heartbeat: resend last known position every 20s to keep signal alive when stationary
            heartbeatInterval = setInterval(function() {
                if (lastLat !== null && lastLon !== null) {
                    sendLocation(lastLat, lastLon);
                }
            }, 20000);

            window.addEventListener('beforeunload', function() {
                if (watchId !== null) navigator.geolocation.clearWatch(watchId);
            });
        })();
        </script>
        </c:if>
    </body>
</html>


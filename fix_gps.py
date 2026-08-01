import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\bookingHistoryDetail.jsp'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace the inner block of Theo dõi & Trạng thái
start_marker = '<div class=\"space-y-5 relative z-10\">'
end_marker = '<!-- Mini Extension Info Link -->'

start_idx = content.find(start_marker)
end_idx = content.find(end_marker)

inner = content[start_idx:end_idx]

# We will completely rewrite this section
new_inner = '''<div class="space-y-5 relative z-10">
                                          <!-- Trạng thái tổng quan luôn hiện -->
                                          <div class="flex items-center gap-4">
                                              <div class="w-10 h-10 rounded-full bg-gray-50 flex items-center justify-center shrink-0 border border-gray-200">
                                                  <i class="fas fa-clipboard-list text-gray-600 text-lg"></i>
                                              </div>
                                              <div>
                                                  <p class="text-xs text-gray-400 font-bold uppercase mb-1">Trạng thái đơn hàng</p>
                                                  <p class="text-base text-gray-800 font-black"></p>
                                              </div>
                                          </div>

                                          <c:if test="">
                                              <div class="flex items-center gap-4 mt-4 pt-4 border-t border-gray-100">
                                                  <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center shrink-0">
                                                      <i class="fas fa-truck text-blue-500 text-lg"></i>
                                                  </div>
                                                  <div>
                                                      <p class="text-xs text-gray-400 font-bold uppercase mb-1">Trạng thái giao xe</p>
                                                      <p class="text-base text-blue-700 font-black"></p>
                                                      <div id="delivery-estimate-history" style="display:none; margin-top:8px; padding:6px 10px; border-radius:6px; background:#f0faf0; border:1px solid #b2dfb2; font-size:12px; color:#2e7d32;">
                                                          <i class="fas fa-spinner fa-spin mr-1"></i> Đang tính toán thời gian giao...
                                                      </div>
                                                  </div>
                                              </div>
                                              
                                              <script>
                                              (function() {
                                                  // Chi tinh toan neu chua giao hoac dang giao
                                                  var deliveryStatus = '';
                                                  if(deliveryStatus !== 'Đã giao' && deliveryStatus !== 'Hủy giao') {
                                                      var startTime = new Date('');
                                                      var now = new Date();
                                                      
                                                      var diffMs = startTime - now;
                                                      var diffMins = Math.floor(diffMs / 60000);
                                                      
                                                      var estBox = document.getElementById('delivery-estimate-history');
                                                      estBox.style.display = 'block';
                                                      
                                                      if(diffMins > 0) {
                                                          estBox.innerHTML = '<i class="fas fa-bolt text-yellow-500 mr-1"></i> <strong>Dự kiến tài xế tới trong:</strong> ' + diffMins + ' phút (Khoảng ' + (diffMins*0.7).toFixed(1) + ' km)';
                                                      } else {
                                                          estBox.innerHTML = '<i class="fas fa-exclamation-triangle text-red-500 mr-1"></i> <strong>Quá hạn:</strong> Tài xế đang đến trễ ' + Math.abs(diffMins) + ' phút!';
                                                          estBox.style.background = '#fff0f0';
                                                          estBox.style.borderColor = '#ffcdd2';
                                                          estBox.style.color = '#c62828';
                                                      }
                                                  }
                                              })();
                                              </script>
                                          </c:if>

                                          <c:if test="">
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
                                                          document.getElementById('gpsCoords').innerText = 'Lat: ' + lat + '\\nLon: ' + lon;
                                                          
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

                                          <c:if test="">
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

                          <!-- Mini Extension Info Link -->'''

content = content[:start_idx] + new_inner + content[end_idx:]

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Done!')

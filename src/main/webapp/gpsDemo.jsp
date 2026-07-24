<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SmartRide GPS Tracker - Demo</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="staffAssets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #dc3545;
            --primary-dark: #b02a37;
            --bg-color: #f8f9fa;
            --text-main: #212529;
            --text-muted: #6c757d;
            --success: #198754;
        }
        
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--bg-color);
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background: white;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-bottom: 2px solid var(--primary);
        }

        .header h2 {
            margin: 0;
            font-weight: 800;
            font-size: 22px;
            color: var(--primary);
            letter-spacing: 0.5px;
        }

        .container {
            padding: 25px 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .input-group {
            width: 100%;
            max-width: 350px;
            margin-bottom: 20px;
            position: relative;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
            font-size: 14px;
        }

        .input-group input {
            width: 100%;
            padding: 15px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 16px;
            font-family: inherit;
            transition: all 0.3s ease;
            box-sizing: border-box;
            background: white;
        }

        .input-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(220, 53, 69, 0.1);
        }

        .tracker-circle {
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: linear-gradient(145deg, #e43a4a, #c6303e);
            box-shadow:  20px 20px 60px #d2d4d6,
                         -20px -20px 60px #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            margin: 30px 0;
            position: relative;
        }
        
        .tracker-circle::before {
            content: '';
            position: absolute;
            top: -10px; left: -10px; right: -10px; bottom: -10px;
            border: 2px solid var(--primary);
            border-radius: 50%;
            opacity: 0;
            transition: all 0.5s ease;
        }

        .tracker-circle:active {
            transform: scale(0.95);
            box-shadow: inset 10px 10px 20px rgba(0,0,0,0.2), inset -10px -10px 20px rgba(255,255,255,0.1);
        }

        .tracker-circle i {
            font-size: 50px;
            margin-bottom: 10px;
        }

        .tracker-circle span {
            font-size: 20px;
            font-weight: 800;
            letter-spacing: 1px;
            text-align: center;
            line-height: 1.2;
        }

        /* Active State */
        .is-tracking .tracker-circle {
            background: linear-gradient(145deg, #198754, #146c43);
            animation: pulse 2s infinite;
        }
        
        .is-tracking .tracker-circle::before {
            animation: ripple 2s infinite;
        }

        .status-box {
            background: white;
            padding: 15px 20px;
            border-radius: 12px;
            width: 100%;
            max-width: 350px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            margin-top: 10px;
            display: none;
        }
        
        .is-tracking .status-box {
            display: block;
        }

        .status-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #f1f3f5;
        }
        .status-item:last-child { border-bottom: none; }
        
        .status-label {
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 500;
        }
        
        .status-val {
            font-weight: 700;
            font-family: monospace;
            font-size: 15px;
            color: var(--primary);
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
        
        @keyframes ripple {
            0% { transform: scale(1); opacity: 0.5; }
            100% { transform: scale(1.3); opacity: 0; }
        }
        
        .footer {
            text-align: center;
            padding: 20px;
            color: var(--text-muted);
            font-size: 13px;
        }
    </style>
</head>
<body>

    <div class="header">
        <h2><i class="bi bi-broadcast me-2"></i>SmartRide GPS</h2>
    </div>

    <div class="container">
        <p class="text-center" style="color: var(--text-muted); margin-bottom: 25px; line-height: 1.5; font-size: 14px;">
            Nhập mã chuyến đi và nhấn Bắt đầu để truyền phát vị trí thực tế của bạn lên hệ thống giám sát.
        </p>

        <div class="input-group">
            <label>Mã chuyến đi (Booking ID)</label>
            <input type="text" id="bookingId" placeholder="VD: BK-12345" value="DEMO-001">
        </div>

        <div class="input-group">
            <label>Tên khách hàng</label>
            <input type="text" id="customerName" placeholder="Tên hiển thị trên bản đồ" value="Khách Test">
        </div>
        
        <input type="hidden" id="vehicleName" value="Honda AirBlade (Test)">
        <input type="hidden" id="phone" value="0987654321">

        <!-- Start Button -->
        <div class="tracker-circle" id="btnToggleGps">
            <i class="bi bi-geo-alt-fill" id="iconGps"></i>
            <span id="textGps">BẮT ĐẦU<br>TRUYỀN PHÁT</span>
        </div>
        
        <button id="btnTestFar" style="margin-top: 20px; padding: 12px 25px; border-radius: 50px; border: none; background: linear-gradient(135deg, #f59e0b, #d97706); color: #fff; font-weight: 700; cursor: pointer; display: none; box-shadow: 0 4px 15px rgba(245, 158, 11, 0.4); font-size: 14px; letter-spacing: 0.5px;">
            <i class="bi bi-rocket-takeoff me-2"></i> THỬ NGHIỆM > 50KM (ĐI HUẾ)
        </button>

        <!-- Status Panel -->
        <div class="status-box">
            <div class="status-item">
                <span class="status-label">Trạng thái</span>
                <span class="status-val text-success" style="color: var(--success);">Đang kết nối...</span>
            </div>
            <div class="status-item">
                <span class="status-label">Vĩ độ (Lat)</span>
                <span class="status-val" id="valLat">--.------</span>
            </div>
            <div class="status-item">
                <span class="status-label">Kinh độ (Lng)</span>
                <span class="status-val" id="valLng">--.------</span>
            </div>
            <div class="status-item">
                <span class="status-label">Độ chính xác</span>
                <span class="status-val" id="valAcc" style="color: var(--text-main);">-- m</span>
            </div>
            <div class="status-item">
                <span class="status-label">Tín hiệu Gửi</span>
                <span class="status-val text-success" id="valPing" style="color: var(--success);">0</span>
            </div>
        </div>
    </div>
    
    <div class="footer">
        Cung cấp bởi công nghệ Geolocation API<br>
        © 2026 SmartRide Team
    </div>

    <script>
        let watchId = null;
        let isTracking = false;
        let pingCount = 0;

        const btnToggle = document.getElementById('btnToggleGps');
        const iconGps = document.getElementById('iconGps');
        const textGps = document.getElementById('textGps');
        
        const valLat = document.getElementById('valLat');
        const valLng = document.getElementById('valLng');
        const valAcc = document.getElementById('valAcc');
        const valPing = document.getElementById('valPing');
        
        const inputBookingId = document.getElementById('bookingId');
        const inputCustomerName = document.getElementById('customerName');
        const inputVehicleName = document.getElementById('vehicleName');
        const inputPhone = document.getElementById('phone');

        // Auto-fill from URL if provided
        const urlParams = new URLSearchParams(window.location.search);
        if(urlParams.has('bookingId')) {
            inputBookingId.value = urlParams.get('bookingId');
            inputBookingId.readOnly = true;
            inputBookingId.style.backgroundColor = '#f1f3f5';
        }
        if(urlParams.has('customerName')) {
            inputCustomerName.value = urlParams.get('customerName');
            inputCustomerName.readOnly = true;
            inputCustomerName.style.backgroundColor = '#f1f3f5';
        }
        if(urlParams.has('vehicleName')) {
            inputVehicleName.value = urlParams.get('vehicleName');
        }
        if(urlParams.has('phone')) {
            inputPhone.value = urlParams.get('phone');
        }

        btnToggle.addEventListener('click', () => {
            if (!isTracking) {
                startTracking();
            } else {
                stopTracking();
            }
        });

        function startTracking() {
            if (!navigator.geolocation) {
                alert("Trình duyệt của bạn không hỗ trợ định vị GPS!");
                return;
            }

            let bId = inputBookingId.value.trim();
            if(!bId) {
                alert("Vui lòng nhập Mã chuyến đi!");
                inputBookingId.focus();
                return;
            }

            // Request Location
            watchId = navigator.geolocation.watchPosition(
                position => {
                    // This runs every time the phone's GPS detects movement!
                    sendLocationToServer(position.coords);
                },
                error => {
                    console.error("GPS Error:", error);
                    alert("Lỗi GPS: Vui lòng cho phép quyền truy cập Vị trí trong cài đặt điện thoại/trình duyệt.");
                    stopTracking();
                },
                {
                    enableHighAccuracy: true,
                    maximumAge: 0,
                    timeout: 5000
                }
            );

            // Update UI State
            isTracking = true;
            document.body.classList.add('is-tracking');
            iconGps.className = "bi bi-stop-circle";
            textGps.innerHTML = "ĐANG PHÁT<br>CHẠM ĐỂ DỪNG";
            inputBookingId.disabled = true;
            inputCustomerName.disabled = true;
            document.getElementById('btnTestFar').style.display = 'block';
            pingCount = 0;
            valPing.textContent = '0';
        }

        function stopTracking() {
            if (watchId !== null) {
                navigator.geolocation.clearWatch(watchId);
                watchId = null;
            }
            
            // Remove from server immediately via API? 
            // In demo, we just stop sending pings.

            // Update UI State
            isTracking = false;
            document.body.classList.remove('is-tracking');
            iconGps.className = "bi bi-geo-alt-fill";
            textGps.innerHTML = "BẮT ĐẦU<br>TRUYỀN PHÁT";
            inputBookingId.disabled = false;
            inputCustomerName.disabled = false;
            document.getElementById('btnTestFar').style.display = 'none';
            
            valLat.textContent = "--.------";
            valLng.textContent = "--.------";
            valAcc.textContent = "-- m";
        }

        function sendLocationToServer(coords) {
            valLat.textContent = coords.latitude.toFixed(6);
            valLng.textContent = coords.longitude.toFixed(6);
            valAcc.textContent = "~" + Math.round(coords.accuracy) + " m";

            let bId = inputBookingId.value.trim();
            let cName = inputCustomerName.value.trim() || "Khách Test";

            // POST to the backend API you have set up in UpdateLocationServlet
            // Ensure you send it as FormData or URL Encoded depending on how Servlet reads it
            let formData = new URLSearchParams();
            formData.append('bookingId', bId);
            formData.append('customerName', cName);
            formData.append('vehicleName', inputVehicleName.value.trim());
            formData.append('phone', inputPhone.value.trim());
            formData.append('lat', coords.latitude);
            formData.append('lon', coords.longitude);

            fetch('api/update-location', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData.toString()
            })
            .then(res => {
                if(res.ok) {
                    pingCount++;
                    valPing.textContent = pingCount + " lần";
                }
            })
            .catch(err => console.error("Error sending GPS to server:", err));
        }

        document.getElementById('btnTestFar').addEventListener('click', () => {
            if(isTracking) {
                // Hue coordinates (> 50km from Da Nang)
                let fakeCoords = {
                    latitude: 16.463713,
                    longitude: 107.590530,
                    accuracy: 5
                };
                sendLocationToServer(fakeCoords);
                alert("Đã gửi tọa độ ảo giả lập khách đi tới Huế (Cách ĐN >90km)!\n\nHãy mở bản đồ Admin để xem cảnh báo Đỏ nhé!");
            }
        });
    </script>
</body>
</html>

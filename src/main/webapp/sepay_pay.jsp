<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán SePay VietQR</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 20px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .sepay-container {
            max-width: 400px;
            width: 100%;
            background: #fff;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            border: 1px solid #f1f5f9;
        }
        .sepay-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .sepay-logo {
            font-size: 24px;
            font-weight: 800;
            color: #1e293b;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .sepay-subtitle {
            font-size: 13px;
            color: #64748b;
            margin-top: 6px;
        }
        .qr-box {
            background: #f8fafc;
            padding: 16px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            text-align: center;
            margin-bottom: 20px;
        }
        .qr-img {
            width: 200px;
            height: 200px;
            border-radius: 8px;
            margin: 0 auto 12px auto;
            display: block;
            background: #fff;
            padding: 8px;
            border: 1px solid #e2e8f0;
        }
        .bank-info {
            font-size: 14px;
            color: #475569;
            line-height: 1.6;
        }
        .amount-text {
            font-size: 18px;
            font-weight: 800;
            color: #b59349;
        }
        .note-box {
            background: #f0fdf4;
            border: 1.5px solid #86efac;
            border-radius: 12px;
            padding: 12px;
            text-align: center;
            margin-bottom: 20px;
        }
        .note-title {
            font-size: 12px;
            color: #16a34a;
            font-weight: 700;
            margin-bottom: 4px;
        }
        .note-content {
            font-size: 18px;
            font-weight: 800;
            color: #15803d;
            letter-spacing: 1px;
        }
        .status-box {
            text-align: center;
            padding: 12px;
            border-radius: 10px;
            background: #fef9c3;
            color: #92400e;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s;
        }
        .status-success {
            background: #dcfce7;
            color: #16a34a;
        }
    </style>
</head>
<body>

<div class="sepay-container" id="payment-content" style="display:none;">
    <div class="sepay-header">
        <div class="sepay-logo">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <rect width="24" height="24" rx="6" fill="#1e40af"/>
                <path d="M7 12l3 3 7-7" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            SePay VietQR
        </div>
        <div class="sepay-subtitle">Quét mã QR bằng ứng dụng ngân hàng</div>
    </div>

    <div class="qr-box">
        <img id="qr-img" class="qr-img" src="" alt="QR Code">
        <div class="bank-info">
            <div>Ngân hàng: <strong>MBBank (MBB)</strong></div>
            <div>Số tài khoản: <strong>0943515000</strong></div>
            <div>Số tiền: <strong class="amount-text" id="amount-text">0 ₫</strong></div>
        </div>
    </div>

    <div class="note-box">
        <div class="note-title">NỘI DUNG CHUYỂN KHOẢN (BẮT BUỘC):</div>
        <div class="note-content" id="transfer-note">BK...</div>
        <div style="font-size: 11px; color: #16a34a; margin-top: 4px;">Hệ thống sẽ tự động xác nhận sau 5s</div>
    </div>

    <div class="status-box" id="status-box">
        ⏳ Đang chờ thanh toán...
    </div>
</div>

<script>
    let pollInterval;
    let currentBookingId = 'BK' + Date.now(); 
    let amountToPay = 0;

    window.addEventListener('message', function(event) {
        if (event.data && typeof event.data.dataTotal !== 'undefined') {
            const dataTotal = parseFloat(event.data.dataTotal) || 0;
            const payments = event.data.dataPayment || [];
            
            let paid = 0;
            payments.forEach(p => paid += parseFloat(p));
            
            amountToPay = dataTotal - paid;
            
            if(event.data.bookingId) {
                currentBookingId = event.data.bookingId;
            }

            if (amountToPay > 0) {
                initPayment(amountToPay, currentBookingId);
            } else {
                document.getElementById('status-box').className = 'status-box status-success';
                document.getElementById('status-box').innerHTML = '✅ Đã thanh toán đủ.';
                document.getElementById('payment-content').style.display = 'block';
                setTimeout(() => {
                    window.parent.postMessage({ status: 'success' }, '*');
                }, 1000);
            }
        }
    });

    function initPayment(amount, note) {
        document.getElementById('payment-content').style.display = 'block';
        document.getElementById('transfer-note').textContent = note;
        document.getElementById('amount-text').textContent = amount.toLocaleString('vi-VN') + ' ₫';
        
        const qrUrl = 'https://img.vietqr.io/image/MB-0943515000-compact2.png?amount=' + amount + '&addInfo=' + encodeURIComponent(note) + '&accountName=SMARTRIDE';
        document.getElementById('qr-img').src = qrUrl;

        startPolling(note);
    }

    function startPolling(bookingId) {
        if (pollInterval) clearInterval(pollInterval);
        
        pollInterval = setInterval(() => {
            fetch('check-payment-status?bookingId=' + bookingId)
                .then(r => r.json())
                .then(d => {
                    if (d.status === 'paid') {
                        clearInterval(pollInterval);
                        document.getElementById('status-box').className = 'status-box status-success';
                        document.getElementById('status-box').innerHTML = '✅ Thanh toán thành công!';
                        
                        setTimeout(() => {
                            window.parent.postMessage({ status: 'success' }, '*');
                        }, 1500);
                    }
                }).catch(e => console.log(e));
        }, 5000);
    }
</script>
</body>
</html>

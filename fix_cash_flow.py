import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Add data-full-amount to dataInput
t1 = '''<h2 id="dataInput" data-amount=" + depositAmount + " style="margin:0; font-size:26px; color:#b59349; font-weight:700;">'''
r1 = '''<h2 id="dataInput" data-amount=" + depositAmount + " data-full-amount=" + finalAmount + " style="margin:0; font-size:26px; color:#b59349; font-weight:700;">'''
content = content.replace(t1, r1)

# 2. Modify highlightPayment
t2 = '''chkTransfer.innerHTML        = '';
                                }
                            }'''
r2 = '''chkTransfer.innerHTML        = '';
                                }
                                syncDepositSummary(); // re-sync UI when method changes
                            }'''
content = content.replace(t2, r2)

# 3. Update syncDepositSummary logic
t3 = '''var rawAmt = dataEl.getAttribute('data-amount');
                                var amt = rawAmt ? parseInt(rawAmt) : 0;
                                if (amt > 0) {
                                    summaryAmt.textContent = '&#8363;' + amt.toLocaleString('vi-VN');
                                    try {
                                        var h4 = dataEl.parentElement ? dataEl.parentElement.querySelector('h4') : null;
                                        summaryLbl.textContent = h4 ? h4.textContent.trim() : 'Số tiền cần thanh toán trước';
                                    } catch(e) {}
                                }'''
r3 = '''var methodCash = document.getElementById('check-cash') && document.getElementById('check-cash').style.background === 'rgb(181, 147, 73)';
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
                                }'''
content = content.replace(t3, r3)

# 4. Update the IIFE that runs initially in syncDepositSummary
t4 = '''var raw = dataEl.getAttribute('data-amount');
                                     if (raw) amt = parseInt(raw) || 0;
                                     try {
                                         var h4 = dataEl.parentElement ? dataEl.parentElement.querySelector('h4') : null;
                                         if (h4) lbl = h4.textContent.trim();
                                     } catch(e) {}
                                 }

                                 // Fallback: tính thủ công từ ngày + giờ nếu dataInput chưa có'''
r4 = '''var methodCash = document.getElementById('check-cash') && document.getElementById('check-cash').style.background === 'rgb(181, 147, 73)' || document.querySelector('input[value="cash"]') && document.querySelector('input[value="cash"]').checked;
                                     var raw = dataEl.getAttribute(methodCash ? 'data-full-amount' : 'data-amount');
                                     if (raw) amt = parseInt(raw) || 0;
                                     
                                     var titleBox = summaryAmt.previousElementSibling;
                                     var submitBtn = document.querySelector('#payment-method-container button');
                                     if (methodCash) {
                                         if (titleBox) titleBox.textContent = 'TỔNG TIỀN (KHI NHẬN XE)';
                                         lbl = 'Thanh toán tiền mặt khi nhận xe';
                                         if (submitBtn) submitBtn.textContent = 'Xác nhận đặt xe (Thanh toán sau)';
                                     } else {
                                         if (titleBox) titleBox.textContent = 'SỐ TIỀN ĐẶT CỌC';
                                         try {
                                             var h4 = dataEl.parentElement ? dataEl.parentElement.querySelector('h4') : null;
                                             if (h4) lbl = h4.textContent.trim();
                                         } catch(e) {}
                                         if (submitBtn) submitBtn.textContent = 'Xác nhận thanh toán';
                                     }
                                 }

                                 // Fallback: tính thủ công từ ngày + giờ nếu dataInput chưa có'''
content = content.replace(t4, r4)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed cash payment flow UI')

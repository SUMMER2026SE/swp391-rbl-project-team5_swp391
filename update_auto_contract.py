import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\bookingHistoryDetail.jsp'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

target = '''                if (urlParams.get('autoPay') === 'true' && document.getElementById("pay-btn")) {
                    setTimeout(openPaymentModal, 300);
                }'''
replacement = '''                if (urlParams.get('autoPay') === 'true' && document.getElementById("pay-btn")) {
                    setTimeout(openPaymentModal, 300);
                }
                
                // Auto open contract modal if requested (after successful payment)
                if (urlParams.get('autoContract') === '1') {
                    setTimeout(openContractModal, 800);
                }'''

if target in content:
    content = content.replace(target, replacement)
    print('Added autoContract trigger to bookingHistoryDetail.jsp')

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

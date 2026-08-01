import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

target = "window.location.href = ctxPath + (ctxPath.endsWith('/') ? '' : '/') + 'bookingHistoryDetail?bookingId=' + bid;"
replacement = "window.location.href = ctxPath + (ctxPath.endsWith('/') ? '' : '/') + 'bookingHistoryDetail?bookingId=' + bid + '&autoContract=1';"

if target in content:
    content = content.replace(target, replacement)
    print('Replaced target 1 (SePay)')

target2 = "window.location.href = ctxPath + (ctxPath.endsWith('/') ? '' : '/') + 'bookingHistoryDetail?bookingId=' + bookingId;"
replacement2 = "window.location.href = ctxPath + (ctxPath.endsWith('/') ? '' : '/') + 'bookingHistoryDetail?bookingId=' + bookingId + '&autoContract=1';"

if target2 in content:
    content = content.replace(target2, replacement2)
    print('Replaced target 2 (Cash)')

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('booking.jsp updated')

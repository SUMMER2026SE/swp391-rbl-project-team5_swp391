import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Current text
old_text = '<h4 style="margin:0; font-size:18px; color:#333; font-weight:700;">Thanh toán trước ( + depositPercent + %  + depositPlanLabel + ) / Hoặc 100% nếu Tiền mặt:</h4>'

# New layout
new_text = '''<div>
                                            <h4 style="margin:0; font-size:18px; color:#333; font-weight:700;">Thanh toán trước ( + depositPercent + %  + depositPlanLabel + ):</h4>
                                            <div style="font-size:13px; color:#b59349; font-weight:600; font-style:italic; margin-top:4px;">*Hoặc thanh toán 100% khi nhận xe nếu chọn Tiền mặt</div>
                                        </div>'''

content = content.replace(old_text, new_text)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Updated deposit label layout')

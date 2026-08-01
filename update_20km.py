import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace notice text
old_notice = '⛔ Quý khách ở <b>trên 20km</b> hệ thống sẽ không nhận đơn, vui lòng gọi Hotline để hỗ trợ riêng.'
new_notice = '⛔ Nếu địa chỉ <b>trên 20km</b>, quý khách vui lòng chọn nhận xe tại Cửa hàng hoặc nhập một địa chỉ khác gần hơn.'
content = content.replace(old_notice, new_notice)

# Replace Swal error
old_swal = 'Khoảng cách giao xe (\' + dist.toFixed(1) + \' km) đã vượt quá 20km. Xin lỗi, chúng tôi không hỗ trợ giao xa như vậy. Vui lòng liên hệ Hotline!'
new_swal = 'Khoảng cách giao xe (\' + dist.toFixed(1) + \' km) đã vượt quá 20km. Vui lòng chọn nhận xe tại Cửa hàng hoặc nhập địa chỉ khác gần hơn!'
content = content.replace(old_swal, new_swal)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Updated 20km notices')

import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Remove the new checkbox
new_checkbox = '''                                <!-- Terms Checkbox -->
                                <div style="margin-bottom: 20px; display: flex; align-items: flex-start; gap: 10px; padding: 0 5px;">
                                    <input type="checkbox" id="agreeTerms" style="margin-top: 3px; width: 16px; height: 16px; cursor: pointer; accent-color: #b59349;">
                                    <label for="agreeTerms" style="font-size: 13px; color: #475569; cursor: pointer; line-height: 1.4;">
                                        Tôi đã đọc và đồng ý với các <a href="policies.jsp" target="_blank" style="color: #b59349; font-weight: bold; text-decoration: underline;">Điều khoản dịch vụ</a> và Hợp đồng thuê xe.
                                    </label>
                                </div>

'''
content = content.replace(new_checkbox, "")

# 2. Remove the validation in confirmPaymentMethod
validation_block = '''            var agreeTerms = document.getElementById('agreeTerms');
            if(agreeTerms && !agreeTerms.checked) {
                if(typeof Swal !== 'undefined') {
                    Swal.fire({icon: 'warning', title: 'Chưa đồng ý', text: 'Vui lòng đánh dấu vào ô đồng ý với Điều khoản và Hợp đồng thuê xe trước khi thanh toán.'});
                } else {
                    alert('Vui lòng đánh dấu vào ô đồng ý với Điều khoản và Hợp đồng thuê xe trước khi thanh toán.');
                }
                return;
            }
            
'''
content = content.replace(validation_block, "")

# 3. Update the old checkbox label
old_label = '''Tôi đã đọc và đồng ý với <span style="color:#b59349; text-decoration:underline; cursor:pointer;" onclick="document.getElementById('terms-modal').style.display='flex'">Điều khoản &amp; Chính sách</span> của SmartRide'''
new_label = '''Tôi đã đọc và đồng ý với <span style="color:#b59349; text-decoration:underline; cursor:pointer;" onclick="document.getElementById('terms-modal').style.display='flex'">Điều khoản</span> &amp; Hợp đồng thuê xe điện tử'''
content = content.replace(old_label, new_label)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Removed redundant checkbox and updated the old one')

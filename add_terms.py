import os

file_path = r"d:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp"

with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# 1. Add Checkbox UI above the CTA button
cta_target = """                                <!-- CTA Button -->
                                <button type="button" onclick="confirmPaymentMethod()" style="width:100%;padding:16px;background:linear-gradient(135deg,#b59349,#d4aa5f);color:#fff;border:none;border-radius:12px;font-size:15px;font-weight:700;cursor:pointer;letter-spacing:0.3px;box-shadow:0 4px 14px rgba(181,147,73,0.28);">
                                    Xác nhận thanh toán
                                </button>"""

checkbox_html = """                                <!-- Terms Checkbox -->
                                <div style="margin-bottom: 20px; display: flex; align-items: flex-start; gap: 10px; padding: 0 5px;">
                                    <input type="checkbox" id="agreeTerms" style="margin-top: 3px; width: 16px; height: 16px; cursor: pointer; accent-color: #b59349;">
                                    <label for="agreeTerms" style="font-size: 13px; color: #475569; cursor: pointer; line-height: 1.4;">
                                        Tôi đã đọc và đồng ý với các <a href="policies.jsp" target="_blank" style="color: #b59349; font-weight: bold; text-decoration: underline;">Điều khoản dịch vụ</a> và Hợp đồng thuê xe.
                                    </label>
                                </div>

                                <!-- CTA Button -->
                                <button type="button" onclick="confirmPaymentMethod()" style="width:100%;padding:16px;background:linear-gradient(135deg,#b59349,#d4aa5f);color:#fff;border:none;border-radius:12px;font-size:15px;font-weight:700;cursor:pointer;letter-spacing:0.3px;box-shadow:0 4px 14px rgba(181,147,73,0.28);">
                                    Xác nhận thanh toán
                                </button>"""

if "id=\"agreeTerms\"" not in content:
    content = content.replace(cta_target, checkbox_html)

# 2. Add validation inside confirmPaymentMethod()
func_target = """            function confirmPaymentMethod() {
            // Xóa thông báo lỗi AI cũ (nếu có) khi người dùng thử lại
            var aiErrBox = document.getElementById('ai-verify-error-box');"""

func_val = """            function confirmPaymentMethod() {
            var agreeTerms = document.getElementById('agreeTerms');
            if(agreeTerms && !agreeTerms.checked) {
                if(typeof Swal !== 'undefined') {
                    Swal.fire({icon: 'warning', title: 'Chưa đồng ý', text: 'Vui lòng đánh dấu vào ô đồng ý với Điều khoản và Hợp đồng thuê xe trước khi thanh toán.'});
                } else {
                    alert('Vui lòng đánh dấu vào ô đồng ý với Điều khoản và Hợp đồng thuê xe trước khi thanh toán.');
                }
                return;
            }
            
            // Xóa thông báo lỗi AI cũ (nếu có) khi người dùng thử lại
            var aiErrBox = document.getElementById('ai-verify-error-box');"""

if "agreeTerms.checked" not in content:
    content = content.replace(func_target, func_val)
    # Also handle the variant with unicode corruption like XA3a thA'ng
    func_target_alt = """            function confirmPaymentMethod() {
            // XA3a thA'ng bAo l-i AI cc (nu cA3) khi ng?i dA1ng th- li
            var aiErrBox = document.getElementById('ai-verify-error-box');"""
    func_val_alt = """            function confirmPaymentMethod() {
            var agreeTerms = document.getElementById('agreeTerms');
            if(agreeTerms && !agreeTerms.checked) {
                if(typeof Swal !== 'undefined') {
                    Swal.fire({icon: 'warning', title: 'Chưa đồng ý', text: 'Vui lòng đánh dấu vào ô đồng ý với Điều khoản và Hợp đồng thuê xe trước khi thanh toán.'});
                } else {
                    alert('Vui lòng đánh dấu vào ô đồng ý với Điều khoản và Hợp đồng thuê xe trước khi thanh toán.');
                }
                return;
            }
            
            // XA3a thA'ng bAo l-i AI cc (nu cA3) khi ng?i dA1ng th- li
            var aiErrBox = document.getElementById('ai-verify-error-box');"""
    content = content.replace(func_target_alt, func_val_alt)

with open(file_path, "w", encoding="utf-8") as f:
    f.write(content)
print("Updated successfully")

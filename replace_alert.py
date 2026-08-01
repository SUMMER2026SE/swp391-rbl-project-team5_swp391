import os

file_path = r"d:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\bookingHistoryDetail.jsp"

with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# 1. Add SweetAlert2 CDN if not present
if "sweetalert2" not in content:
    # Add to <head>
    head_tag = "</head>"
    swal_cdn = '\n    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>\n'
    content = content.replace(head_tag, swal_cdn + head_tag)

# 2. Replace alert(...) with Swal.fire(...)
# I'll use regex to replace alert(...) strings
# alert('Lỗi GPS: Vui lòng bật vị trí (Location) trên điện thoại và tải lại trang!');
# -> Swal.fire({icon: 'error', title: 'Lỗi GPS', text: 'Vui lòng bật vị trí (Location) trên điện thoại và tải lại trang!'});
import re

content = content.replace(
    "alert('Lỗi GPS: Vui lòng bật vị trí (Location) trên điện thoại và tải lại trang!');",
    "Swal.fire({icon: 'error', title: 'Lỗi GPS', text: 'Vui lòng bật vị trí (Location) trên điện thoại và tải lại trang!'});"
)

content = content.replace(
    'alert("Trình duyệt không hỗ trợ định vị GPS.");',
    "Swal.fire({icon: 'error', title: 'Không hỗ trợ', text: 'Trình duyệt không hỗ trợ định vị GPS.'});"
)

content = content.replace(
    'alert("Thanh toán thành công! Hệ thống sẽ cập nhật trạng thái đơn hàng của bạn.");',
    "Swal.fire({icon: 'success', title: 'Thành công!', text: 'Thanh toán thành công! Hệ thống sẽ cập nhật trạng thái đơn hàng của bạn.'}).then(() => { window.location.reload(); });"
)
# And remove the window.location.reload() that follows immediately
content = content.replace(
    'Swal.fire({icon: \'success\', title: \'Thành công!\', text: \'Thanh toán thành công! Hệ thống sẽ cập nhật trạng thái đơn hàng của bạn.\'}).then(() => { window.location.reload(); });\n                        window.location.reload();',
    'Swal.fire({icon: \'success\', title: \'Thành công!\', text: \'Thanh toán thành công! Hệ thống sẽ cập nhật trạng thái đơn hàng của bạn.\'}).then(() => { window.location.reload(); });'
)

content = content.replace(
    'alert("Lỗi khi cập nhật thanh toán: " + data.message);',
    'Swal.fire({icon: \'error\', title: \'Thất bại\', text: "Lỗi khi cập nhật thanh toán: " + data.message});'
)

content = content.replace(
    'alert("Da xảy ra lỗi trong quá trình cập nhật thanh toán.");',
    'Swal.fire({icon: \'error\', title: \'Lỗi\', text: "Đã xảy ra lỗi trong quá trình cập nhật thanh toán."});'
)

content = content.replace(
    'alert("Da x?y ra l?i trong qu trnh c?p nh?t thanh ton.");',
    'Swal.fire({icon: \'error\', title: \'Lỗi\', text: "Đã xảy ra lỗi trong quá trình cập nhật thanh toán."});'
)
content = content.replace(
    'alert("Đã xảy ra lỗi trong quá trình cập nhật thanh toán.");',
    'Swal.fire({icon: \'error\', title: \'Lỗi\', text: "Đã xảy ra lỗi trong quá trình cập nhật thanh toán."});'
)


content = content.replace(
    'alert("Điện thoại của bạn không hỗ trợ GPS. Yêu cầu đổi thiết bị!");',
    'Swal.fire({icon: \'error\', title: \'Lỗi GPS\', text: "Điện thoại của bạn không hỗ trợ GPS. Yêu cầu đổi thiết bị!"});'
)

content = content.replace(
    'alert("BẮT BUỘC BẬT ĐỊNH VỊ!\\nHệ thống phát hiện bạn đã từ chối quyền Truy cập Vị trí. Theo chính sách an toàn, bạn buộc phải cho phép trang web này lấy vị trí của bạn.");',
    'Swal.fire({icon: \'warning\', title: \'BẮT BUỘC BẬT ĐỊNH VỊ!\', text: "Hệ thống phát hiện bạn đã từ chối quyền Truy cập Vị trí. Theo chính sách an toàn, bạn buộc phải cho phép trang web này lấy vị trí của bạn."});'
)

# For any generic alert(some_var); we could replace with Swal.fire(some_var) but I've matched the exact strings above.
# Let's also handle the charset issue if there are any unicode mismatches by just replacing `alert(` with `Swal.fire(` as a fallback? No, Swal.fire takes an object for better UI.
# Let's do a generic regex for remaining alerts: alert("...")
def repl_alert(m):
    msg = m.group(1)
    return f'Swal.fire("Thông báo", {msg}, "info");'

content = re.sub(r'alert\((["\'].*?["\'])\);', repl_alert, content)

with open(file_path, "w", encoding="utf-8") as f:
    f.write(content)
print("Updated successfully")

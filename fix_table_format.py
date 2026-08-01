import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace delivery fee icon
content = content.replace('🛵', '<i class="fas fa-motorcycle" style="color:#6b7280; font-size:12px; margin-right:4px;"></i>')

# Change "Cần đặt cọc" label
old_deposit_label = 'Cần đặt cọc ( + depositPercent + %  + depositPlanLabel + ):'
new_deposit_label = 'Thanh toán trước ( + depositPercent + %  + depositPlanLabel + ) / Hoặc 100% nếu Tiền mặt:'
content = content.replace(old_deposit_label, new_deposit_label)

# Currency replacements (exact strings from inspect_table)
replacements = {
    '₫ + price.toLocaleString() + /Ngày': ' + price.toLocaleString(\'vi-VN\') + đ/Ngày',
    '₫ + totalPrice.toLocaleString() + </td>': ' + totalPrice.toLocaleString(\'vi-VN\') + đ</td>',
    '₫ + price.toLocaleString() + </td>': ' + price.toLocaleString(\'vi-VN\') + đ</td>',
    '₫ + deliveryFee.toLocaleString() + </span>': ' + deliveryFee.toLocaleString(\'vi-VN\') + đ</span>',
    '₫ + (totalAmount - deliveryFee).toLocaleString() + </span>': ' + (totalAmount - deliveryFee).toLocaleString(\'vi-VN\') + đ</span>',
    '-₫ + appliedDiscount.toLocaleString() + </span>': '- + appliedDiscount.toLocaleString(\'vi-VN\') + đ</span>',
    '₫ + finalAmount.toLocaleString() + </h4>': ' + finalAmount.toLocaleString(\'vi-VN\') + đ</h4>',
    '₫ + depositAmount.toLocaleString(\'vi-VN\') + </h2>': ' + depositAmount.toLocaleString(\'vi-VN\') + đ</h2>'
}

for old, new in replacements.items():
    content = content.replace(old, new)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Updated table formatting')

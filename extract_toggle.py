import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Let's extract the part of toggleCustomLocation where it sets fee
start_idx = content.find('function toggleCustomLocation(type)')
end_idx = content.find('function haversine(')
if start_idx != -1 and end_idx != -1:
    with open('inspect_toggle.txt', 'w', encoding='utf-8') as out:
        out.write(content[start_idx:end_idx])
print('Extracted inspect_toggle.txt')

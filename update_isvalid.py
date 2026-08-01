import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\java\com\smartride\util\DBUtil.java'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    'if(!conn.isClosed() && conn.isValid(1))',
    'if(!conn.isClosed())'
)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Removed isValid check')

import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\java\com\smartride\util\DBUtil.java'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    'jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require',
    'jdbc:postgresql://13.114.6.6:6543/postgres?sslmode=require'
)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Updated DBUtil with direct IP')

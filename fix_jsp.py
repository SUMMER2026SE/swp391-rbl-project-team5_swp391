# -*- coding: utf-8 -*-
import os

file_path = 'src/main/webapp/manageBooking.jsp'
with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

# I will just write a script to replace all of them!
replacements = {
    '?A xAc nh-n': 'Ðã xác nh?n',
    '?A thanh toAn': 'Ðã thanh toán',
    '?A h y': 'Ðã h?y',
    'Ch? xAc nh-n': 'Ch? xác nh?n',
    '?ang thuA': 'Ðang thuê',
    '?A tr': 'Ðã tr?',
    'QuA hn': 'Quá h?n',
    'Chua giao': 'Chua giao',
    '?A giao': 'Ðã giao',
    'Da tr?': 'Ðã tr?',
    'Da giao': 'Ðã giao',
    'Ch? nh?n xe': 'Ch? nh?n xe',
    'HoAn tt x- lA': 'Hoàn t?t x? lý',
    'HoAn tt': 'Hoàn t?t',
    '?A hoAn ti?n': 'Ðã hoàn ti?n',
    '?A hoAn thAnh': 'Ðã hoàn thành',
    'XAc nh-n': 'Xác nh?n'
}

# The mangled text is actually different because it was read by PowerShell.
# Let me use the ACTUAL bytes in the file!

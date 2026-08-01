import os

files = [
    'src/main/webapp/booking.jsp',
    'src/main/webapp/manageBooking.jsp',
    'src/main/webapp/sepay_pay.jsp'
]

for f in files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    content = content.replace('bank=VCB&acc=1037077133', 'bank=MBB&acc=0943515000')
    content = content.replace('Vietcombank (VCB)', 'MBBank (MBB)')
    content = content.replace('1037077133', '0943515000')
    
    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)

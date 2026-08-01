import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\home.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

target_pickup = '''                                    <div id="dropdown-pickup" style="display:none; position:absolute; top:100%; left:0; width:100%; background:#fff; border-radius:8px; box-shadow:0 10px 25px rgba(0,0,0,0.1); z-index:999; margin-top:4px; border:1px solid #eee; overflow:hidden;">'''
repl_pickup = '''                                    <div id="dropdown-pickup" style="display:none; position:absolute; top:100%; left:0; min-width:320px; white-space:nowrap; background:#fff; border-radius:8px; box-shadow:0 10px 25px rgba(0,0,0,0.1); z-index:999; margin-top:4px; border:1px solid #eee; overflow:hidden;">'''
content = content.replace(target_pickup, repl_pickup)

target_return = '''                                    <div id="dropdown-return" style="display:none; position:absolute; top:100%; left:0; width:100%; background:#fff; border-radius:8px; box-shadow:0 10px 25px rgba(0,0,0,0.1); z-index:999; margin-top:4px; border:1px solid #eee; overflow:hidden;">'''
repl_return = '''                                    <div id="dropdown-return" style="display:none; position:absolute; top:100%; left:0; min-width:320px; white-space:nowrap; background:#fff; border-radius:8px; box-shadow:0 10px 25px rgba(0,0,0,0.1); z-index:999; margin-top:4px; border:1px solid #eee; overflow:hidden;">'''
content = content.replace(target_return, repl_return)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed dropdown widths')

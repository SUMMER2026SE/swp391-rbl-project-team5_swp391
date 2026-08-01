import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Let's write the relevant part of buildStep5Table to a temp file to inspect
start_idx = content.find('//calculator motorcycles')
end_idx = content.find('function toggleNextButton()')
if start_idx != -1 and end_idx != -1:
    with open('inspect_table.txt', 'w', encoding='utf-8') as out:
        out.write(content[start_idx:end_idx])
print('Extracted inspect_table.txt')

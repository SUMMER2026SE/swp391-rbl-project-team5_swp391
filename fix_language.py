import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Change button text
target_btn = '<i class="fas fa-location-crosshairs"></i> Vị trí</button>'
repl_btn = '<i class="fas fa-location-crosshairs"></i> Tự động lấy vị trí</button>'
content = content.replace(target_btn, repl_btn)

# Add accept-language=vi to reverse geocoding API
target_rev = "fetch('https://nominatim.openstreetmap.org/reverse?format=json&lat=' + lat + '&lon=' + lon)"
repl_rev = "fetch('https://nominatim.openstreetmap.org/reverse?format=json&lat=' + lat + '&lon=' + lon + '&accept-language=vi')"
content = content.replace(target_rev, repl_rev)

# Add accept-language=vi to search API
target_search = "fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(address + ', Da Nang'))"
repl_search = "fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(address + ', Da Nang') + '&accept-language=vi')"
content = content.replace(target_search, repl_search)

# Clean up some common leftover words if any (e.g. Ward -> Phường) - Actually accept-language=vi should handle it, but we can do a quick JS cleanup too just in case
js_cleanup_target = "var address = data.display_name;"
js_cleanup_repl = "var address = data.display_name.replace(/ Ward/g, '').replace(/ District/g, '');"
content = content.replace(js_cleanup_target, js_cleanup_repl)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed button text and language in booking.jsp')

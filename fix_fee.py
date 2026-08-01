import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace the fee calculation in toggleCustomLocation
old_toggle_fee = 'var fee = Math.ceil(dist - 3) * 5000;'
new_toggle_fee = 'var fee = Math.ceil(dist - 3) * 5000;\n                document.getElementById(\'custom_\' + type + \'_input\').dataset.dist = dist.toFixed(1);'
content = content.replace(old_toggle_fee, new_toggle_fee)

old_toggle_free = 'document.getElementById(\'custom_\' + type + \'_input\').dataset.fee = 0;'
new_toggle_free = 'document.getElementById(\'custom_\' + type + \'_input\').dataset.fee = 0;\n                document.getElementById(\'custom_\' + type + \'_input\').dataset.dist = dist.toFixed(1);'
content = content.replace(old_toggle_free, new_toggle_free)

# Now fix the onStepChanging logic
old_onstep_dist = '''let distPickup = distanceMap[pickupLoc] !== undefined ? distanceMap[pickupLoc] : 0;
                            let distReturn = distanceMap[returnLoc] !== undefined ? distanceMap[returnLoc] : 0;
                            
                            // T ng khong cAch c n giao + nh-n (ch% tA-nh 1 chi?u i t c-a hAng)
                            let totalDistance = distPickup + distReturn;
                            
                            // CA'ng thcc: 3km  u Free. T km 4: 5k/km.
                            let deliveryFee = 0;
                            if (totalDistance > 3) {
                                deliveryFee = (totalDistance - 3) * 5000;
                            }'''

# Since string matching with encodings can be tricky, I will use regex

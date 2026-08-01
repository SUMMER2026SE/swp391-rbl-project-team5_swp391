import os
import re

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Update toggleCustomLocation to store dataset.dist
content = content.replace(
    "var fee = Math.ceil(dist - 3) * 5000;",
    "var fee = Math.ceil(dist - 3) * 5000;\n                document.getElementById('custom_' + type + '_input').dataset.dist = dist.toFixed(1);"
)
content = content.replace(
    "document.getElementById('custom_' + type + '_input').dataset.fee = 0;",
    "document.getElementById('custom_' + type + '_input').dataset.fee = 0;\n                document.getElementById('custom_' + type + '_input').dataset.dist = dist.toFixed(1);"
)

# 2. Update the logic in buildStep5Table (onStepChanging)
# We will use regex to replace the distance and fee calculation
pattern = r"let distPickup = distanceMap\[pickupLoc\] !== undefined \? distanceMap\[pickupLoc\] : 0;[\s\S]*?if \(totalDistance > 3\) \{[\s\S]*?deliveryFee = \(totalDistance - 3\) \* 5000;[\s\S]*?\}"

replacement = """let distPickup = 0;
                            if (pickupLoc === 'Your own address') {
                                let datasetDist = document.getElementById('custom_pickup_input').dataset.dist;
                                distPickup = datasetDist ? parseFloat(datasetDist) : 8;
                            } else {
                                distPickup = distanceMap[pickupLoc] !== undefined ? distanceMap[pickupLoc] : 0;
                            }
                            
                            let distReturn = 0;
                            if (returnLoc === 'Your own address') {
                                let datasetDist = document.getElementById('custom_return_input').dataset.dist;
                                distReturn = datasetDist ? parseFloat(datasetDist) : 8;
                            } else {
                                distReturn = distanceMap[returnLoc] !== undefined ? distanceMap[returnLoc] : 0;
                            }
                            
                            // Tổng khoảng cách cần giao + nhận (chỉ tính 1 chiều đi từ cửa hàng)
                            let totalDistance = parseFloat((distPickup + distReturn).toFixed(1));
                            
                            // Công thức: 3km đầu Free. Từ km 4: 5k/km.
                            let deliveryFee = 0;
                            if (totalDistance > 3) {
                                deliveryFee = Math.ceil(totalDistance - 3) * 5000;
                            }"""

content = re.sub(pattern, replacement, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Updated distance and fee logic')

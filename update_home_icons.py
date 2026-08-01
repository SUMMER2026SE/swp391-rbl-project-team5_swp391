import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\home.jsp'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace pickup options
pickup_target = '''                                        <div onclick="selectHeroLoc('pickup', 'Tại cửa hàng SmartRide - 15 Võ Văn Kiệt')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;">🏪 Tại cửa hàng SmartRide - 15 Võ Văn Kiệt</div>
                                        <div onclick="selectHeroLoc('pickup', 'Ga Đà Nẵng - 202 Hải Phòng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;">🚆 Ga Đà Nẵng - 202 Hải Phòng</div>
                                        <div onclick="selectHeroLoc('pickup', 'Sân bay Quốc tế Đà Nẵng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;">✈️ Sân bay Quốc tế Đà Nẵng</div>
                                        <div onclick="selectHeroLoc('pickup', 'Bến xe Trung tâm Đà Nẵng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;">🚌 Bến xe Trung tâm Đà Nẵng</div>'''

pickup_repl = '''                                        <div onclick="selectHeroLoc('pickup', 'Tại cửa hàng SmartRide - 202 Hải Phòng, Đà Nẵng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#b59349; font-weight:bold;"><i class="fas fa-store" style="width:20px; text-align:center; color:#b59349;"></i> Tại cửa hàng SmartRide - 202 Hải Phòng</div>
                                        <div onclick="selectHeroLoc('pickup', 'Ga Đà Nẵng - Số 202 đường Hải Phòng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;"><i class="fas fa-map-marker-alt" style="width:20px; text-align:center; color:#94a3b8;"></i> Ga Đà Nẵng - 202 Hải Phòng</div>
                                        <div onclick="selectHeroLoc('pickup', 'Sân bay Quốc tế Đà Nẵng - 132 Phan Đình Phùng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;"><i class="fas fa-map-marker-alt" style="width:20px; text-align:center; color:#94a3b8;"></i> Sân bay Quốc tế Đà Nẵng</div>
                                        <div onclick="selectHeroLoc('pickup', 'Bến xe Trung tâm - 33 Tôn Đức Thắng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;"><i class="fas fa-map-marker-alt" style="width:20px; text-align:center; color:#94a3b8;"></i> Bến xe Trung tâm Đà Nẵng</div>'''

content = content.replace(pickup_target, pickup_repl)

# Replace return options
return_target = '''                                        <div onclick="selectHeroLoc('return', 'Tại cửa hàng SmartRide - 15 Võ Văn Kiệt')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;">🏪 Tại cửa hàng SmartRide - 15 Võ Văn Kiệt</div>
                                        <div onclick="selectHeroLoc('return', 'Ga Đà Nẵng - 202 Hải Phòng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;">🚆 Ga Đà Nẵng - 202 Hải Phòng</div>
                                        <div onclick="selectHeroLoc('return', 'Sân bay Quốc tế Đà Nẵng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;">✈️ Sân bay Quốc tế Đà Nẵng</div>
                                        <div onclick="selectHeroLoc('return', 'Bến xe Trung tâm Đà Nẵng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;">🚌 Bến xe Trung tâm Đà Nẵng</div>'''

return_repl = '''                                        <div onclick="selectHeroLoc('return', 'Tại cửa hàng SmartRide - 202 Hải Phòng, Đà Nẵng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#b59349; font-weight:bold;"><i class="fas fa-store" style="width:20px; text-align:center; color:#b59349;"></i> Tại cửa hàng SmartRide - 202 Hải Phòng</div>
                                        <div onclick="selectHeroLoc('return', 'Ga Đà Nẵng - Số 202 đường Hải Phòng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;"><i class="fas fa-map-marker-alt" style="width:20px; text-align:center; color:#94a3b8;"></i> Ga Đà Nẵng - 202 Hải Phòng</div>
                                        <div onclick="selectHeroLoc('return', 'Sân bay Quốc tế Đà Nẵng - 132 Phan Đình Phùng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;"><i class="fas fa-map-marker-alt" style="width:20px; text-align:center; color:#94a3b8;"></i> Sân bay Quốc tế Đà Nẵng</div>
                                        <div onclick="selectHeroLoc('return', 'Bến xe Trung tâm - 33 Tôn Đức Thắng')" style="padding:10px 16px; cursor:pointer; border-bottom:1px solid #f9f9f9; font-size:13px; color:#444;"><i class="fas fa-map-marker-alt" style="width:20px; text-align:center; color:#94a3b8;"></i> Bến xe Trung tâm Đà Nẵng</div>'''

content = content.replace(return_target, return_repl)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Updated home.jsp icons')

import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\booking.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Update the checkbox text
target_text = '''Tôi đã đọc và đồng ý với <span style="color:#b59349; text-decoration:underline; cursor:pointer;" onclick="document.getElementById('terms-modal').style.display='flex'">Điều khoản</span> &amp; Hợp đồng thuê xe điện tử'''
repl_text = '''Tôi đã đọc và đồng ý với <span style="color:#b59349; text-decoration:underline; cursor:pointer;" onclick="document.getElementById('terms-modal').style.display='flex'">Điều khoản</span> &amp; <span style="color:#b59349; text-decoration:underline; cursor:pointer;" onclick="document.getElementById('contract-sample-modal').style.display='flex'">Hợp đồng thuê xe điện tử</span>'''
content = content.replace(target_text, repl_text)

# Find terms-modal and append contract-sample-modal after it
# Assuming terms-modal ends somewhere. Let's just append contract-sample-modal right before </body>
modal_html = '''
    <!-- CONTRACT SAMPLE MODAL -->
    <div id="contract-sample-modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:10000; align-items:center; justify-content:center; backdrop-filter:blur(5px);">
        <div style="background:#fff; width:90%; max-width:800px; height:80vh; border-radius:15px; overflow:hidden; display:flex; flex-direction:column; box-shadow:0 25px 50px -12px rgba(0,0,0,0.25);">
            <!-- Modal Header -->
            <div style="padding:20px; border-bottom:1px solid #eee; display:flex; justify-content:space-between; align-items:center; background:#f9f9f9;">
                <h4 style="margin:0; color:#b59349; font-weight:700;"><i class="fas fa-file-contract"></i> HỢP ĐỒNG THUÊ XE MẪU</h4>
                <button onclick="document.getElementById('contract-sample-modal').style.display='none'" style="background:none; border:none; font-size:24px; cursor:pointer; color:#666;">&times;</button>
            </div>
            <!-- Modal Body (Iframe to a sample contract, or just scrollable text) -->
            <div style="padding:20px; overflow-y:auto; flex-grow:1; font-family: 'Times New Roman', serif; line-height:1.6; color:#333;">
                <div style="text-align:center; margin-bottom:20px;">
                    <h3 style="font-weight:bold; margin-bottom:5px;">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h3>
                    <h4 style="font-weight:bold; text-decoration:underline;">Độc lập - Tự do - Hạnh phúc</h4>
                    <br>
                    <h3 style="font-weight:bold;">HỢP ĐỒNG THUÊ XE ĐIỆN TỬ</h3>
                </div>
                <p><i>(Đây là bản hợp đồng mẫu. Hợp đồng chính thức chứa thông tin cá nhân của bạn sẽ được tự động tạo và gửi về Email ngay sau khi bạn thanh toán cọc thành công).</i></p>
                <hr>
                <p><b>BÊN A (Bên cho thuê): CỬA HÀNG XE MÁY SMARTRIDE</b></p>
                <p>Địa chỉ: 202 Hải Phòng, Phường Tân Chính, Quận Thanh Khê, Đà Nẵng</p>
                <p>Hotline: 0987.654.321</p>
                <br>
                <p><b>BÊN B (Bên thuê):</b> [THÔNG TIN KHÁCH HÀNG TỰ ĐỘNG ĐIỀN]</p>
                <p>CCCD/Hộ chiếu: [SỐ CCCD TỰ ĐỘNG ĐIỀN]</p>
                <br>
                <p><b>ĐIỀU 1: ĐỐI TƯỢNG HỢP ĐỒNG</b></p>
                <p>Bên A đồng ý cho Bên B thuê xe máy (thông tin chi tiết về loại xe, biển số, giá thuê, thời gian thuê được đính kèm theo hóa đơn điện tử hệ thống).</p>
                <br>
                <p><b>ĐIỀU 2: TRÁCH NHIỆM BÊN A</b></p>
                <p>- Giao xe đúng loại, đúng thời gian và địa điểm đã thỏa thuận.</p>
                <p>- Hỗ trợ cứu hộ 24/7 trong suốt quá trình thuê xe nếu xe gặp sự cố kỹ thuật (không do lỗi cố ý của Bên B).</p>
                <br>
                <p><b>ĐIỀU 3: TRÁCH NHIỆM BÊN B</b></p>
                <p>- Sử dụng xe đúng mục đích, chấp hành nghiêm chỉnh luật lệ giao thông đường bộ Việt Nam.</p>
                <p>- Không tự ý cầm cố, thế chấp, giao xe cho bên thứ 3 hoặc sử dụng xe vào mục đích vi phạm pháp luật.</p>
                <p>- Bồi thường 100% chi phí sửa chữa theo báo giá chính hãng nếu xảy ra va quệt, hư hỏng do lỗi của Bên B.</p>
                <br>
                <p><b>ĐIỀU 4: ĐIỀU KHOẢN CHUNG</b></p>
                <p>Hợp đồng điện tử này có giá trị pháp lý tương đương bản giấy theo Luật Giao dịch điện tử Việt Nam. Khách hàng tích chọn "Đồng ý" tại website đồng nghĩa với việc đã ký kết hợp đồng này.</p>
            </div>
            <!-- Modal Footer -->
            <div style="padding:15px 20px; border-top:1px solid #eee; text-align:right; background:#f9f9f9;">
                <button onclick="document.getElementById('contract-sample-modal').style.display='none'" style="background:#b59349; color:#fff; border:none; padding:10px 20px; border-radius:5px; font-weight:bold; cursor:pointer;">Tôi đã hiểu</button>
            </div>
        </div>
    </div>
</body>'''
content = content.replace('</body>', modal_html)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Added contract sample modal')

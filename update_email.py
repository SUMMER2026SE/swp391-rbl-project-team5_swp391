import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\java\com\smartride\controller\SepayWebhookServlet.java'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

target = '''                        // 2. Gửi Email thông báo
                        String emailContent = "<div style='font-family: sans-serif; padding: 20px; border: 1px solid #ddd; border-radius: 8px;'>"
                                + "<h2 style='color: #2eca6a;'>Thanh toán thành công!</h2>"
                                + "<p>Chào bạn,</p>"
                                + "<p>SmartRide đã nhận được khoản thanh toán cọc cho đơn hàng <strong>" + bookingId + "</strong>.</p>"
                                + "<p>Số tiền: <strong>" + amount + " VND</strong></p>"
                                + "<p>Cảm ơn bạn đã tin tưởng dịch vụ của SmartRide!</p>"
                                + "</div>";
                        SendEmail.sendVerificationEmail(acc.getEmail(), emailContent);'''

replacement = '''                        // 2. Gửi Email thông báo có link Hợp Đồng
                        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
                        String contractLink = baseUrl + "/bookingHistoryDetail?bookingId=" + bookingId + "&autoContract=1";
                        String amountStrEmail = String.format("%,d", amount).replace(',', '.');
                        
                        String emailContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 30px; border: 1px solid #e2e8f0; border-radius: 12px; background-color: #ffffff;'>"
                                + "<div style='text-align: center; margin-bottom: 20px;'>"
                                + "<h1 style='color: #b59349; margin: 0;'>SmartRide</h1>"
                                + "<p style='color: #64748b; font-size: 14px; margin-top: 5px;'>Xác nhận đặt xe & Hợp đồng điện tử</p>"
                                + "</div>"
                                + "<div style='background-color: #f8fafc; padding: 20px; border-radius: 8px; border-left: 4px solid #2eca6a; margin-bottom: 25px;'>"
                                + "<h2 style='color: #0f172a; margin-top: 0; font-size: 18px;'>Thanh toán cọc thành công!</h2>"
                                + "<p style='color: #334155; line-height: 1.6; margin-bottom: 10px;'>Chào bạn <strong>" + acc.getUserName() + "</strong>,</p>"
                                + "<p style='color: #334155; line-height: 1.6; margin-bottom: 0;'>Chúng tôi đã nhận được khoản thanh toán cọc <strong>" + amountStrEmail + " VNĐ</strong> cho mã đơn hàng <strong style='color: #b59349;'>" + bookingId + "</strong>.</p>"
                                + "</div>"
                                + "<p style='color: #334155; line-height: 1.6;'>Xe của bạn đã được cửa hàng giữ và sẵn sàng để giao theo đúng thời gian đã đặt. Kèm theo đây là Hợp đồng thuê xe điện tử chứng nhận giao dịch của bạn.</p>"
                                + "<div style='text-align: center; margin: 35px 0;'>"
                                + "<a href='" + contractLink + "' style='background-color: #b59349; color: #ffffff; padding: 14px 28px; text-decoration: none; border-radius: 8px; font-weight: bold; display: inline-block;'>XEM HỢP ĐỒNG ĐIỆN TỬ</a>"
                                + "</div>"
                                + "<p style='color: #64748b; font-size: 13px; border-top: 1px solid #e2e8f0; padding-top: 15px;'>Nếu bạn có bất kỳ thắc mắc nào, vui lòng liên hệ hotline 0905.123.456 để được hỗ trợ nhanh nhất.</p>"
                                + "<p style='color: #64748b; font-size: 13px;'>Trân trọng,<br>Đội ngũ SmartRide Đà Nẵng</p>"
                                + "</div>";
                        SendEmail.sendVerificationEmail(acc.getEmail(), emailContent);'''

if target in content:
    content = content.replace(target, replacement)
    print('Updated Email Template in SepayWebhookServlet')

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

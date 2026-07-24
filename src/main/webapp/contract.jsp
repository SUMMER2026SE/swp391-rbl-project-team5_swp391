<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.smartride.dao.BookingDAO"%>
<%@page import="com.smartride.dto.Booking"%>
<%@page import="com.smartride.dto.Account"%>
<%@page import="com.smartride.dto.Customer"%>
<%@page import="com.smartride.dao.AccountDAO"%>
<%@page import="com.smartride.dao.CustomerDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%
    String bookingId = request.getParameter("id");
    if (bookingId == null || bookingId.isEmpty()) {
        out.println("Không tìm thấy hợp đồng!");
        return;
    }
    
    Booking booking = null;
    Customer customer = null;
    Account account = null;
    List<Map<String, Object>> motorcycles = null;
    
    if (bookingId.equals("preview")) {
        // Dummy data for preview mode
        booking = new Booking();
        booking.setBookingDate("2026-07-23 10:00:00");
        booking.setStartDate("2026-07-23 12:00:00");
        booking.setEndDate("2026-07-24 12:00:00");
        
        account = new Account();
        account.setFirstName("Nguyễn Văn");
        account.setLastName("A");
        account.setPhoneNumber("0901234567");
        account.setAddress("Hải Châu, Đà Nẵng");
        
        customer = new Customer();
        customer.setIdentityCard("048099001234");
        
        motorcycles = new java.util.ArrayList<>();
    } else {
        BookingDAO dao = BookingDAO.getInstance();
        booking = dao.getBookingById(bookingId);
        if (booking == null) {
            out.println("Hợp đồng không tồn tại!");
            return;
        }
        
        CustomerDAO daoCus = CustomerDAO.getInstance();
        customer = daoCus.getCustomerbyID(booking.getCustomerID());
        AccountDAO daoAcc = AccountDAO.getInstance();
        if (customer != null) {
            account = daoAcc.getAccountbyID(customer.getAccountId());
        }
        
        motorcycles = dao.getMotorcyclesByBookingID(bookingId);
    }
    
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&family=Great+Vibes&display=swap" rel="stylesheet">
    <title>Hợp Đồng Thuê Xe - <%= bookingId %></title>
    <style>
        body { margin: 0; padding: 20px; background: #f4f4f5; display: flex; justify-content: center; }
        .a4-container { 
            width: 800px; 
            max-width: 800px; 
            background: #fff; 
            padding: 40px 50px; 
            box-sizing: border-box; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
            font-family: 'Times New Roman', serif; 
            line-height: 1.6; 
            color: #111; 
            font-size: 15px; 
        }
        .header { text-align: center; margin-bottom: 30px; }
        .header h2 { margin: 0; font-size: 18px; text-transform: uppercase; font-weight: bold; }
        .header h3 { margin: 15px 0 20px; font-size: 22px; font-weight: bold; }
        .header .motto { margin: 5px 0; font-weight: bold; font-size: 16px; text-decoration: underline; }
        .section-title { font-weight: bold; margin-top: 25px; margin-bottom: 10px; font-size: 16px; text-transform: uppercase; }
        .info-block { margin-bottom: 15px; padding-left: 10px; }
        .info-block p { margin: 5px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; margin-bottom: 20px; }
        th, td { border: 1px solid #333; padding: 10px; text-align: left; }
        th { background-color: #f5f5f5; font-weight: bold; }
        .footer { margin-top: 60px; display: flex; justify-content: space-around; text-align: center; }
        .signature { margin-top: 50px; }
        .signature-font { font-family: 'Great Vibes', 'Dancing Script', cursive; font-size: 36px; font-weight: normal; color: #000080; display: block; margin-bottom: 5px; }
        .signature-font-store { font-family: 'Dancing Script', cursive; font-size: 36px; font-weight: bold; color: #c20000; display: block; margin-bottom: 5px; }
        .highlight { font-weight: bold; }
    </style>
</head>
<body>
    <div class="a4-container" id="contract-content">

    <div class="header">
        <h2>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h2>
        <p class="motto">Độc lập - Tự do - Hạnh phúc</p>
        <p>---o0o---</p>
        <h3>HỢP ĐỒNG THUÊ XE MÔ TÔ, GẮN MÁY</h3>
        <p>Số/Mã hợp đồng: <span class="highlight"><%= bookingId %></span></p>
    </div>

    <p>Hôm nay, ngày <span class="highlight"><%= booking.getBookingDate() %></span>, tại Cửa hàng SmartRide Đà Nẵng. Chúng tôi gồm có:</p>

    <div class="section-title">BÊN CHO THUÊ (BÊN A)</div>
    <div class="info-block">
        <p>Tên tổ chức/Cá nhân: <span class="highlight">Cửa hàng cho thuê xe máy SmartRide</span></p>
        <p>Địa chỉ: 254 Nguyễn Văn Linh, Thạc Gián, Thanh Khê, Đà Nẵng</p>
        <p>Số điện thoại: 0905.123.456</p>
    </div>

    <div class="section-title">BÊN THUÊ (BÊN B)</div>
    <div class="info-block">
        <% if (account != null && customer != null) { %>
        <p>Ông/Bà: <span class="highlight" id="preview-name"><%= account.getFirstName() %> <%= account.getLastName() %></span></p>
        <p>Số CMND/CCCD/Passport: <span class="highlight" id="preview-cccd"><%= customer.getIdentityCard() %></span></p>
        <p>Địa chỉ liên lạc: <%= account.getAddress() != null ? account.getAddress() : "Không có" %></p>
        <p>Số điện thoại: <span class="highlight" id="preview-phone"><%= account.getPhoneNumber() %></span></p>
        <% } else { %>
        <p>Thông tin khách hàng không có sẵn hoặc đã bị xóa khỏi hệ thống.</p>
        <% } %>
    </div>

    <div class="section-title">ĐIỀU 1: NỘI DUNG HỢP ĐỒNG</div>
    <p>Bên A đồng ý cho Bên B thuê xe với các thông tin chi tiết như sau:</p>
    <table>
        <thead>
            <tr>
                <th>Loại xe (Model)</th>
                <th>Phân khúc (Category)</th>
                <th>Số lượng (Quantity)</th>
            </tr>
        </thead>
        <tbody id="contract-motor-list">
            <% for(Map<String, Object> mc : motorcycles) { %>
            <tr>
                <td style="font-weight: bold;"><%= mc.get("Model") %></td>
                <td><%= mc.get("CategoryName") %></td>
                <td style="text-align: center; font-weight: bold;"><%= mc.get("Quantity") %> chiếc</td>
            </tr>
            <% } %>
        </tbody>
    </table>
    
    <div class="info-block">
        <p>Thời gian nhận xe: <span class="highlight" id="preview-start-date"><%= booking.getStartDate() %></span></p>
        <p>Thời gian trả xe: <span class="highlight" id="preview-end-date"><%= booking.getEndDate() %></span></p>
        <p>Địa điểm giao xe: <%= booking.getDeliveryLocation() %></p>
        <p>Địa điểm thu hồi xe: <%= booking.getReturnedLocation() %></p>
    </div>

    <div class="section-title">ĐIỀU 2: QUY ĐỊNH VÀ PHẠT VI PHẠM</div>
    <ol style="padding-left: 20px;">
        <li><span class="highlight">Sử dụng xe:</span> Bên B cam kết sử dụng xe đúng mục đích, tuân thủ luật giao thông. Không cầm cố, thế chấp hoặc cho người khác mượn xe.</li>
        <li><span class="highlight">Trễ hạn trả xe:</span> Nếu Bên B trả xe trễ so với giờ quy định mà không gia hạn, Bên A sẽ tính phí phạt là <span class="highlight">50,000 VNĐ / giờ</span>. Quá 6 giờ sẽ tính thành 1 ngày thuê.</li>
        <li><span class="highlight">Hư hỏng và mất mát:</span> Bên B phải bồi thường 100% chi phí sửa chữa bằng phụ tùng chính hãng nếu xe bị trầy xước, móp méo, hư hỏng. Nếu làm mất xe, Bên B bồi thường theo giá trị thị trường hiện tại của xe.</li>
        <li><span class="highlight">Vi phạm giao thông:</span> Bên B chịu hoàn toàn trách nhiệm trước pháp luật và các khoản phạt nguội, chi phí liên quan nếu vi phạm luật giao thông trong thời gian thuê xe.</li>
    </ol>

    <div class="section-title">ĐIỀU 3: CAM KẾT CHUNG</div>
    <p>Hai bên cam kết thực hiện đúng các điều khoản trong hợp đồng. Hợp đồng có hiệu lực kể từ lúc Bên B nhận xe và kết thúc khi Bên B hoàn trả xe cùng các giấy tờ liên quan cho Bên A trong tình trạng nguyên vẹn.</p>

    <div class="footer">
        <div>
            <p class="highlight">BÊN THUÊ (BÊN B)</p>
            <p><em>(Ký, ghi rõ họ tên)</em></p>
            <div class="signature">
                <% if (account != null) { %>
                    <span class="signature-font" id="preview-sign-name1"><%= account.getFirstName() %> <%= account.getLastName() %></span>
                    <span class="highlight" id="preview-sign-name2"><%= account.getFirstName() %> <%= account.getLastName() %></span>
                <% } %>
            </div>
        </div>
        <div>
            <p class="highlight">BÊN CHO THUÊ (BÊN A)</p>
            <p><em>(Ký, đóng dấu)</em></p>
            <div class="signature">
                <span class="signature-font-store">SmartRide Store</span>
                <span style="color: #c20000; font-weight: bold; font-size: 18px;">Cửa hàng SmartRide</span>
            </div>
        </div>
    </div>

</div>

<script>
    if ('<%= bookingId %>' === 'preview') {
        try {
            const parentDoc = window.parent.document;
            
            // Sync user info
            const fname = parentDoc.querySelector('input[name="firstName"]');
            const lname = parentDoc.querySelector('input[name="lastName"]');
            const cccd = parentDoc.querySelector('input[name="cccd"]');
            const phone = parentDoc.querySelector('input[name="phoneNumber"]');
            
            let fullName = '';
            if (fname && fname.value) {
                fullName = (lname && lname.value ? lname.value + ' ' : '') + fname.value;
                document.getElementById('preview-name').textContent = fullName;
                document.getElementById('preview-sign-name1').textContent = fullName;
                document.getElementById('preview-sign-name2').textContent = fullName;
            }
            if (cccd && cccd.value) document.getElementById('preview-cccd').textContent = cccd.value;
            if (phone && phone.value) document.getElementById('preview-phone').textContent = phone.value;
            
            // Sync dates
            const pDate = parentDoc.querySelector('input[name="pickupDate"]');
            const rDate = parentDoc.querySelector('input[name="returnDate"]');
            if (pDate && pDate.value) document.getElementById('preview-start-date').textContent = pDate.value.replace('T', ' ');
            if (rDate && rDate.value) document.getElementById('preview-end-date').textContent = rDate.value.replace('T', ' ');
            
            // Sync motorcycles
            const selects = parentDoc.querySelectorAll('#motorcyclelist .form-check-select');
            const tbody = document.getElementById('contract-motor-list');
            let hasItems = false;
            selects.forEach(function(sel) {
                const qty = parseInt(sel.value) || 0;
                if (qty > 0) {
                    hasItems = true;
                    const box = sel.closest('.form-box');
                    const name = box.querySelector('.motor-name').textContent.trim();
                    const category = box.querySelector('.motor-category') ? box.querySelector('.motor-category').textContent.trim() : 'Xe máy';
                    
                    const tr = document.createElement('tr');
                    tr.innerHTML = '<td style="font-weight: bold;">' + name + '</td>' +
        customer.setIdentityCard("048099001234");
        
        motorcycles = new java.util.ArrayList<>();
    } else {
        BookingDAO dao = BookingDAO.getInstance();
        booking = dao.getBookingById(bookingId);
        if (booking == null) {
            out.println("Hợp đồng không tồn tại!");
            return;
        }
        
        CustomerDAO daoCus = CustomerDAO.getInstance();
        customer = daoCus.getCustomerbyID(booking.getCustomerID());
        AccountDAO daoAcc = AccountDAO.getInstance();
        if (customer != null) {
            account = daoAcc.getAccountbyID(customer.getAccountId());
        }
        
        motorcycles = dao.getMotorcyclesByBookingID(bookingId);
    }
    
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&family=Great+Vibes&display=swap" rel="stylesheet">
    <title>Hợp Đồng Thuê Xe - <%= bookingId %></title>
    <style>
        body { margin: 0; padding: 20px; background: #f4f4f5; display: flex; justify-content: center; }
        .a4-container { 
            width: 800px; 
            max-width: 800px; 
            background: #fff; 
            padding: 40px 50px; 
            box-sizing: border-box; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
            font-family: 'Times New Roman', serif; 
            line-height: 1.6; 
            color: #111; 
            font-size: 15px; 
        }
        .header { text-align: center; margin-bottom: 30px; }
        .header h2 { margin: 0; font-size: 18px; text-transform: uppercase; font-weight: bold; }
        .header h3 { margin: 15px 0 20px; font-size: 22px; font-weight: bold; }
        .header .motto { margin: 5px 0; font-weight: bold; font-size: 16px; text-decoration: underline; }
        .section-title { font-weight: bold; margin-top: 25px; margin-bottom: 10px; font-size: 16px; text-transform: uppercase; }
        .info-block { margin-bottom: 15px; padding-left: 10px; }
        .info-block p { margin: 5px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; margin-bottom: 20px; }
        th, td { border: 1px solid #333; padding: 10px; text-align: left; }
        th { background-color: #f5f5f5; font-weight: bold; }
        .footer { margin-top: 60px; display: flex; justify-content: space-around; text-align: center; }
        .signature { margin-top: 50px; }
        .signature-font { font-family: 'Great Vibes', 'Dancing Script', cursive; font-size: 36px; font-weight: normal; color: #000080; display: block; margin-bottom: 5px; }
        .signature-font-store { font-family: 'Dancing Script', cursive; font-size: 36px; font-weight: bold; color: #c20000; display: block; margin-bottom: 5px; }
        .highlight { font-weight: bold; }
    </style>
</head>
<body>
    <div class="a4-container" id="contract-content">

    <div class="header">
        <h2>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h2>
        <p class="motto">Độc lập - Tự do - Hạnh phúc</p>
        <p>---o0o---</p>
        <h3>HỢP ĐỒNG THUÊ XE MÔ TÔ, GẮN MÁY</h3>
        <p>Số/Mã hợp đồng: <span class="highlight"><%= bookingId %></span></p>
    </div>

    <p>Hôm nay, ngày <span class="highlight"><%= booking.getBookingDate() %></span>, tại Cửa hàng SmartRide Đà Nẵng. Chúng tôi gồm có:</p>

    <div class="section-title">BÊN CHO THUÊ (BÊN A)</div>
    <div class="info-block">
        <p>Tên tổ chức/Cá nhân: <span class="highlight">Cửa hàng cho thuê xe máy SmartRide</span></p>
        <p>Địa chỉ: 254 Nguyễn Văn Linh, Thạc Gián, Thanh Khê, Đà Nẵng</p>
        <p>Số điện thoại: 0905.123.456</p>
    </div>

    <div class="section-title">BÊN THUÊ (BÊN B)</div>
    <div class="info-block">
        <% if (account != null && customer != null) { %>
        <p>Ông/Bà: <span class="highlight" id="preview-name"><%= account.getFirstName() %> <%= account.getLastName() %></span></p>
        <p>Số CMND/CCCD/Passport: <span class="highlight" id="preview-cccd"><%= customer.getIdentityCard() %></span></p>
        <p>Địa chỉ liên lạc: <%= account.getAddress() != null ? account.getAddress() : "Không có" %></p>
        <p>Số điện thoại: <span class="highlight" id="preview-phone"><%= account.getPhoneNumber() %></span></p>
        <% } else { %>
        <p>Thông tin khách hàng không có sẵn hoặc đã bị xóa khỏi hệ thống.</p>
        <% } %>
    </div>

    <div class="section-title">ĐIỀU 1: NỘI DUNG HỢP ĐỒNG</div>
    <p>Bên A đồng ý cho Bên B thuê xe với các thông tin chi tiết như sau:</p>
    <table>
        <thead>
            <tr>
                <th>Loại xe (Model)</th>
                <th>Phân khúc (Category)</th>
                <th>Số lượng (Quantity)</th>
            </tr>
        </thead>
        <tbody id="contract-motor-list">
            <% for(Map<String, Object> mc : motorcycles) { %>
            <tr>
                <td style="font-weight: bold;"><%= mc.get("Model") %></td>
                <td><%= mc.get("CategoryName") %></td>
                <td style="text-align: center; font-weight: bold;"><%= mc.get("Quantity") %> chiếc</td>
            </tr>
            <% } %>
        </tbody>
    </table>
    
    <div class="info-block">
        <p>Thời gian nhận xe: <span class="highlight" id="preview-start-date"><%= booking.getStartDate() %></span></p>
        <p>Thời gian trả xe: <span class="highlight" id="preview-end-date"><%= booking.getEndDate() %></span></p>
        <p>Địa điểm giao xe: <%= booking.getDeliveryLocation() %></p>
        <p>Địa điểm thu hồi xe: <%= booking.getReturnedLocation() %></p>
    </div>

    <div class="section-title">ĐIỀU 2: QUY ĐỊNH VÀ PHẠT VI PHẠM</div>
    <ol style="padding-left: 20px;">
        <li><span class="highlight">Sử dụng xe:</span> Bên B cam kết sử dụng xe đúng mục đích, tuân thủ luật giao thông. Không cầm cố, thế chấp hoặc cho người khác mượn xe.</li>
        <li><span class="highlight">Trễ hạn trả xe:</span> Nếu Bên B trả xe trễ so với giờ quy định mà không gia hạn, Bên A sẽ tính phí phạt là <span class="highlight">50,000 VNĐ / giờ</span>. Quá 6 giờ sẽ tính thành 1 ngày thuê.</li>
        <li><span class="highlight">Hư hỏng và mất mát:</span> Bên B phải bồi thường 100% chi phí sửa chữa bằng phụ tùng chính hãng nếu xe bị trầy xước, móp méo, hư hỏng. Nếu làm mất xe, Bên B bồi thường theo giá trị thị trường hiện tại của xe.</li>
        <li><span class="highlight">Vi phạm giao thông:</span> Bên B chịu hoàn toàn trách nhiệm trước pháp luật và các khoản phạt nguội, chi phí liên quan nếu vi phạm luật giao thông trong thời gian thuê xe.</li>
    </ol>

    <div class="section-title">ĐIỀU 3: CAM KẾT CHUNG</div>
    <p>Hai bên cam kết thực hiện đúng các điều khoản trong hợp đồng. Hợp đồng có hiệu lực kể từ lúc Bên B nhận xe và kết thúc khi Bên B hoàn trả xe cùng các giấy tờ liên quan cho Bên A trong tình trạng nguyên vẹn.</p>

    <div class="footer">
        <div>
            <p class="highlight">BÊN THUÊ (BÊN B)</p>
            <p><em>(Ký, ghi rõ họ tên)</em></p>
            <div class="signature">
                <% if (account != null) { %>
                    <span class="signature-font" id="preview-sign-name1"><%= account.getFirstName() %> <%= account.getLastName() %></span>
                    <span class="highlight" id="preview-sign-name2"><%= account.getFirstName() %> <%= account.getLastName() %></span>
                <% } %>
            </div>
        </div>
        <div>
            <p class="highlight">BÊN CHO THUÊ (BÊN A)</p>
            <p><em>(Ký, đóng dấu)</em></p>
            <div class="signature">
                <span class="signature-font-store">SmartRide Store</span>
                <span style="color: #c20000; font-weight: bold; font-size: 18px;">Cửa hàng SmartRide</span>
            </div>
        </div>
    </div>

</div>

<script>
    if ('<%= bookingId %>' === 'preview') {
        try {
            const parentDoc = window.parent.document;
            
            // Sync user info
            const fname = parentDoc.querySelector('input[name="firstName"]');
            const lname = parentDoc.querySelector('input[name="lastName"]');
            const cccd = parentDoc.querySelector('input[name="cccd"]');
            const phone = parentDoc.querySelector('input[name="phoneNumber"]');
            
            let fullName = '';
            if (fname && fname.value) {
                fullName = (lname && lname.value ? lname.value + ' ' : '') + fname.value;
                document.getElementById('preview-name').textContent = fullName;
                document.getElementById('preview-sign-name1').textContent = fullName;
                document.getElementById('preview-sign-name2').textContent = fullName;
            }
            if (cccd && cccd.value) document.getElementById('preview-cccd').textContent = cccd.value;
            if (phone && phone.value) document.getElementById('preview-phone').textContent = phone.value;
            
            // Sync dates
            const pDate = parentDoc.querySelector('input[name="pickupDate"]');
            const rDate = parentDoc.querySelector('input[name="returnDate"]');
            if (pDate && pDate.value) document.getElementById('preview-start-date').textContent = pDate.value.replace('T', ' ');
            if (rDate && rDate.value) document.getElementById('preview-end-date').textContent = rDate.value.replace('T', ' ');
            
            // Sync motorcycles
            const selects = parentDoc.querySelectorAll('#motorcyclelist .form-check-select');
            const tbody = document.getElementById('contract-motor-list');
            let hasItems = false;
            selects.forEach(function(sel) {
                const qty = parseInt(sel.value) || 0;
                if (qty > 0) {
                    hasItems = true;
                    const box = sel.closest('.form-box');
                    const name = box.querySelector('.motor-name').textContent.trim();
                    const category = box.querySelector('.motor-category') ? box.querySelector('.motor-category').textContent.trim() : 'Xe máy';
                    
                    const tr = document.createElement('tr');
                    tr.innerHTML = '<td style="font-weight: bold;">' + name + '</td>' +
                                   '<td>' + category + '</td>' +
                                   '<td style="text-align: center; font-weight: bold;">' + qty + ' chiếc</td>';
                    tbody.appendChild(tr);
                }
            });
            if (!hasItems) {
                 tbody.innerHTML = '<tr><td colspan="3" style="text-align:center; color:red;">Bạn chưa chọn xe nào trong Đơn Hàng</td></tr>';
            }
        } catch(e) { console.error("Could not fetch data from parent:", e); }
    }
    
    <% if ("1".equals(request.getParameter("print"))) { %>
        window.onload = function() {
            setTimeout(function() {
                window.print();
            }, 500);
        };
    <% } %>
</script>
</body>
</html>

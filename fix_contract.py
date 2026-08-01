import os

file_path = r"d:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\contract.jsp"

with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# Add fonts
if "fonts.googleapis.com" not in content:
    content = content.replace(
        '<meta charset="UTF-8">',
        '<meta charset="UTF-8">\n    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&family=Great+Vibes&display=swap" rel="stylesheet">'
    )

# Add CSS classes
content = content.replace(
    '.signature { margin-top: 90px; }',
    '.signature { margin-top: 50px; }\n        .signature-font { font-family: \'Great Vibes\', \'Dancing Script\', cursive; font-size: 36px; font-weight: normal; color: #000080; display: block; margin-bottom: 5px; }\n        .signature-font-store { font-family: \'Dancing Script\', cursive; font-size: 36px; font-weight: bold; color: #c20000; display: block; margin-bottom: 5px; }'
)

# Fix table
table_orig = """    <table>
        <tr>
            <th>Loại xe</th>
            <th>Biển số</th>
            <th>Màu sắc</th>
        </tr>
        <% for(Map<String, Object> mc : motorcycles) { %>
        <tr>
            <td><%= mc.get("MotorcycleName") %></td>
            <td><%= mc.get("LicensePlate") %></td>
            <td><%= mc.get("Color") %></td>
        </tr>
        <% } %>
    </table>"""

table_new = """    <table>
        <tr>
            <th>Loại xe (Model)</th>
            <th>Phân khúc (Category)</th>
            <th>Số lượng (Quantity)</th>
        </tr>
        <% for(Map<String, Object> mc : motorcycles) { %>
        <tr>
            <td style="font-weight: bold;"><%= mc.get("Model") %></td>
            <td><%= mc.get("CategoryName") %></td>
            <td style="text-align: center; font-weight: bold;"><%= mc.get("Quantity") %> chiếc</td>
        </tr>
        <% } %>
    </table>"""
content = content.replace(table_orig, table_new)

# Fix signatures
sig_orig1 = """            <div class="signature">
                <% if (account != null) { %>
                    <span class="highlight"><%= account.getLastName() %> <%= account.getFirstName() %></span>
                <% } %>
            </div>"""

sig_new1 = """            <div class="signature">
                <% if (account != null) { %>
                    <span class="signature-font"><%= account.getLastName() %> <%= account.getFirstName() %></span>
                    <span class="highlight"><%= account.getLastName() %> <%= account.getFirstName() %></span>
                <% } %>
            </div>"""
content = content.replace(sig_orig1, sig_new1)

sig_orig2 = """            <div class="signature">
                <span style="color: #c20000; font-weight: bold; font-size: 18px;">SmartRide Store</span>
            </div>"""

sig_new2 = """            <div class="signature">
                <span class="signature-font-store">SmartRide Store</span>
                <span style="color: #c20000; font-weight: bold; font-size: 18px;">Cửa hàng SmartRide</span>
            </div>"""
content = content.replace(sig_orig2, sig_new2)


with open(file_path, "w", encoding="utf-8") as f:
    f.write(content)
print("Contract updated")

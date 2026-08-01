import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\bookingHistoryDetail.jsp'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Add invoice button
target_button = '''                                <button type="button" id="contract-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #4f46e5" onclick="openContractModal()">
                                    <i class="fas fa-file-contract"></i> Xem hợp đồng
                                </button>'''
replacement_button = '''                                <button type="button" id="contract-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #4f46e5" onclick="openContractModal()">
                                    <i class="fas fa-file-contract"></i> Xem hợp đồng
                                </button>
                                <c:if test="">
                                    <button type="button" id="invoice-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #10b981" onclick="openInvoiceModal()">
                                        <i class="fas fa-file-invoice-dollar"></i> Xem Biên lai
                                    </button>
                                </c:if>'''

content = content.replace(target_button, replacement_button)

# Also support alternative encoding in case
target_button2 = '''                                <button type="button" id="contract-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #4f46e5" onclick="openContractModal()">
                                    <i class="fas fa-file-contract"></i> Xem h?p d?ng
                                </button>'''
replacement_button2 = '''                                <button type="button" id="contract-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #4f46e5" onclick="openContractModal()">
                                    <i class="fas fa-file-contract"></i> Xem hợp đồng
                                </button>
                                <c:if test="">
                                    <button type="button" id="invoice-btn" class="px-4 py-2 text-white rounded-xl font-bold text-sm shadow-md transition-all duration-200 cursor-pointer flex items-center gap-1.5 hover:opacity-90" style="background-color: #10b981" onclick="openInvoiceModal()">
                                        <i class="fas fa-file-invoice-dollar"></i> Xem Biên lai
                                    </button>
                                </c:if>'''
content = content.replace(target_button2, replacement_button2)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

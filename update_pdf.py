import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\bookingHistoryDetail.jsp'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

target = '''<button class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-bold text-sm shadow-md transition-colors" onclick="document.getElementById('contractIframe').contentWindow.print()">
                            <i class="fas fa-print"></i> In h?p d?ng
                        </button>'''
# Fix encoding issues in search target
target_alt = '''<button class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-bold text-sm shadow-md transition-colors" onclick="document.getElementById('contractIframe').contentWindow.print()">
                            <i class="fas fa-print"></i> In hợp đồng
                        </button>'''

replacement = '''<button class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-bold text-sm shadow-md transition-colors mr-2" onclick="downloadContractPDF()">
                            <i class="fas fa-file-download"></i> Tải PDF
                        </button>
                        <button class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-bold text-sm shadow-md transition-colors" onclick="document.getElementById('contractIframe').contentWindow.print()">
                            <i class="fas fa-print"></i> In hợp đồng
                        </button>
                        
                        <!-- Include html2pdf.js -->
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
                        <script>
                            function downloadContractPDF() {
                                const iframe = document.getElementById('contractIframe');
                                const element = iframe.contentWindow.document.body;
                                const opt = {
                                  margin:       [0, 0, 0, 0],
                                  filename:     'HopDongThueXe_.pdf',
                                  image:        { type: 'jpeg', quality: 0.98 },
                                  html2canvas:  { scale: 2, useCORS: true },
                                  jsPDF:        { unit: 'in', format: 'a4', orientation: 'portrait' }
                                };
                                html2pdf().set(opt).from(element).save();
                            }
                        </script>'''

content = content.replace(target, replacement).replace(target_alt, replacement)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Added PDF download button')

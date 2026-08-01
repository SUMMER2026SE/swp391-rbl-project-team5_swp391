import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\bookingHistoryDetail.jsp'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Add invoice modal
modal_target = '''        <!-- Contract Modal -->
        <div id="contract-modal" class="hidden items-center justify-center p-4" style="position: fixed; inset: 0; background-color: rgba(0,0,0,0.6); backdrop-filter: blur(4px); z-index: 999999;">'''

modal_replacement = '''        <!-- Invoice Modal -->
        <div id="invoice-modal" class="hidden items-center justify-center p-4" style="position: fixed; inset: 0; background-color: rgba(0,0,0,0.6); backdrop-filter: blur(4px); z-index: 999999;">
            <div class="bg-white rounded-2xl w-full max-w-4xl max-h-[90vh] shadow-2xl relative flex flex-col overflow-hidden animate-fade-in-up">
                <!-- Header -->
                <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between bg-gray-50/80">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center text-green-600">
                            <i class="fas fa-file-invoice-dollar text-lg"></i>
                        </div>
                        <div>
                            <h3 class="font-bold text-gray-800 text-lg">Biên lai thanh toán</h3>
                            <p class="text-sm text-gray-500 font-medium">SmartRide Booking</p>
                        </div>
                    </div>
                    <button onclick="closeInvoiceModal()" class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200 text-gray-400 hover:text-gray-600 transition-colors">
                        <i class="fas fa-times text-lg"></i>
                    </button>
                </div>
                
                <!-- Content -->
                <div class="flex-1 overflow-hidden bg-gray-50 relative p-4">
                    <iframe id="invoiceIframe" src="" class="w-full h-full border-0 bg-white shadow-sm rounded-xl"></iframe>
                </div>

                <!-- Footer -->
                <div class="px-6 py-4 border-t border-gray-100 flex items-center justify-between bg-white">
                    <div class="text-sm text-gray-500">
                        <i class="fas fa-info-circle text-green-500 mr-1"></i> Biên lai xác nhận thanh toán 100%
                    </div>
                    <div class="flex gap-2">
                        <button class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-bold text-sm shadow-md transition-colors mr-2" onclick="downloadInvoicePDF()">
                            <i class="fas fa-file-download"></i> Tải PDF
                        </button>
                        <button class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-bold text-sm shadow-md transition-colors" onclick="document.getElementById('invoiceIframe').contentWindow.print()">
                            <i class="fas fa-print"></i> In biên lai
                        </button>
                        <script>
                            function downloadInvoicePDF() {
                                const iframe = document.getElementById('invoiceIframe');
                                const element = iframe.contentWindow.document.body;
                                const opt = {
                                  margin:       [0, 0, 0, 0],
                                  filename:     'BienLai_.pdf',
                                  image:        { type: 'jpeg', quality: 0.98 },
                                  html2canvas:  { scale: 2, useCORS: true },
                                  jsPDF:        { unit: 'in', format: 'a4', orientation: 'portrait' }
                                };
                                html2pdf().set(opt).from(element).save();
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contract Modal -->
        <div id="contract-modal" class="hidden items-center justify-center p-4" style="position: fixed; inset: 0; background-color: rgba(0,0,0,0.6); backdrop-filter: blur(4px); z-index: 999999;">'''

content = content.replace(modal_target, modal_replacement)

script_target = '''            function openContractModal() {
                const modal = document.getElementById('contract-modal');
                if (modal) modal.style.display = 'flex';
            }'''
script_replacement = '''            function openInvoiceModal() {
                const modal = document.getElementById('invoice-modal');
                if (modal) {
                    modal.style.display = 'flex';
                    const iframe = document.getElementById('invoiceIframe');
                    if (iframe && iframe.src === '') {
                        iframe.src = 'invoice.jsp?bookingId=';
                    }
                }
            }
            function closeInvoiceModal() {
                const modal = document.getElementById('invoice-modal');
                if (modal) modal.style.display = 'none';
            }
            
            function openContractModal() {
                const modal = document.getElementById('contract-modal');
                if (modal) modal.style.display = 'flex';
            }'''
content = content.replace(script_target, script_replacement)

window_click_target = '''                const payment = document.getElementById("payment-modal");
                const extendFormModal = document.getElementById("extend-form-modal");'''
window_click_replacement = '''                const payment = document.getElementById("payment-modal");
                const extendFormModal = document.getElementById("extend-form-modal");
                const invoice = document.getElementById("invoice-modal");'''
content = content.replace(window_click_target, window_click_replacement)

window_click2_target = '''                if (event.target === extendFormModal) {
                    closeExtensionFormModal();
                }'''
window_click2_replacement = '''                if (event.target === extendFormModal) {
                    closeExtensionFormModal();
                }
                if (event.target === invoice) {
                    closeInvoiceModal();
                }'''
content = content.replace(window_click2_target, window_click2_replacement)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Invoice modal added')

import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\home.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Add onchange to select
target_select = '''                                            <select name="locations" class="form-select form-select-lg" style="border-radius: 12px; border: none; background: #ffffff; color: #1a1816; font-weight: 500; font-family: 'Plus Jakarta Sans', sans-serif; box-shadow: 0 5px 15px rgba(0,0,0,0.1); cursor: pointer; padding-left: 45px; height: 56px;" required>'''
repl_select = '''                                            <select name="locations" id="smartLocationSelect" onchange="triggerAIAssistant(this)" class="form-select form-select-lg" style="border-radius: 12px; border: none; background: #ffffff; color: #1a1816; font-weight: 500; font-family: 'Plus Jakarta Sans', sans-serif; box-shadow: 0 5px 15px rgba(0,0,0,0.1); cursor: pointer; padding-left: 45px; height: 56px;" required>'''
content = content.replace(target_select, repl_select)

# Add AI box HTML below the form
target_form_end = '''                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>'''
repl_form_end = '''                                        </button>
                                    </div>
                                </form>
                                
                                <!-- AI Assistant Response Box -->
                                <div id="ai-assistant-box" style="display:none; margin-top:20px; background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(10px); border: 1px solid rgba(181, 147, 73, 0.3); border-radius: 15px; padding: 15px 20px; color: #fff; font-family: 'Plus Jakarta Sans', sans-serif; transform: translateY(-10px); opacity: 0; transition: all 0.4s ease;">
                                    <div style="display:flex; align-items:center; gap:10px; margin-bottom: 8px;">
                                        <div style="width:30px; height:30px; border-radius:50%; background:#b59349; display:flex; align-items:center; justify-content:center;">
                                            <i class="bi bi-robot" style="color:#fff; font-size:14px;"></i>
                                        </div>
                                        <span style="font-weight:700; color:#b59349; letter-spacing:0.5px;">AI Trợ Lý Phân Tích:</span>
                                    </div>
                                    <div id="ai-assistant-text" style="font-size: 14.5px; line-height: 1.5; color: #e5e7eb; font-weight: 400; min-height: 22px;">
                                        <!-- Text typed out here -->
                                    </div>
                                </div>
                                
                            </div>
                        </div>'''
content = content.replace(target_form_end, repl_form_end)

# Add AI javascript
target_script = '''            function handleSmartSearch(e, form) {'''
repl_script = '''            const aiRules = {
                mountain: {
                    keywords: ['đèo', 'hải vân', 'sơn trà', 'bà nà', 'đỉnh', 'núi'],
                    text: 'Khu vực này có địa hình dốc cao và đèo dốc. Trợ lý AI khuyên bạn nên chọn các dòng <b>Xe Số (Wave, Sirius)</b> hoặc <b>Xe Tay Côn (Winner, Exciter)</b> để có lực kéo tốt và đảm bảo an toàn tuyệt đối khi đổ đèo nhé!'
                },
                flat_long: {
                    keywords: ['hội an', 'bãi biển', 'ngũ hành sơn', 'nam ô'],
                    text: 'Tuyến đường này chủ yếu là đường bằng phẳng và di chuyển khá xa. Các dòng <b>Xe Tay Ga (Air Blade, Vision)</b> sẽ mang lại trải nghiệm êm ái, thoải mái nhất cho chuyến đi của bạn!'
                },
                city: {
                    keywords: [],
                    text: 'Địa hình nội thành rất đẹp và dễ đi! Bạn có thể thoải mái chọn bất kỳ dòng xe nào theo sở thích. Một chiếc <b>Xe Tay Ga (Vespa, Lead, Vision)</b> sẽ rất tiện lợi để lượn lờ phố xá và check-in cà phê đấy!'
                }
            };

            function triggerAIAssistant(selectElement) {
                const selectedText = selectElement.options[selectElement.selectedIndex].text.toLowerCase();
                const aiBox = document.getElementById('ai-assistant-box');
                const aiText = document.getElementById('ai-assistant-text');
                
                // Show box with animation
                aiBox.style.display = 'block';
                setTimeout(() => {
                    aiBox.style.opacity = '1';
                    aiBox.style.transform = 'translateY(0)';
                }, 50);

                // Start typing animation
                aiText.innerHTML = '<span style="color:#a8b2d1;"><i class="fas fa-circle-notch fa-spin"></i> Đang phân tích địa hình tự động...</span>';
                
                // Determine rule
                let ruleToApply = aiRules.city; // default
                for (let keyword of aiRules.mountain.keywords) {
                    if (selectedText.includes(keyword)) {
                        ruleToApply = aiRules.mountain;
                        break;
                    }
                }
                if (ruleToApply === aiRules.city) {
                    for (let keyword of aiRules.flat_long.keywords) {
                        if (selectedText.includes(keyword)) {
                            ruleToApply = aiRules.flat_long;
                            break;
                        }
                    }
                }

                // Simulate AI thinking delay
                setTimeout(() => {
                    typeWriter(ruleToApply.text, aiText, 0);
                }, 1200);
            }

            function typeWriter(text, element, index) {
                if (index === 0) { element.innerHTML = ''; }
                
                // Parse HTML tags properly so they appear instantly instead of letter-by-letter
                if (text.charAt(index) === '<') {
                    let tag = '';
                    while (text.charAt(index) !== '>' && index < text.length) {
                        tag += text.charAt(index);
                        index++;
                    }
                    tag += '>';
                    element.innerHTML += tag;
                    index++;
                }
                
                if (index < text.length) {
                    element.innerHTML += text.charAt(index);
                    setTimeout(() => {
                        typeWriter(text, element, index + 1);
                    }, 25); // typing speed
                } else {
                    // Add a tiny link to auto-filter
                    element.innerHTML += '<div style="margin-top:10px;"><button onclick="document.querySelector(\\'form[action=searchCriteria]\\').submit()" style="background:none; border:none; padding:0; color:#b59349; text-decoration:underline; font-size:13px; font-weight:bold; cursor:pointer;">Tiến hành tìm xe phù hợp <i class="fas fa-arrow-right"></i></button></div>';
                }
            }

            function handleSmartSearch(e, form) {'''
content = content.replace(target_script, repl_script)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Added AI Assistant auto-thinking logic to home.jsp')

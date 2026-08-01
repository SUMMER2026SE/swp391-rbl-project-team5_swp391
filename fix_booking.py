import re
with open('src/main/webapp/booking.jsp', 'r', encoding='utf-8') as f:
    content = f.read()

# Remove the duplicate standalone input for pickup
pickup_standalone_pattern = re.compile(r'<input type="text" id="custom_pickup_input".*?oninput="updateCustomLocation\(\'pickup\'\)" />\s*', re.DOTALL)
content = pickup_standalone_pattern.sub('', content)

# Add oninput="updateCustomLocation('pickup')" to the wrapper's input
content = content.replace('onblur="calcDistance(\'pickup\')"', 'onblur="calcDistance(\'pickup\')" oninput="updateCustomLocation(\'pickup\')"')

# Remove the duplicate standalone input for return
return_standalone_pattern = re.compile(r'<input type="text" id="custom_return_input".*?oninput="updateCustomLocation\(\'return\'\)" />\s*', re.DOTALL)
content = return_standalone_pattern.sub('', content)

# Add oninput="updateCustomLocation('return')" to the wrapper's input
content = content.replace('onblur="calcDistance(\'return\')"', 'onblur="calcDistance(\'return\')" oninput="updateCustomLocation(\'return\')"')

# Fix toggleCustomLocation in JS
js_old = '''                                        function toggleCustomLocation(type) {
                                            var select = document.getElementById(type + 'location');
                                            var input = document.getElementById('custom_' + type + '_input');
                                            var selectedOption = select.options[select.selectedIndex];
                                            if (selectedOption.text.includes('(tự nhập)')) {
                                                input.style.display = 'block';
                                                input.required = true;
                                            } else {
                                                input.style.display = 'none';
                                                input.required = false;
                                            }
                                        }'''

js_new = '''                                        function toggleCustomLocation(type) {
                                            var select = document.getElementById(type + 'location');
                                            var wrapper = document.getElementById(type + '_custom_wrapper');
                                            var input = document.getElementById('custom_' + type + '_input');
                                            var selectedOption = select.options[select.selectedIndex];
                                            if (selectedOption.text.includes('(tự nhập)')) {
                                                wrapper.style.display = 'block';
                                                input.required = true;
                                            } else {
                                                wrapper.style.display = 'none';
                                                input.required = false;
                                            }
                                        }'''

content = content.replace(js_old, js_new)

with open('src/main/webapp/booking.jsp', 'w', encoding='utf-8') as f:
    f.write(content)
print('Done!')
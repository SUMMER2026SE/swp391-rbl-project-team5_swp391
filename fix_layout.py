with open('src/main/webapp/bookingHistoryDetail.jsp', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Extract GPS DEMO BLOCK and remove <c:if test="${false}">
gps_start_marker = '<c:if test="${false}">\s*<!-- GPS DEMO BLOCK -->' 
import re
gps_pattern = re.compile(r'<c:if test="\$\{false\}">\s*(<!-- GPS DEMO BLOCK -->.*?</script>)\s*</c:if>', re.DOTALL)
match = gps_pattern.search(content)
if match:
    gps_content = match.group(1)
    content = content[:match.start()] + content[match.end():]
    
    gps_column = f'''<!-- Column 4: Định vị GPS -->
                            <div class="flex flex-col h-full">
                                <div class="bg-white border border-gray-100 shadow-sm rounded-2xl p-6 relative overflow-hidden flex-1">
{gps_content}
                                </div>
                            </div>'''

# 2. Get Column 2 and 3 from full_bookingHistoryDetail.jsp
with open('full_bookingHistoryDetail.jsp', 'r', encoding='utf-8') as f:
    full_content = f.read()

col2_start = full_content.find('<!-- Column 2:')
# End of Column 3 is the grid closing div. We know it ends before '<!-- Mini Extension Info Link -->'
mini_ext_start = full_content.find('<!-- Mini Extension Info Link -->')

# Go back from mini_ext_start to find the closing </div> of the grid.
grid_close_index = full_content.rfind('</div>', 0, mini_ext_start)

col2_and_3_content = full_content[col2_start:grid_close_index].strip()

# 3. Find the end of the grid in bookingHistoryDetail.jsp
# It ends right before '<!-- Mini Extension Info Link -->'
insert_end = content.find('<!-- Mini Extension Info Link -->')
insert_grid_close = content.rfind('</div>', 0, insert_end)

# Insert col2, col3, col4 right before insert_grid_close
new_columns = f"\n                            {col2_and_3_content}\n                            {gps_column}\n                            "
content = content[:insert_grid_close] + new_columns + content[insert_grid_close:]

# Fix grid cols to lg:grid-cols-2
content = content.replace('grid-cols-1 lg:grid-cols-1', 'grid-cols-1 lg:grid-cols-2')
content = content.replace('grid-cols-1 lg:grid-cols-3', 'grid-cols-1 lg:grid-cols-2')

# 4. Fix Chat JS flicker
chat_js_pattern = re.compile(r'(function loadChatMessages\(\) \{.*?)(\s*let container = \$\(.*?;)(.*?\.html\(html\);)(.*?\}\))', re.DOTALL)
chat_js_replacement = r'''\1\2
                if (window.lastChatHtml !== html) {
                    window.lastChatHtml = html;
                    \3\4
                }'''
content = chat_js_pattern.sub(chat_js_replacement, content)

with open('src/main/webapp/bookingHistoryDetail.jsp', 'w', encoding='utf-8') as f:
    f.write(content)
print('Done layout extraction!')
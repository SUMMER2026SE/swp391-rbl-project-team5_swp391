import re

def refactor_jsp(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Step 1: Change grid-cols-3 to grid-cols-2
    content = content.replace(
        '<div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">',
        '<div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">'
    )

    # Step 2: We need to extract the "Trạng thái giao xe", "GPS", and "Lý do hủy" from Column 1.
    # We find the start of <c:if test="${statusBooking == 'Đã xác nhận'}"> inside Column 1
    # which is around line 173.
    # The end is after the cancellation block.
    
    start_str = """                                        <c:if test="${statusBooking == 'Đã xác nhận'}">"""
    end_str = """                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Column 2: Chi tiết xe -->"""
                            
    start_idx = content.find(start_str)
    end_idx = content.find(end_str) + len("""                                        </c:if>""")
    
    if start_idx == -1 or end_idx < start_idx:
        print("Could not find the block to extract!")
        return

    extracted_block = content[start_idx:end_idx]
    
    # Remove the extracted block from Column 1
    content = content[:start_idx] + content[end_idx:]

    # Step 3: Now we close the first grid after Column 2, and start a new grid.
    # We need to find the end of Column 2.
    col3_start_str = """                            <!-- Column 3: Tổng kết thanh toán -->"""
    col3_start_idx = content.find(col3_start_str)
    
    if col3_start_idx == -1:
        print("Could not find Column 3!")
        return
        
    grid2_split = """
                        </div>
                        
                        <!-- Content Grid Row 2: Payment and Status -->
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
"""
    content = content[:col3_start_idx] + grid2_split + content[col3_start_idx:]

    # Step 4: Add the new Column 4 (Status & GPS) after Column 3
    # Find the end of Column 3
    # Wait, Column 3 ends with:
    #                                 </div>
    #                                 
    #                             </div>
    #                         </div>
    #                         
    #                         <!-- Mini Extension Info Link -->
    
    col3_end_str = """                            </div>
                        </div>

                        <!-- Mini Extension Info Link -->"""
                        
    col3_end_idx = content.find(col3_end_str)
    if col3_end_idx == -1:
        print("Could not find end of grid!")
        # Let's try another string
        col3_end_str2 = """                                </div>
                                
                            </div>"""
        col3_end_idx = content.find(col3_end_str2) + len(col3_end_str2)
        if col3_end_idx == -1:
            print("Still could not find end of col 3")
            return
            
    # Wrap the extracted block in a new Card
    new_card = f"""
                            <!-- Column 4: Theo dõi & Trạng thái -->
                            <div class="flex flex-col h-full">
                                <div class="bg-white border border-gray-100 shadow-sm rounded-2xl p-6 relative overflow-hidden flex-1">
                                    <h4 class="text-lg font-extrabold text-gray-800 mb-5 flex items-center relative z-10">
                                        <i class="fas fa-satellite-dish text-blue-500 mr-3 text-xl"></i> Theo dõi & Trạng thái
                                    </h4>
                                    <div class="space-y-5 relative z-10">
{extracted_block}
                                    </div>
                                </div>
                            </div>
"""

    content = content[:col3_end_idx] + new_card + content[col3_end_idx:]
    
    # Let's fix the extra closing </div> for the grid.
    # The original file had a closing </div> for the 3-col grid. Now we have two grids, so we need to make sure both are closed.
    # We inserted `</div>` before the second grid, so the original `</div>` will close the second grid. This is perfect.
    
    # Fix the padding of the extracted blocks. They have `mt-6 pt-5 border-t border-gray-100`. We should remove the border-t on the first one so it looks good as a new card.
    content = content.replace(
        '<div class="mt-6 pt-5 border-t border-gray-100 flex items-center gap-4">',
        '<div class="flex items-center gap-4">', 1
    )

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)
        
    print("Successfully refactored JSP!")

refactor_jsp(r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\webapp\bookingHistoryDetail.jsp')

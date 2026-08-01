<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tích Lũy & Thưởng - SmartRide</title>
    <jsp:include page="/includes/customer/header.jsp" />
    <style>
        .loyalty-container {
            max-width: 900px;
            margin: 40px auto;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .loyalty-card {
            background: linear-gradient(135deg, #1f1c2c, #928DAB);
            color: white;
            padding: 30px;
            border-radius: 16px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .loyalty-card::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 60%);
            transform: rotate(45deg);
        }

        .tier-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            display: inline-block;
            margin-bottom: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.3);
        }

        .spent-amount {
            font-size: 36px;
            font-weight: 800;
            margin: 0;
            letter-spacing: 1px;
            text-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .loyalty-icon {
            font-size: 80px;
            opacity: 0.9;
            text-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        /* Progress Bar */
        .progress-wrapper {
            margin-top: 20px;
            position: relative;
        }
        
        .progress-labels {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            margin-bottom: 8px;
            color: rgba(255,255,255,0.8);
            font-weight: 500;
        }

        .progress-bar-bg {
            background: rgba(255, 255, 255, 0.2);
            height: 8px;
            border-radius: 4px;
            overflow: hidden;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.2);
        }

        .progress-bar-fill {
            background: #d4af37;
            height: 100%;
            border-radius: 4px;
            transition: width 1s ease-in-out;
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.5);
        }

        /* Milestones Grid */
        .milestones {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }

        .milestone-card {
            background: #f8f9fa;
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .milestone-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            border-color: #d4af37;
        }

        .milestone-card.achieved {
            background: linear-gradient(145deg, #fff, #f0f8ff);
            border-color: #4CAF50;
        }

        .milestone-icon {
            font-size: 30px;
            margin-bottom: 15px;
        }

        .milestone-card.achieved .milestone-icon {
            color: #4CAF50;
        }

        /* Vouchers */
        .vouchers-section h3 {
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }

        .voucher-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .voucher-item {
            background: #fff;
            border: 1px dashed #d4af37;
            border-radius: 12px;
            padding: 20px;
            position: relative;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .voucher-item:hover {
            box-shadow: 0 8px 25px rgba(212, 175, 55, 0.15);
            transform: translateY(-3px);
        }

        .voucher-icon {
            background: #fff8e1;
            color: #d4af37;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }

        .voucher-info h4 {
            margin: 0 0 5px;
            font-size: 16px;
            color: #333;
        }
        .voucher-info p {
            margin: 0;
            font-size: 13px;
            color: #666;
        }
        .voucher-code {
            display: inline-block;
            margin-top: 8px;
            background: #f5f5f5;
            padding: 4px 10px;
            border-radius: 6px;
            font-family: monospace;
            font-weight: bold;
            color: #d4af37;
            letter-spacing: 1px;
        }
    </style>
</head>
<body>
    <div class="loyalty-container">
        
        <%
            Float totalSpentObj = (Float) request.getAttribute("totalSpent");
            float spent = (totalSpentObj != null) ? totalSpentObj : 0f;
            
            String tier = "MEMBER";
            String tierName = "Thành Viên Mới";
            String icon = "bi-star";
            float nextMilestone = 2000000f;
            float prevMilestone = 0f;
            
            if (spent >= 10000000f) {
                tier = "DIAMOND";
                tierName = "Kim Cương";
                icon = "bi-gem";
                prevMilestone = 10000000f;
                nextMilestone = 10000000f; // Maxed out
            } else if (spent >= 5000000f) {
                tier = "GOLD";
                tierName = "Vàng";
                icon = "bi-award";
                prevMilestone = 5000000f;
                nextMilestone = 10000000f;
            } else if (spent >= 2000000f) {
                tier = "SILVER";
                tierName = "Bạc";
                icon = "bi-shield-check";
                prevMilestone = 2000000f;
                nextMilestone = 5000000f;
            }
            
            float progressPercent = 100f;
            if (nextMilestone > prevMilestone) {
                progressPercent = ((spent - prevMilestone) / (nextMilestone - prevMilestone)) * 100f;
            }
        %>
        
        <div class="loyalty-card">
            <div style="flex: 1; z-index: 1;">
                <div class="tier-badge"><i class="bi <%= icon %>"></i> Hạng <%= tierName %></div>
                <div style="font-size: 14px; opacity: 0.9; margin-bottom: 5px;">Tổng chi tiêu tích lũy</div>
                <div class="spent-amount">
                    <fmt:formatNumber value="<%= spent %>" type="currency" currencySymbol="đ" maxFractionDigits="0" />
                </div>
                
                <div class="progress-wrapper">
                    <div class="progress-labels">
                        <span>Hạng hiện tại</span>
                        <% if (!tier.equals("DIAMOND")) { %>
                            <span>Cần <fmt:formatNumber value="<%= nextMilestone - spent %>" type="currency" currencySymbol="đ" maxFractionDigits="0" /> nữa để lên hạng</span>
                        <% } else { %>
                            <span>Bạn đã đạt hạng cao nhất!</span>
                        <% } %>
                    </div>
                    <div class="progress-bar-bg">
                        <div class="progress-bar-fill" style="width: <%= progressPercent %>%;"></div>
                    </div>
                </div>
            </div>
            <div class="loyalty-icon" style="z-index: 1;">
                <i class="bi <%= icon %>"></i>
            </div>
        </div>

        <h3 style="font-size: 20px; margin-bottom: 20px; color: #333;">Hành trình đặc quyền</h3>
        <div class="milestones">
            <div class="milestone-card <%= spent >= 2000000f ? "achieved" : "" %>">
                <div class="milestone-icon"><i class="bi bi-shield-check" style="color: #9e9e9e;"></i></div>
                <h4 style="margin:0 0 10px;">Hạng Bạc</h4>
                <p style="font-size: 13px; color: #666; margin:0 0 10px;">Mốc: 2.000.000 đ</p>
                <div style="font-size: 12px; font-weight: 600; color: #d4af37;">Thưởng Voucher Giảm 15%</div>
            </div>
            <div class="milestone-card <%= spent >= 5000000f ? "achieved" : "" %>">
                <div class="milestone-icon"><i class="bi bi-award" style="color: #ffc107;"></i></div>
                <h4 style="margin:0 0 10px;">Hạng Vàng</h4>
                <p style="font-size: 13px; color: #666; margin:0 0 10px;">Mốc: 5.000.000 đ</p>
                <div style="font-size: 12px; font-weight: 600; color: #d4af37;">Thưởng Voucher Giảm 30%</div>
            </div>
            <div class="milestone-card <%= spent >= 10000000f ? "achieved" : "" %>">
                <div class="milestone-icon"><i class="bi bi-gem" style="color: #00bcd4;"></i></div>
                <h4 style="margin:0 0 10px;">Kim Cương</h4>
                <p style="font-size: 13px; color: #666; margin:0 0 10px;">Mốc: 10.000.000 đ</p>
                <div style="font-size: 12px; font-weight: 600; color: #d4af37;">Thưởng Voucher Giảm 50%</div>
            </div>
        </div>

        <div class="vouchers-section">
            <h3><i class="bi bi-ticket-perforated"></i> Kho Voucher Của Bạn</h3>
            
            <c:choose>
                <c:when test="">
                    <div class="voucher-grid">
                        <c:forEach var="v" items="">
                            <div class="voucher-item">
                                <div class="voucher-icon">
                                    <i class="bi bi-gift"></i>
                                </div>
                                <div class="voucher-info">
                                    <h4></h4>
                                    <p>Giảm: <fmt:formatNumber value="" type="number" maxFractionDigits="0"/> đ</p>
                                    <div class="voucher-code"></div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; background: #f9f9f9; border-radius: 12px;">
                        <i class="bi bi-emoji-frown" style="font-size: 40px; color: #ccc; margin-bottom: 10px; display: block;"></i>
                        <p style="color: #777;">Bạn chưa có voucher nào. Hãy đặt xe để tích điểm nhé!</p>
                        <a href="/home" style="display: inline-block; margin-top: 15px; padding: 10px 20px; background: #b59349; color: #fff; text-decoration: none; border-radius: 8px; font-weight: 600;">Đặt Xe Ngay</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
    <jsp:include page="/includes/customer/footer.jsp" />
</body>
</html>

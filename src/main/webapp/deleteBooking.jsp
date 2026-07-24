<%@page import="com.smartride.util.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String bookingId = request.getParameter("bookingId");
    String errorMsg = null;
    if (bookingId != null && !bookingId.trim().isEmpty()) {
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            String[] tables = {"Payment", "Extension", "Cancellation", "Booking Detail", "Booking"};
            for (String table : tables) {
                String sql = "DELETE FROM \"" + table + "\" WHERE \"BookingID\" = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, bookingId);
                pstmt.executeUpdate();
                pstmt.close();
            }
        } catch (Exception e) {
            errorMsg = e.getMessage();
            e.printStackTrace();
        } finally {
            if (conn != null) try { conn.close(); } catch (Exception ignore) {}
        }
    }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"></head>
<body>
<% if (errorMsg != null) { %>
    <p style="color:red;font-family:sans-serif;padding:20px;">
        <b>Lỗi khi xóa đơn:</b><br><%= errorMsg %>
    </p>
<% } else { %>
<script>
    // Redirect parent window (tránh bị load lại trong iframe)
    if (window.top !== window.self) {
        window.top.location.href = '<%= request.getContextPath() %>/manageSmartRide.jsp?iframeSrc=manageBooking';
    } else {
        window.location.href = '<%= request.getContextPath() %>/manageSmartRide.jsp?iframeSrc=manageBooking';
    }
</script>
<% } %>
</body>
</html>

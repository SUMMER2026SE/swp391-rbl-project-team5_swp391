<%@ page import="java.sql.*, com.smartride.util.DBUtil, java.time.LocalDateTime, java.time.format.DateTimeFormatter" %><%
try {
    Connection conn = DBUtil.makeConnection();
    // Get a booking that is "Da giao" (Dang thue)
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM \"Booking\" WHERE \"DeliveryStatus\" = 'Da giao' LIMIT 1");
    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        String bookingId = rs.getString("BookingID");
        String oldEnd = rs.getString("EndDate");
        
        // Check if there is already an extension
        PreparedStatement psCheck = conn.prepareStatement("SELECT * FROM \"Extension\" WHERE \"BookingID\" = ?");
        psCheck.setString(1, bookingId);
        ResultSet rsCheck = psCheck.executeQuery();
        if(!rsCheck.next()){
            // Insert mock extension
            String sqlInsert = "INSERT INTO \"Extension\" (\"ExtensionDate\", \"PreviousEndDate\", \"NewEndDate\", \"ExtenstionFee\", \"BookingID\") VALUES (NOW(), ?, ?, 200000, ?)";
            PreparedStatement psIns = conn.prepareStatement(sqlInsert);
            psIns.setString(1, oldEnd);
            // new end date = old end date + 1 day (simplification, just hardcode a string based on oldEnd or just NOW + 2 days)
            psIns.setString(2, "2026-12-31 23:59:59");
            psIns.setString(3, bookingId);
            psIns.executeUpdate();
            out.println("Created extension for booking " + bookingId);
        } else {
            out.println("Extension already exists for " + bookingId);
        }
    } else {
        out.println("No 'Da giao' booking found to extend.");
    }
} catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

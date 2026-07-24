<%@page import="com.smartride.dao.BookingDAO"%>
<%
    String bookingId = request.getParameter("bookingId");
    if(bookingId != null && !bookingId.trim().isEmpty()) {
        BookingDAO dao = BookingDAO.getInstance();
        dao.updateBookingStatus(bookingId, "Đã hủy");
        response.getWriter().write("success");
    } else {
        response.getWriter().write("error");
    }
%>

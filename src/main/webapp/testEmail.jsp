<%@ page import="com.smartride.constant.SendEmail" %><%
try {
    SendEmail.sendVerificationEmail("lequangminhqwer@gmail.com", "Test Email from Render");
    out.println("Email requested to send.");
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>

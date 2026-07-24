<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="com.smartride.util.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Init Chat Table</title>
</head>
<body>
<%
    try (Connection conn = DBUtil.getConnection()) {
        String sql = "CREATE TABLE IF NOT EXISTS \"Chat_Message\" (\n" +
                     "    \"MessageID\" SERIAL PRIMARY KEY,\n" +
                     "    \"BookingID\" VARCHAR(20) REFERENCES \"Booking\"(\"BookingID\"),\n" +
                     "    \"SenderID\" INT REFERENCES \"Account\"(\"AccountID\"),\n" +
                     "    \"SenderRole\" VARCHAR(20),\n" +
                     "    \"Message\" TEXT NOT NULL,\n" +
                     "    \"SentAt\" TIMESTAMP DEFAULT CURRENT_TIMESTAMP\n" +
                     ");";
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
            out.println("<h3>Table Chat_Message created successfully.</h3>");
        }
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
</body>
</html>

package com.smartride.util;
import java.sql.*;
public class DumpAdmin {
    public static void main(String[] args) throws Exception {
        Connection conn = DBUtil.makeConnection();
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT \"Username\", \"Password\", \"RoleID\" FROM \"Account\" WHERE \"RoleID\" IN (2,3)");
        while(rs.next()) {
            System.out.println("Role: " + rs.getInt(3) + " | User: " + rs.getString(1) + " | Pass: " + rs.getString(2));
        }
    }
}

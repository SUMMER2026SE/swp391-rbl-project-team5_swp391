package com.smartride.util;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.DatabaseMetaData;

public class GetBookingSchema {
    public static void main(String[] args) {
        try {
            Connection conn = DBUtil.makeConnection();
            DatabaseMetaData md = conn.getMetaData();
            ResultSet rs = md.getColumns(null, null, "Booking", null);
            System.out.println("--- Booking COLUMNS ---");
            while (rs.next()) {
                System.out.println(rs.getString("COLUMN_NAME") + " - " + rs.getString("TYPE_NAME"));
            }
            conn.close();
            DBUtil.shutdown();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
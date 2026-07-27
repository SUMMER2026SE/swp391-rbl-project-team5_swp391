package com.smartride.util;
import java.sql.Connection;
import java.sql.Statement;

public class AlterBookingTable {
    public static void main(String[] args) {
        try {
            Connection conn = DBUtil.makeConnection();
            Statement stmt = conn.createStatement();
            // Try adding column ApprovedDate
            try {
                stmt.execute("ALTER TABLE \"Booking\" ADD COLUMN \"ApprovedDate\" TIMESTAMP");
                System.out.println("Column ApprovedDate added successfully.");
            } catch (Exception e) {
                System.out.println("Column might already exist or error: " + e.getMessage());
            }
            conn.close();
            DBUtil.shutdown();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
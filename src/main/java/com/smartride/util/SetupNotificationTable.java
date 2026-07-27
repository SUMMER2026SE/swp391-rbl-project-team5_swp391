package com.smartride.util;

import java.sql.Connection;
import java.sql.Statement;

public class SetupNotificationTable {
    public static void main(String[] args) {
        try {
            Connection conn = DBUtil.makeConnection();
            if (conn != null) {
                Statement stmt = conn.createStatement();
                String sql = "CREATE TABLE IF NOT EXISTS notification_tracker ("
                        + "booking_id VARCHAR(50) PRIMARY KEY,"
                        + "pickup_1h BOOLEAN DEFAULT FALSE,"
                        + "pickup_30m BOOLEAN DEFAULT FALSE,"
                        + "return_2h BOOLEAN DEFAULT FALSE,"
                        + "return_1h BOOLEAN DEFAULT FALSE,"
                        + "return_30m BOOLEAN DEFAULT FALSE"
                        + ");";
                stmt.execute(sql);
                System.out.println("Table notification_tracker created successfully!");
                stmt.close();
                DBUtil.closeConnection(conn);
            } else {
                System.out.println("Failed to connect to database.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

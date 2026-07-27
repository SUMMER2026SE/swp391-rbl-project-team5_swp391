package com.smartride.util;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

public class DBUpdateEvent {
    public static void main(String[] args) {
        Connection conn = DBUtil.makeConnection();
        if (conn != null) {
            try {
                Statement stm = conn.createStatement();
                String sql = "ALTER TABLE \"Event\" ADD COLUMN IF NOT EXISTS \"IsPublished\" BOOLEAN DEFAULT FALSE;";
                stm.execute(sql);
                System.out.println("Successfully added IsPublished column to Event table.");
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                DBUtil.closeConnection(conn);
            }
        }
    }
}

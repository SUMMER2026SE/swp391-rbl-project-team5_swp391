package com.smartride.util;

import java.sql.Connection;
import java.sql.Statement;

public class SetupDB {
    public static void main(String[] args) {
        try (Connection conn = DBUtil.makeConnection();
             Statement stmt = conn.createStatement()) {
            
            // Create Favorite table
            String createFavorite = "CREATE TABLE IF NOT EXISTS \"Favorite\" (" +
                    "\"favorite_id\" SERIAL PRIMARY KEY, " +
                    "\"account_id\" INT NOT NULL, " +
                    "\"motorcycle_id\" VARCHAR(50) NOT NULL, " +
                    "\"created_at\" TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")";
            stmt.executeUpdate(createFavorite);
            System.out.println("Favorite table created.");

            // Create Notification table
            String createNotif = "CREATE TABLE IF NOT EXISTS \"Notification\" (" +
                    "\"notification_id\" SERIAL PRIMARY KEY, " +
                    "\"account_id\" INT NULL, " +
                    "\"title\" VARCHAR(255) NOT NULL, " +
                    "\"message\" TEXT NOT NULL, " +
                    "\"link\" VARCHAR(255), " +
                    "\"is_read\" BOOLEAN DEFAULT FALSE, " +
                    "\"created_at\" TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")";
            stmt.executeUpdate(createNotif);
            System.out.println("Notification table created.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

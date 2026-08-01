package com.smartride;

import com.smartride.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class InsertBookings {
    public static void main(String[] args) {
        try (Connection conn = DBUtil.makeConnection()) {
            if (conn == null) {
                System.out.println("Connection is null!");
                return;
            }

            int customerId = 1;
            
            // We will insert 5 bookings over the past 5 months
            for (int i = 1; i <= 5; i++) {
                String bookingId = "BOOKT000" + (i + 10);
                LocalDateTime bookingDate = LocalDateTime.now().minusDays(i * 25);
                LocalDateTime startDate = bookingDate;
                LocalDateTime endDate = bookingDate.plusDays(3);
                
                // Insert Booking
                String sqlBooking = "INSERT INTO \"Booking\" (\"BookingID\", \"BookingDate\", \"StartDate\", \"EndDate\", \"StatusBooking\", \"DeliveryLocation\", \"ReturnedLocation\", \"DeliveryStatus\", \"CustomerID\") " +
                                    "VALUES (?, ?, ?, ?, 'Đã xác nhận', 'Store', 'Store', 'Đã trả', ?)";
                try (PreparedStatement ps = conn.prepareStatement(sqlBooking)) {
                    ps.setString(1, bookingId);
                    ps.setTimestamp(2, Timestamp.valueOf(bookingDate));
                    ps.setTimestamp(3, Timestamp.valueOf(startDate));
                    ps.setTimestamp(4, Timestamp.valueOf(endDate));
                    ps.setInt(5, customerId);
                    ps.executeUpdate();
                }
                
                // Get a random MotorcycleDetailID and Price
                int motorDetailId = i; // Let's assume ID 1 to 5 exist
                double price = 200000.0 * i;
                
                // Insert Booking Detail
                String sqlDetail = "INSERT INTO \"Booking Detail\" (\"BookingID\", \"MotorcycleDetailID\") VALUES (?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sqlDetail)) {
                    ps.setString(1, bookingId);
                    ps.setInt(2, motorDetailId);
                    ps.executeUpdate();
                }
                
                // Insert Payment
                String sqlPay = "INSERT INTO \"Payment\" (\"BookingID\", \"PaymentMethod\", \"PaymentDate\", \"PaymentAmount\", \"PaymentStatus\") VALUES (?, 'Tiền mặt', ?, ?, 'Giao dịch thành công')";
                try (PreparedStatement ps = conn.prepareStatement(sqlPay)) {
                    ps.setString(1, bookingId);
                    ps.setTimestamp(2, Timestamp.valueOf(bookingDate));
                    ps.setDouble(3, price * 3); // 3 days
                    ps.executeUpdate();
                }
                
                System.out.println("Inserted Booking: " + bookingId + " on " + bookingDate);
            }
            
            System.out.println("Finished inserting 5 test bookings.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

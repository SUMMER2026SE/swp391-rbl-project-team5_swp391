package com.smartride.dao;

import com.smartride.dto.ChatMessage;
import com.smartride.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import java.sql.Timestamp;

public class ChatMessageDAO {

    private static ChatMessageDAO instance;

    public static ChatMessageDAO getInstance() {
        if (instance == null) {
            instance = new ChatMessageDAO();
        }
        return instance;
    }

    public List<ChatMessage> getMessagesByBookingId(String bookingId) {
        List<ChatMessage> list = new ArrayList<>();
        String sql = "SELECT c.\"MessageID\", c.\"BookingID\", c.\"SenderID\", c.\"SenderRole\", c.\"Message\", c.\"SentAt\", "
                   + "a.\"FirstName\", a.\"LastName\", a.\"Image\" "
                   + "FROM \"Chat_Message\" c "
                   + "JOIN \"Account\" a ON c.\"SenderID\" = a.\"AccountID\" "
                   + "WHERE c.\"BookingID\" = ? "
                   + "ORDER BY c.\"SentAt\" ASC";
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        
        try (Connection conn = DBUtil.makeConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ChatMessage msg = new ChatMessage();
                    msg.setMessageId(rs.getInt("MessageID"));
                    msg.setBookingId(rs.getString("BookingID"));
                    msg.setSenderId(rs.getInt("SenderID"));
                    msg.setSenderRole(rs.getString("SenderRole"));
                    msg.setMessage(rs.getString("Message"));
                    
                    Timestamp ts = rs.getTimestamp("SentAt");
                    if (ts != null) {
                        msg.setSentAt(sdf.format(ts));
                    }
                    
                    String firstName = rs.getString("FirstName");
                    String lastName = rs.getString("LastName");
                    msg.setSenderName((lastName != null ? lastName : "") + " " + (firstName != null ? firstName : ""));
                    msg.setSenderImage(rs.getString("Image"));
                    
                    list.add(msg);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insertMessage(String bookingId, int senderId, String senderRole, String message) {
        String sql = "INSERT INTO \"Chat_Message\"(\"BookingID\", \"SenderID\", \"SenderRole\", \"Message\") "
                   + "VALUES(?, ?, ?, ?)";
        try (Connection conn = DBUtil.makeConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            ps.setInt(2, senderId);
            ps.setString(3, senderRole);
            ps.setString(4, message);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

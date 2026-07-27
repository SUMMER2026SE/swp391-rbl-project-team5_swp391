package com.smartride.dto;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ChatMessage implements Serializable {
    private int messageId;
    private String bookingId;
    private int senderId;
    private String senderRole;
    private String message;
    private String sentAt;
    
    // Additional fields for display
    private String senderName;
    private String senderImage;
}

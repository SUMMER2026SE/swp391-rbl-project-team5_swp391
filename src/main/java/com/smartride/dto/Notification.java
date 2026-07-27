package com.smartride.dto;

import java.io.Serializable;
import java.sql.Timestamp;
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
public class Notification implements Serializable {
    private int notificationId;
    private Integer accountId; // null means broadcast to all
    private String title;
    private String message;
    private String link;
    private boolean isRead;
    private Timestamp createdAt;
}

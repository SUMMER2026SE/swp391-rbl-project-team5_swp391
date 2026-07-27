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
public class Favorite implements Serializable {
    private int favoriteId;
    private int accountId;
    private String motorcycleId;
    private Timestamp createdAt;
    
    // Extra fields for UI display
    private String motorcycleName;
    private String motorcycleImage;
    private int rentPrice;
}

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
public class Extension implements Serializable{
    private int extensionID;
    private String extensionDate, previousEndDate, newEndDate;
    private double extensionFee;
    private String bookingID;
    private String staffID;
    private String paymentStatus;
}

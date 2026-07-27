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
public class BookingVerification implements Serializable{
    private int bookingVerificationID;
    private String bookingID;
    private String staffID;
    private String verificationDate;
    
}

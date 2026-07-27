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

public class BookingDetail implements Serializable{
    
    private int bookingDetailID;
    private int motorcycleDetailID;
    private String bookingID;
    private double totalPrice;
}

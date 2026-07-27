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

public class AccessoryDetail implements Serializable{
    private String bookingID;
    private int accessoryID;
    private int quantity;
    private double totalPrice;     
}

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
public class Payment implements Serializable{
    private int paymentId;
    private String bookingId;
    private String paymentMethod;
    private String paymentDate;
    private double paymentAmount;
    private String paymentStatus;
}

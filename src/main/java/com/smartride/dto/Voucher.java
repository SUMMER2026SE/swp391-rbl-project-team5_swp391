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
public class Voucher implements Serializable {
    private int voucherId;
    private String code;
    private double discountAmount;
    private String description;
    private String createdTime;
    private String status;
    private boolean isPublished;
}

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
public class Cancellation implements Serializable{

    private int cancellationID;
    private String cancellationDate;
    private String note;
    private String bookingID;
    private String staffID;
}

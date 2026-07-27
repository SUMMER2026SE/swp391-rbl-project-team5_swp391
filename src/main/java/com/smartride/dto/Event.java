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
public class Event implements Serializable {

    private int eventID;
    private String eventTitle;
    private String createdDate, startDate, endDate, content;
    private String eventImage;
    private double discount;
    private String staffID;
    private boolean isPublished;
}

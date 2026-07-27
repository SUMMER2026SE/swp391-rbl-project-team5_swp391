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
public class Feedback implements Serializable {

    private int feedbackID;
    private String content;
    private int productRate;
    private int serviceRate;
    private int deliveryRate;
    private String feedbackTime;
    private String customerName;
    private String customerImage;
    private int CustomerId;
    private String BookingID;

    public Feedback(int fbId, String content, int productRate, int serviceRate, int deliveryRate, int customerId, String bookingId) {
        this.feedbackID = fbId;
        this.content = content;
        this.productRate = productRate;
        this.serviceRate = serviceRate;
        this.deliveryRate = deliveryRate;
        this.CustomerId = customerId;
        this.BookingID = bookingId;
    }

    public Feedback(int feedbackID, String content, int productRate, int serviceRate, int deliveryRate, String feedbackTime, int CustomerId, String BookingID) {
        this.feedbackID = feedbackID;
        this.content = content;
        this.productRate = productRate;
        this.serviceRate = serviceRate;
        this.deliveryRate = deliveryRate;
        this.feedbackTime = feedbackTime;
        this.CustomerId = CustomerId;
        this.BookingID = BookingID;
    }

    

    
}

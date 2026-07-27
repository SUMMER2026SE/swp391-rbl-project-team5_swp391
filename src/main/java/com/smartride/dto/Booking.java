package com.smartride.dto;

import com.smartride.util.RentalPricingUtil;
import java.io.Serializable;
import java.util.List;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Booking implements Serializable {

    private String bookingID, bookingDate, startDate, endDate, statusBooking, deliveryLocation, returnedLocation, deliveryStatus, deliveryImage, handoverChecklist;
    private int voucherID;
    private int customerID;
    private List<BookingDetail> listBookingDetails;
    private int overdueDays;

    public Booking(String bookingID, String bookingDate, String startDate, String endDate, String statusBooking, String deliveryLocation, String returnedLocation, String deliveryStatus, int voucherID, int customerID) {
        this.bookingID = bookingID;
        this.bookingDate = bookingDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.statusBooking = statusBooking;
        this.deliveryLocation = deliveryLocation;
        this.returnedLocation = returnedLocation;
        this.deliveryStatus = deliveryStatus;
        this.voucherID = voucherID;
        this.customerID = customerID;
    }

    public Booking(String bookingID, String bookingDate, String startDate, String endDate, String statusBooking, String deliveryLocation, String returnedLocation, String deliveryStatus, int voucherID, int customerID, List<BookingDetail> listBookingDetails) {
        this.bookingID = bookingID;
        this.bookingDate = bookingDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.statusBooking = statusBooking;
        this.deliveryLocation = deliveryLocation;
        this.returnedLocation = returnedLocation;
        this.deliveryStatus = deliveryStatus;
        this.voucherID = voucherID;
        this.customerID = customerID;
        this.listBookingDetails = listBookingDetails;
    }

    public int getRentalDays() {
        return RentalPricingUtil.calculateRentalDays(startDate, endDate);
    }

    public String getRentalPlan() {
        return RentalPricingUtil.getPlanLabel(getRentalDays());
    }

    private int extractFee(String location) {
        if (location == null) return 0;
        int fee = 0;
        try {
            java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("(?i)giao xe:?\\s*([0-9,]+)");
            java.util.regex.Matcher matcher = pattern.matcher(location);
            if (matcher.find()) {
                String feeStr = matcher.group(1).replace(",", "").trim();
                fee = Integer.parseInt(feeStr);
            }
        } catch (Exception e) {
            // Ignore parse errors, return 0
        }
        return fee;
    }

    public int getDeliveryFee() {
        return extractFee(this.deliveryLocation) + extractFee(this.returnedLocation);
    }

}

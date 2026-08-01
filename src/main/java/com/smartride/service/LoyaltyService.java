package com.smartride.service;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.CustomerDAO;
import com.smartride.dao.VoucherDAO;
import com.smartride.dto.Booking;
import com.smartride.dto.Customer;
import java.util.UUID;

public class LoyaltyService {

    public static void checkAndIssueVoucher(String bookingID) {
        java.util.List<Booking> bookings = BookingDAO.getInstance().searchBookingbyBookingId(bookingID);
        if (bookings == null || bookings.isEmpty()) return;
        Booking booking = bookings.get(0);

        Customer customer = CustomerDAO.getInstance().getCustomerbyID(booking.getCustomerID());
        if (customer == null) return;

        int accountId = customer.getAccountId();
        float totalSpent = CustomerDAO.getInstance().getTotalSpentByAccountId(accountId);

        issueVoucherIfEligible(accountId, totalSpent, 10000000f, "VIP-DIAMOND", 50, "Voucher VIP Kim Cương (Giảm 50%)");
        issueVoucherIfEligible(accountId, totalSpent, 5000000f, "VIP-GOLD", 30, "Voucher VIP Vàng (Giảm 30%)");
        issueVoucherIfEligible(accountId, totalSpent, 2000000f, "VIP-SILVER", 15, "Voucher VIP Bạc (Giảm 15%)");
    }

    private static void issueVoucherIfEligible(int accountId, float totalSpent, float threshold, String tierCodePrefix, double discountAmount, String description) {
        if (totalSpent >= threshold) {
            VoucherDAO voucherDAO = VoucherDAO.getInstance();
            if (!voucherDAO.hasMilestoneVoucher(accountId, tierCodePrefix)) {
                // Issue voucher
                String randomCode = tierCodePrefix + "-" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();
                boolean success = voucherDAO.createPersonalVoucher(randomCode, accountId, discountAmount, description);
                if (success) {
                    System.out.println("Issued milestone voucher " + randomCode + " to account " + accountId);
                }
            }
        }
    }
}

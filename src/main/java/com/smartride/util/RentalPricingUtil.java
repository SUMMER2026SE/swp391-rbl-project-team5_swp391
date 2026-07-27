package com.smartride.util;

import com.smartride.dto.PriceList;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public final class RentalPricingUtil {

    private static final DateTimeFormatter[] BOOKING_DATE_FORMATS = {
        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"),
        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"),
        DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"),
        DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm"),
        DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"),
        DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")
    };

    private RentalPricingUtil() {
    }

    public static int calculateRentalDays(String startDate, String endDate) {
        LocalDateTime start = parseDateTime(startDate);
        LocalDateTime end = parseDateTime(endDate);

        if (start == null || end == null || !end.isAfter(start)) {
            return 1;
        }

        long minutes = Duration.between(start, end).toMinutes();
        return Math.max(1, (int) Math.ceil(minutes / 1440.0));
    }

    public static double selectDailyRate(PriceList priceList, int rentalDays) {
        if (rentalDays >= 30) {
            return priceList.getDailyPriceForMonth();
        }
        if (rentalDays >= 7) {
            return priceList.getDailyPriceForWeek();
        }
        return priceList.getDailyPriceForDay();
    }

    public static String getPlanLabel(int rentalDays) {
        if (rentalDays >= 30) {
            return "Theo tháng";
        }
        if (rentalDays >= 7) {
            return "Theo tuần";
        }
        return "Theo ngày";
    }

    private static LocalDateTime parseDateTime(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }

        String normalizedValue = value.trim().replace('T', ' ');
        if (normalizedValue.length() > 19) {
            normalizedValue = normalizedValue.substring(0, 19);
        }

        for (DateTimeFormatter formatter : BOOKING_DATE_FORMATS) {
            try {
                return LocalDateTime.parse(normalizedValue, formatter);
            } catch (DateTimeParseException ignored) {
                // Try the next supported booking format.
            }
        }
        return null;
    }
}

package com.smartride.util;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.NotificationDAO;
import com.smartride.dao.VoucherDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

@WebListener
public class DeliveryCheckerJob implements ServletContextListener {

    private ScheduledExecutorService scheduler;
    private static final Logger logger = Logger.getLogger(DeliveryCheckerJob.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        // Run every 1 minute
        scheduler.scheduleAtFixedRate(this::checkLateDeliveries, 1, 1, TimeUnit.MINUTES);
        logger.info("[DeliveryCheckerJob] Background job started — checking late deliveries every 1 minute.");
    }

    private void checkLateDeliveries() {
        try {
            List<Map<String, Object>> lateOrders = BookingDAO.getInstance().getLateDeliveries();
            if (lateOrders.isEmpty()) return;

            logger.info("[DeliveryCheckerJob] Found " + lateOrders.size() + " late deliveries.");

            for (Map<String, Object> order : lateOrders) {
                String bookingID = (String) order.get("bookingID");
                int accountID = (int) order.get("accountID");

                // Generate unique voucher code
                String randomSuffix = generateRandomCode(4);
                String shortBookingID = bookingID.replace("BK", "");
                String voucherCode = "LATE" + shortBookingID + randomSuffix;

                // Create personal voucher (50,000 VND discount)
                String desc = "Bồi thường giao xe trễ cho đơn #" + bookingID + ". Dùng 1 lần cho đơn tiếp theo.";
                boolean created = VoucherDAO.getInstance().createPersonalVoucher(voucherCode, accountID, 50000, desc);

                if (created) {
                    // Send personal notification
                    String title = "🎁 Xin lỗi! Tặng bạn voucher bồi thường";
                    String message = "Đơn #" + bookingID + " bị giao trễ so với cam kết 45 phút. SmartRide xin lỗi và tặng bạn mã giảm 50,000đ: " + voucherCode + ". Có hiệu lực cho đơn đặt xe tiếp theo!";
                    String link = "bookingHistoryDetail?bookingId=" + bookingID;
                    NotificationDAO.getInstance().insertNotification(accountID, title, message, link);

                    // Mark as sent to avoid duplicate
                    BookingDAO.getInstance().markLateVoucherSent(bookingID);

                    logger.info("[DeliveryCheckerJob] Sent late voucher " + voucherCode + " to accountID=" + accountID + " for booking " + bookingID);
                }
            }
        } catch (Exception e) {
            logger.severe("[DeliveryCheckerJob] Error: " + e.getMessage());
        }
    }

    private String generateRandomCode(int length) {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
            logger.info("[DeliveryCheckerJob] Background job stopped.");
        }
        // Dừng DBUtil keepalive thread sạch sẽ khi webapp bị unload/hot-reload
        DBUtil.shutdown();
    }
}

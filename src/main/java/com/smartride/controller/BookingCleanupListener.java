package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@WebListener
public class BookingCleanupListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        // Chạy mỗi 1 phút để dọn dẹp các đơn hàng Soft Lock quá hạn 10 phút
        scheduler.scheduleAtFixedRate(() -> {
            try {
                BookingDAO.getInstance().cancelExpiredPendingBookings(10); // 10 minutes
            } catch (Exception e) {
                e.printStackTrace();
            }
        }, 1, 1, TimeUnit.MINUTES);
        System.out.println("BookingCleanupListener started for Inventory Soft Lock.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
        System.out.println("BookingCleanupListener stopped.");
    }
}

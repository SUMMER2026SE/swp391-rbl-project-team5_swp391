package com.smartride.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * In-memory store for real-time vehicle locations.
 * Key = bookingID, Value = LocationEntry (lat, lon, customerName, timestamp)
 * No DB needed – just memory, suitable for demo/SWP391.
 */
public class LocationStore {

    private LocationStore() {}

    // bookingID -> latest location
    private static final Map<String, LocationEntry> store = new ConcurrentHashMap<>();

    public static void update(String bookingId, double lat, double lon, String customerName, String vehicleName, String phone) {
        store.put(bookingId, new LocationEntry(lat, lon, customerName, vehicleName, phone, System.currentTimeMillis()));
    }

    public static Map<String, LocationEntry> getAll() {
        return store;
    }

    public static void remove(String bookingId) {
        store.remove(bookingId);
    }

    public static class LocationEntry {
        public final double lat;
        public final double lon;
        public final String customerName;
        public final String vehicleName;
        public final String phone;
        public final long   timestamp; // ms epoch

        public LocationEntry(double lat, double lon, String customerName, String vehicleName, String phone, long timestamp) {
            this.lat          = lat;
            this.lon          = lon;
            this.customerName = customerName;
            this.vehicleName  = vehicleName;
            this.phone        = phone;
            this.timestamp    = timestamp;
        }
    }
}

package com.smartride.controller;

import com.smartride.util.LocationStore;
import com.smartride.util.LocationStore.LocationEntry;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

/**
 * Returns JSON of all active vehicle locations for the admin live map.
 * GET /api/get-locations
 * Response: { "locations": [ { "bookingId":"B001","lat":16.07,"lon":108.21,"name":"Nguyen Van A","age":45 }, ... ] }
 * "age" = seconds since last update (to detect stale/offline phones)
 */
@WebServlet(name = "GetLocationsServlet", urlPatterns = {"/api/get-locations"})
public class GetLocationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");

        // Only staff/admin can poll
        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("staff") == null && session.getAttribute("account") == null)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"locations\":[]}");
            return;
        }

        Map<String, LocationEntry> all = LocationStore.getAll();
        long now = System.currentTimeMillis();

        StringBuilder sb = new StringBuilder("{\"locations\":[");
        boolean first = true;
        for (Map.Entry<String, LocationEntry> entry : all.entrySet()) {
            if (!first) sb.append(",");
            first = false;
            LocationEntry loc = entry.getValue();
            long ageSeconds = (now - loc.timestamp) / 1000;
            sb.append("{")
              .append("\"bookingId\":\"").append(escape(entry.getKey())).append("\",")
              .append("\"lat\":").append(loc.lat).append(",")
              .append("\"lon\":").append(loc.lon).append(",")
              .append("\"name\":\"").append(escape(loc.customerName)).append("\",")
              .append("\"vehicleName\":\"").append(escape(loc.vehicleName)).append("\",")
              .append("\"phone\":\"").append(escape(loc.phone)).append("\",")
              .append("\"age\":").append(ageSeconds)
              .append("}");
        }
        sb.append("]}");

        PrintWriter out = response.getWriter();
        out.print(sb.toString());
    }

    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}

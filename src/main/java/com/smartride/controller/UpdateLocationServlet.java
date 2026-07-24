package com.smartride.controller;

import com.smartride.util.LocationStore;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import jakarta.servlet.annotation.MultipartConfig;

/**
 * Receives real-time GPS coordinates from customer's phone.
 * Called by watchPosition() JS every ~10 seconds when booking is active.
 * POST /api/update-location  { bookingId, lat, lon }
 */
@WebServlet(name = "UpdateLocationServlet", urlPatterns = {"/api/update-location"})
@MultipartConfig
public class UpdateLocationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");

        // Temporary disable auth for GPS Demo
        /*
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"ok\":false,\"msg\":\"Unauthorized\"}");
            return;
        }
        */

        String action       = request.getParameter("action");
        String bookingId    = request.getParameter("bookingId");

        if ("stop".equals(action) && bookingId != null) {
            LocationStore.remove(bookingId);
            response.getWriter().write("{\"ok\":true}");
            return;
        }

        String latStr       = request.getParameter("lat");
        String lonStr       = request.getParameter("lon");
        String customerName = request.getParameter("customerName");
        String vehicleName  = request.getParameter("vehicleName");
        String phone        = request.getParameter("phone");

        if (bookingId == null || latStr == null || lonStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"ok\":false,\"msg\":\"Missing params\"}");
            return;
        }

        try {
            double lat = Double.parseDouble(latStr);
            double lon = Double.parseDouble(lonStr);

            LocationStore.update(bookingId, lat, lon,
                    customerName != null ? customerName : "Khách hàng",
                    vehicleName != null ? vehicleName : "Xe máy",
                    phone != null ? phone : "Chưa cập nhật");
            response.getWriter().write("{\"ok\":true}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"ok\":false,\"msg\":\"Invalid lat/lon\"}");
        }
    }

    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
        resp.setStatus(HttpServletResponse.SC_OK);
    }
}

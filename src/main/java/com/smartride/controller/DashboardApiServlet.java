package com.smartride.controller;

import com.google.gson.Gson;
import com.smartride.dao.DashboardDAO;
import com.smartride.dto.DashboardStatsData;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DashboardApiServlet", urlPatterns = {"/api/dashboard"})
public class DashboardApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String period = request.getParameter("period");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        
        if (period == null || period.isEmpty()) {
            period = "30days"; // Default
        }

        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.
        
        try {
            DashboardDAO dashboardDAO = DashboardDAO.getInstance();
            DashboardStatsData data = dashboardDAO.getDashboardData(period, startDate, endDate);
            
            Gson gson = new Gson();
            String jsonStr = gson.toJson(data);
            
            try (PrintWriter out = response.getWriter()) {
                out.print(jsonStr);
                out.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.print("{}"); // Return empty object on error to avoid syntax errors
                out.flush();
            }
        }
    }
}

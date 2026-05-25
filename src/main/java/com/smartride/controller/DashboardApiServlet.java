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

        DashboardDAO dashboardDAO = DashboardDAO.getInstance();
        DashboardStatsData data = dashboardDAO.getDashboardData(period, startDate, endDate);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Gson gson = new Gson();
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(data));
            out.flush();
        }
    }
}

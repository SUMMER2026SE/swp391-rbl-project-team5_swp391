package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CheckOverlapServlet", urlPatterns = {"/api/check-overlap"})
public class CheckOverlapServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String newEndDate = request.getParameter("newEndDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        if (bookingId == null || newEndDate == null) {
            out.print("{\"error\": \"Missing parameters\"}");
            return;
        }
        
        BookingDAO dao = BookingDAO.getInstance();
        boolean hasOverlap = dao.checkOverlapForExtension(bookingId, newEndDate);
        
        out.print("{\"overlap\": " + hasOverlap + "}");
    }
}

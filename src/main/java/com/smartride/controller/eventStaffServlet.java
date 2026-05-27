package com.smartride.controller;

import com.smartride.dao.EventDAO;
import com.smartride.dao.StaffDAO;
import com.smartride.dto.Event;
import com.smartride.dto.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "eventStaffServlet", urlPatterns = {"/eventStaffServlet"})
public class eventStaffServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EventDAO eventDAO = EventDAO.getInstance();
        StaffDAO staffDAO = StaffDAO.getInstance();
        
        List<Staff> staffList = staffDAO.getAllStaff();
        List<Event> eventList = eventDAO.getAllEvent();
        
        request.setAttribute("staffList", staffList);
        request.setAttribute("eventList", eventList);
        request.getRequestDispatcher("eventStaff.jsp").forward(request, response);
    }

}

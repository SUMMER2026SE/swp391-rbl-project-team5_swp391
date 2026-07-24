package com.smartride.controller;

import com.smartride.dto.Event;
import com.smartride.dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.io.IOException;

@WebServlet(name = "ViewEventServlet", urlPatterns = {"/event"})
public class ViewEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        
        EventDAO eventDAO = EventDAO.getInstance();
        int total = eventDAO.getTotalEvent();
        int endPage = total / 9;
        if (total % 9 != 0) {
            endPage++;
        }
        
        List<Event> listEvent = eventDAO.getPagingEvent(index);
        
        request.setAttribute("listEvent", listEvent);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.getRequestDispatcher("event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}

package com.smartride.controller;

import com.smartride.dao.EventDAO;
import com.smartride.dto.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@MultipartConfig
@WebServlet(name = "UpdateEventStaff", urlPatterns = {"/UpdateEventStaff"})
public class UpdateEventStaff extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateEventStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateEventStaff at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EventDAO eventDAO = EventDAO.getInstance();
        String eventIDst = request.getParameter("eventID");
        int id = Integer.parseInt(eventIDst);
        Event event = eventDAO.getEventbyID(id);
        request.setAttribute("event", event);
        request.getRequestDispatcher("/eventStaff.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EventDAO eventDAO = EventDAO.getInstance();
        FileUploaded fileUploaded = new FileUploaded(getServletContext().getRealPath("/images"));
        
        String eventIDst = request.getParameter("editEventID");
        String eventTitle = request.getParameter("editEventTitle");
//        String createdDate = request.getParameter("editCreatedDate");
        String startDate = request.getParameter("editStartDate");
        String endDate = request.getParameter("editEndDate");
        String content = request.getParameter("editContent");
        System.out.println(startDate);
        String name = "imageEvent" + eventTitle + ".jpg";
        Part part = request.getPart("editEventImage");
        String publicUrl = fileUploaded.handleFileUpload(part, name);
        
        try {
            int eventID = Integer.parseInt(eventIDst);
            if (publicUrl == null) {
                Event oldEvent = eventDAO.getEventbyID(eventID);
                if (oldEvent != null) {
                    publicUrl = oldEvent.getEventImage();
                } else {
                    publicUrl = name;
                }
            }
            
            // Get current date and time
            LocalDateTime currentDateTime = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedDateTime = currentDateTime.format(formatter);
            
            String discount = request.getParameter("editDiscount");
            double discountInput = Double.parseDouble(discount);
            // Chuyển đổi từ phần trăm (5) sang thập phân (0.05) để lưu database
            double dis = discountInput / 100.0;
            
            // Lấy staffID từ event cũ để giữ nguyên
            Event oldEvent = eventDAO.getEventbyID(eventID);
            String staffID = oldEvent != null ? oldEvent.getStaffID() : null;
            
            Event event = new Event(eventID, eventTitle, formattedDateTime, startDate, endDate, content, publicUrl, dis, staffID, false);
            eventDAO.updateEvent(event);
        } catch (Exception e) {
        }
        response.sendRedirect("eventStaffServlet");
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

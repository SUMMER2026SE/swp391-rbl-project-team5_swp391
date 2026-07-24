package com.smartride.controller;

import com.smartride.dao.TouristLocationDAO;
import com.smartride.dto.TouristLocation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;

@MultipartConfig
@WebServlet(name = "UpdateTourismLoctionServletStaff", urlPatterns = {"/UpdateTourismLoctionServletStaff"})
public class UpdateTourismLoctionServletStaff extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateTourismLoctionServletStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateTourismLoctionServletStaff at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TouristLocationDAO touristLocationDAO = TouristLocationDAO.getInstance();
        int id = Integer.parseInt(request.getParameter("locationId"));
        TouristLocation motorbike = touristLocationDAO.getTouristLocationbyID(id);
        request.setAttribute("motorbike", motorbike);
        request.getRequestDispatcher("/touristLocationStaff.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TouristLocationDAO touristLocationDAO = TouristLocationDAO.getInstance();
        FileUploaded fileUploaded = new FileUploaded(getServletContext().getRealPath("/images"));
        
        // Récupérer les paramètres depuis la requête
        String locationIdStr = request.getParameter("locationId");
        String locationName = request.getParameter("locationName");

        
        String name = "imageTour" + locationName + ".jpg";
        Part part = request.getPart("locationImage");
        String publicUrl = fileUploaded.handleFileUpload(part, name);
        
        String description = request.getParameter("description");
        String urlArticle = request.getParameter("urlArticle");
        
        try {
            int locationId = Integer.parseInt(locationIdStr);
            
            // Lấy thông tin địa điểm cũ để giữ lại staffID
            TouristLocation oldLoc = touristLocationDAO.getTouristLocationbyID(locationId);
            String staffID = oldLoc != null ? oldLoc.getStaffID() : null;
            
            if (publicUrl == null) {
                if (oldLoc != null) {
                    publicUrl = oldLoc.getLocationImage();
                } else {
                    publicUrl = name;
                }
            }

            TouristLocation touristLocation = new TouristLocation(locationId, locationName, publicUrl, description, urlArticle, staffID);

            touristLocationDAO.updateTouristLocation(touristLocation);
        } catch (Exception e) {
        }
        response.sendRedirect("TourismLocationServletStaff");
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

package com.smartride.controller;

import com.smartride.dao.StaffDAO;
import com.smartride.dao.TouristLocationDAO;
import com.smartride.dto.Staff;
import com.smartride.dto.TouristLocation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

@MultipartConfig
@WebServlet(name = "AddTouristLocationServletStaff", urlPatterns = {"/AddTouristLocationServletStaff"})
public class AddTouristLocationServletStaff extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TouristLocationDAO touristLocationDAO = TouristLocationDAO.getInstance();
        FileUploaded fileUploaded = new FileUploaded(getServletContext().getRealPath("/images"));
        try {
            String locationName = request.getParameter("locationName");
            
            String name = "imageTour" + locationName + ".jpg";
            Part part = request.getPart("locationImage");
            String publicUrl = fileUploaded.handleFileUpload(part, name);
            if (publicUrl == null) publicUrl = name;
            

            String description = request.getParameter("description");
            String urlArticle = request.getParameter("urlArticle");
            
            // Không cần staffID nữa, set null hoặc giá trị mặc định
            String staffID = null;

            TouristLocation touristLocation = new TouristLocation(0, locationName, publicUrl, description, urlArticle, staffID);
            touristLocationDAO.addNewTouristLocation(touristLocation);
            
        } catch (Exception e) {
            System.out.println(e);
        }
        response.sendRedirect("TourismLocationServletStaff");
    }
}

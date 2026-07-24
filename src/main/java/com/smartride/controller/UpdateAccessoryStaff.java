package com.smartride.controller;

import com.smartride.dao.AccessoryDAO;
import com.smartride.dto.Accessory;
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
@WebServlet(name = "UpdateAccessoryStaff", urlPatterns = {"/UpdateAccessoryStaff"})
public class UpdateAccessoryStaff extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateAccessoryStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccessoryStaff at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        AccessoryDAO accessoryDAO = AccessoryDAO.getInstance();
//        int id = Integer.parseInt(request.getParameter("accessoryId"));
//        Accessory accessory = accessoryDAO.getAccessoryByid(id);
//        request.setAttribute("motorbike", accessory);
//        request.getRequestDispatcher("/touristLocationStaff.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccessoryDAO accessoryDAO = AccessoryDAO.getInstance();
        FileUploaded fileUploaded = new FileUploaded(getServletContext().getRealPath("/images"));
        int accessoryId = Integer.parseInt(request.getParameter("accessoryId"));
        String accessoryName = request.getParameter("accessoryName");
        String accessoryDecription = request.getParameter("accessoryDescription");

        String imageName = "imageAccessory" + accessoryId + ".jpg";
        Part imagePart = request.getPart("accessoryImage");
        String publicImage = fileUploaded.handleFileUpload(imagePart, imageName);

        String iconImageName = "iconAccessory" + accessoryId + ".jpg";
        Part iconImagePart = request.getPart("accessoryImageIcon");
        String publicIcon = fileUploaded.handleFileUpload(iconImagePart, iconImageName);

        if (publicImage == null || publicIcon == null) {
            Accessory oldAccessory = accessoryDAO.getAccessoryByid(accessoryId);
            if (oldAccessory != null) {
                if (publicImage == null) publicImage = oldAccessory.getAccessoryImage();
                if (publicIcon == null) publicIcon = oldAccessory.getAccessoryImageicon();
            }
        }
        
        if (publicImage == null) publicImage = imageName;
        if (publicIcon == null) publicIcon = iconImageName;

        double price = Double.parseDouble(request.getParameter("price"));
        try {
            Accessory accessory = new Accessory(accessoryId, accessoryName, publicImage, publicIcon, accessoryDecription, price);
            accessoryDAO.updateAccessory(accessory);
        } catch (Exception e) {
        }
        response.sendRedirect("accessoriesStaffServlet");
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

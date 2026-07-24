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

@MultipartConfig
@WebServlet(name = "AddAccessoryStaff", urlPatterns = {"/AddAccessoryStaff"})
public class AddAccessoryStaff extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccessoryDAO accessoryDAO = AccessoryDAO.getInstance();
        FileUploaded fileUploaded = new FileUploaded(getServletContext().getRealPath("/images"));
        try {
            String accessoryName = request.getParameter("accessoryName");

            String imageName = "imageAccessory" + accessoryName + ".jpg";
            Part imagePart = request.getPart("accessoryImage");
            String publicImage = fileUploaded.handleFileUpload(imagePart, imageName);
            if (publicImage == null) publicImage = imageName;

            String iconImageName = "iconAccessory" + accessoryName + ".jpg";
            Part iconImagePart = request.getPart("accessoryImageIcon");
            String publicIcon = fileUploaded.handleFileUpload(iconImagePart, iconImageName);
            if (publicIcon == null) publicIcon = iconImageName;

            String accessoryDescription = request.getParameter("accessoryDescription");
            double price = Double.parseDouble(request.getParameter("price"));

            Accessory accessory = new Accessory(0, accessoryName, publicImage, publicIcon, accessoryDescription, price);
            accessoryDAO.addNewAccessory(accessory);

        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("accessoriesStaffServlet");

    }
}

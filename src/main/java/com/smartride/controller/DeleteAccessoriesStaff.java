package com.smartride.controller;

import com.smartride.dao.AccessoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import com.smartride.dto.Accessory;
import com.smartride.util.SupabaseStorageUtil;

@WebServlet(name = "DeleteAccessoriesStaff", urlPatterns = {"/DeleteAccessoriesStaff"})
public class DeleteAccessoriesStaff extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteAccessoriesStaff</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteAccessoriesStaff at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccessoryDAO touristLocationDAO = AccessoryDAO.getInstance();
        try {
            String id = request.getParameter("accessoryId");
            Accessory accessory = touristLocationDAO.getAccessoryByid(Integer.parseInt(id));
            if (accessory != null) {
                if (accessory.getAccessoryImage() != null) {
                    SupabaseStorageUtil.deleteFile(accessory.getAccessoryImage());
                }
                if (accessory.getAccessoryImageicon() != null) {
                    SupabaseStorageUtil.deleteFile(accessory.getAccessoryImageicon());
                }
            }

            touristLocationDAO.deleteAccessory(id);
            response.sendRedirect("accessoriesStaffServlet");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

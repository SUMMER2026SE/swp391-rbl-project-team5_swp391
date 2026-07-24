package com.smartride.controller;

import com.smartride.dao.MotorcycleDAO;
import com.smartride.dto.Motorcycle;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet(name="UpdateMotorcycleServlet", urlPatterns={"/updateMotorcycle"})
public class UpdateMotorcycleServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateMotorcycleServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateMotorcycleServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        MotorcycleDAO md = MotorcycleDAO.getInstance();
        FileUploaded fileUploaded = new FileUploaded(getServletContext().getRealPath("/images"));
        String id = request.getParameter("id");
        String model = request.getParameter("modelName");

        
        String name = "image" + id + ".jpg";
        Part part = request.getPart("image");
        String publicUrl = fileUploaded.handleFileUpload(part, name);
        
        if (publicUrl == null) {
            Motorcycle oldMotor = md.getMotorcycleByid(id);
            if (oldMotor != null) {
                publicUrl = oldMotor.getImage();
            } else {
                publicUrl = name;
            }
        }
        
        String displacement = request.getParameter("displacement");
        String description = request.getParameter("description");
        int minAge = Integer.parseInt(request.getParameter("minAge"));
        int bid = Integer.parseInt(request.getParameter("brandID"));
        int cid = Integer.parseInt(request.getParameter("categoryID"));
        int pid = Integer.parseInt(request.getParameter("priceListID"));
        
        Motorcycle motorcycle = new Motorcycle(id, model, publicUrl, displacement, description, minAge, bid, cid, pid);
        md.updateMotorcycle(motorcycle);
        
        response.sendRedirect("motorManage");
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

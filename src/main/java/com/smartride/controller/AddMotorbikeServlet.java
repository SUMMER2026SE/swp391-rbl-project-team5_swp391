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
import org.apache.commons.fileupload.FileUpload;

@WebServlet(name = "AddMotorbikeServlet", urlPatterns = {"/addMotorbike"})
@MultipartConfig
public class AddMotorbikeServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddMotorbikeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddMotorbikeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part image = request.getPart("image");

        String id = request.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            id = MotorcycleDAO.getInstance().getNewMotorcycleID();
        }
        String model = request.getParameter("model");
        String displacement = request.getParameter("displacement");
        String description = request.getParameter("description");
        String minAgeStr = request.getParameter("minAge");
        int minAge = 0;
        if (minAgeStr != null && !minAgeStr.trim().isEmpty()) {
            minAge = Integer.parseInt(minAgeStr);
        }
        String brandName = request.getParameter("brandName");
        int brandID = com.smartride.dao.BrandDAO.getInstance().getBrandIdByName(brandName);
        if (brandID == -1) {
            brandID = com.smartride.dao.BrandDAO.getInstance().addBrand(brandName);
        }
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        int priceListID = Integer.parseInt(request.getParameter("priceListID"));

        MotorcycleDAO md = MotorcycleDAO.getInstance();

//        String relativePath = getServletContext().getRealPath("/images");
//        FileUploaded f = new FileUploaded(relativePath);
//        FileUploaded f = new FileUploaded("D:\\FPT_UNI\\SWP391\\Code\\MotorcycleRental\\src\\main\\webapp\\images");

        // Đường dẫn thư mục lưu trữ ảnh
//        String uploadPath = getServletContext().getRealPath("/images");
//        File uploadDir = new File(uploadPath);
//        if (!uploadDir.exists()) {
//            uploadDir.mkdir();
//        }
//
//        // Lấy tên tệp
//        String fileName = getFileName(image);
//        String filePath = uploadPath + File.separator + fileName;
//        
        String fileName = getFileName(image);
        FileUploaded f = new FileUploaded("");
        String publicUrl = f.handleFileUpload(image, fileName);
        if (publicUrl == null) {
            publicUrl = fileName; // Fallback
        }
        
        try {
            Motorcycle motor = new Motorcycle(id, model, publicUrl, displacement, description, minAge, brandID, categoryID, priceListID);
            md.addMotorcycle(motor);
        } catch (Exception e) {
            System.out.println(e);
        }

        response.sendRedirect("motorManage");

    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String cd : contentDisposition.split(";")) {
                if (cd.trim().startsWith("filename")) {
                    return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                }
            }
        }
        return null;
    }
    @Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

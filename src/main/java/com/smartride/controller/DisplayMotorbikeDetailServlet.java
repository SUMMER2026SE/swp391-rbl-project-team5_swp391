package com.smartride.controller;

import com.smartride.dao.MotorcycleDetailDAO;
import com.smartride.dto.MotorcycleDetail;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DisplayMotorbikeDetailServlet", urlPatterns = {"/displayDetail"})
public class DisplayMotorbikeDetailServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DisplayMotorbikeDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DisplayMotorbikeDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String motorcycleId = request.getParameter("motorcycleId");

        // Lấy chi tiết mẫu xe và biển số xe từ cơ sở dữ liệu
        MotorcycleDetail detail = new MotorcycleDetail();
        MotorcycleDetailDAO mdd = MotorcycleDetailDAO.getInstance();
        
        mdd.getMotorcycleDetail(motorcycleId);

        // Chuyển đổi đối tượng thành JSON
        String json = new Gson().toJson(detail);

        // Gửi phản hồi JSON về client
        response.setContentType("application/json");
        response.getWriter().write(json);
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

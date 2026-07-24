package com.smartride.controller;

import com.smartride.dao.MotorcycleDetailDAO;
import com.smartride.dto.MotorcycleDetail;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;

@WebServlet(name = "AddMotorbikeDetailServlet", urlPatterns = {"/addMotorDetail"})
public class AddMotorbikeDetailServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddMotorbikeDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddMotorbikeDetailServlet at " + request.getContextPath() + "</h1>");
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
        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        // Phân tích cú pháp JSON
        String jsonString = jsonBuffer.toString();
        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(jsonString, JsonObject.class);

        // Validate JSON data
        if (jsonObject == null || jsonObject.get("motorcycleId") == null || jsonObject.get("licensePlate") == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Vui lòng nhập đầy đủ thông tin!");
            return;
        }
        // Xử lý dữ liệu JSON
        String data1 = jsonObject.get("motorcycleId").getAsString();
        String data2 = jsonObject.get("licensePlate").getAsString();

        MotorcycleDetailDAO mdd = MotorcycleDetailDAO.getInstance();
        try {
            MotorcycleDetail detail = new MotorcycleDetail();

            if (mdd.getDetailByLicensePlate(data2) == null) {
                detail.setMotorcycleId(data1);
                detail.setLicensePlate(data2);
                mdd.addMotorDetail(detail);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Motorbike added successfully!");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Biển số xe đã có! Vui lòng nhập lại!");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Đã có lỗi xảy ra! Vui lòng thử lại sau!");
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

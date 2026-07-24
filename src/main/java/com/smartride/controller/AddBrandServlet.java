package com.smartride.controller;

import com.smartride.dao.BrandDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet(name = "AddBrandServlet", urlPatterns = {"/addBrand"})
public class AddBrandServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            String brandName = request.getParameter("brandName");
            JsonObject json = new JsonObject();
            
            if (brandName == null || brandName.trim().isEmpty()) {
                json.addProperty("status", "error");
                json.addProperty("message", "Tên hãng không được để trống!");
            } else {
                BrandDAO dao = BrandDAO.getInstance();
                int newId = dao.addBrand(brandName.trim());
                if (newId > 0) {
                    json.addProperty("status", "success");
                    json.addProperty("id", newId);
                    json.addProperty("name", brandName.trim());
                } else {
                    json.addProperty("status", "error");
                    json.addProperty("message", "Lỗi cơ sở dữ liệu!");
                }
            }
            out.print(new Gson().toJson(json));
        }
    }
}

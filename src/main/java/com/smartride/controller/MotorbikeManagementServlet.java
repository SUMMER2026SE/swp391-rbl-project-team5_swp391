package com.smartride.controller;

import com.smartride.dao.BrandDAO;
import com.smartride.dao.CategoryDAO;
import com.smartride.dao.MotorcycleDAO;
import com.smartride.dao.PriceListDAO;
import com.smartride.dto.Brand;
import com.smartride.dto.Category;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.PriceList;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "MotorbikeManagementServlet", urlPatterns = {"/motorManage"})
public class MotorbikeManagementServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        MotorcycleDAO md = MotorcycleDAO.getInstance();
        PriceListDAO pd = PriceListDAO.getInstance();
        BrandDAO bd = BrandDAO.getInstance();
        CategoryDAO cd = CategoryDAO.getInstance();
        List<Motorcycle> listM = md.getAll();
        List<PriceList> listP = pd.getAllPriceList();
        List<Brand> listB = bd.getAllBrand();
        List<Category> listC = cd.getAllCategory();
        java.util.LinkedHashMap<String, String> mapA = md.getAllAvailableMotorCycle();
        String newMotorID = md.getNewMotorcycleID();

        request.setAttribute("listM", listM);
        request.setAttribute("listP", listP);
        request.setAttribute("listB", listB);
        request.setAttribute("listC", listC);
        request.setAttribute("mapA", mapA);
        request.setAttribute("newMotorID", newMotorID);

        request.getRequestDispatcher("motorbikeManagement.jsp").forward(request, response);

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
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

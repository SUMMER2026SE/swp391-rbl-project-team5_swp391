package com.smartride.controller;

import com.smartride.dao.PriceListDAO;
import com.smartride.dto.PriceList;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddPricingServlet", urlPatterns = {"/addpricing"})
public class AddPricingServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddPricingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPricingServlet at " + request.getContextPath() + "</h1>");
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

        double priceForDay = Double.parseDouble(request.getParameter("priceForDay"));
        double priceForWeek = Double.parseDouble(request.getParameter("priceForWeek"));
        double priceForMonth = Double.parseDouble(request.getParameter("priceForMonth"));

        PriceListDAO pd = PriceListDAO.getInstance();

        try {
            PriceList p = new PriceList();
            
            p.setDailyPriceForDay(priceForDay);
            p.setDailyPriceForWeek(priceForWeek);
            p.setDailyPriceForMonth(priceForMonth);
            pd.addPricing(p);

        } catch (Exception e) {
            System.out.println(e);
        }
        response.sendRedirect("pricingManage");
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

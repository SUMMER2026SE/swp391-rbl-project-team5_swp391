package com.smartride.controller;

import com.smartride.dao.CategoryDAO;
import com.smartride.dao.MotorcycleDAO;
import com.smartride.dao.PriceListDAO;
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
import java.text.NumberFormat;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Set;

@WebServlet(name = "MotorcycleLoadMoreServlet", urlPatterns = {"/load"})
public class MotorcycleLoadMoreServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String amount = request.getParameter("total");
        int iAmount = Integer.parseInt(amount);
        List<Motorcycle> listM = MotorcycleDAO.getInstance().getNext3Motorcycles(iAmount);
        LinkedHashMap<String, String> listMA = MotorcycleDAO.getInstance().getAllAvailableMotorCycle();
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        for (Motorcycle m : listM) {
            Category c = CategoryDAO.getInstance().getCategoryById(m.getCategoryID());
            PriceList p = PriceListDAO.getInstance().getPricingByid(String.valueOf(m.getPriceListID()));
            String formattedPrice = currencyFormatter.format(p.getDailyPriceForDay() * 1000);
            boolean found = listMA.containsKey(m.getMotorcycleId());
            out.println("<div class=\"motorcycle box col-md-3\">\n"
                    + "                                    <div class=\"banner-image\">\n"
                    + "                                        <img src=\"images/" + m.getImage() + "\" width=\"100%\" height=\"100%\" alt=\"alt\"/>\n"
                    + "                                    </div>\n"
                    + "                                    <h2 style=\"margin: 16px;\" href=\"motorcycleDetail?id=" + m.getMotorcycleId() + "\"><strong>" + m.getModel() + "</strong></h2>\n"
                    + "                                    <p style=\"font-weight: bold;\">" + c.getCategoryName() + "<br/>\n"
                    + "                                        " + formattedPrice + "/ngày\n"
                    + "                                    </p>\n"
                    + "                                    <div class=\"button-wrapper\" style=\"display: flex; gap: 10px; justify-content: center; width: 100%; margin-top: 18px;\">\n"
                    + "                                        <a href=\"motorcycleDetail?id=" + m.getMotorcycleId() + "\" class=\"btn outline-huhu\" style=\"flex: 1; text-align: center; display: inline-flex; align-items: center; justify-content: center;\">CHI TIẾT</a>\n");
            if (found) {
                out.println("        <a href=\"booking?motorcycleid=" + m.getMotorcycleId() + "\" class=\"btn fill\" style=\"flex: 1; text-align: center; display: inline-flex; align-items: center; justify-content: center;\">THUÊ NGAY</a>\n");
            } else {
                out.println("        <a href=\"#\" class=\"btn fill disabled\" style=\"flex: 1; text-align: center; display: inline-flex; align-items: center; justify-content: center;\">HẾT XE</a>\n");
            }
            out.println("    </div>\n"
                    + "</div>");
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
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

package com.smartride.controller;

import com.smartride.dao.BrandDAO;
import com.smartride.dao.CategoryDAO;
import com.smartride.dao.DemandDAO;
import com.smartride.dao.DemandPriceRangeDAO;
import com.smartride.dao.MotorcycleDAO;
import com.smartride.dao.PriceListDAO;
import com.smartride.dto.Brand;
import com.smartride.dto.Category;
import com.smartride.dto.Demand;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.PriceList;
import com.smartride.dto.SearchCriteria;
import com.smartride.util.CacheHelper;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SearchMotorcycleServlet", urlPatterns = {"/searchMotorcycle"})
public class SearchMotorcycleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        String key = request.getParameter("textSearch");

        MotorcycleDAO motorcycleDAO = MotorcycleDAO.getInstance();

        CacheHelper.loadCache(getServletContext());
        
        int total = motorcycleDAO.getTotalMotorcyclesCountByName(key);
        int endPage = total / 9;
        if (total % 9 != 0) {
            endPage++;
        }
        
        List<Motorcycle> motorcycles = motorcycleDAO.getPagingMotorcyclesByName(key, index);
        request.setAttribute("key", key);


        if (motorcycles.isEmpty()) {
            request.setAttribute("noResults", true);
        }
        
        LinkedHashMap<String, String> listMA = motorcycleDAO.getAllAvailableMotorCycle();
        request.setAttribute("listMA", listMA);
        request.setAttribute("search", "searchName");
        request.setAttribute("motorcycles", motorcycles);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("totalMotorcycles", total);

        request.getRequestDispatcher("motorbikes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}

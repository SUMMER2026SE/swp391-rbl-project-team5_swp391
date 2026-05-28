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
import com.smartride.dto.SearchCriteria.PriceRange;
import com.smartride.util.CacheHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import com.smartride.dao.TouristLocationDAO;
import com.smartride.dto.TouristLocation;

@WebServlet(name = "MotorcycleServlet", urlPatterns = {"/motorcycle"})
public class MotorcycleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    MotorcycleDAO motorcycleDAO = MotorcycleDAO.getInstance();
    CategoryDAO categoryDAO = CategoryDAO.getInstance();
    PriceListDAO priceListDAO = PriceListDAO.getInstance();
    BrandDAO brandDAO = BrandDAO.getInstance();
    DemandDAO demandDAO = DemandDAO.getInstance();
    DemandPriceRangeDAO demandPriceRangeDAO = DemandPriceRangeDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);

        CacheHelper.loadCache(getServletContext());
        
        int total = motorcycleDAO.getTotalMotorcyclesCount();
        int endPage = total / 9;
        if (total % 9 != 0) {
            endPage++;
        }
        
        List<Motorcycle> motorcycles = motorcycleDAO.getPagingMotorcycles(index);


        
        LinkedHashMap<String, String> listMA = motorcycleDAO.getAllAvailableMotorCycle();
        request.setAttribute("listMA", listMA);

        List<TouristLocation> listLocations = TouristLocationDAO.getInstance().getAllTouristLocation();
        request.setAttribute("listLocations", listLocations);

        request.setAttribute("motorcycles", motorcycles);
        
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("search", "default");
        request.setAttribute("totalMotorcycles", total);

        request.getRequestDispatcher("motorbikes.jsp").forward(request, response);
    }
}

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
import com.smartride.dto.SearchCriteria.PriceRange;
import com.smartride.util.CacheHelper;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import com.smartride.dao.TouristLocationDAO;
import com.smartride.dto.TouristLocation;

@WebServlet(name = "SearchCriteriaServlet", urlPatterns = {"/searchCriteria"})
public class SearchCriteriaServlet extends HttpServlet {

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

        String[] priceRanges = request.getParameterValues("priceRanges");
        String[] brands = request.getParameterValues("brands");
        String[] categories = request.getParameterValues("categories");
        String[] displacements = request.getParameterValues("displacements");
        String[] demands = request.getParameterValues("demands");
        String[] locations = request.getParameterValues("locations");
        
        HttpSession session = request.getSession();
        SearchCriteria criteria = null;

        // If all parameters are null, it might be a pagination request, so try to get from session
        if (priceRanges == null && brands == null && categories == null && displacements == null && demands == null && locations == null) {
            criteria = (SearchCriteria) session.getAttribute("criteria");
        }

        // If criteria is still null or it's a new search (at least one parameter is not null)
        if (criteria == null || (priceRanges != null || brands != null || categories != null || displacements != null || demands != null || locations != null)) {
            criteria = new SearchCriteria();
            if (priceRanges != null) {
                for (String range : priceRanges) {
                    String[] prices = range.split(",");
                    double minPrice = Double.parseDouble(prices[0]);
                    double maxPrice = Double.parseDouble(prices[1]);
                    if (maxPrice == 0) {
                        maxPrice = Double.MAX_VALUE;
                    }
                    criteria.addPriceRange(minPrice, maxPrice);
                }
            }
            if (brands != null) {
                for (String brandId : brands) {
                    criteria.addBrandID(Integer.parseInt(brandId));
                }
            }
            if (categories != null) {
                for (String categoryId : categories) {
                    criteria.addCategoryID(Integer.parseInt(categoryId));
                }
            }
            if (displacements != null) {
                for (String displacement : displacements) {
                    criteria.addDisplacement(displacement);
                }
            }
            if (demands != null) {
                for (String demandId : demands) {
                    criteria.addDemandID(Integer.parseInt(demandId));
                }
            }
            if (locations != null) {
                for (String locationId : locations) {
                    criteria.addLocationID(Integer.parseInt(locationId));
                }
            }
            session.setAttribute("criteria", criteria);
        }
        
        int total = motorcycleDAO.getTotalMotorcyclesCountByCriteria(criteria);
        int endPage = total / 9;
        if (total % 9 != 0) {
            endPage++;
        }
        
        List<Motorcycle> motorcycles = motorcycleDAO.getPagingMotorcyclesByCriteria(criteria, index);
        CacheHelper.loadCache(getServletContext());
        
        LinkedHashMap<String, String> listMA = motorcycleDAO.getAllAvailableMotorCycle();
        request.setAttribute("listMA", listMA);
        request.setAttribute("search", "searchCriteria");

        List<TouristLocation> listLocations = TouristLocationDAO.getInstance().getAllTouristLocation();
        request.setAttribute("listLocations", listLocations);

        request.setAttribute("motorcycles", motorcycles);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("totalMotorcycles", total);
        
        if (motorcycles.isEmpty()) {
            request.setAttribute("noResults", true);
        }
        request.getRequestDispatcher("motorbikes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}

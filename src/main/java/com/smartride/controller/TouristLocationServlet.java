package com.smartride.controller;

import com.smartride.dao.TouristLocationDAO;
import com.smartride.dto.TouristLocation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.smartride.dto.LocationRecommendationDTO;
import java.util.Map;

@WebServlet(name = "TouristLocationServlet", urlPatterns = {"/touristLocation"})
public class TouristLocationServlet extends HttpServlet {
    
    TouristLocationDAO touristLocationDAO = TouristLocationDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        
        int total = touristLocationDAO.getTotalTouristLocation();
        int endPage = total / 9;
        if (total % 9 != 0) {
            endPage++;
        }
        
        List<TouristLocation> touristLocations = touristLocationDAO.getPagingTouristLocation(index);
        
        Map<Integer, List<LocationRecommendationDTO>> recommendMap
                = touristLocationDAO.getRecommendationsByLocations(touristLocations);
        
        request.setAttribute("touristLocation", touristLocations);
        request.setAttribute("recommendMap", recommendMap);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.getRequestDispatcher("touristLocation.jsp").forward(request, response);
    }  
}

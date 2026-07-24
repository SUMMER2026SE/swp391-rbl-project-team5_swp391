package com.smartride.controller;

import com.smartride.dao.StaffDAO;
import com.smartride.dao.TouristLocationDAO;
import com.smartride.dto.Staff;
import com.smartride.dto.TouristLocation;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.LocationRecommendationDTO;
import com.smartride.dao.MotorcycleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "TourismLocationServletStaff", urlPatterns = {"/TourismLocationServletStaff"})
public class TourismLocationServletStaff extends HttpServlet {

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TouristLocationDAO touristLocationDAO = TouristLocationDAO.getInstance();
        StaffDAO staffDAO = StaffDAO.getInstance();
        
        List<TouristLocation> touristLocations = touristLocationDAO.getAllTouristLocation();
        List<Staff> staffList = staffDAO.getAllStaff();
        List<Motorcycle> allMotorcycles = MotorcycleDAO.getInstance().getAll();
        
        // Lấy danh sách gợi ý cho từng địa điểm
        Map<Integer, List<LocationRecommendationDTO>> recommendMap = new HashMap<>();
        for (TouristLocation loc : touristLocations) {
            List<LocationRecommendationDTO> recs = touristLocationDAO.getRecommendationsByLocation(loc.getLocationId());
            recommendMap.put(loc.getLocationId(), recs);
        }
        
        request.setAttribute("staffList", staffList);
        request.setAttribute("touristLocation", touristLocations);
        request.setAttribute("allMotorcycles", allMotorcycles);
        request.setAttribute("recommendMap", recommendMap);
        request.getRequestDispatcher("tourismLocatonStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        TouristLocationDAO dao = TouristLocationDAO.getInstance();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            if ("add".equals(action)) {
                int locationId = Integer.parseInt(request.getParameter("locationId"));
                String motorcycleId = request.getParameter("motorcycleId");
                String reason = request.getParameter("reason");
                int priority = Integer.parseInt(request.getParameter("priority"));
                
                boolean success = dao.addRecommendation(locationId, motorcycleId, reason, priority);
                out.print("{\"success\": " + success + "}");
            } else if ("delete".equals(action)) {
                int locationId = Integer.parseInt(request.getParameter("locationId"));
                String motorcycleId = request.getParameter("motorcycleId");
                
                boolean success = dao.deleteRecommendation(locationId, motorcycleId);
                out.print("{\"success\": " + success + "}");
            } else {
                out.print("{\"success\": false, \"message\": \"Unknown action\"}");
            }
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}

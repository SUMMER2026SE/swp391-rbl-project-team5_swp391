package com.smartride;

import com.smartride.dao.TouristLocationDAO;
import com.smartride.dto.TouristLocation;
import java.util.List;

public class UpdateLocation {
    public static void main(String[] args) {
        TouristLocationDAO dao = TouristLocationDAO.getInstance();
        List<TouristLocation> list = dao.getAllTouristLocation();
        boolean found = false;
        for (TouristLocation loc : list) {
            if (loc.getLocationName().contains("Bà Nà") || loc.getLocationName().contains("Ba Na")) {
                loc.setLocationImage("bana_hills.png");
                dao.updateTouristLocation(loc);
                System.out.println("Updated: " + loc.getLocationName());
                found = true;
            }
        }
        if (!found) {
            System.out.println("Ba Na Hills not found.");
        }
    }
}

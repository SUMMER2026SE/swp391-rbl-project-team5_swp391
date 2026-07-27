package com.smartride.util;

import com.smartride.dao.BrandDAO;
import com.smartride.dao.CategoryDAO;
import com.smartride.dao.DemandDAO;
import com.smartride.dao.DemandPriceRangeDAO;
import com.smartride.dao.MotorcycleDAO;
import com.smartride.dao.PriceListDAO;
import com.smartride.dto.Brand;
import com.smartride.dto.Category;
import com.smartride.dto.Demand;
import com.smartride.dto.PriceList;
import com.smartride.dto.SearchCriteria.PriceRange;
import jakarta.servlet.ServletContext;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CacheHelper {
    public static void loadCache(ServletContext context) {
        if (context.getAttribute("categories") == null) {
            List<Category> categories = CategoryDAO.getInstance().getAllCategory();
            List<PriceList> priceLists = PriceListDAO.getInstance().getAllPriceList();
            List<Brand> brandLists = BrandDAO.getInstance().getAllBrand();
            List<String> listDisplacement = MotorcycleDAO.getInstance().getListDisplacements();
            List<Demand> listDemand = DemandDAO.getInstance().getAllDemand();
            List<PriceRange> listPriceRange = DemandPriceRangeDAO.getInstance().getListDemandPriceRanges();

            context.setAttribute("categories", categories);
            context.setAttribute("priceLists", priceLists);
            context.setAttribute("listBrand", brandLists);
            context.setAttribute("listDisplacement", listDisplacement);
            context.setAttribute("listDemand", listDemand);
            context.setAttribute("listPriceRange", listPriceRange);

            Map<Integer, String> categoryMap = new HashMap<>();
            for (Category category : categories) {
                categoryMap.put(category.getCategoryID(), category.getCategoryName());
            }
            context.setAttribute("categoryMap", categoryMap);

            Map<Integer, Double> priceMap = new HashMap<>();
            for (PriceList p : priceLists) {
                priceMap.put(p.getPriceListId(), p.getDailyPriceForDay());
            }
            context.setAttribute("priceMap", priceMap);
        }
    }
}

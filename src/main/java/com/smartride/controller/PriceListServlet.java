package com.smartride.controller;

import com.smartride.dao.MotorcycleDAO;
import com.smartride.dao.PriceListDAO;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.PriceList;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name="PriceListServlet", urlPatterns={"/pricing"})
public class PriceListServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        
        String categoryIdStr = request.getParameter("category");
        int categoryId = 0;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                categoryId = 0;
            }
        }
        
        PriceListDAO pd = PriceListDAO.getInstance();
        MotorcycleDAO md = MotorcycleDAO.getInstance();
        com.smartride.dao.CategoryDAO cd = com.smartride.dao.CategoryDAO.getInstance();
        
        int total;
        String searchKeyword = request.getParameter("search");
        
        com.smartride.dto.SearchCriteria criteria = new com.smartride.dto.SearchCriteria();
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            criteria.setKeyword(searchKeyword.trim());
        }

        if (categoryId > 0) {
            criteria.addCategoryID(categoryId);
            
            // Smart Grouping Logic
            String selectedCatName = "";
            List<com.smartride.dto.Category> allCats = cd.getAllCategory();
            for (com.smartride.dto.Category c : allCats) {
                if (c.getCategoryID() == categoryId) {
                    selectedCatName = c.getCategoryName().toLowerCase();
                    break;
                }
            }
            
            if (selectedCatName.contains("côn")) {
                for (com.smartride.dto.Category c : allCats) {
                    String name = c.getCategoryName().toLowerCase();
                    if (name.contains("thể thao") || name.contains("phân khối")) {
                        criteria.addCategoryID(c.getCategoryID());
                    }
                }
            } else if (selectedCatName.contains("số") || selectedCatName.contains("ga")) {
                for (com.smartride.dto.Category c : allCats) {
                    String name = c.getCategoryName().toLowerCase();
                    if (name.contains("50cc")) {
                        criteria.addCategoryID(c.getCategoryID());
                    }
                }
            }
        }
        
        total = md.getTotalMotorcyclesCountByCriteria(criteria);
        List<Motorcycle> listM = md.getPagingMotorcyclesByCriteria(criteria, index);
        
        int endPage = total / 9;
        if (total % 9 != 0) {
            endPage++;
        }
        
        List<PriceList> listP = pd.getAllPriceList();
        List<com.smartride.dto.Category> listC = cd.getAllCategory();
        
        request.setAttribute("listP", listP);
        request.setAttribute("listM", listM);
        request.setAttribute("listC", listC);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("currentCategory", categoryId);
        request.setAttribute("searchKeyword", searchKeyword);
        
        request.getRequestDispatcher("pricing.jsp").forward(request, response);
    } 

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
    }

}

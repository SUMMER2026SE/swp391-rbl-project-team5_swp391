package com.smartride.controller;

import com.smartride.dao.AccessoryDAO;
import com.smartride.dao.BrandDAO;
import com.smartride.dao.MotorcycleDAO;
import com.smartride.dao.PriceListDAO;
import com.smartride.dto.Accessory;
import com.smartride.dto.Brand;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.PriceList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MotorcycleDetailServlet", urlPatterns = {"/motorcycleDetail"})
public class MotorcycleDetailServlet extends HttpServlet {

    MotorcycleDAO motorcycleDAO = MotorcycleDAO.getInstance();
    BrandDAO brandDAO = BrandDAO.getInstance();
    PriceListDAO priceListDAO = PriceListDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String motorcycleId = request.getParameter("id");

        Motorcycle motorcycleDetail = motorcycleDAO.getMotorcycleByid(motorcycleId);
        List<Brand> brand = brandDAO.getAllBrand();
        int priceListId = motorcycleDetail.getPriceListID();

        PriceList priceList = priceListDAO.getPricingByid(String.valueOf(priceListId));
        List<Accessory> listAccess = AccessoryDAO.getInstance().getAll();

        request.setAttribute("motorcycleDetail", motorcycleDetail);
        request.setAttribute("brand", brand);
        request.setAttribute("priceList", priceList);
        request.setAttribute("listAccess", listAccess);
        
        // Ensure robust and abundant data for related vehicles slider (slide.jsp)
        List<Motorcycle> listM = motorcycleDAO.getMotorcycles();
        List<PriceList> listP = priceListDAO.getAllPriceList();
        request.getSession().setAttribute("listM", listM);
        request.getSession().setAttribute("listP", listP);
        
        // Fetch feedbacks for this motorcycle
        List<com.smartride.dto.Feedback> feedbacks = com.smartride.dao.FeedbackDAO.getInstance().getFeedbacksByMotorcycleId(motorcycleId);
        request.setAttribute("feedbacks", feedbacks);
        
        request.getRequestDispatcher("motorbikeDetails.jsp").forward(request, response);
    }

}

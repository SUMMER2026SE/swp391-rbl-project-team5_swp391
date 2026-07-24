package com.smartride.controller;

import com.smartride.dao.AccountDAO;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.BrandDAO;
import com.smartride.dao.FeedbackDAO;
import com.smartride.dao.MotorcycleDAO;
import com.smartride.dao.PriceListDAO;
import com.smartride.dao.TouristLocationDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.Brand;
import com.smartride.dto.Feedback;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.PriceList;
import com.smartride.dto.TouristLocation;
import com.smartride.dto.Brand;
import com.smartride.dto.Feedback;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.PriceList;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        FeedbackDAO fd = FeedbackDAO.getInstance(); //view feedback

        MotorcycleDAO md = MotorcycleDAO.getInstance();//view featured motorbikes
        BrandDAO bd = BrandDAO.getInstance();
        PriceListDAO pd = PriceListDAO.getInstance();
        List<Feedback> listF = fd.getAllFeedbacks();
        List<Motorcycle> listM = md.getAll();
        List<Brand> listB = bd.getAllBrand();
        List<PriceList> listP = pd.getAllPriceList();
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account != null) {
            Booking book = BookingDAO.getInstance().getLastestBooking(account.getAccountId());
            if (book != null) {
                request.setAttribute("book", book);
                request.setAttribute("statusBooking", book.getStatusBooking());
            } else {
                request.removeAttribute("book");
                request.removeAttribute("statusBooking");
            }
        }
        
        List<com.smartride.dto.FAQ> listFAQ = com.smartride.dao.FAQDAO.getInstance().getAllFAQ();
        request.setAttribute("listFAQ", listFAQ);

        List<TouristLocation> listLocations = TouristLocationDAO.getInstance().getAllTouristLocation();

        session.setAttribute("account", account);
        request.setAttribute("listF", listF);
        session.setAttribute("listM", listM);
        session.setAttribute("listB", listB);
        session.setAttribute("listP", listP);
        session.setAttribute("listLocations", listLocations);

        request.getRequestDispatcher("home.jsp").forward(request, response);
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

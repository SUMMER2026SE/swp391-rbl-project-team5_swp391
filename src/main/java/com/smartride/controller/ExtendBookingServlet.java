package com.smartride.controller;

import com.smartride.dao.AccessoryDAO;
import com.smartride.dao.AccessoryDetailDAO;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.BookingDetailDAO;
import com.smartride.dao.MotorcycleDAO;
import com.smartride.dao.PaymentDAO;
import com.smartride.dao.PriceListDAO;
import com.smartride.dto.Accessory;
import com.smartride.dto.Booking;
import com.smartride.dto.BookingDetail;
import com.smartride.dto.Motorcycle;
import com.smartride.dto.Payment;
import com.smartride.dto.PriceList;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

@WebServlet(name = "ExtendBookingServlet", urlPatterns = {"/extend"})
public class ExtendBookingServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String bookingid = request.getParameter("bookingid");
        BookingDAO daoB = BookingDAO.getInstance();
        Booking booking = daoB.getBookingById(bookingid);
        
        if (booking == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking not found");
            return;
        }
        
        request.setAttribute("booking", booking);
        
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

        try {
            Date dateStart = dateTimeFormat.parse(booking.getStartDate());
            Date dateEnd = dateTimeFormat.parse(booking.getEndDate());
            String dateStartPart = dateFormat.format(dateStart);
            String timeStartPart = timeFormat.format(dateStart);
            String dateEndPart = dateFormat.format(dateEnd);
            String timeEndPart = timeFormat.format(dateEnd);
            
            request.setAttribute("startDate", dateStartPart);
            request.setAttribute("startTime", timeStartPart);
            request.setAttribute("endDate", dateEndPart);
            request.setAttribute("endTime", timeEndPart);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        MotorcycleDAO daoM = MotorcycleDAO.getInstance();
        LinkedHashMap<Motorcycle, Integer> listM = daoM.getListMotorcycleByBookingId(booking.getBookingID());
        request.setAttribute("listM", listM );
        
        
        AccessoryDAO daoA = AccessoryDAO.getInstance();
        LinkedHashMap<Accessory, Integer>  listA = daoA.getListByBookingId(booking.getBookingID());
        request.setAttribute("listA", listA);
        
        PriceListDAO daoP = PriceListDAO.getInstance();
        List<PriceList> listP = daoP.getAllPriceList();
        request.setAttribute("listP", listP);
        
        PaymentDAO daoPM = PaymentDAO.getInstance();
        List<Payment> listPM = daoPM.getListByBookingId(booking.getBookingID());
        request.setAttribute("listPM", listPM);
        
        request.getRequestDispatcher("extendBooking.jsp").forward(request, response);
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

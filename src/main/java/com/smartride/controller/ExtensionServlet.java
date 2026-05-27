package com.smartride.controller;

import com.smartride.dao.BookingDAO;
import com.smartride.dao.ExtensionDAO;
import com.smartride.dto.Booking;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="ExtensionServlet", urlPatterns={"/extension"})
public class ExtensionServlet extends HttpServlet {
    //LOGIC: Ấn vào 1 mục --> Xem detail và nhập newEndDate, submit --> Trả về trạng thái và gửi email


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //chưa xong, đợi booking xong đã
        String bookingId = request.getParameter("newEndDate"); //lấy bookingId của đơn thuê muốn gia hạn
        BookingDAO bookingDAO = BookingDAO.getInstance();
        Booking booking = bookingDAO.getBookingById(bookingId);
        String newEndDate = request.getParameter("newEndDate");
        ExtensionDAO extensionDAO = ExtensionDAO.getInstance();
        extensionDAO.addExtension(newEndDate, newEndDate, 0, bookingId);
    }


}

// Minor update 16

// Minor update 17

// fix patch 4

// fix patch 23

// fix patch 43

// fix patch 46

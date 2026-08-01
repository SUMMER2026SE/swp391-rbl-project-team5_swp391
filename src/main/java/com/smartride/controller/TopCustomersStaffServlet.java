package com.smartride.controller;

import com.smartride.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "TopCustomersStaffServlet", urlPatterns = {"/topCustomersStaff"})
public class TopCustomersStaffServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Object account = session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CustomerDAO dao = CustomerDAO.getInstance();
        List<Map<String, Object>> topCustomers = dao.getTopCustomers(20);
        
        request.setAttribute("topCustomers", topCustomers);
        request.getRequestDispatcher("topCustomersStaff.jsp").forward(request, response);
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
}

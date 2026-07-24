package com.smartride.controller;

import com.smartride.dao.AccountDAO;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.CustomerDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SearchCustomerServlet", urlPatterns = {"/searchCustomer"})
public class SearchCustomerServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchCustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchCustomerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountIdParam = request.getParameter("accountId");
        int accountId = 0;

        if (accountIdParam != null && !accountIdParam.isEmpty()) {
            accountId = Integer.parseInt(accountIdParam);
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
            AccountDAO.getInstance().updateRoleAndGetStatuses(accountId, isActive, 1, 4);
        }
        String id = request.getParameter("id");
        List<Account> accounts = AccountDAO.getInstance().getAccountbyCustomerID(Integer.parseInt(id));
        Map<Integer, Customer> customerMap = CustomerDAO.getInstance().getCustomersMappedByAccountId();
        Map<Integer, Integer> bookingCount = AccountDAO.getInstance().getBookingCountbyAccount();

        int activeCount = 0;
        int disabledCount = 0;

        for (Account account : accounts) {
            if (account.getRoleID() == 1) {
                activeCount++;
            } else if (account.getRoleID() == 4) {
                disabledCount++;
            }
        }
        session.setAttribute("accounts", accounts);
        session.setAttribute("activeCount", activeCount);
        session.setAttribute("disabledCount", disabledCount);
        session.setAttribute("allCount", accounts.size());
        session.setAttribute("customerMap", customerMap);
        session.setAttribute("bookingCount", bookingCount);
        request.getRequestDispatcher("manageCustomer.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountIdParam = request.getParameter("accountId");
        int accountId = 0; 

        if (accountIdParam != null && !accountIdParam.isEmpty()) {
            accountId = Integer.parseInt(accountIdParam);
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
            AccountDAO.getInstance().updateRoleAndGetStatuses(accountId, isActive, 1, 4);
        }
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        List<Account> accounts = AccountDAO.getInstance().searchAccountsbyUserNameandName(username, name);
        Map<Integer, Customer> customerMap = CustomerDAO.getInstance().getCustomersMappedByAccountId();
        Map<Integer, Integer> bookingCount = AccountDAO.getInstance().getBookingCountbyAccount();

        int activeCount = 0;
        int disabledCount = 0;

        for (Account account : accounts) {
            if (account.getRoleID() == 1) {
                activeCount++;
            } else if (account.getRoleID() == 4) {
                disabledCount++;
            }
        }
        session.setAttribute("accounts", accounts);
        session.setAttribute("activeCount", activeCount);
        session.setAttribute("disabledCount", disabledCount);
        session.setAttribute("allCount", accounts.size());
        session.setAttribute("customerMap", customerMap);
        session.setAttribute("bookingCount", bookingCount);
        request.getRequestDispatcher("manageCustomer.jsp").forward(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

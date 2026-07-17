package com.smartride.controller;

import com.smartride.dao.AccountDAO;
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

@WebServlet(name = "ManageCustomerServlet", urlPatterns = {"/manageCustomer"})
public class ManageCustomerServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageCustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageCustomerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        List<Account> accounts = AccountDAO.getInstance().getListAccountByRoleAndDisable(1,4);
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
        Map<Account, Booking> accountBookingMap = AccountDAO.getInstance().getAccountOverdue();
        session.setAttribute("accountBookingMap", accountBookingMap);
        session.setAttribute("activeCount", activeCount);
        session.setAttribute("disabledCount", disabledCount);
        session.setAttribute("allCount", accounts.size());
        session.setAttribute("accounts", accounts);
        session.setAttribute("customerMap", customerMap);
        session.setAttribute("bookingCount", bookingCount);
        request.getRequestDispatcher("manageCustomer.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String action = request.getParameter("action");

        if ("updateRoleAndGetStatuses".equals(action)) {
            int accountId = Integer.parseInt(request.getParameter("accountId"));
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

            Map<Integer, Integer> updatedStatuses = AccountDAO.getInstance().updateRoleAndGetStatuses(accountId, isActive,1,4);
            List<Account> accounts = AccountDAO.getInstance().getListAccountByRoleAndDisable(1,4);
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
            session.setAttribute("isActive", isActive);
            session.setAttribute("updatedStatuses", updatedStatuses);
            session.setAttribute("accounts", accounts);
            session.setAttribute("activeCount", activeCount);
            session.setAttribute("disabledCount", disabledCount);
            session.setAttribute("allCount", accounts.size());
            session.setAttribute("customerMap", customerMap);
            session.setAttribute("bookingCount", bookingCount);
            request.getRequestDispatcher("manageCustomer.jsp").forward(request, response);
        }

    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

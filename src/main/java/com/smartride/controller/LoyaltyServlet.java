package com.smartride.controller;

import com.smartride.dao.CustomerDAO;
import com.smartride.dao.VoucherDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Voucher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoyaltyServlet", urlPatterns = {"/loyalty"})
public class LoyaltyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        int accountId = account.getAccountId();
        float totalSpent = CustomerDAO.getInstance().getTotalSpentByAccountId(accountId);
        List<Voucher> myVouchers = VoucherDAO.getInstance().getAvailableVouchersForAccount(accountId);

        request.setAttribute("totalSpent", totalSpent);
        request.setAttribute("myVouchers", myVouchers);
        
        request.getRequestDispatcher("/loyalty.jsp").forward(request, response);
    }
}

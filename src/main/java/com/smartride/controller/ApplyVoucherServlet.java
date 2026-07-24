package com.smartride.controller;

import com.smartride.dao.CustomerDAO;
import com.smartride.dao.VoucherDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Customer;
import com.smartride.dto.Voucher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ApplyVoucherServlet", urlPatterns = {"/applyVoucher"})
public class ApplyVoucherServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("account") == null) {
            response.getWriter().write("{\"valid\":false,\"message\":\"Vui lòng đăng nhập để dùng voucher\"}");
            return;
        }

        String code = request.getParameter("code");
        if (code == null || code.trim().isEmpty()) {
            response.getWriter().write("{\"valid\":false,\"message\":\"Mã voucher không được để trống\"}");
            return;
        }

        Account account = (Account) session.getAttribute("account");
        Customer customer = CustomerDAO.getInstance().getCustomerbyAccountID(account.getAccountId());
        int customerId = (customer != null) ? customer.getCustomerId() : 0;

        Voucher voucher = VoucherDAO.getInstance().getVoucherByCode(code.trim(), customerId);

        if (voucher == null) {
            response.getWriter().write("{\"valid\":false,\"message\":\"Mã voucher không hợp lệ hoặc đã được sử dụng\"}");
        } else {
            // Format discount nicely
            long discount = (long) voucher.getDiscountAmount();
            String json = String.format(
                "{\"valid\":true,\"voucherId\":%d,\"discount\":%d,\"code\":\"%s\",\"description\":\"%s\"}",
                voucher.getVoucherId(),
                discount,
                voucher.getCode(),
                voucher.getDescription() != null ? voucher.getDescription().replace("\"", "\\\"") : ""
            );
            response.getWriter().write(json);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

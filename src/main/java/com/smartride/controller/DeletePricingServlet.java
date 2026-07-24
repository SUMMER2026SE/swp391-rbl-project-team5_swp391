package com.smartride.controller;

import com.smartride.dao.PriceListDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="DeletePricingServlet", urlPatterns={"/deletePricing"})
public class DeletePricingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            PriceListDAO pd = PriceListDAO.getInstance();
            boolean success = pd.deletePricing(id);
            if (!success) {
                request.getSession().setAttribute("deleteError", "Không thể xóa bảng giá này vì đang có xe máy sử dụng gói giá này!");
            } else {
                request.getSession().setAttribute("deleteSuccess", "Đã xóa bảng giá thành công!");
            }
        }
        response.sendRedirect("pricingManage");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
}

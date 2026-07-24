package com.smartride.controller;

import com.smartride.dao.VoucherDAO;
import com.smartride.dao.NotificationDAO;
import com.smartride.dao.CustomerDAO;
import com.smartride.dto.Voucher;
import com.smartride.dto.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "VoucherManageServlet", urlPatterns = {"/manageVoucher"})
public class VoucherManageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VoucherDAO dao = VoucherDAO.getInstance();
        List<Voucher> vouchers = dao.getAllVouchers();
        
        for (Voucher v : vouchers) {
            v.setPublished(NotificationDAO.getInstance().isVoucherPublished(v.getCode()));
        }
        
        request.setAttribute("vouchers", vouchers);
        request.getRequestDispatcher("manageVoucher.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        VoucherDAO dao = VoucherDAO.getInstance();
        
        try {
            if ("add".equals(action)) {
                String code = request.getParameter("code").toUpperCase();
                double discount = Double.parseDouble(request.getParameter("discountAmount"));
                String description = request.getParameter("description");
                String status = "Đang hoạt động"; // Default
                Voucher v = new Voucher();
                v.setCode(code);
                v.setDiscountAmount(discount);
                v.setDescription(description);
                v.setStatus(status);
                
                dao.insertVoucher(v);
            } else if ("edit".equals(action)) {
                int voucherId = Integer.parseInt(request.getParameter("voucherId"));
                String code = request.getParameter("code").toUpperCase();
                double discount = Double.parseDouble(request.getParameter("discountAmount"));
                String description = request.getParameter("description");
                String status = request.getParameter("status");
                Voucher v = new Voucher();
                v.setVoucherId(voucherId);
                v.setCode(code);
                v.setDiscountAmount(discount);
                v.setDescription(description);
                v.setStatus(status);
                
                dao.updateVoucher(v);
                request.getSession().setAttribute("successMsg", "Cập nhật Voucher thành công!");
            } else if ("delete".equals(action)) {
                int voucherId = Integer.parseInt(request.getParameter("voucherId"));
                boolean deleted = dao.deleteVoucher(voucherId);
                if (!deleted) {
                    request.getSession().setAttribute("errorMsg", "Không thể xóa Voucher này vì nó đã được sử dụng. Vui lòng chuyển trạng thái sang Ngừng hoạt động.");
                } else {
                    request.getSession().setAttribute("successMsg", "Xóa Voucher thành công!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Đã xảy ra lỗi: " + e.getMessage());
        }
        response.sendRedirect("manageVoucher");
    }
}

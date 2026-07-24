package com.smartride.controller;

import com.smartride.dao.AccountDAO;
import com.smartride.dto.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changepassword"})
public class ChangePasswordServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("changepassword.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account ac = (Account) session.getAttribute("account");
        String password = request.getParameter("password");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        try {
            if (ac != null) {
                if (!com.smartride.util.PasswordUtil.checkPassword(password, ac.getPassWord())) {
                    request.setAttribute("errorPass", "Mật khẩu hiện tại không đúng.");
                } else if (password.equals(newPassword)) {
                    request.setAttribute("errorPass", "Mật khẩu hiện tại và mật khẩu cũ không được giống nhau.");
                } else if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("errorPass", "Mật khẩu mới và mật khẩu xác nhận không khớp.");
                } else if (!checkValidPass(newPassword)) {
                    request.setAttribute("errorPass", "Password phải chứa ít nhất 8 ký tự, bao gồm ít nhất 1 ký tự in hoa và 1 chữ số.");
                } else {
                    boolean isChanged = AccountDAO.getInstance().changePassword(ac.getAccountId(), newPassword);
                    if (isChanged) {
                        ac.setPassWord(com.smartride.util.PasswordUtil.hashPassword(newPassword));
                        session.setAttribute("account", ac);
                        request.setAttribute("successChange", "Thay đổi mật khẩu thành công.");
                    } else {
                        request.setAttribute("errorPass", "Lỗi CSDL: Cột Password trong DB không đủ dài để chứa mã hóa BCrypt (cần ít nhất 60 ký tự). Bạn hãy vào Supabase sửa kiểu dữ liệu cột Password thành VARCHAR(255).");
                    }
                }
            } else {
                response.setContentType("text/html;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Bạn cần đăng nhập lại.');");
                    out.println("location='login.jsp';");
                    out.println("</script>");
                }
                return;
            }

            // Always forward back to the correct page based on role so the user can see the success or error message.
            if (ac.getRoleID() == 3) {
                request.getRequestDispatcher("profileStaff.jsp").forward(request, response);
            } else if (ac.getRoleID() == 1) {
                request.getRequestDispatcher("profileAdmin.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            }
        } catch (ServletException | IOException | NumberFormatException ex) {
            System.out.println(ex);
        }
    }

    private boolean checkValidPass(String pass) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d).{8,}$";
        return pass != null && pass.matches(passwordRegex);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

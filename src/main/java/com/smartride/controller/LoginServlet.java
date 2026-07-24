package com.smartride.controller;
import com.smartride.dao.AccountDAO;
import com.smartride.dto.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String username = null;
        String password = null;
        String rem = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("Username")) {
                    username = cookie.getValue();
                }
                if (cookie.getName().equals("Password")) {
                    password = cookie.getValue();
                }
                if (cookie.getName().equals("rem")) {
                    rem = cookie.getValue();
                }
            }
        }

        // Set attributes to pre-fill the login form
        request.setAttribute("Username", username);
        request.setAttribute("Password", password);
        request.setAttribute("rem", rem);

        if (request.getSession().getAttribute("account") != null) {
            response.sendRedirect("home");
            return;
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String username = request.getParameter("Username");
        String password = request.getParameter("Password");
        String rememberMe = request.getParameter("rem");

        Cookie usernameCookie = new Cookie("Username", username);
        Cookie passwordCookie = new Cookie("Password", password);
        Cookie rememberMeCookie = new Cookie("rem", rememberMe);

        if (rememberMe != null) {// có chọn
            usernameCookie.setMaxAge(60*60*24); // 30 days
            passwordCookie.setMaxAge(60*60*24); // 30 days
            rememberMeCookie.setMaxAge(60*60*24); // 30 days
        } else { // không chọn
            usernameCookie.setMaxAge(0); // Delete cookie
            passwordCookie.setMaxAge(0); // Delete cookie
            rememberMeCookie.setMaxAge(0); // Delete cookie
        }
        // lưu vào browser
        response.addCookie(usernameCookie);
        response.addCookie(passwordCookie);
        response.addCookie(rememberMeCookie);

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {

            request.setAttribute("error", "Vui lòng cung cấp cả tên người dùng và mật khẩu");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Account account = AccountDAO.getInstance().checkLogin(username, password);

        if (account == null) {

            request.setAttribute("error", "Tên đăng nhập hoặc Mật khẩu không đúng! <br> Vui lòng nhập lại");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            session.setAttribute("account", account);

            // Điều chỉnh logic chuyển hướng dựa trên RoleID
            if (account.getRoleID() == 1) {
                String redirect = (String) session.getAttribute("redirectAfterLogin");
                if (redirect != null) {
                    session.removeAttribute("redirectAfterLogin");
                    response.sendRedirect(redirect);
                } else {
                    response.sendRedirect("home");
                }
            } else if (account.getRoleID() == 2 || account.getRoleID() == 3) {
                response.sendRedirect("manageSmartRide.jsp?iframeSrc=homeStaff");
            } else {
                request.setAttribute("error", "Tài khoản bạn đã bị khóa <br> Vui lòng liên hệ với trang web để lấy lại thông tin");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}
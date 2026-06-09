package com.mycompany.smartridesystem.controller;

import com.mycompany.smartridesystem.dao.AccountDAO;
import com.mycompany.smartridesystem.dto.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/updateprofile"})
public class UpdateProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfileServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phonenumber");
        String userName = request.getParameter("username");
        String accountID = request.getParameter("accountID");
        HttpSession session = request.getSession();
        Account ac = (Account) session.getAttribute("account");

        try {
            if (ac != null) {
                if (isEmptyOrNull(email)) {
                    request.setAttribute("errorProfile", "Cáº­p nháº­t há»“ sÆ¡ tháº¥t báº¡i! KhÃ´ng Ä‘Æ°á»£c Ä‘á»ƒ trá»‘ng email.");
                } else if (!isEmptyOrNull(email) && !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                    request.setAttribute("errorProfile", "Cáº­p nháº­t há»“ sÆ¡ tháº¥t báº¡i! Email chÆ°a Ä‘Ãºng format.");
                } else if (!isEmptyOrNull(phoneNumber) && !phoneNumber.matches("^0\\d{9}$")) {
                    request.setAttribute("errorProfile", "Cáº­p nháº­t há»“ sÆ¡ tháº¥t báº¡i! Äiá»‡n thoáº¡i pháº£i cÃ³ 10 sá»‘, vÃ  báº¯t Ä‘áº§u sá»‘ 0.");
                } else if (!isEmptyOrNull(dob) && java.time.LocalDate.parse(dob).isAfter(java.time.LocalDate.now())) {
                    request.setAttribute("errorProfile", "Cáº­p nháº­t há»“ sÆ¡ tháº¥t báº¡i! NgÃ y sinh khÃ´ng Ä‘Æ°á»£c lá»›n hÆ¡n ngÃ y hiá»‡n táº¡i.");
                } else if (AccountDAO.getInstance().checkEmailExists(email, ac.getEmail())) {
                    request.setAttribute("errorProfile", "Email Ä‘Ã£ tá»“n táº¡i trÆ°á»›c Ä‘Ã³. Vui lÃ²ng nháº­p Ä‘á»‹a chá»‰ email khÃ¡c!");
                } else if (AccountDAO.getInstance().checkPhoneNumExists(phoneNumber, ac.getPhoneNumber())) {
                    request.setAttribute("errorProfile", "Sá»‘ Ä‘iá»‡n thoáº¡i Ä‘Ã£ tá»“n táº¡i trÆ°á»›c Ä‘Ã³. Vui lÃ²ng nháº­p sá»‘ khÃ¡c!");
                } else {
                    boolean success = AccountDAO.getInstance().update(firstName, lastName, gender, dob, address, phoneNumber, email, userName, Integer.parseInt(accountID));
                    if (success) {
                        session.setAttribute("account", AccountDAO.getInstance().getAccountbyID(Integer.parseInt(accountID)));
                        request.setAttribute("mess", "Cáº­p nháº­t há»“ sÆ¡ thÃ nh cÃ´ng!");
                    } else {
                        request.setAttribute("errorProfile", "Cáº­p nháº­t há»“ sÆ¡ tháº¥t báº¡i!");
                    }
                }
            } else {
                response.setContentType("text/html;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Báº¡n cáº§n Ä‘Äƒng nháº­p láº¡i.');");
                    out.println("location='login.jsp';");
                    out.println("</script>");
                }
                return;
            }
            boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
            if (isAjax) {
                response.setContentType("application/json;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    if (request.getAttribute("errorProfile") != null) {
                        out.print("{\"success\": false, \"message\": \"" + request.getAttribute("errorProfile") + "\"}");
                    } else {
                        out.print("{\"success\": true, \"message\": \"" + request.getAttribute("mess") + "\"}");
                    }
                }
                return;
            }

            if (ac.getRoleID() == 1) {
                request.getRequestDispatcher("profileCustomer.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("profileStaff.jsp").forward(request, response);
            }
        } catch (ServletException | IOException | NumberFormatException ex) {
            System.out.println(ex);
        }
    }

    private boolean isEmptyOrNull(String str) {
        return str == null || str.trim().isEmpty();
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}


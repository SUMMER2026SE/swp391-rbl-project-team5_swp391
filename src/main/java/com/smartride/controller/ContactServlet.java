package com.smartride.controller;

import com.smartride.dao.ContactDAO;
import com.smartride.dto.Account;
import jakarta.mail.Session;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="ContactServlet", urlPatterns={"/contact"})
public class ContactServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        String honeypot = request.getParameter("website_url_honeypot");
        if (honeypot != null && !honeypot.isEmpty()) {
            // SPAM BOT DETECTED: Silently accept but do nothing
            request.setAttribute("msg", "Gửi yêu cầu thành công! Cảm ơn bạn đã liên hệ, đội ngũ SmartRide sẽ phản hồi bạn trong vòng 24h làm việc.");
            request.getRequestDispatcher("contact.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        
        Long lastContactTime = (Long) session.getAttribute("lastContactTime");
        if (lastContactTime != null && (System.currentTimeMillis() - lastContactTime < 60000)) {
            // Rate limit: 1 request per 60 seconds
            request.setAttribute("errorMsg", "Bạn thao tác quá nhanh. Vui lòng chờ 1 phút trước khi gửi yêu cầu tiếp theo để tránh spam.");
            request.getRequestDispatcher("contact.jsp").forward(request, response);
            return;
        }
        session.setAttribute("lastContactTime", System.currentTimeMillis());

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String title = request.getParameter("title");
        String message = request.getParameter("message");
        
        ContactDAO cd = ContactDAO.getInstance();
        Account acc = (Account) session.getAttribute("account");
        
        if(acc != null){
            cd.insertContact(name, phone, email, title, message, acc.getAccountId());
        } else {
            cd.insertContact(name, phone, email, title, message, null);
        }
        
        // Gửi email thông báo cho Khách hàng
        String customerContent = "<h3>Xin chào " + name + ",</h3>"
                + "<p>Cảm ơn bạn đã liên hệ với <strong>SmartRide</strong>.</p>"
                + "<p>Chúng tôi đã nhận được yêu cầu của bạn với nội dung sau:</p>"
                + "<ul>"
                + "<li><strong>Tiêu đề:</strong> " + title + "</li>"
                + "<li><strong>Nội dung:</strong><br/>" + message.replace("\n", "<br>") + "</li>"
                + "</ul>"
                + "<p>Đội ngũ hỗ trợ của chúng tôi sẽ xem xét và phản hồi bạn qua email hoặc số điện thoại (" + phone + ") trong thời gian sớm nhất (thường trong vòng 24 giờ làm việc).</p>"
                + "<br><p>Trân trọng,<br><strong>Đội ngũ SmartRide</strong></p>";

        // Gửi email thông báo về mail hệ thống
        String adminTo = "smartride.system@gmail.com";
        String adminContent = "<h3>Bạn vừa nhận được một liên hệ mới từ khách hàng trên hệ thống SmartRide.</h3>"
                + "<p><strong>Thông tin khách hàng:</strong></p>"
                + "<ul>"
                + "<li><strong>Tên:</strong> " + name + "</li>"
                + "<li><strong>Số điện thoại:</strong> " + phone + "</li>"
                + "<li><strong>Email:</strong> " + email + "</li>"
                + "<li><strong>Tiêu đề:</strong> " + title + "</li>"
                + "</ul>"
                + "<p><strong>Nội dung:</strong><br/>" + message.replace("\n", "<br>") + "</p>";
        
        try {
            // Gửi cho Admin (Main Mail)
            com.smartride.constant.SendEmail.sendVerificationEmail(adminTo, adminContent);
            
            // Gửi cho Khách hàng
            com.smartride.constant.SendEmail.sendVerificationEmail(email, customerContent);

            request.setAttribute("msg", "Gửi yêu cầu thành công! Cảm ơn bạn đã liên hệ, đội ngũ SmartRide sẽ phản hồi bạn trong vòng 24h làm việc.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Đã lưu thông tin liên hệ nhưng có lỗi khi gửi email thông báo: " + e.getMessage());
        }
        
        request.getRequestDispatcher("contact.jsp").forward(request, response);
       
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

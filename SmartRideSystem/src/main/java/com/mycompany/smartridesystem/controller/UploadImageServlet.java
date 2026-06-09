package com.mycompany.smartridesystem.controller;

import com.mycompany.smartridesystem.dao.AccountDAO;
import com.mycompany.smartridesystem.dto.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Random;
import com.mycompany.smartridesystem.util.SupabaseStorageUtil;

@WebServlet(name = "UploadImageServlet", urlPatterns = {"/uploadimage"})
@MultipartConfig
public class UploadImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private FileUploaded fileUploadHandler;

    @Override
    public void init() throws ServletException {
        fileUploadHandler = new FileUploaded(getServletContext().getRealPath("/images"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("profileCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("login.jsp");  // Redirect to login if session is invalid
                return;
            }
            String id = request.getParameter("id");

            String name = "imageAcc" + id + generateBookingCode() + ".jpg";
            Part filePart = request.getPart("file");
            String publicUrl = fileUploadHandler.handleFileUpload(filePart, name, "profileImg");
            if (publicUrl == null) publicUrl = name;

            // Delete old image if exists
            if (account.getImage() != null && !account.getImage().isEmpty()) {
                SupabaseStorageUtil.deleteFile(account.getImage());
            }

            AccountDAO dao = AccountDAO.getInstance();
            dao.updateProfileImage(Integer.parseInt(id), publicUrl);
            
            // CÃ¡ÂºÂ­p nhÃ¡ÂºÂ­t thuÃ¡Â»â„¢c tÃƒÂ­nh image trong Ã„â€˜Ã¡Â»â€˜i tÃ†Â°Ã¡Â»Â£ng account
            account.setImage(publicUrl);

            // CÃ¡ÂºÂ­p nhÃ¡ÂºÂ­t lÃ¡ÂºÂ¡i Ã„â€˜Ã¡Â»â€˜i tÃ†Â°Ã¡Â»Â£ng account trong session
            session.setAttribute("account", account);

            
      
        } catch (Exception e) {
            System.out.println(e);
        }
//        if (filePart != null && filePart.getSize() > 0) {
//            String fileName = fileUploadHandler.generateNewFileName(fileUploadHandler.getFileName(filePart));
//            String filePath = fileUploadHandler.handleFileUpload(filePart, fileName);
//            Account account = (Account) session.getAttribute("account");
//            if (filePath != null) {
//                // Update the database with the new file path
//                AccountDAO.getInstance().updateProfileImage(account.getAccountId(), filePath);
//
//                response.setContentType("application/json");
//                response.setCharacterEncoding("UTF-8");
//                response.getWriter().write("{\"success\": true, \"filePath\": \"" + filePath + "\"}");
//            } else {
//                response.setContentType("application/json");
//                response.setCharacterEncoding("UTF-8");
//                response.getWriter().write("{\"success\": false}");
//            }
//        } else {
//            response.setContentType("application/json");
//            response.setCharacterEncoding("UTF-8");
//            response.getWriter().write("{\"success\": false, \"message\": \"No file uploaded\"}");
//        }
    }
    
    private String generateBookingCode() {
          //KhÃ¡Â»Å¸i tÃ¡ÂºÂ¡o mÃ¡Â»â„¢t Ã„â€˜Ã¡Â»â€˜i tÃ†Â°Ã¡Â»Â£ng Random
        Random random = new Random();

        // Sinh ra 6 sÃ¡Â»â€˜ ngÃ¡ÂºÂ«u nhiÃƒÂªn tÃ¡Â»Â« 0 Ã„â€˜Ã¡ÂºÂ¿n 999999
        int randomNumber = random.nextInt(1000000);

        // Format sÃ¡Â»â€˜ ngÃ¡ÂºÂ«u nhiÃƒÂªn thÃƒÂ nh chuÃ¡Â»â€”i, thÃƒÂªm vÃƒÂ o "BOOK"
        String bookingCode = String.format("%06d", randomNumber);

        return bookingCode;
    }
}

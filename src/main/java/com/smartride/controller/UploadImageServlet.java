package com.smartride.controller;

import com.smartride.dao.AccountDAO;
import com.smartride.dto.Account;
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
import com.smartride.util.SupabaseStorageUtil;

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
            
            // Cáº­p nháº­t thuá»™c tÃ­nh image trong Ä‘á»‘i tÆ°á»£ng account
            account.setImage(publicUrl);

            // Cáº­p nháº­t láº¡i Ä‘á»‘i tÆ°á»£ng account trong session
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
          //Khá»Ÿi táº¡o má»™t Ä‘á»‘i tÆ°á»£ng Random
        Random random = new Random();

        // Sinh ra 6 sá»‘ ngáº«u nhiÃªn tá»« 0 Ä‘áº¿n 999999
        int randomNumber = random.nextInt(1000000);

        // Format sá»‘ ngáº«u nhiÃªn thÃ nh chuá»—i, thÃªm vÃ o "BOOK"
        String bookingCode = String.format("%06d", randomNumber);

        return bookingCode;
    }
}
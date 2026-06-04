
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
                response.sendRedirect("login.jsp");  
                return;
            }
            String id = request.getParameter("id");

            String name = "imageAcc" + id + generateBookingCode() + ".jpg";
            Part filePart = request.getPart("file");
            String publicUrl = fileUploadHandler.handleFileUpload(filePart, name, "profileImg");
            if (publicUrl == null) publicUrl = name;

            
            if (account.getImage() != null && !account.getImage().isEmpty()) {
                SupabaseStorageUtil.deleteFile(account.getImage());
            }

            AccountDAO dao = AccountDAO.getInstance();
            dao.updateProfileImage(Integer.parseInt(id), publicUrl);
            
            
            account.setImage(publicUrl);

            
            session.setAttribute("account", account);

            
      
        } catch (Exception e) {
            System.out.println(e);
        }





















    }
    
    private String generateBookingCode() {
          
        Random random = new Random();

        
        int randomNumber = random.nextInt(1000000);

        
        String bookingCode = String.format("%06d", randomNumber);

        return bookingCode;
    }
}

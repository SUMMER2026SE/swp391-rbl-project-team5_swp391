package com.smartride.controller;

import com.smartride.constant.GoogleLogin;
import com.smartride.constant.PasswordGenerator;
import com.smartride.dao.AccountDAO;
import com.smartride.dto.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

@WebServlet(name="LoginGoogleServlet", urlPatterns={"/login-google"})
public class LoginGoogleServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        
        String scheme = request.getHeader("X-Forwarded-Proto");
        if (scheme == null) scheme = request.getScheme();
        String serverName = request.getServerName();
        if (!serverName.equals("localhost") && !serverName.equals("127.0.0.1")) {
            scheme = "https";
        }
        int serverPort = request.getServerPort();
        String contextPath = request.getContextPath();
        String redirectUri = scheme + "://" + serverName + (serverPort == 80 || serverPort == 443 ? "" : ":" + serverPort) + contextPath + "/login-google";
        
        String accessToken = GoogleLogin.getToken(code, redirectUri);
        //String jsonAcc = GoogleLogin.getUserInfo(accessToken);
        String email = GoogleLogin.getEmail(accessToken);
        Account acc = AccountDAO.getInstance().getAccountByEmail(email);
        if (acc == null) { //chưa có account
            //tạo 1 account mới chỉ bao gồm: email, username (email), password
            AccountDAO.getInstance().createANewAccountForLoginGoogle(email, PasswordGenerator.generatePassword(6));
            acc = AccountDAO.getInstance().getAccountByEmail(email);
        }
        session.setAttribute("account", acc);
        response.sendRedirect("home");
    } 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

}

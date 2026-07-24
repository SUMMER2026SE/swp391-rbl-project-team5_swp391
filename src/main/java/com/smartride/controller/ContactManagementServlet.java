package com.smartride.controller;

import com.smartride.dao.AccountDAO;
import com.smartride.dao.ContactDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Contact;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name="ContactManagementServlet", urlPatterns={"/contactManage"})
public class ContactManagementServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        ContactDAO cd = ContactDAO.getInstance();
        AccountDAO ad = AccountDAO.getInstance();
        
        List<Contact> listContact = cd.getAllContact();
        List<Account> listA = ad.getAllAccount();
        
        request.setAttribute("listContact", listContact);
        request.setAttribute("listA", listA);
        
        request.getRequestDispatcher("contactManagement.jsp").forward(request, response);
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
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

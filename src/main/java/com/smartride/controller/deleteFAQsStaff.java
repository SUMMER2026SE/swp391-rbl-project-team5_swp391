package com.smartride.controller;

import com.smartride.dao.FAQDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "deleteFAQsStaff", urlPatterns = {"/deleteFAQs"})
public class deleteFAQsStaff extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FAQDAO fAQDAO = FAQDAO.getInstance();
        try {
            String id = request.getParameter("questionID");
            fAQDAO.deleteFAQs(id);
            response.sendRedirect("faqsStaff");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

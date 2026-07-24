package com.smartride.controller;

import com.smartride.dao.FeedbackDAO;
import com.smartride.dto.Feedback;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name="FeedbackManagementServlet", urlPatterns={"/feedbackManage"})
public class FeedbackManagementServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        FeedbackDAO fd = FeedbackDAO.getInstance();
        
        List<Feedback> listF = fd.getAllFeedbacks();
        int quantity = fd.getQuantityFeedback();
        
        request.setAttribute("listF", listF);
        request.setAttribute("quantity", quantity);
        request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
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

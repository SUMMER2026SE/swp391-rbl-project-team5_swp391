package com.smartride.controller;

import com.smartride.dao.FAQDAO;
import com.smartride.dto.FAQ;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateFAQsServletStaff", urlPatterns = {"/UpdateFAQsServletStaff"})
public class UpdateFAQsServletStaff extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FAQDAO faqDAO = FAQDAO.getInstance();
        String idStr = request.getParameter("questionID");
        String question = request.getParameter("question");
        String answer = request.getParameter("answer");

        int questionID = Integer.parseInt(idStr);
        FAQ faq = new FAQ();
        faq.setQuestionID(questionID);
        faq.setQuestion(question);
        faq.setAnswer(answer);
        faqDAO.updateFAQs(faq);

        response.sendRedirect("faqsStaff");
    }

}

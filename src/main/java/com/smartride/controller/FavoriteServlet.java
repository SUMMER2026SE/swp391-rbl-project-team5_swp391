package com.smartride.controller;

import com.smartride.dao.FavoriteDAO;
import com.smartride.dto.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "FavoriteServlet", urlPatterns = {"/favorite"})
public class FavoriteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            out.print("{\"status\":\"unauthorized\"}");
            out.flush();
            return;
        }

        Account account = (Account) session.getAttribute("account");
        int accountId = account.getAccountId();
        
        String action = request.getParameter("action");
        String motorcycleId = request.getParameter("motorcycleId");

        if (action == null) {
            out.print("{\"status\":\"error\", \"message\":\"Missing parameters\"}");
            out.flush();
            return;
        }
        if (!"count".equals(action) && motorcycleId == null) {
            out.print("{\"status\":\"error\", \"message\":\"Missing motorcycleId parameter\"}");
            out.flush();
            return;
        }

        FavoriteDAO dao = FavoriteDAO.getInstance();
        boolean success = false;

        if ("add".equals(action)) {
            success = dao.addFavorite(accountId, motorcycleId);
        } else if ("remove".equals(action)) {
            success = dao.removeFavorite(accountId, motorcycleId);
        } else if ("check".equals(action)) {
            success = dao.isFavorite(accountId, motorcycleId);
            out.print("{\"status\":\"success\", \"isFavorite\":" + success + "}");
            out.flush();
            return;
        } else if ("count".equals(action)) {
            int count = dao.getFavoritesByAccountId(accountId).size();
            out.print("{\"status\":\"success\", \"totalFavorites\":" + count + "}");
            out.flush();
            return;
        }

        if (success) {
            int totalFavorites = dao.getFavoritesByAccountId(accountId).size();
            out.print("{\"status\":\"success\", \"totalFavorites\":" + totalFavorites + "}");
        } else {
            out.print("{\"status\":\"error\", \"message\":\"Action failed\"}");
        }
        out.flush();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Có thể dùng để render trang list favorite sau
        request.getRequestDispatcher("favorites.jsp").forward(request, response);
    }
}

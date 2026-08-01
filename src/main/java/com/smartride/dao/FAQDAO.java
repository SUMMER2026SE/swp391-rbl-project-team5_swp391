package com.smartride.dao;

import com.smartride.dto.FAQ;
import com.smartride.util.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FAQDAO implements Serializable, DAO<FAQDAO> {

    private static FAQDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private FAQDAO() {
    }

    public static FAQDAO getInstance() {
        if (instance == null) {
            instance = new FAQDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(FAQDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public List<FAQ> getAllFAQ() {
        List<FAQ> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"FAQ\";";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new FAQ(rs.getInt("QuestionID"), rs.getString("Question"), rs.getString("Answer")));
            }
        } catch (Exception ex) {
            Logger.getLogger(FAQDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void addNewFAQs(FAQ faq) {
        PreparedStatement stm;
        try {
            String sql = "INSERT INTO \"FAQ\" (\"Question\", \"Answer\") VALUES (?, ?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, faq.getQuestion());
            stm.setString(2, faq.getAnswer());
            stm.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(FAQDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteFAQs(String id) {
        PreparedStatement stm;
        try {
            String sql = "DELETE FROM \"FAQ\" WHERE \"QuestionID\" = ?;";
            stm = conn.prepareStatement(sql);
            try {
                stm.setInt(1, Integer.parseInt(id));
            } catch (NumberFormatException e) {
                stm.setString(1, id); // Fallback if id is not a number
            }
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updateFAQs(FAQ faq) {
        PreparedStatement stm;
        try {
            String sql = "UPDATE \"FAQ\" SET \"Question\" = ?, \"Answer\" = ? WHERE \"QuestionID\" = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, faq.getQuestion());
            stm.setString(2, faq.getAnswer());
            stm.setInt(3, faq.getQuestionID());

            int rowsUpdated = stm.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("FAQ updated successfully.");
            } else {
                System.out.println("No FAQ updated.");
            }
        } catch (Exception e) {
            System.out.println("Error updating FAQ: " + e.getMessage());
        }    
    }

    @Override
    public List<FAQDAO> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    @Override
    public void insert(FAQDAO t) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    @Override
    public void update(FAQDAO t) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    @Override
    public void delete(FAQDAO t) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    public static void main(String[] args) {
        FAQDAO dao = getInstance();
        for(FAQ x: dao.getAllFAQ()){
            System.out.println(x);
        }
    }
}

package com.smartride.dao;

import com.smartride.dto.Contact;
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

public class ContactDAO implements Serializable {

    private static ContactDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private ContactDAO() {

    }

    public static ContactDAO getInstance() {
        if (instance == null) {
            instance = new ContactDAO();
        }
        return instance;
    }

    public void insertContact(String name, String phoneNumber, String email, String title, String message, Integer accountID) {
        String sql = "INSERT INTO \"Contact\"\n"
                + "           (\"Name\"\n"
                + "           ,\"PhoneNumber\"\n"
                + "           ,\"Email\"\n"
                + "           ,\"Title\"\n"
                + "           ,\"Message\"\n"
                + "           ,\"AccountID\")\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phoneNumber);
            ps.setString(3, email);
            ps.setString(4, title);
            ps.setString(5, message);
             if (accountID != null) {
                ps.setInt(6, accountID);
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }
           
           
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public List<Contact> getAllContact() {
        List<Contact> list = new ArrayList<>();

        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "select * from \"Contact\"";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {  
                list.add(new Contact(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7)));
            }
        } catch (Exception ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public static void main(String[] args) {
        ContactDAO cd = ContactDAO.getInstance();
       
       // cd.insertContact("Jessica", "0912345678", "jessica123@gmail.com", "Ask Question 1", "123 abc", null);
        System.out.println(cd.getAllContact());
    }
}

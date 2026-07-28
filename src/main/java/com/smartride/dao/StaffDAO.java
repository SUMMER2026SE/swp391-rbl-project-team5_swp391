package com.smartride.dao;

import com.smartride.dto.Staff;
import com.smartride.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StaffDAO {

    private static StaffDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private StaffDAO() {
    }

    public static StaffDAO getInstance() {

        if (instance == null) {
            instance = new StaffDAO();
        }
        return instance;
    }

    public List<Staff> getAllStaff() {
        List<Staff> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "select * from \"Staff\"";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getString("staffID"), rs.getString("managerID"), rs.getInt("accountID")));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Staff getStaffbyAccountID(int accountID) {
        PreparedStatement st;
        ResultSet rs;
        String sql = "select * from \"Staff\"\n"
                + "where \"AccountID\" = (Select \"AccountID\" from \"Account\" where \"RoleID\" = 2 and \"AccountID\" = ?)";
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, accountID);
            rs = st.executeQuery();
            if (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffID(rs.getString(1));
                staff.setManagerID(rs.getString(2));
                staff.setAccountID(rs.getInt(3));
                return staff;
            }
        }catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public static void main(String[] args) {
        StaffDAO dao = new StaffDAO();
//        System.out.println(dao.getAllStaff());
        System.out.println(dao.getStaffbyAccountID(5));
    }

}

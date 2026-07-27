package com.smartride.util;
import com.smartride.dao.AccountDAO;
import com.smartride.dao.StaffDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Staff;
import java.util.List;

public class FindStaff {
    public static void main(String[] args) {
        try {
            System.out.println("--- STAFF ACCOUNTS ---");
            List<Staff> staffs = StaffDAO.getInstance().getAllStaff();
            for(Staff s : staffs) {
                Account a = AccountDAO.getInstance().getAccountbyID(s.getAccountID());
                System.out.println("StaffID: " + s.getStaffID() + " | Username: " + a.getUserName() + " | Pass: " + a.getPassWord());
            }
            DBUtil.shutdown();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
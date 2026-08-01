package com.smartride.dao;

import com.smartride.dto.Customer;
import com.smartride.dto.Motorcycle;
import com.smartride.util.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerDAO implements Serializable, DAO<Customer> {

    private static CustomerDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    public CustomerDAO() {
    }

    public static CustomerDAO getInstance() {

        if (instance == null) {
            instance = new CustomerDAO();
        }
        return instance;
    }

    public List<Customer> getAll() {
        List<Customer> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * from \"Customer\"";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Customer(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), 0, rs.getInt(7)));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void createNewCustomer(String IdentityCard, String IdentityCardImage, String IssuedOnDate, String ExpDate, String TypeCard, int TypeID, int AccountID) {
        String sql = "INSERT INTO \"Customer\" (\n"
                + "    \"IdentityCard\",\n"
                + "    \"IdentityCardImage\",\n"
                + "    \"IssuedOnDate\",\n"
                + "    \"ExpDate\",\n"
                + "    \"TypeCard\",\n"
                + "    \"AccountID\"\n"
                + ") VALUES (\n"
                + "  ?,?,CAST(NULLIF(?, '') AS date),CAST(NULLIF(?, '') AS date),?,? );";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, IdentityCard);
            ps.setString(2, IdentityCardImage);
            ps.setString(3, IssuedOnDate);
            ps.setString(4, ExpDate);
            ps.setString(5, TypeCard);
            ps.setInt(6, AccountID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            throw new RuntimeException("Lỗi tạo Customer: " + e.getMessage(), e);
        }
    }

    public void updateCustomer(String IdentityCard, String IdentityCardImage, String IssuedOnDate, String ExpDate, String TypeCard, int CustomerId) {
        String sql = "UPDATE \"Customer\" "
                + "SET \"IdentityCard\" = ?, \"IdentityCardImage\" = ?, "
                + "\"IssuedOnDate\" = CAST(NULLIF(?, '') AS date), \"ExpDate\" = CAST(NULLIF(?, '') AS date), \"TypeCard\" = ? "
                + "WHERE \"CustomerID\" = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, IdentityCard);
            st.setString(2, IdentityCardImage);
            st.setString(3, IssuedOnDate);
            st.setString(4, ExpDate);
            st.setString(5, TypeCard);
            st.setInt(6, CustomerId);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
            throw new RuntimeException("Lỗi update Customer: " + e.getMessage(), e);
        }
    }

    @Override
    public void insert(Customer t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Customer t) {
        String sql = "UPDATE \"Customer\" "
                + "SET \"IdentityCard\" = ?, \"IdentityCardImage\" = ?, "
                + "\"IssuedOnDate\" = ?, \"ExpDate\" = ?, \"TypeCard\" = ? "
                + "WHERE \"CustomerID\" = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, t.getIdentityCard());
            st.setString(2, t.getIdentityCardImage());
            st.setString(3, t.getIssuedOnDate());
            st.setString(4, t.getExpDate());
            st.setString(5, t.getTypeCard());
            st.setInt(6, t.getCustomerId());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Customer getCustomerbyAccountID(int id) {
        String sql = " SELECT * FROM \"Customer\"\n"
                + " WHERE \"AccountID\" = ? ORDER BY \"CustomerID\" DESC LIMIT 1";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), 0, rs.getInt(7));
                return customer;
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public Customer getCustomerbyID(int id) {
        String sql = "SELECT \n"
                + "\"CustomerID\",\n"
                + "\"IdentityCard\",\n"
                + "\"IdentityCardImage\",\n"
                + "TO_CHAR(\"IssuedOnDate\", 'DD-MM-YYYY'),\n"
                + "TO_CHAR(\"ExpDate\", 'DD-MM-YYYY'),\n"
                + "\"TypeCard\",\n"
                + "\"AccountID\"\n"
                + "FROM \"Customer\"\n"
                + "WHERE \"CustomerID\" = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), 0, rs.getInt(7));
                return customer;
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public Map<Integer, Customer> getCustomersMappedByAccountId() {
        String sql = "SELECT \n"
                + "\"CustomerID\",\n"
                + "\"IdentityCard\",\n"
                + "\"IdentityCardImage\",\n"
                + "TO_CHAR(\"IssuedOnDate\", 'DD-MM-YYYY') AS \"IssuedOnDate\",\n"
                + "TO_CHAR(\"ExpDate\", 'DD-MM-YYYY') AS \"ExpDate\",\n"
                + "\"TypeCard\",\n"
                + "\"AccountID\"\n"
                + "FROM \n"
                + "\"Customer\"";
        Map<Integer, Customer> customerMap = new HashMap<>();

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        0,
                        rs.getInt(7)
                );
                customerMap.put(customer.getAccountId(), customer);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return customerMap;
    }
    
    

    @Override
    public void delete(Customer t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public static void main(String[] args) {
    }

    public float getTotalSpentByAccountId(int accountId) {
        String sql = "SELECT SUM(bd.\"TotalPrice\") AS \"TotalSpent\" "
                   + "FROM \"Customer\" c "
                   + "JOIN \"Booking\" b ON c.\"CustomerID\" = b.\"CustomerID\" "
                   + "JOIN \"Booking Detail\" bd ON b.\"BookingID\" = bd.\"BookingID\" "
                   + "WHERE c.\"AccountID\" = ? AND b.\"StatusBooking\" = 'Đã hoàn thành'";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getFloat("TotalSpent");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public List<Map<String, Object>> getTopCustomers(int limit) {
        List<Map<String, Object>> topCustomers = new ArrayList<>();
        String sql = "SELECT c.\"CustomerID\", a.\"FullName\", a.\"Email\", a.\"Phone\", "
                   + "COUNT(b.\"BookingID\") AS \"TotalBookings\", "
                   + "SUM(bd.\"TotalPrice\") AS \"TotalSpent\" "
                   + "FROM \"Customer\" c "
                   + "JOIN \"Account\" a ON c.\"AccountID\" = a.\"AccountID\" "
                   + "JOIN \"Booking\" b ON c.\"CustomerID\" = b.\"CustomerID\" "
                   + "JOIN \"Booking Detail\" bd ON b.\"BookingID\" = bd.\"BookingID\" "
                   + "WHERE b.\"StatusBooking\" = 'Đã hoàn thành' "
                   + "GROUP BY c.\"CustomerID\", a.\"FullName\", a.\"Email\", a.\"Phone\" "
                   + "ORDER BY \"TotalSpent\" DESC, \"TotalBookings\" DESC "
                   + "LIMIT ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, limit);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("CustomerID", rs.getInt("CustomerID"));
                map.put("FullName", rs.getString("FullName"));
                map.put("Email", rs.getString("Email"));
                map.put("Phone", rs.getString("Phone"));
                map.put("TotalBookings", rs.getInt("TotalBookings"));
                map.put("TotalSpent", rs.getFloat("TotalSpent"));
                topCustomers.add(map);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return topCustomers;
    }

}
package com.smartride.dao;

import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.util.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AccountDAO implements Serializable {

    private static AccountDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    public AccountDAO() {
    }

    public static AccountDAO getInstance() {

        if (instance == null) {
            instance = new AccountDAO();
        }
        return instance;
    }

    public Account checkLogin(String userName, String passWord) {

        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"Account\" WHERE \"Username\" = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, userName);
            rs = stm.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("Password");
                if (com.smartride.util.PasswordUtil.checkPassword(passWord, storedPassword)) {
                    // Tự động nâng cấp thuật toán mã hóa nếu phát hiện dùng bản cũ quá nặng (cost 12)
                    if (storedPassword.startsWith("$2a$12$")) {
                        try {
                            String newHash = com.smartride.util.PasswordUtil.hashPassword(passWord);
                            PreparedStatement updateStm = conn.prepareStatement("UPDATE \"Account\" SET \"Password\" = ? WHERE \"Username\" = ?");
                            updateStm.setString(1, newHash);
                            updateStm.setString(2, userName);
                            updateStm.executeUpdate();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    return new Account(rs.getInt("AccountID"), rs.getString("FirstName"), rs.getString("LastName"),
                            rs.getString("Gender"), rs.getString("DayOfBirth"), rs.getString("Address"), rs.getString("PhoneNumber"),
                            rs.getString("Image"), rs.getString("Email"), rs.getString("Username"), rs.getString("Password"), rs.getInt("RoleID"));
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void createANewAccountForLoginGoogle(String email, String password) {
        String sql = "INSERT INTO \"Account\"(\"Email\", \"Username\", \"Password\", \"RoleID\")\n"
                + "VALUES (?, ?, ?, 1)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, email);
            ps.setString(3, com.smartride.util.PasswordUtil.hashPassword(password));
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void createANewAccount(String firstName, String lastName, String gender, String phone, String email, String userName, String password) {
        String sql = "INSERT INTO \"Account\"\n"
                + "           (\"FirstName\"\n"
                + "           ,\"LastName\"\n"
                + "           ,\"Gender\"\n"
                + "           ,\"PhoneNumber\"\n"
                + "           ,\"Email\"\n"
                + "           ,\"Username\"\n"
                + "           ,\"Password\"\n"
                + "           ,\"RoleID\")\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?, ?, 1)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, gender);
            ps.setString(4, phone);
            ps.setString(5, email);
            ps.setString(6, userName);
            ps.setString(7, com.smartride.util.PasswordUtil.hashPassword(password));
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Account getAccountByEmail(String email) {
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"Account\" WHERE \"Email\" =  ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery();
            if (rs.next()) {
                return new Account(rs.getInt("AccountID"), rs.getString("FirstName"), rs.getString("LastName"),
                        rs.getString("Gender"), rs.getString("DayOfBirth"), rs.getString("Address"), rs.getString("PhoneNumber"),
                        rs.getString("Image"), rs.getString("Email"), rs.getString("Username"), rs.getString("Password"), rs.getInt("RoleID"));
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean createToken(String token, String email) {
        Timestamp expiration = new Timestamp(System.currentTimeMillis() + 1 * 60 * 1000); // 1 phút
        String checkEmailSql = "SELECT COUNT(*) FROM \"Account\" WHERE \"Email\" = ?";
        String insertTokenSql = "INSERT INTO \"PasswordResetToken\" (\"Email\", \"Token\", \"Expiration\", \"AccountID\") "
                + "SELECT \"Email\", ?, ?, \"AccountID\" FROM \"Account\" WHERE \"Email\" = ?";
        try {
            // Kiểm tra xem email có tồn tại không
            PreparedStatement checkEmailStmt = conn.prepareStatement(checkEmailSql);
            checkEmailStmt.setString(1, email);
            ResultSet rs = checkEmailStmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            if (count == 0) {
                // Email không tồn tại
                return false;
            }

            // Email tồn tại, tiếp tục chèn token
            PreparedStatement insertTokenStmt = conn.prepareStatement(insertTokenSql);
            insertTokenStmt.setString(1, token);
            insertTokenStmt.setTimestamp(2, expiration);
            insertTokenStmt.setString(3, email);
            insertTokenStmt.executeUpdate();

            return true;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public int getAccountIdByToken(String token) {
        ResultSet rs;
        String sql = "SELECT \"AccountID\" FROM \"PasswordResetToken\" WHERE \"Token\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, token);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -9999;
    }

    public void resetPassword(String email, String password) {
        String sql = "UPDATE \"Account\" SET \"Password\" = ? WHERE \"Email\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, com.smartride.util.PasswordUtil.hashPassword(password));
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean update(String firstName, String lastName, String gender, String dob, String address, String phoneNumber,
            String email, String username, int accountid) {
        String sql = "UPDATE \"Account\" SET \"FirstName\" = ?, \"LastName\" = ?, \"Gender\" = ?, \"DayOfBirth\" = ?, \"Address\" = ?,"
                + "\"PhoneNumber\" = ?, \"Email\" = ?, \"Username\" = ? WHERE \"AccountID\" = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, firstName);
            st.setString(2, lastName);
            st.setString(3, gender);
            
            if (dob == null || dob.trim().isEmpty()) {
                st.setNull(4, java.sql.Types.DATE);
            } else {
                try {
                    java.sql.Date sqlDate = java.sql.Date.valueOf(dob);
                    st.setDate(4, sqlDate);
                } catch (IllegalArgumentException e) {
                    st.setNull(4, java.sql.Types.DATE);
                }
            }
            
            st.setString(5, address);
            st.setString(6, phoneNumber);
            st.setString(7, email);
            st.setString(8, username);
            st.setInt(9, accountid);

            int rowAffect = st.executeUpdate();
            if (rowAffect > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean changePassword(int AccountID, String password) {
        String sql = "UPDATE \"Account\" SET \"Password\" = ? WHERE \"AccountID\" = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, com.smartride.util.PasswordUtil.hashPassword(password));
            st.setInt(2, AccountID);
            int rowAffect = st.executeUpdate();
            if (rowAffect > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public Account getAccountbyID(int id) {
        String sql = " SELECT * FROM \"Account\"\n"
                + " WHERE \"AccountID\" = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("AccountID"),
                    rs.getString("FirstName"),
                    rs.getString("LastName"),
                    rs.getString("Gender"),
                    rs.getString("DayOfBirth"),
                    rs.getString("Address"),
                    rs.getString("PhoneNumber"),
                    rs.getString("Image"),
                    rs.getString("Email"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getInt("RoleID")
                );
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public List<Account> getAllAccount() {
        List<Account> list = new ArrayList<>();

        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"Account\"";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getInt("AccountID"), rs.getString("FirstName"), rs.getString("LastName"),
                        rs.getString("Gender"), rs.getString("DayOfBirth"), rs.getString("Address"), rs.getString("PhoneNumber"),
                        rs.getString("Image"), rs.getString("Email"), rs.getString("Username"), rs.getString("Password"), rs.getInt("RoleID")));
            }
        } catch (Exception ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Account> getListAccountByRole(int role) {
        List<Account> listA = new ArrayList<>();
        String sql = "SELECT \n"
                + "    \"AccountID\",\n"
                + "    \"FirstName\",\n"
                + "    \"LastName\",\n"
                + "    \"Gender\",\n"
                + "    TO_CHAR(\"DayOfBirth\", 'DD-MM-YYYY') AS \"DayOfBirth\",\n"
                + "    \"Address\",\n"
                + "    \"PhoneNumber\",\n"
                + "    \"Image\",\n"
                + "    \"Email\",\n"
                + "    \"Username\",\n"
                + "    \"Password\",\n"
                + "    \"RoleID\" FROM \"Account\" WHERE \"RoleID\" = ?";
        PreparedStatement st;
        ResultSet rs;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, role);
            rs = st.executeQuery();
            while (rs.next()) {
                listA.add(new Account(
                        rs.getInt("AccountID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("DayOfBirth"),
                        rs.getString("Address"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Image"),
                        rs.getString("Email"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getInt("RoleID")
                ));
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return listA;
    }

    public List<Account> getListAccountByRoleAndDisable(int role, int disablerole) {
        List<Account> listA = new ArrayList<>();
        String sql = "SELECT \n"
                + "    \"AccountID\",\n"
                + "    \"FirstName\",\n"
                + "    \"LastName\",\n"
                + "    \"Gender\",\n"
                + "    TO_CHAR(\"DayOfBirth\", 'DD-MM-YYYY') AS \"DayOfBirth\",\n"
                + "    \"Address\",\n"
                + "    \"PhoneNumber\",\n"
                + "    \"Image\",\n"
                + "    \"Email\",\n"
                + "    \"Username\",\n"
                + "    \"Password\",\n"
                + "    \"RoleID\" FROM \"Account\" WHERE \"RoleID\" = ? or \"RoleID\" = ?";
        PreparedStatement st;
        ResultSet rs;
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, role);
            st.setInt(2, disablerole);
            rs = st.executeQuery();
            while (rs.next()) {
                listA.add(new Account(
                        rs.getInt("AccountID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("DayOfBirth"),
                        rs.getString("Address"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Image"),
                        rs.getString("Email"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getInt("RoleID")
                ));
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return listA;
    }

    public Map<Integer, Integer> getBookingCountbyAccount() {
        Map<Integer, Integer> counts = new HashMap<>();
        PreparedStatement st;
        ResultSet rs;
        String sql = "SELECT a.\"AccountID\", COUNT(b.\"BookingID\") AS \"Quality\"\n"
                + "FROM \"Account\" a\n"
                + "LEFT JOIN \"Customer\" c ON c.\"AccountID\" = a.\"AccountID\"\n"
                + "LEFT JOIN \"Booking\" b ON b.\"CustomerID\" = c.\"CustomerID\"\n"
                + "GROUP BY a.\"AccountID\";";
        try {
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                int AccountID = rs.getInt("AccountID");
                int Quality = rs.getInt("Quality");
                counts.put(AccountID, Quality);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return counts;
    }

    public Map<Integer, Integer> updateRoleAndGetStatuses(int accountId, boolean isActive, int role, int disablerole) {
        String sql = "UPDATE \"Account\" SET \"RoleID\" = ? WHERE \"AccountID\" = ?";
        int newRoleId = isActive ? role : disablerole;  // 1 for active, 4 for disable
        PreparedStatement st;
        ResultSet rs;

        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, newRoleId);
            st.setInt(2, accountId);
            st.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);
        }

        Map<Integer, Integer> roleStatuses = new HashMap<>();
        String query = "SELECT \"AccountID\", \"RoleID\" FROM \"Account\"";
        try {
            st = conn.prepareStatement(query);
            rs = st.executeQuery();

            while (rs.next()) {
                int accId = rs.getInt("AccountID");
                int roleId = rs.getInt("RoleID");
                roleStatuses.put(accId, roleId);
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return roleStatuses;
    }

    public List<Account> searchAccountsbyUserNameandName(String username, String name) {
        List<Account> list = new ArrayList<>();
        PreparedStatement st;
        ResultSet rs;

        try {
            StringBuilder sql = new StringBuilder("SELECT * FROM \"Account\" WHERE 1=1");
            if (!username.isEmpty() && !name.isEmpty()) {
                // Nếu cả hai điều kiện không rỗng, sử dụng OR
                sql.append(" AND (\"Username\" LIKE ? OR (\"FirstName\" || ' ' || \"LastName\") LIKE ?)");
            } else if (!username.isEmpty() || !name.isEmpty()) {
                // Nếu một trong hai điều kiện không rỗng, sử dụng AND
                if (!username.isEmpty()) {
                    sql.append(" AND \"Username\" LIKE ?");
                } else if (!name.isEmpty()) {
                    sql.append(" AND (\"FirstName\" || ' ' || \"LastName\") LIKE ?");
                }
            }
            sql.append(" AND (\"RoleID\" = 1 OR \"RoleID\" = 4)");

            st = conn.prepareStatement(sql.toString());
            int index = 1;

            if (!username.isEmpty() && !name.isEmpty()) {
                st.setString(index++, "%" + username + "%");
                st.setString(index++, "%" + name + "%");
            } else if (!username.isEmpty()) {
                st.setString(index++, "%" + username + "%");
            } else if (!name.isEmpty()) {
                st.setString(index++, "%" + name + "%");
            }

            rs = st.executeQuery();

            while (rs.next()) {
                list.add(new Account(
                        rs.getInt("AccountID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("DayOfBirth"),
                        rs.getString("Address"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Image"),
                        rs.getString("Email"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getInt("RoleID")
                ));
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public Account getAccountbyBookingID(String bookingId) {
        PreparedStatement st;
        ResultSet rs;
        String sql = "SELECT a.* FROM \"Account\" a\n"
                + "JOIN \"Customer\" c ON a.\"AccountID\" = c.\"AccountID\"\n"
                + "JOIN \"Booking\" b ON b.\"CustomerID\" = c.\"CustomerID\"\n"
                + "WHERE b.\"BookingID\" = ?";
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, bookingId);
            rs = st.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("AccountID"),
                    rs.getString("FirstName"),
                    rs.getString("LastName"),
                    rs.getString("Gender"),
                    rs.getString("DayOfBirth"),
                    rs.getString("Address"),
                    rs.getString("PhoneNumber"),
                    rs.getString("Image"),
                    rs.getString("Email"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getInt("RoleID")
                );
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public List<Account> getAccountbyCustomerID(int customerID) {
        List<Account> list = new ArrayList<>();

        PreparedStatement st;
        ResultSet rs;
        String sql = "SELECT * FROM \"Account\"\n"
                + "JOIN \"Customer\" ON \"Account\".\"AccountID\" = \"Customer\".\"AccountID\"\n"
                + "WHERE \"CustomerID\" = ?";
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, customerID);
            rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Account(
                        rs.getInt("AccountID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("DayOfBirth"),
                        rs.getString("Address"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Image"),
                        rs.getString("Email"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getInt("RoleID")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Account getAccountbyCustomerId(int customerID) {
        PreparedStatement st;
        ResultSet rs;
        String sql = "SELECT a.* FROM \"Account\" a\n"
                + "JOIN \"Customer\" c ON a.\"AccountID\" = c.\"AccountID\"\n"
                + "WHERE c.\"CustomerID\" = ?";
        try {
            st = conn.prepareStatement(sql);
            st.setInt(1, customerID);
            rs = st.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("AccountID"),
                    rs.getString("FirstName"),
                    rs.getString("LastName"),
                    rs.getString("Gender"),
                    rs.getString("DayOfBirth"),
                    rs.getString("Address"),
                    rs.getString("PhoneNumber"),
                    rs.getString("Image"),
                    rs.getString("Email"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getInt("RoleID")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean updateProfileImage(int AccountID, String filePath) {
        PreparedStatement st;
        String sql = "UPDATE \"Account\" SET \"Image\" = ? WHERE \"AccountID\" = ?";
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, filePath);
            st.setInt(2, AccountID);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailExists(String email, String currentEmail) {
        PreparedStatement st;
        ResultSet rs;
        String sql;
        if (currentEmail == null || currentEmail.trim().isEmpty()) {
            sql = "SELECT COUNT(*) FROM \"Account\" WHERE \"Email\" = ?";
        } else {
            sql = "SELECT COUNT(*) FROM \"Account\" WHERE \"Email\" = ? AND \"Email\" <> ?";
        }
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, email);
            if (currentEmail != null && !currentEmail.trim().isEmpty()) {
                st.setString(2, currentEmail);
            }
            rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkPhoneNumExists(String phoneNumber, String currentPhoneNumber) {
        PreparedStatement st = null;
        ResultSet rs = null;
        String sql;
        if (currentPhoneNumber == null || currentPhoneNumber.trim().isEmpty()) {
            sql = "SELECT COUNT(*) FROM \"Account\" WHERE \"PhoneNumber\" = ?";
        } else {
            sql = "SELECT COUNT(*) FROM \"Account\" WHERE \"PhoneNumber\" = ? AND \"PhoneNumber\" <> ?";
        }
        try {
            st = conn.prepareStatement(sql);
            st.setString(1, phoneNumber);
            if (currentPhoneNumber != null && !currentPhoneNumber.trim().isEmpty()) {
                st.setString(2, currentPhoneNumber);
            }
            rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Map<Account, Booking> getAccountOverdue() {
        Map<Account, Booking> map = new HashMap<>();
        PreparedStatement st;
        ResultSet rs;
        String sql = "SELECT A.*, B.\"BookingID\", \n"
                + "TO_CHAR(COALESCE(E.\"NewEndDate\", B.\"EndDate\"), 'DD-MM-YYYY HH24:MI:SS') AS \"EndDate\",\n"
                + "EXTRACT(DAY FROM (NOW() - COALESCE(E.\"NewEndDate\", B.\"EndDate\"))) AS \"OverdueDays\"\n"
                + "FROM \"Account\" A\n"
                + "JOIN \"Customer\" C ON A.\"AccountID\" = C.\"AccountID\"\n"
                + "JOIN \"Booking\" B ON C.\"CustomerID\" = B.\"CustomerID\"\n"
                + "LEFT JOIN \"Extension\" E ON B.\"BookingID\" = E.\"BookingID\"\n"
                + "WHERE COALESCE(E.\"NewEndDate\", B.\"EndDate\") < NOW()\n"
                + "AND (B.\"StatusBooking\" = 'Đã xác nhận' AND B.\"DeliveryStatus\" != 'Đã trả')\n"
                + "ORDER BY COALESCE(E.\"NewEndDate\", B.\"EndDate\") DESC;";

        try {
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccountId(rs.getInt(1));
                acc.setFirstName(rs.getString(2));
                acc.setLastName(rs.getString(3));
                acc.setGender(rs.getString(4));
                acc.setDob(rs.getString(5));
                acc.setAddress(rs.getString(6));
                acc.setPhoneNumber(rs.getString(7));
                acc.setImage(rs.getString(8));
                acc.setEmail(rs.getString(9));
                acc.setUserName(rs.getString(10));
                acc.setPassWord(rs.getString(11));
                acc.setRoleID(rs.getInt(12));

                Booking booking = new Booking();
                booking.setBookingID(rs.getString("BookingID"));
                booking.setEndDate(rs.getString("EndDate"));
                booking.setOverdueDays(rs.getInt("OverdueDays"));
                map.put(acc, booking);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return map;
    }

    public static void main(String[] args) {
        AccountDAO dao = getInstance();
        Map<Account, Booking> account = dao.getAccountOverdue();
        System.out.println(account);
    }

    public boolean checkUsernameExist(String username) {
        String sql = "SELECT * FROM \"Account\" WHERE \"Username\" = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean checkPhoneExist(String phone) {
        String sql = "SELECT * FROM \"Account\" WHERE \"PhoneNumber\" = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, phone);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
}

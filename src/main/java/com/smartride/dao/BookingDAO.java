package com.smartride.dao;

import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.BookingDetail;
import com.smartride.dto.Customer;
import com.smartride.util.DBUtil;
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

public class BookingDAO {
    
    private static BookingDAO instance;
    private Connection conn = DBUtil.makeConnection();

    // Cấm new trực tiếp DAO
    //Chỉ new DAO qua hàm static getInstance() để quản lí được số object/instance đã new - SINGLETON DESIGN PATTERN
    private BookingDAO() {
    }
    
    public static BookingDAO getInstance() {
        
        if (instance == null) {
            instance = new BookingDAO();
        }
        return instance;
    }
    
    public void addBooking(String bookingID, String bookingDate, String startDate, String endDate, String deliveryLocation, String returnedLocation, Integer voucherID, int customerID) {
        String sql = " INSERT INTO \"Booking\" (\n"
                + "    \"BookingID\", \n"
                + "    \"BookingDate\", \n"
                + "    \"StartDate\", \n"
                + "    \"EndDate\", \n"
                + "    \"StatusBooking\", \n"
                + "    \"DeliveryLocation\", \n"
                + "    \"ReturnedLocation\", \n"
                + "    \"DeliveryStatus\", \n"
                + "    \"VoucherID\", \n"
                + "    \"CustomerID\"\n"
                + ") VALUES"
                + " (?, CAST(? AS timestamp), CAST(? AS timestamp), CAST(? AS timestamp), ?, ?, ?, ?, ?, ?)";
        String sqlNoVoucher = " INSERT INTO \"Booking\" (\n"
                + "    \"BookingID\", \n"
                + "    \"BookingDate\", \n"
                + "    \"StartDate\", \n"
                + "    \"EndDate\", \n"
                + "    \"StatusBooking\", \n"
                + "    \"DeliveryLocation\", \n"
                + "    \"ReturnedLocation\", \n"
                + "    \"DeliveryStatus\", \n"
                + "    \"CustomerID\"\n"
                + ") VALUES"
                + " (?, CAST(? AS timestamp), CAST(? AS timestamp), CAST(? AS timestamp), ?, ?, ?, ?, ?)";
        try {
            if (voucherID == 0) {
                PreparedStatement ps = conn.prepareStatement(sqlNoVoucher);
                ps.setString(1, bookingID);
                ps.setString(2, bookingDate);
                ps.setString(3, startDate);
                ps.setString(4, endDate);
                ps.setString(5, "Chờ xác nhận");
                ps.setString(6, deliveryLocation);
                ps.setString(7, returnedLocation);
                ps.setString(8, "Chưa giao");
                ps.setInt(9, customerID);
                ps.executeUpdate();
            } else {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, bookingID);
                ps.setString(2, bookingDate);
                ps.setString(3, startDate);
                ps.setString(4, endDate);
                ps.setString(5, "Chờ xác nhận");
                ps.setString(6, deliveryLocation);
                ps.setString(7, returnedLocation);
                ps.setString(8, "Chưa giao");
                ps.setInt(9, voucherID);
                ps.setInt(10, customerID);
                ps.executeUpdate();
            }
            
        } catch (SQLException e) {
            System.out.println(e);
            throw new RuntimeException("Lỗi lưu Booking: " + e.getMessage(), e);
        }
    }
    
    public List<Map<String, Object>> getMotorcyclesByBookingID(String bookingID) {
        PreparedStatement stm;
        ResultSet rs;
        List<Map<String, Object>> motorcycleList = new ArrayList<>();
        String sql = "SELECT m.\"Model\", COUNT(m.\"MotorcycleID\") AS \"Quantity\", m.\"Image\", c.\"CategoryName\" "
                + "FROM \"Motorcycle\" m "
                + "JOIN \"Motorcycle Detail\" md ON m.\"MotorcycleID\" = md.\"MotorcycleID\" "
                + "JOIN \"Category\" c ON c.\"CategoryID\" = m.\"CategoryID\" "
                + "WHERE md.\"MotorcycleDetailID\" IN (SELECT \"MotorcycleDetailID\" FROM \"Booking Detail\" WHERE \"BookingID\" = ?) "
                + "GROUP BY m.\"Model\", m.\"Image\", c.\"CategoryName\"";
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, bookingID);
            rs = stm.executeQuery();
            while (rs.next()) {
                Map<String, Object> motorcycleInfo = new HashMap<>();
                motorcycleInfo.put("Model", rs.getString("Model"));
                motorcycleInfo.put("Quantity", rs.getInt("Quantity"));
                motorcycleInfo.put("Image", rs.getString("Image"));
                motorcycleInfo.put("CategoryName", rs.getString("CategoryName"));
                
                motorcycleList.add(motorcycleInfo);
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return motorcycleList;
    }
    
    public Booking getBookingById(String bookingId) {
        PreparedStatement stm;
        ResultSet rs;
        try {
            String sql = "SELECT * FROM \"Booking\" WHERE \"BookingID\" = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, bookingId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                List<BookingDetail> listBookingDetails = BookingDetailDAO.getInstance().getListBookingDetails(rs.getString(1));
                b.setBookingID(rs.getString(1));
                b.setBookingDate(rs.getString(2));
                b.setStartDate(rs.getString(3));
                b.setEndDate(rs.getString(4));
                b.setStatusBooking(rs.getString(5));
                b.setDeliveryLocation(rs.getString(6));
                b.setReturnedLocation(rs.getString(7));
                b.setDeliveryStatus(rs.getString(8));
                b.setVoucherID(rs.getInt(9));
                b.setCustomerID(rs.getInt(10));
                b.setListBookingDetails(listBookingDetails);
                return b;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //all, pending, confirmed, cancelled
    public List<Booking> getBookingWithDetails(String statusBooking, String deliveryStatus, int accountID) {
        PreparedStatement stm;
        ResultSet rs;
        List<Booking> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM \"Booking\"\n"
                + "WHERE \"CustomerID\" = (\n"
                + "	SELECT \"CustomerID\" FROM \"Customer\" WHERE \"AccountID\" = ?)");
        if (!"all".equals(statusBooking)) {
            sql.append(" AND");
            if ("pending".equals(statusBooking)) {
                sql.append(" \"StatusBooking\" = 'Chờ xác nhận'");
            }
            if ("confirmed".equals(statusBooking)) {
                sql.append(" \"StatusBooking\" = 'Đã xác nhận'");
                if (!deliveryStatus.equals("all")) {
                    sql.append(" AND \"DeliveryStatus\" = ");
                    if (deliveryStatus.equals("notDelivered")) {
                        sql.append("'Chưa giao'");
                    }
                    if (deliveryStatus.equals("delivered")) {
                        sql.append("'Đã giao'");
                    }
                    if (deliveryStatus.equals("returned")) {
                        sql.append("'Đã trả'");
                    }
                }
            }
            if ("cancelled".equals(statusBooking)) {
                sql.append(" \"StatusBooking\" = 'Đã hủy'");
            }
        }
        sql.append(" ORDER BY \"BookingDate\" DESC");
        try {
            stm = conn.prepareStatement(sql.toString());
            stm.setInt(1, accountID);
            rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                List<BookingDetail> listBookingDetails = BookingDetailDAO.getInstance().getListBookingDetails(rs.getString(1));
                b.setBookingID(rs.getString(1));
                b.setBookingDate(rs.getString(2));
                b.setStartDate(rs.getString(3));
                b.setEndDate(rs.getString(4));
                b.setStatusBooking(rs.getString(5));
                b.setDeliveryLocation(rs.getString(6));
                b.setReturnedLocation(rs.getString(7));
                b.setDeliveryStatus(rs.getString(8));
                b.setVoucherID(rs.getInt(9));
                b.setCustomerID(rs.getInt(10));
                b.setListBookingDetails(listBookingDetails);
                list.add(b);
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Map<String, Integer> getMotorcycleDetailsByBookingID(String bookingID) {
        PreparedStatement stm;
        ResultSet rs;
        Map<String, Integer> motorcycleDetails = new HashMap<>();
        String sql = "select m.\"Model\", COUNT(m.\"MotorcycleID\") \"Quantity\"\n"
                + "from \"Motorcycle\" m\n"
                + "	JOIN \"Motorcycle Detail\" md\n"
                + "	ON m.\"MotorcycleID\" = md.\"MotorcycleID\"\n"
                + "where md.\"MotorcycleDetailID\" IN (\n"
                + "	select \"MotorcycleDetailID\" from \"Booking Detail\"\n"
                + "	where \"BookingID\" = ?\n"
                + ")\n"
                + "GROUP BY m.\"MotorcycleID\", m.\"Model\"";
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, bookingID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String model = rs.getString("Model");
                int quantity = rs.getInt("Quantity");
                motorcycleDetails.put(model, quantity);
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return motorcycleDetails;
    }
    
    public List<String> getMotorcyclePlatesByBookingID(String bookingID) {
        PreparedStatement stm;
        ResultSet rs;
        List<String> motorcycleDetails = new ArrayList<>();
        String sql = "select m.\"Model\", md.\"LicensePlate\"\n"
                + "from \"Motorcycle\" m\n"
                + "	JOIN \"Motorcycle Detail\" md\n"
                + "	ON m.\"MotorcycleID\" = md.\"MotorcycleID\"\n"
                + "where md.\"MotorcycleDetailID\" IN (\n"
                + "	select \"MotorcycleDetailID\" from \"Booking Detail\"\n"
                + "	where \"BookingID\" = ?\n"
                + ")";
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, bookingID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String model = rs.getString("Model");
                String plate = rs.getString("LicensePlate");
                motorcycleDetails.add(model + " - Biển: " + plate);
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return motorcycleDetails;
    }
    
    public boolean updateBookingStatus(String bookingID, String status) {
        PreparedStatement stm;
        String sql = "UPDATE \"Booking\" SET \"StatusBooking\" = ? WHERE \"BookingID\" = ?";
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, status);
            stm.setString(2, bookingID);
            int rowAffect = stm.executeUpdate();
            if (rowAffect > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean updateDeliveryStatus(String deliveryStatus, String bookingID) {
        PreparedStatement stm;
        String sql = "UPDATE \"Booking\" SET \"DeliveryStatus\" = ? WHERE \"BookingID\" = ?";
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, deliveryStatus);
            stm.setString(2, bookingID);
            
            int rowAffect = stm.executeUpdate();
            if (rowAffect > 0) {
                if ("Đã trả".equals(deliveryStatus)) {
                    makeMotorcyclesStatus(bookingID, "Có sẵn", "Đã trả xe");
                } else if ("Đã giao".equals(deliveryStatus)) {
                    makeMotorcyclesStatus(bookingID, "Đang thuê", "Đã giao xe cho khách");
                }
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    private void makeMotorcyclesStatus(String bookingID, String status, String note) {
        String sqlDetails = "SELECT \"MotorcycleDetailID\" FROM \"Booking Detail\" WHERE \"BookingID\" = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sqlDetails);
            stm.setString(1, bookingID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int motorDetailId = rs.getInt("MotorcycleDetailID");
                String sqlInsert = "INSERT INTO \"Motorcycle Status\" (\"MotorcycleDetailID\", \"StaffID\", \"StatusAction\", \"UpdateDate\", \"Note\") " +
                                   "VALUES (?, 'STAFF00001', ?, CURRENT_DATE, ?)";
                PreparedStatement psInsert = conn.prepareStatement(sqlInsert);
                psInsert.setInt(1, motorDetailId);
                psInsert.setString(2, status);
                psInsert.setString(3, note);
                psInsert.executeUpdate();
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void cancelExpiredPendingBookings(int minutes) {
        String sql = "SELECT \"BookingID\" FROM \"Booking\" "
                   + "WHERE \"StatusBooking\" = N'Chờ thanh toán' "
                   + "  AND DATEDIFF(MINUTE, CAST(\"BookingDate\" AS DATETIME), GETDATE()) >= ?";
        java.util.List<String> expiredBookings = new java.util.ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, minutes);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    expiredBookings.add(rs.getString("BookingID"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        for (String bookingId : expiredBookings) {
            updateBookingStatus(bookingId, "Đã huỷ");
            makeMotorcyclesStatus(bookingId, "Có sẵn", "Đơn hàng quá hạn thanh toán");
            System.out.println("Auto-cancelled expired booking: " + bookingId);
        }
    }
    
    public Booking getLastestBooking(int accountId) {
        PreparedStatement stm;
        ResultSet rs;
        String sql = "SELECT *\n"
                + "FROM \"Booking\"\n"
                + "WHERE \"CustomerID\" = (SELECT \"CustomerID\" FROM \"Customer\" WHERE \"AccountID\" = ?)\n"
                + "ORDER BY \"BookingDate\" DESC LIMIT 1;";
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, accountId);
            rs = stm.executeQuery();
            if (rs.next()) {
                return new Booking(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }
    
    public List<Booking> getAllBookings() {
        PreparedStatement stm;
        ResultSet rs;
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    \"BookingID\",\n"
                + "    TO_CHAR(\"BookingDate\", 'DD-MM-YYYY HH24:MI:SS') AS \"BookingDate\",\n"
                + "    TO_CHAR(\"StartDate\", 'DD-MM-YYYY HH24:MI:SS') AS \"StartDate\",\n"
                + "    TO_CHAR(\"EndDate\", 'DD-MM-YYYY HH24:MI:SS') AS \"EndDate\",\n"
                + "    \"StatusBooking\",\n"
                + "    \"DeliveryLocation\",\n"
                + "    \"ReturnedLocation\",\n"
                + "    \"DeliveryStatus\",\n"
                + "    \"VoucherID\",\n"
                + "    \"CustomerID\"\n"
                + "    FROM \n"
                + "    \"Booking\" where \"StatusBooking\" != 'Đã hủy' ORDER BY \"Booking\".\"BookingDate\" DESC";
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                List<BookingDetail> listBookingDetails = BookingDetailDAO.getInstance().getListBookingDetails(rs.getString(1));
                b.setBookingID(rs.getString(1));
                b.setBookingDate(rs.getString(2));
                b.setStartDate(rs.getString(3));
                b.setEndDate(rs.getString(4));
                b.setStatusBooking(rs.getString(5));
                b.setDeliveryLocation(rs.getString(6));
                b.setReturnedLocation(rs.getString(7));
                b.setDeliveryStatus(rs.getString(8));
                b.setVoucherID(rs.getInt(9));
                b.setCustomerID(rs.getInt(10));
                b.setListBookingDetails(listBookingDetails);
                list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Booking getBookingsByUsername(String username) {
        PreparedStatement stm;
        ResultSet rs;
        
        String sql = "SELECT b.*, c.*, a.* "
                + "FROM \"Booking\" b "
                + "JOIN \"Customer\" c ON b.\"CustomerID\" = c.\"CustomerID\" "
                + "JOIN \"Account\" a ON a.\"AccountID\" = b.\"CustomerID\" "
                + "WHERE a.\"Username\" = ?";
        
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, username);
            rs = stm.executeQuery();
            
            while (rs.next()) {
                Booking booking = new Booking();
                // Lấy thông tin Booking
                booking.setBookingID(rs.getString("BookingID"));
                booking.setBookingDate(rs.getString("BookingDate"));
                booking.setStartDate(rs.getString("StartDate"));
                booking.setEndDate(rs.getString("EndDate"));
                booking.setStatusBooking(rs.getString("StatusBooking"));
                booking.setDeliveryLocation(rs.getString("DeliveryLocation"));
                booking.setReturnedLocation(rs.getString("ReturnedLocation"));
                booking.setDeliveryStatus(rs.getString("DeliveryStatus"));
                booking.setVoucherID(rs.getInt("VoucherID"));
                Customer customer = CustomerDAO.getInstance().getCustomerbyAccountID(rs.getInt("CustomerID"));
                Account account = AccountDAO.getInstance().getAccountbyID(customer.getAccountId());
                customer.setAccountId(account.getAccountId());
                booking.setCustomerID(customer.getCustomerId());
                
                return booking;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public List<Booking> searchBookingbyBookingId(String bookingId) {
        PreparedStatement stm;
        ResultSet rs;
        List<Booking> list = new ArrayList<>();
        String sql = "Select * from \"Booking\" where \"BookingID\" LIKE ?";
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + bookingId + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingID(rs.getString(1));
                b.setBookingDate(rs.getString(2));
                b.setStartDate(rs.getString(3));
                b.setEndDate(rs.getString(4));
                b.setStatusBooking(rs.getString(5));
                b.setDeliveryLocation(rs.getString(6));
                b.setReturnedLocation(rs.getString(7));
                b.setDeliveryStatus(rs.getString(8));
                b.setVoucherID(rs.getInt(9));
                b.setCustomerID(rs.getInt(10));
                list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    /**
     * Tự động đổi DeliveryStatus → "Quá hạn" cho tất cả booking đã quá ngày trả
     * mà khách vẫn đang giữ xe (DeliveryStatus = 'Đã giao').
     * Trả về danh sách bookingID bị đổi trạng thái (để scheduler gửi email).
     */
    public List<String> markOverdueBookings() {
        List<String> overdueIds = new ArrayList<>();
        // Lấy các booking đang thuê nhưng đã qua EndDate (hoặc NewEndDate nếu đã gia hạn)
        String sqlSelect = "SELECT b.\"BookingID\" FROM \"Booking\" b "
                + "LEFT JOIN \"Extension\" e ON b.\"BookingID\" = e.\"BookingID\" "
                + "WHERE b.\"DeliveryStatus\" = 'Đã giao' "
                + "AND b.\"StatusBooking\" = 'Đã xác nhận' "
                + "AND COALESCE(e.\"NewEndDate\", b.\"EndDate\") < NOW()";
        try {
            PreparedStatement ps = conn.prepareStatement(sqlSelect);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                overdueIds.add(rs.getString("BookingID"));
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return overdueIds;
        }

        // Đổi DeliveryStatus thành "Quá hạn" cho từng booking
        if (!overdueIds.isEmpty()) {
            String sqlUpdate = "UPDATE \"Booking\" SET \"DeliveryStatus\" = 'Quá hạn' "
                    + "WHERE \"BookingID\" = ?";
            try {
                PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate);
                for (String bid : overdueIds) {
                    psUpdate.setString(1, bid);
                    psUpdate.addBatch();
                }
                psUpdate.executeBatch();
                psUpdate.close();
            } catch (SQLException ex) {
                Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return overdueIds;
    }

    /**
     * Tính số ngày quá hạn và phí phạt cho một booking.
     * Phí phạt = số ngày trễ × (tổng tiền / số ngày thuê) × 1.5
     * Trả về mảng [overdueDays, lateFee].
     */
    public double[] getOverdueDaysAndLateFee(String bookingID) {
        String sql = "SELECT "
                + "CEIL(EXTRACT(EPOCH FROM (NOW() - COALESCE(e.\"NewEndDate\", b.\"EndDate\"))) / 86400) AS overdue_days, "
                + "b.\"EndDate\", "
                + "COALESCE(e.\"NewEndDate\", b.\"EndDate\") AS effective_end_date, "
                + "b.\"StartDate\" "
                + "FROM \"Booking\" b "
                + "LEFT JOIN \"Extension\" e ON b.\"BookingID\" = e.\"BookingID\" "
                + "WHERE b.\"BookingID\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, bookingID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int overdueDays = Math.max(0, rs.getInt("overdue_days"));

                // Tính tổng tiền thuê từ BookingDetail
                double totalRentalFee = 0;
                String sqlTotal = "SELECT SUM(\"TotalPrice\") FROM \"Booking Detail\" WHERE \"BookingID\" = ?";
                PreparedStatement psTotal = conn.prepareStatement(sqlTotal);
                psTotal.setString(1, bookingID);
                ResultSet rsTotal = psTotal.executeQuery();
                if (rsTotal.next()) {
                    totalRentalFee = rsTotal.getDouble(1);
                }
                rsTotal.close();
                psTotal.close();

                // Tính số ngày thuê gốc để ra giá ngày
                java.sql.Timestamp startTs = rs.getTimestamp("StartDate");
                java.sql.Timestamp endTs = rs.getTimestamp("effective_end_date");
                int rentalDays = 1;
                if (startTs != null && endTs != null) {
                    long diffMs = endTs.getTime() - startTs.getTime();
                    rentalDays = Math.max(1, (int) Math.ceil(diffMs / (1000.0 * 60 * 60 * 24)));
                }

                double dailyRate = totalRentalFee / rentalDays;
                double lateFee = overdueDays * dailyRate * 1.5;

                rs.close();
                ps.close();
                return new double[]{overdueDays, Math.round(lateFee)};
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new double[]{0, 0};
    }

    /**
     * Staff xác nhận khách đã trả xe: set DeliveryStatus = 'Đã trả', ghi ActualReturnDate = NOW().
     */
    public boolean confirmReturn(String bookingID) {
        // Tự tạo cột ActualReturnDate nếu chưa có (safe migration)
        try {
            conn.createStatement().execute(
                "ALTER TABLE \"Booking\" ADD COLUMN IF NOT EXISTS \"ActualReturnDate\" TIMESTAMP"
            );
        } catch (Exception ignored) {}

        String sql = "UPDATE \"Booking\" SET \"DeliveryStatus\" = 'Đã trả', "
                + "\"ActualReturnDate\" = NOW() "
                + "WHERE \"BookingID\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, bookingID);
            int rows = ps.executeUpdate();
            ps.close();
            if (rows > 0) {
                makeMotorcyclesStatus(bookingID, "Có sẵn", "Đã trả xe - Xác nhận bởi Staff");
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
        BookingDAO bookingDAO = BookingDAO.getInstance();
//        System.out.println(bookingDAO.getMotorcycleDetailsByBookingID("BOOK000006"));
//        System.out.println(bookingDAO.updateBookingStatus("BOOK000006", "Đã hủy"));
//        System.out.println(bookingDAO.getLastestBooking(10));
//        System.out.println(bookingDAO.getAllBookings());
//        System.out.println(bookingDAO.getBookingsByUsername("minhtuns2311"));
        System.out.println(bookingDAO.searchBookingbyBookingId("BOOK000004"));
    }

    /**
     * Lấy BookingID gần nhất của khách đã thuê và đã trả xe đó
     * Dùng để kiểm tra xem khách có quyền viết feedback không
     */
    public String getCompletedBookingIdForMotorcycle(int accountId, String motorcycleId) {
        String sql = "SELECT b.\"BookingID\" FROM \"Booking\" b " +
                     "JOIN \"Customer\" c ON b.\"CustomerID\" = c.\"CustomerID\" " +
                     "JOIN \"Booking Detail\" bd ON b.\"BookingID\" = bd.\"BookingID\" " +
                     "JOIN \"MotorcycleDetail\" md ON bd.\"MotorcycleDetailID\" = md.\"MotorcycleDetailID\" " +
                     "LEFT JOIN \"Feedback\" f ON f.\"BookingID\" = b.\"BookingID\" " +
                     "WHERE c.\"AccountID\" = ? AND md.\"MotorcycleID\" = ? " +
                     "AND b.\"StatusBooking\" = N'Đã xác nhận' AND b.\"DeliveryStatus\" = N'Đã trả' " +
                     "AND f.\"FeedbackID\" IS NULL " +
                     "ORDER BY b.\"BookingDate\" DESC LIMIT 1";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.setString(2, motorcycleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("BookingID");
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}


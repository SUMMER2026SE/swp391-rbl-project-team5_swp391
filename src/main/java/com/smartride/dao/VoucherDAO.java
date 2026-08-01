package com.smartride.dao;

import com.smartride.dto.Voucher;
import com.smartride.util.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VoucherDAO implements Serializable {

    private static VoucherDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private VoucherDAO() {}

    public static VoucherDAO getInstance() {
        if (instance == null) {
            instance = new VoucherDAO();
        }
        return instance;
    }

    /**
     * Get a valid (active) voucher by code.
     * If customerID > 0, also checks that the voucher belongs to that customer OR is a general voucher (customerID=0).
     */
    public Voucher getVoucherByCode(String code, int customerId) {
        String sql = "SELECT \"VoucherID\", \"Code\", \"DiscountAmount\", \"Description\", \"CreatedTime\", \"Status\" "
                   + "FROM \"Voucher\" "
                   + "WHERE \"Code\" = ? AND \"Status\" = 'Đang hoạt động'";
        try (Connection c = DBUtil.makeConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Voucher v = new Voucher();
                    v.setVoucherId(rs.getInt("VoucherID"));
                    v.setCode(rs.getString("Code"));
                    v.setDiscountAmount(rs.getDouble("DiscountAmount"));
                    v.setDescription(rs.getString("Description"));
                    v.setCreatedTime(rs.getString("CreatedTime"));
                    v.setStatus(rs.getString("Status"));
                    return v;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Voucher getVoucherById(int voucherId) {
        String sql = "SELECT \"VoucherID\", \"Code\", \"DiscountAmount\", \"Description\", \"CreatedTime\", \"Status\", \"UsageLimit\", \"UsedCount\", \"MaxUsagePerCustomer\" "
                   + "FROM \"Voucher\" "
                   + "WHERE \"VoucherID\" = ?";
        try (Connection c = DBUtil.makeConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Voucher v = new Voucher();
                    v.setVoucherId(rs.getInt("VoucherID"));
                    v.setCode(rs.getString("Code"));
                    v.setDiscountAmount(rs.getDouble("DiscountAmount"));
                    v.setDescription(rs.getString("Description"));
                    v.setCreatedTime(rs.getString("CreatedTime"));
                    v.setStatus(rs.getString("Status"));
                    // Using default 0 for optional fields if not fetched
                    return v;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Check if a voucher is currently valid (active) by its ID.
     */
    public boolean isValidVoucher(int voucherId) {
        String sql = "SELECT \"VoucherID\" FROM \"Voucher\" WHERE \"VoucherID\" = ? AND \"Status\" = 'Đang hoạt động'";
        try (Connection c = DBUtil.makeConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Mark a voucher as used after booking is confirmed.
     */
    public void markVoucherUsed(int voucherId) {
        String sql = "UPDATE \"Voucher\" SET \"Status\" = 'Ngừng hoạt động' WHERE \"VoucherID\" = ?";
        try (Connection c = DBUtil.makeConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Get all vouchers for a specific customer (for display).
     */
    public java.util.List<Voucher> getVouchersByCustomerId(int customerId) {
        java.util.List<Voucher> list = new java.util.ArrayList<>();
        String sql = "SELECT \"VoucherID\", \"Code\", \"DiscountAmount\", \"Description\", \"CreatedTime\", \"Status\" "
                   + "FROM \"Voucher\" ORDER BY \"CreatedTime\" DESC";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Voucher v = new Voucher();
                v.setVoucherId(rs.getInt("VoucherID"));
                v.setCode(rs.getString("Code"));
                v.setDiscountAmount(rs.getDouble("DiscountAmount"));
                v.setDescription(rs.getString("Description"));
                v.setCreatedTime(rs.getString("CreatedTime"));
                v.setStatus(rs.getString("Status"));
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy toàn bộ danh sách voucher (dành cho Admin)
     */
    public java.util.List<Voucher> getAllVouchers() {
        java.util.List<Voucher> list = new java.util.ArrayList<>();
        String sql = "SELECT \"VoucherID\", \"Code\", \"DiscountAmount\", \"Description\", \"CreatedTime\", \"Status\" "
                   + "FROM \"Voucher\" ORDER BY \"CreatedTime\" DESC";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Voucher v = new Voucher();
                v.setVoucherId(rs.getInt("VoucherID"));
                v.setCode(rs.getString("Code"));
                v.setDiscountAmount(rs.getDouble("DiscountAmount"));
                v.setDescription(rs.getString("Description"));
                v.setCreatedTime(rs.getString("CreatedTime"));
                v.setStatus(rs.getString("Status"));
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Thêm Voucher mới
     */
    public boolean insertVoucher(Voucher v) {
        String sql = "INSERT INTO \"Voucher\" (\"Code\", \"DiscountAmount\", \"Description\", \"Status\") VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, v.getCode());
            ps.setDouble(2, v.getDiscountAmount());
            ps.setString(3, v.getDescription());
            ps.setString(4, v.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật Voucher
     */
    public boolean updateVoucher(Voucher v) {
        String sql = "UPDATE \"Voucher\" SET \"Code\" = ?, \"DiscountAmount\" = ?, \"Description\" = ?, \"Status\" = ? WHERE \"VoucherID\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, v.getCode());
            ps.setDouble(2, v.getDiscountAmount());
            ps.setString(3, v.getDescription());
            ps.setString(4, v.getStatus());
            ps.setInt(5, v.getVoucherId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa Voucher
     */
    public boolean deleteVoucher(int voucherId) {
        String sql = "DELETE FROM \"Voucher\" WHERE \"VoucherID\" = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, voucherId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Create a personal voucher for a specific customer (late delivery compensation)
    public boolean createPersonalVoucher(String code, int accountId, double discountAmount, String description) {
        String sql = "INSERT INTO \"Voucher\" (\"Code\", \"DiscountAmount\", \"Description\", \"Status\", \"account_id\", \"max_uses\", \"used_count\") VALUES (?, ?, ?, 'Đang hoạt động', ?, 1, 0)";
        try (Connection c = DBUtil.makeConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setDouble(2, discountAmount);
            ps.setString(3, description);
            ps.setInt(4, accountId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check if a voucher code belongs to a specific account (for personal vouchers)
    public boolean hasMilestoneVoucher(int accountId, String tierCodePrefix) {
        String sql = "SELECT 1 FROM \"Voucher\" WHERE \"account_id\" = ? AND \"Code\" LIKE ?";
        try (Connection c = DBUtil.makeConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.setString(2, tierCodePrefix + "%");
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isVoucherOwnedByAccount(String code, int accountId) {
        String sql = "SELECT 1 FROM \"Voucher\" WHERE \"Code\" = ? AND (\"account_id\" = ? OR \"account_id\" IS NULL) AND \"Status\" = 'Đang hoạt động'";
        try (Connection c = DBUtil.makeConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setInt(2, accountId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public java.util.List<Voucher> getAvailableVouchersForAccount(int accountId) {
        java.util.List<Voucher> list = new java.util.ArrayList<>();
        String sql = "SELECT \"VoucherID\", \"Code\", \"DiscountAmount\", \"Description\", \"CreatedTime\", \"Status\" "
                   + "FROM \"Voucher\" "
                   + "WHERE (\"account_id\" = ? OR \"account_id\" IS NULL) "
                   + "AND \"Status\" = 'Đang hoạt động' "
                   + "AND (\"max_uses\" IS NULL OR \"used_count\" IS NULL OR \"used_count\" < \"max_uses\") "
                   + "ORDER BY \"CreatedTime\" DESC";
        try (Connection c = DBUtil.makeConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Voucher v = new Voucher();
                v.setVoucherId(rs.getInt("VoucherID"));
                v.setCode(rs.getString("Code"));
                v.setDiscountAmount(rs.getDouble("DiscountAmount"));
                v.setDescription(rs.getString("Description"));
                v.setCreatedTime(rs.getString("CreatedTime"));
                v.setStatus(rs.getString("Status"));
                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

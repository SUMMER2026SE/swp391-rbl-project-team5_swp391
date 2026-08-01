import java.sql.*;

public class CheckBookingPrice {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
        String user = "postgres.zfvgigfjmbtgwgirdify";
        String pass = "Bimdiendie1@";
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            System.out.println("--- Sirius Price ---");
            PreparedStatement ps = conn.prepareStatement("SELECT p.\"DailyPriceForDay\", p.\"DailyPriceForWeek\", p.\"DailyPriceForMonth\" FROM \"Motorcycle Detail\" md JOIN \"Motorcycle\" m ON md.\"MotorcycleID\" = m.\"MotorcycleID\" JOIN \"PriceList\" p ON m.\"PriceListID\" = p.\"PriceListID\" WHERE \"MotorcycleDetailID\" = (SELECT \"MotorcycleDetailID\" FROM \"Booking Detail\" WHERE \"BookingID\" = 'BK82033928')");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("DailyPriceForDay: " + rs.getBigDecimal("DailyPriceForDay"));
                System.out.println("DailyPriceForWeek: " + rs.getBigDecimal("DailyPriceForWeek"));
                System.out.println("DailyPriceForMonth: " + rs.getBigDecimal("DailyPriceForMonth"));
            }
            
            System.out.println("--- Promo ---");
            ps = conn.prepareStatement("SELECT \"VoucherID\" FROM \"Booking\" WHERE \"BookingID\" = 'BK82033928'");
            rs = ps.executeQuery();
            if (rs.next()) {
                String promo = rs.getString("VoucherID");
                System.out.println("Voucher ID: " + promo);
                if (promo != null && !promo.isEmpty()) {
                    PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM \"Promotion\" WHERE \"PromotionID\" = ?");
                    ps2.setInt(1, Integer.parseInt(promo));
                    ResultSet rs2 = ps2.executeQuery();
                    if(rs2.next()) {
                        System.out.println("DiscountAmount: " + rs2.getBigDecimal("DiscountAmount"));
                        System.out.println("DiscountPercentage: " + rs2.getBigDecimal("DiscountPercentage"));
                        System.out.println("MaximumDiscount: " + rs2.getBigDecimal("MaximumDiscount"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

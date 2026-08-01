import java.sql.*;

public class CheckBookingDates {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
        String user = "postgres.zfvgigfjmbtgwgirdify";
        String pass = "Bimdiendie1@";
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            System.out.println("--- Booking BK82033928 ---");
            PreparedStatement ps = conn.prepareStatement("SELECT \"StartDate\", \"EndDate\", \"DeliveryLocation\", \"ReturnedLocation\" FROM \"Booking\" WHERE \"BookingID\" = 'BK82033928'");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Start: " + rs.getTimestamp("StartDate"));
                System.out.println("End: " + rs.getTimestamp("EndDate"));
                System.out.println("Delivery: " + rs.getString("DeliveryLocation"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

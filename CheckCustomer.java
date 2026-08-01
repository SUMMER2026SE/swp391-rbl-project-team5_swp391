import java.sql.*;

public class CheckCustomer {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres";
        String user = "postgres.jovkcmymnhxowgoybclb";
        String pass = "Lequangminh2005";

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            String query = "SELECT c.\"IdentityCardImage\", b.\"AccountID\" FROM \"Booking\" b " +
                           "JOIN \"Customer\" c ON b.\"AccountID\" = c.\"AccountID\" " +
                           "WHERE b.\"BookingID\" = 'BK82033928'";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {
                if (rs.next()) {
                    System.out.println("IdentityCardImage: " + rs.getString("IdentityCardImage"));
                    System.out.println("AccountID: " + rs.getInt("AccountID"));
                } else {
                    System.out.println("Booking not found or Customer not found.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

import java.sql.*;

public class CheckCustomer {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
        String user = "postgres.zfvgigfjmbtgwgirdify";
        String pass = "Bimdiendie1@";

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return;
        }

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            String query = "SELECT c.\"IdentityCardImage\", c.\"CustomerID\" FROM \"Booking\" b " +
                           "JOIN \"Customer\" c ON b.\"CustomerID\" = c.\"CustomerID\" " +
                           "WHERE b.\"BookingID\" = 'BK82033928'";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {
                if (rs.next()) {
                    System.out.println("IdentityCardImage: " + rs.getString("IdentityCardImage"));
                    System.out.println("CustomerID: " + rs.getInt("CustomerID"));
                } else {
                    System.out.println("Booking not found or Customer not found.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

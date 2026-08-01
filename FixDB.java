import java.sql.*;

public class FixDB {
    public static void main(String[] args) throws Exception {
        Class.forName("org.postgresql.Driver");
        try (Connection c = DriverManager.getConnection(
                "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require",
                "postgres.zfvgigfjmbtgwgirdify", "Bimdiendie1@");
             Statement s = c.createStatement()) {

            System.out.println("Restoring Booking Detail...");
            s.executeUpdate("UPDATE \"Booking Detail\" SET \"TotalPrice\" = 127000 WHERE \"BookingID\" = 'BK82033928'");

            System.out.println("Done!");
        }
    }
}

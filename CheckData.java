import java.sql.*;

public class CheckData {
    public static void main(String[] args) throws Exception {
        String connectionString = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
        String user = "postgres.zfvgigfjmbtgwgirdify";
        String pass = "Bimdiendie1@";
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(connectionString, user, pass);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT \"DeliveryLocation\", \"ReturnedLocation\" FROM \"Booking\" WHERE \"BookingID\" = 'BKTEST0010'");
        if (rs.next()) {
            System.out.println("DL: " + rs.getString(1));
            System.out.println("RL: " + rs.getString(2));
        }
    }
}

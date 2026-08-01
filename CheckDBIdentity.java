import java.sql.*;

public class CheckDBIdentity {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
        String user = "postgres.zfvgigfjmbtgwgirdify";
        String pass = "Bimdiendie1@";
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            System.out.println("--- Customer ID Image ---");
            PreparedStatement ps = conn.prepareStatement("SELECT a.\"Username\", c.\"IdentityCardImage\" FROM \"Customer\" c JOIN \"Account\" a ON c.\"CustomerID\" = a.\"AccountID\"");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString("Username") + " : " + rs.getString("IdentityCardImage"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

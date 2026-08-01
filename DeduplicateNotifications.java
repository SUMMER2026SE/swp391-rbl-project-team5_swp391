import java.sql.*;

public class DeduplicateNotifications {
    public static void main(String[] args) throws Exception {
        String connectionString = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
        String user = "postgres.zfvgigfjmbtgwgirdify";
        String pass = "Bimdiendie1@";
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(connectionString, user, pass);
        
        String sql = "DELETE FROM \"Notification\" WHERE \"notification_id\" NOT IN (SELECT MIN(\"notification_id\") FROM \"Notification\" GROUP BY \"account_id\", \"message\")";
        Statement stmt = conn.createStatement();
        int rowsDeleted = stmt.executeUpdate(sql);
        System.out.println("Deleted " + rowsDeleted + " duplicate notifications.");
    }
}

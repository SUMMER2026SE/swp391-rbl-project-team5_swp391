import java.sql.*;

public class CheckConstraint {
    public static void main(String[] args) throws Exception {
        String connectionString = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
        String user = "postgres.zfvgigfjmbtgwgirdify";
        String pass = "Bimdiendie1@";

        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(connectionString, user, pass);
        Statement stmt = conn.createStatement();
        
        try {
            stmt.executeUpdate("ALTER TABLE \"Booking\" DROP CONSTRAINT \"Booking_DeliveryStatus_check\"");
            System.out.println("Dropped constraint");
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        try {
            stmt.executeUpdate("ALTER TABLE \"Booking\" ADD CONSTRAINT \"Booking_DeliveryStatus_check\" CHECK ((\"DeliveryStatus\")::text = ANY ((ARRAY['Chưa giao'::character varying, 'Đã giao'::character varying, 'Đã trả'::character varying, 'Quá hạn'::character varying])::text[]))");
            System.out.println("Added constraint");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}

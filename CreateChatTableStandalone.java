import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class CreateChatTableStandalone {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require";
        String user = "postgres.zfvgigfjmbtgwgirdify";
        String pass = "Bimdiendie1@";
        
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            String sql = "CREATE TABLE IF NOT EXISTS \"Chat_Message\" (\n" +
                         "    \"MessageID\" SERIAL PRIMARY KEY,\n" +
                         "    \"BookingID\" VARCHAR(20) REFERENCES \"Booking\"(\"BookingID\"),\n" +
                         "    \"SenderID\" INT REFERENCES \"Account\"(\"AccountID\"),\n" +
                         "    \"SenderRole\" VARCHAR(20),\n" +
                         "    \"Message\" TEXT NOT NULL,\n" +
                         "    \"SentAt\" TIMESTAMP DEFAULT CURRENT_TIMESTAMP\n" +
                         ");";
            try (Statement stmt = conn.createStatement()) {
                stmt.execute(sql);
                System.out.println("Table Chat_Message created successfully.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

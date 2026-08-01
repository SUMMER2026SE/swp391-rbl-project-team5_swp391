import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class TestHTTP {
    public static void main(String[] args) throws Exception {
        URL url = new URL("http://localhost:8080/MotorcyleHiringProject/bookingHistoryDetail?bookingId=BKTEST0010");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("Cookie", "JSESSIONID=C3848FFF33F94F1471520828FB13E267"); // Using the cookie from curl earlier
        int responseCode = conn.getResponseCode();
        System.out.println("Response Code: " + responseCode);
        
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            int count = 0;
            while ((inputLine = in.readLine()) != null) {
                System.out.println(inputLine);
                count++;
                if (count > 200) { System.out.println("...truncated..."); break; }
            }
            in.close();
        } catch (Exception e) {
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                System.out.println(inputLine);
            }
            in.close();
        }
    }
}

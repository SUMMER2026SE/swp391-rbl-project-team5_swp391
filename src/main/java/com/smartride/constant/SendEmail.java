package com.smartride.constant;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Random;

public class SendEmail {
    private static final String BREVO_API_KEY = "xkeysib-" + "479690fc3a22baf522c58e1d487d5b3b36e6f9da1a6fe629c8a574d29014752f-" + "fvuMDJHxLnjgQZOl";
    private static final String SENDER_EMAIL = "lequangminhqwer@gmail.com";
    private static final String SENDER_NAME = "SmartRide System";

    public static String generateRandomSixDigits() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    public static void sendVerificationEmail(String to, String emailContent) {
        new Thread(() -> {
            try {
                // Escape JSON string for htmlContent
                String escapedContent = emailContent.replace("\"", "\\\"").replace("\n", "").replace("\r", "");
                
                String subject = "Thông báo từ SmartRide";
                if (emailContent.contains("Mã OTP")) subject = "Mã OTP xác thực tài khoản SmartRide";
                if (emailContent.contains("Đặt lại mật khẩu")) subject = "Yêu cầu đặt lại mật khẩu SmartRide";
                
                String jsonPayload = "{"
                    + "\"sender\":{\"name\":\"" + SENDER_NAME + "\",\"email\":\"" + SENDER_EMAIL + "\"},"
                    + "\"to\":[{\"email\":\"" + to + "\"}],"
                    + "\"subject\":\"" + subject + "\","
                    + "\"htmlContent\":\"" + escapedContent + "\""
                    + "}";

                HttpClient client = HttpClient.newHttpClient();
                HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://api.brevo.com/v3/smtp/email"))
                    .header("accept", "application/json")
                    .header("api-key", BREVO_API_KEY)
                    .header("content-type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
                    .build();

                HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
                
                if (response.statusCode() == 201 || response.statusCode() == 200) {
                    System.out.println("[SendEmail] Gửi mail thành công tới: " + to);
                } else {
                    System.out.println("[SendEmail ERROR] Lỗi API: " + response.statusCode());
                    System.out.println("[SendEmail ERROR] Body: " + response.body());
                }
            } catch (Exception e) {
                System.out.println("[SendEmail ERROR] Lỗi gửi mail qua API tới: " + to);
                System.out.println("[SendEmail ERROR] Exception: " + e.getClass().getName() + " - " + e.getMessage());
                e.printStackTrace();
            }
        }).start();
    }
}
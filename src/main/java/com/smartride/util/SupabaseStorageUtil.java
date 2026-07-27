package com.smartride.util;

import com.smartride.constant.IConstant;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class SupabaseStorageUtil {

    private static final String STORAGE_URL = IConstant.SUPABASE_URL + "/storage/v1/object/";

    /**
     * Tải file lên Supabase Storage (Bucket public)
     * 
     * @param bucket Tên bucket (VD: "motor-images")
     * @param fileName Tên file (VD: "booking-123.png")
     * @param fileStream Luồng dữ liệu của file
     * @param contentType Loại nội dung (VD: "image/jpeg", "image/png")
     * @return URL public của file sau khi tải lên thành công, hoặc null nếu lỗi
     */
    public static String uploadFile(String bucket, String fileName, InputStream fileStream, String contentType) {
        try {
            // URL API endpoint
            URL url = new URL(STORAGE_URL + bucket + "/" + fileName);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            // Thiết lập method POST
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            // Set Headers
            conn.setRequestProperty("Authorization", "Bearer " + IConstant.SUPABASE_SERVICE_ROLE_KEY);
            conn.setRequestProperty("Content-Type", contentType);
            conn.setRequestProperty("x-upsert", "true");
            
            // Copy InputStream từ file sang OutputStream của Request
            try (OutputStream os = conn.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fileStream.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
            }
            
            // Lấy kết quả phản hồi
            int responseCode = conn.getResponseCode();
            if (responseCode == 200 || responseCode == 201) {
                // Nếu thành công, trả về link public
                return IConstant.SUPABASE_URL + "/storage/v1/object/public/" + bucket + "/" + fileName;
            } else {
                System.out.println("Lỗi upload file lên Supabase. Mã lỗi: " + responseCode);
                // Đọc response error
                try (InputStream errorStream = conn.getErrorStream()) {
                    if (errorStream != null) {
                        byte[] errorBuffer = new byte[1024];
                        int read = errorStream.read(errorBuffer);
                        if(read > 0) {
                            System.out.println("Chi tiết lỗi: " + new String(errorBuffer, 0, read));
                        }
                    }
                }
                return null;
            }
            
        } catch (Exception e) {
            System.out.println("Exception khi upload file lên Supabase: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Xóa file khỏi Supabase Storage
     * 
     * @param fileUrl URL public của file cần xóa, hoặc tên file
     * @return true nếu xóa thành công, false nếu lỗi
     */
    public static boolean deleteFile(String fileUrl) {
        if (fileUrl == null || fileUrl.trim().isEmpty()) return false;
        
        try {
            // Lấy tên file từ URL (nếu là URL)
            String fileName = fileUrl;
            if (fileUrl.contains("/")) {
                fileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
            }
            
            // Mặc định xóa từ bucket "motor-images" (điều chỉnh nếu có nhiều bucket)
            String bucket = "motor-images";
            
            URL url = new URL(STORAGE_URL + bucket + "/" + fileName);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            conn.setRequestMethod("DELETE");
            conn.setRequestProperty("Authorization", "Bearer " + IConstant.SUPABASE_SERVICE_ROLE_KEY);
            
            int responseCode = conn.getResponseCode();
            return (responseCode == 200 || responseCode == 204);
            
        } catch (Exception e) {
            System.out.println("Exception khi xóa file trên Supabase: " + e.getMessage());
            return false;
        }
    }
}

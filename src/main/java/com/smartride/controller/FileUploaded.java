package com.smartride.controller;

import jakarta.servlet.http.Part;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileUploaded {
    // Keep constructors for compatibility
    public FileUploaded(String uploadPath) {
    }

    public String handleFileUpload(Part part, String fileName) throws IOException {
        return handleFileUpload(part, fileName, "motor-images");
    }

    public String handleFileUpload(Part part, String fileName, String bucketName) throws IOException {
        String originalFileName = getFileName(part);
        if (originalFileName != null && !originalFileName.isEmpty()) {
            // Upload to Supabase and return the public URL
            String publicUrl = com.smartride.util.SupabaseStorageUtil.uploadFile(bucketName, fileName, part.getInputStream(), part.getContentType());
            return publicUrl;
        }
        return null;
    }

    public String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String cd : contentDisposition.split(";")) {
                if (cd.trim().startsWith("filename")) {
                    return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                }
            }
        }
        return null;
    }

    public String generateNewFileName(String originalFileName) {
        String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String fileExtension = "";
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = originalFileName.substring(dotIndex);
        }
        return originalFileName.substring(0, dotIndex) + "_" + timestamp + fileExtension;
    }
}
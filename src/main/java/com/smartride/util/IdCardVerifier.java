package com.smartride.util;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;

/**
 * Utility gọi FPT.AI Vision API để OCR ảnh CCCD/CMND.
 * Dùng chung cho BookingInforHander và VerifyIdCardServlet.
 *
 * Cấu hình: đặt FPT_API_KEY từ https://console.fpt.ai/
 */
public class IdCardVerifier {

    public static final String FPT_API_KEY = "6wNP06jo9FT0N0rihPRgR0GgHAkw5jdQ";
    private static final String FPT_API_URL = "https://api.fpt.ai/vision/idr/vnm/";

    /**
     * Kết quả xác thực CCCD.
     */
    public static class VerifyResult {
        public boolean configured;   // API key đã được cấu hình chưa
        public boolean success;      // Gọi API thành công không
        public boolean idMatch;      // Số CCCD khớp không
        public boolean nameMatch;    // Họ tên khớp không
        public boolean doeValid;     // CCCD còn hạn không
        public boolean valid;        // idMatch && nameMatch && doeValid
        public String ocrId;
        public String ocrName;
        public String ocrDob;
        public String ocrDoe;
        public String ocrSex;
        public String type;
        public String errorMsg;      // Thông báo tổng quát
        public java.util.List<String> fieldErrors = new java.util.ArrayList<>(); // Lỗi chi tiết từng trường
    }

    /**
     * Xác thực từ đường dẫn file ảnh (local path hoặc URL).
     *
     * @param imagePath  đường dẫn ảnh (local path tương đối với webroot/upload, hoặc http URL)
     * @param webRootPath  đường dẫn webroot thực (getServletContext().getRealPath("/"))
     * @param storedId   số CCCD lưu trong DB
     * @param storedName tên đầy đủ lưu trong DB
     */
    public static VerifyResult verify(String imagePath, String webRootPath,
                                      String storedId, String storedName) {
        VerifyResult r = new VerifyResult();

        if ("YOUR_FPT_API_KEY_HERE".equals(FPT_API_KEY) || FPT_API_KEY == null || FPT_API_KEY.isBlank()) {
            r.configured = false;
            r.success    = false;
            r.valid      = false;
            r.errorMsg   = "Chưa cấu hình FPT.AI API Key";
            return r;
        }
        r.configured = true;

        if (imagePath == null || imagePath.trim().isEmpty()) {
            r.success  = false;
            r.valid    = false;
            r.errorMsg = "Không có ảnh CCCD";
            return r;
        }

        // Resolve file
        File imageFile;
        try {
            if (imagePath.trim().startsWith("http")) {
                imageFile = downloadFromUrl(imagePath.trim());
            } else {
                // local file under /upload/
                String path = imagePath.trim();
                imageFile = new File(webRootPath, "upload" + File.separator + path);
                if (!imageFile.exists()) {
                    // thử không có prefix upload/
                    imageFile = new File(webRootPath, path);
                }
            }
        } catch (Exception e) {
            r.success  = false;
            r.valid    = false;
            r.errorMsg = "Lỗi tải file ảnh: " + e.getMessage();
            return r;
        }

        if (imageFile == null || !imageFile.exists()) {
            r.success  = false;
            r.valid    = false;
            r.errorMsg = "Không tìm thấy file ảnh: " + imagePath;
            return r;
        }

        // Gọi FPT.AI
        String fptJson = callFptApi(imageFile);
        if (fptJson == null) {
            r.success  = false;
            r.valid    = false;
            r.errorMsg = "Lỗi kết nối FPT.AI API";
            return r;
        }

        // Parse kết quả
        r.success = true;
        int errorCode = extractInt(fptJson, "\"errorCode\"");
        if (errorCode != 0) {
            r.success  = false;
            r.valid    = false;
            r.errorMsg = "FPT API lỗi: " + extractString(fptJson, "\"errorMessage\"");
            return r;
        }

        r.ocrId   = extractString(fptJson, "\"id\"");
        r.ocrName = extractString(fptJson, "\"name\"");
        r.ocrDob  = extractString(fptJson, "\"dob\"");
        r.ocrDoe  = extractString(fptJson, "\"doe\"");
        r.ocrSex  = extractString(fptJson, "\"sex\"");
        r.type    = extractString(fptJson, "\"type\"");

        r.idMatch   = storedId   != null && r.ocrId   != null && normalize(storedId).equals(normalize(r.ocrId));
        r.nameMatch = false;
        if (storedName != null && r.ocrName != null) {
            String normDB = normalizeVN(storedName);
            String normOCR = normalizeVN(r.ocrName);
            if (normDB.equalsIgnoreCase(normOCR)) {
                r.nameMatch = true;
            } else {
                // Ignore word order
                String[] dbWords = normDB.split("\\s+");
                String[] ocrWords = normOCR.split("\\s+");
                java.util.Set<String> dbSet = new java.util.HashSet<>(java.util.Arrays.asList(dbWords));
                java.util.Set<String> ocrSet = new java.util.HashSet<>(java.util.Arrays.asList(ocrWords));
                if (dbSet.equals(ocrSet)) {
                    r.nameMatch = true;
                }
            }
        }

        // Kiểm tra ngày hết hạn CCCD (ocrDoe định dạng dd/MM/yyyy hoặc yyyy-MM-dd hoặc ddMMyyyy)
        r.doeValid = true;
        if (r.ocrDoe != null && !r.ocrDoe.equals("N/A") && !r.ocrDoe.isBlank()) {
            try {
                java.time.LocalDate expiry = null;
                String doe = r.ocrDoe.trim();
                // Thử các định dạng phổ biến của FPT.AI
                if (doe.matches("\\d{2}/\\d{2}/\\d{4}")) {
                    expiry = java.time.LocalDate.parse(doe, java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
                } else if (doe.matches("\\d{4}-\\d{2}-\\d{2}")) {
                    expiry = java.time.LocalDate.parse(doe, java.time.format.DateTimeFormatter.ISO_LOCAL_DATE);
                } else if (doe.matches("\\d{8}")) {
                    expiry = java.time.LocalDate.parse(doe, java.time.format.DateTimeFormatter.ofPattern("ddMMyyyy"));
                } else if (doe.matches("\\d{2}-\\d{2}-\\d{4}")) {
                    expiry = java.time.LocalDate.parse(doe, java.time.format.DateTimeFormatter.ofPattern("dd-MM-yyyy"));
                }
                if (expiry != null && expiry.isBefore(java.time.LocalDate.now())) {
                    r.doeValid = false;
                }
            } catch (Exception ignored) { /* không parse được thì bỏ qua */ }
        }

        // Tổng hợp lỗi chi tiết từng trường
        if (!r.idMatch) {
            r.fieldErrors.add("❌ Số CCCD/CMND không khớp: DB lưu [" + (storedId != null ? storedId : "?") + "] – AI đọc được [" + (r.ocrId != null ? r.ocrId : "?") + "]");
        }
        if (!r.nameMatch) {
            r.fieldErrors.add("❌ Họ và tên không khớp: DB lưu [" + (storedName != null ? storedName : "?") + "] – AI đọc được [" + (r.ocrName != null ? r.ocrName : "?") + "]");
        }
        if (!r.doeValid) {
            r.fieldErrors.add("❌ CCCD/CMND đã hết hạn (ngày hết hạn: " + r.ocrDoe + "). Vui lòng cập nhật giấy tờ còn hiệu lực.");
        }

        r.valid = r.idMatch && r.nameMatch && r.doeValid;
        if (!r.valid && r.fieldErrors.isEmpty()) {
            r.fieldErrors.add("❌ Thông tin không khớp với ảnh CCCD/CMND.");
        }
        return r;
    }

    // ─── HTTP multipart ────────────────────────────────────────────────────────

    private static String callFptApi(File imageFile) {
        String boundary = "----FPTBoundary" + System.currentTimeMillis();
        try {
            URL url = new URL(FPT_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("api-key", FPT_API_KEY);
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
            conn.setConnectTimeout(15000);
            conn.setReadTimeout(15000);

            try (DataOutputStream dos = new DataOutputStream(conn.getOutputStream())) {
                dos.writeBytes("--" + boundary + "\r\n");
                dos.writeBytes("Content-Disposition: form-data; name=\"image\"; filename=\""
                        + imageFile.getName() + "\"\r\n");
                dos.writeBytes("Content-Type: image/jpeg\r\n\r\n");
                Files.copy(imageFile.toPath(), dos);
                dos.writeBytes("\r\n--" + boundary + "--\r\n");
                dos.flush();
            }

            int code = conn.getResponseCode();
            InputStream is = (code == 200) ? conn.getInputStream() : conn.getErrorStream();
            if (is == null) return null;
            StringBuilder sb = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) sb.append(line);
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private static File downloadFromUrl(String urlStr) throws Exception {
        URL url = new URL(urlStr);
        File tmp = File.createTempFile("cccd_", ".jpg");
        tmp.deleteOnExit();
        try (InputStream in = url.openStream(); FileOutputStream fos = new FileOutputStream(tmp)) {
            byte[] buf = new byte[4096];
            int n;
            while ((n = in.read(buf)) != -1) fos.write(buf, 0, n);
        }
        return tmp;
    }

    // ─── JSON helpers (no external lib) ────────────────────────────────────────

    private static String extractString(String json, String key) {
        int idx = json.indexOf(key);
        if (idx < 0) return "N/A";
        int colon = json.indexOf(':', idx + key.length());
        if (colon < 0) return "N/A";
        int start = colon + 1;
        while (start < json.length() && (json.charAt(start) == ' ' || json.charAt(start) == '\n'
                || json.charAt(start) == '\r')) start++;
        if (start >= json.length() || json.charAt(start) != '"') return "N/A";
        int end = json.indexOf('"', start + 1);
        return end < 0 ? "N/A" : json.substring(start + 1, end);
    }

    private static int extractInt(String json, String key) {
        int idx = json.indexOf(key);
        if (idx < 0) return -1;
        int colon = json.indexOf(':', idx + key.length());
        if (colon < 0) return -1;
        int start = colon + 1;
        while (start < json.length() && json.charAt(start) == ' ') start++;
        int end = start;
        while (end < json.length() && (Character.isDigit(json.charAt(end)) || json.charAt(end) == '-')) end++;
        try { return Integer.parseInt(json.substring(start, end)); } catch (Exception e) { return -1; }
    }

    // ─── Text normalization ─────────────────────────────────────────────────────

    private static String normalize(String s) {
        return s == null ? "" : s.trim().replaceAll("[^0-9a-zA-Z]", "").toLowerCase();
    }

    private static String normalizeVN(String s) {
        if (s == null) return "";
        return s.trim()
                .replaceAll("[àáâãäåæăắặằẳẵâấậầẩẫ]", "a")
                .replaceAll("[ÀÁÂÃÄÅÆĂẮẶẰẲẴÂẤẬẦẨẪ]", "A")
                .replaceAll("[èéêëêếệềểễ]", "e").replaceAll("[ÈÉÊËÊẾỆỀỂỄ]", "E")
                .replaceAll("[ìíîï]", "i").replaceAll("[ÌÍÎÏ]", "I")
                .replaceAll("[òóôõöøôốộồổỗơớợờởỡ]", "o").replaceAll("[ÒÓÔÕÖØÔỐỘỒỔỖƠỚỢỜỞỠ]", "O")
                .replaceAll("[ùúûüưứựừửữ]", "u").replaceAll("[ÙÚÛÜƯỨỰỪỬỮ]", "U")
                .replaceAll("[ýÿ]", "y").replaceAll("[ÝŸ]", "Y")
                .replaceAll("[đ]", "d").replaceAll("[Đ]", "D")
                .toLowerCase().trim();
    }
}

package com.smartride.controller;

import com.smartride.constant.SendEmail;
import com.smartride.dao.AccessoryDetailDAO;
import com.smartride.dao.AccountDAO;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.BookingDetailDAO;
import com.smartride.dao.CustomerDAO;
import com.smartride.dao.ExtensionDAO;
import com.smartride.dao.MotorcycleDetailDAO;
import com.smartride.dao.MotorcycleStatusDAO;
import com.smartride.dao.PaymentDAO;
import com.smartride.dao.NotificationDAO;
import com.smartride.dto.AccessoryDetail;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@MultipartConfig
@WebServlet(name = "ExtendBookingHandlerServlet", urlPatterns = {"/extendhandler"})
public class ExtendBookingHandlerServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExtendBookingHandlerServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExtendBookingHandlerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    private static final long serialVersionUID = 1L; 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HashMap<String, Object> dataMap = new HashMap<>();
        
        for (Part part : request.getParts()) {
            String fieldName = part.getName();          
            InputStream inputStream = part.getInputStream();
            String value = new BufferedReader(new InputStreamReader(inputStream))
                    .lines().collect(java.util.stream.Collectors.joining("\n"));
            dataMap.put(fieldName, value);
            
        }
        // Convert JSON data to HashMap
        Gson gson = new Gson();
        try {
             Type type = new TypeToken<HashMap<String, Object>>() {}.getType();
             dataMap.putAll(gson.fromJson((String) dataMap.get("jsonData"), type));
        } catch (Exception e) {
             e.printStackTrace();
             response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid JSON format");
             return;
        }
       
        // Process other data from dataMap
        String bookingid = (String) dataMap.get("bookingid");
        String returnPre = (String) dataMap.get("returnTimePre");
        String returnDate = (String) dataMap.get("returnDate");
        String paymentDate = (String) dataMap.get("paymenttime");
        int amount = Integer.parseInt((String) dataMap.get("amount"));
        
        //Extend
        ExtensionDAO daoE = ExtensionDAO.getInstance();
        daoE.addExtension(returnPre, returnDate, amount/100000, bookingid);
        
        //Payment
        // Định dạng chuỗi đầu vào
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        
        // Chuyển đổi chuỗi thành LocalDateTime
        LocalDateTime dateTime = LocalDateTime.parse(paymentDate, inputFormatter);
        
        // Định dạng chuỗi đầu ra
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        // Chuyển đổi LocalDateTime thành chuỗi định dạng mới
        String paymentDateText = dateTime.format(outputFormatter);
        PaymentDAO daoP = PaymentDAO.getInstance();
        daoP.addPayment(bookingid, "Ngân hàng", paymentDateText, amount/100000, "Giao dịch thành công");
        
        // Notify staff
        NotificationDAO.getInstance().insertStaffNotification(
            "Khách gia hạn thuê xe",
            "Đơn " + bookingid + " vừa được gia hạn và thanh toán thành công " + (amount/100000) + "k.",
            "manageBooking"
        );
        
        // Send confirmation email
//       StringBuilder emailContent = new StringBuilder();
//        emailContent.append("<!DOCTYPE html>\n");
//        emailContent.append("<html lang=\"vi\">\n");
//        emailContent.append("<head>\n");
//        emailContent.append("    <meta charset=\"UTF-8\">\n");
//        emailContent.append("    <title>Thông tin đặt xe</title>\n");
//        emailContent.append("    <style>\n");
//        emailContent.append("        body {\n");
//        emailContent.append("            font-family: Arial, sans-serif;\n");
//        emailContent.append("        }\n");
//        emailContent.append("        .container {\n");
//        emailContent.append("            max-width: 600px;\n");
//        emailContent.append("            margin: 0 auto;\n");
//        emailContent.append("            padding: 20px;\n");
//        emailContent.append("            border: 1px solid #ddd;\n");
//        emailContent.append("            border-radius: 10px;\n");
//        emailContent.append("        }\n");
//        emailContent.append("        .header {\n");
//        emailContent.append("            font-size: 18px;\n");
//        emailContent.append("            font-weight: bold;\n");
//        emailContent.append("            margin-bottom: 20px;\n");
//        emailContent.append("        }\n");
//        emailContent.append("        .info, .vehicle-info, .note {\n");
//        emailContent.append("            margin-bottom: 20px;\n");
//        emailContent.append("        }\n");
//        emailContent.append("        .info div, .vehicle-info div {\n");
//        emailContent.append("            margin-bottom: 10px;\n");
//        emailContent.append("        }\n");
//        emailContent.append("        .info div span, .vehicle-info div span {\n");
//        emailContent.append("            font-weight: bold;\n");
//        emailContent.append("        }\n");
//        emailContent.append("        .note ul {\n");
//        emailContent.append("            list-style: none;\n");
//        emailContent.append("            padding: 0;\n");
//        emailContent.append("        }\n");
//        emailContent.append("        .note ul li {\n");
//        emailContent.append("            margin-bottom: 10px;\n");
//        emailContent.append("        }\n");
//        emailContent.append("    </style>\n");
//        emailContent.append("</head>\n");
//        emailContent.append("<body>\n");
//        emailContent.append("<div class=\"container\">\n");
//        emailContent.append("    <div class=\"header\">Thông tin đặt xe của bạn</div>\n");
//        emailContent.append("    <div class=\"info\">\n");
//        emailContent.append("        <div><span>Họ tên:</span> ").append(firstname).append(" ").append(lastname).append("</div>\n");
//        emailContent.append("        <div><span>Số điện thoại:</span> ").append(phone).append("</div>\n");
//        emailContent.append("        <div><span>Email:</span> ").append(email).append("</div>\n");
//        emailContent.append("        <div><span>Ngày nhận xe:</span> ").append(pickupDate).append("</div>\n");
//        emailContent.append("        <div><span>Ngày trả xe:</span> ").append(returnDate).append("</div>\n");
//        emailContent.append("        <div><span>Địa điểm nhận xe:</span> ").append(pickupLocation).append("</div>\n");
//        emailContent.append("        <div><span>Địa điểm trả xe:</span> ").append(returnLocation).append("</div>\n");
//        emailContent.append("    </div>\n");
//        emailContent.append("    <div class=\"vehicle-info\">\n");
//        emailContent.append("        <div class=\"header\">Thông tin xe:</div>\n");
//
//        // Lặp qua danh sách xe và thêm thông tin vào email
//        for (Map.Entry<String, Integer> entry : bikeCounts.entrySet()) {
//            String bikeName = entry.getKey();
//            int quantity = entry.getValue();
//            emailContent.append("        <div><span>Tên xe:</span> ").append(bikeName).append("             x").append(quantity).append("</div>\n");
////            emailContent.append("        <div><span>Số lượng:</span> x").append(quantity).append(" VND</div>\n");
//        }
//        emailContent.append("<div><span>Phí thuê xe dự tính:</span> ").append(total).append(" VND</div>");
//        emailContent.append("    </div>\n");
//        emailContent.append("    <div class=\"note\">\n");
//        emailContent.append("        <div class=\"header\">Lưu ý:</div>\n");
//        emailContent.append("        <ul>\n");
//        emailContent.append("            <li>Vui lòng mang theo giấy tờ tùy thân khi nhận xe.</li>\n");
//        emailContent.append("            <li>Kiểm tra kỹ thông tin xe trước khi nhận.</li>\n");
//        emailContent.append("            <li>Liên hệ với chúng tôi nếu có bất kỳ thắc mắc nào.</li>\n");
//        emailContent.append("        </ul>\n");
//        emailContent.append("    </div>\n");
//        emailContent.append("</div>\n");
//        emailContent.append("</body>\n");
//        emailContent.append("</html>\n");
//        SendEmail.sendVerificationEmail(email, emailContent.toString());

        // Set the response content type
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(gson.toJson(dataMap));
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

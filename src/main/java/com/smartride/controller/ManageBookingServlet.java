package com.smartride.controller;

import com.smartride.constant.SendEmail;
import com.smartride.dao.AccountDAO;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.CancellationDAO;
import com.smartride.dao.ExtensionDAO;
import com.smartride.dao.NotificationDAO;
import com.smartride.dao.PaymentDAO;
import com.smartride.dao.StaffDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.Cancellation;
import com.smartride.dto.Extension;
import com.smartride.dto.Payment;
import com.smartride.dto.Staff;
import com.smartride.util.SupabaseStorageUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet(name = "ManageBookingServlet", urlPatterns = {"/manageBooking"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ManageBookingServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageBookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageBookingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        BookingDAO.getInstance().markOverdueBookings();
        List<Booking> bookings = BookingDAO.getInstance().getAllBookings();
        List<Cancellation> cancels = CancellationDAO.getInstance().getAllCancellation();
        List<Extension> extend = ExtensionDAO.getInstance().getAllExtension();
        Map<String, Map<String, Integer>> motorcycleDetailsMap = new HashMap<>();
        Map<String, List<String>> motorcyclePlatesMap = new HashMap<>();
        Map<String, Payment> paymentsMap = new HashMap<>();
        for (Booking book : bookings) {
            Map<String, Integer> motorcycleDetails = BookingDAO.getInstance().getMotorcycleDetailsByBookingID(book.getBookingID());
            motorcycleDetailsMap.put(book.getBookingID(), motorcycleDetails);
            
            List<String> plates = BookingDAO.getInstance().getMotorcyclePlatesByBookingID(book.getBookingID());
            motorcyclePlatesMap.put(book.getBookingID(), plates);
            
            Payment payment = PaymentDAO.getInstance().getPayMentbyBookingId(book.getBookingID());
            if (payment != null) {
                paymentsMap.put(book.getBookingID(), payment);
            }
        }
        session.setAttribute("motorcycleDetailsMap", motorcycleDetailsMap);
        session.setAttribute("motorcyclePlatesMap", motorcyclePlatesMap);
        session.setAttribute("paymentsMap", paymentsMap);
        session.setAttribute("bookings", bookings);
        session.setAttribute("cancels", cancels);
        session.setAttribute("extend", extend);
        request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String bookingID = request.getParameter("bookingID");

        if (bookingID != null && !bookingID.isEmpty()) {
            String manualPayment = request.getParameter("manualPayment");
            if ("true".equals(manualPayment)) {
                String amtStr = request.getParameter("amount");
                int amt = 0;
                if (amtStr != null && !amtStr.isEmpty()) {
                    try { amt = Integer.parseInt(amtStr); } catch (Exception ignored) {}
                }
                BookingDAO.getInstance().updateBookingStatus(bookingID, "Đã thanh toán");
                com.smartride.dao.PaymentDAO daoP = com.smartride.dao.PaymentDAO.getInstance();
                java.time.LocalDateTime currentDateTime = java.time.LocalDateTime.now();
                java.time.format.DateTimeFormatter outputFormatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String paymentDateText = currentDateTime.format(outputFormatter);
                // Sá»­ dá»¥ng sá»‘ tiá»n tá»« form
                daoP.addPayment(bookingID, "Nhận chuyển khoản (Thủ công)", paymentDateText, amt, "Giao dá»‹ch thÃ nh cÃ´ng");
                
                com.smartride.dao.MotorcycleStatusDAO daoMS = com.smartride.dao.MotorcycleStatusDAO.getInstance();
                com.smartride.dao.BookingDetailDAO daoBD = com.smartride.dao.BookingDetailDAO.getInstance();
                List<com.smartride.dto.BookingDetail> listBD = daoBD.getListBookingDetails(bookingID);
                Account accountStaff = (Account) session.getAttribute("account");
                com.smartride.dto.Staff staff = (accountStaff != null) ? StaffDAO.getInstance().getStaffbyAccountID(accountStaff.getAccountId()) : null;
                String staffId = (staff != null) ? staff.getStaffID() : "STAFF00001";
                
                for(com.smartride.dto.BookingDetail bd : listBD) {
                    int mcId = bd.getMotorcycleDetailID();
                    if(mcId > 0) {
                        daoMS.insertMotorcycleStatus(mcId, staffId, "Đã thanh toán cá»c", paymentDateText, "Xác nhận thủ công bởi Admin");
                    }
                }
            } else {
                String delistatus = request.getParameter("delistatus_" + bookingID);
                if (delistatus != null && !delistatus.isEmpty()) {
                    if ("Đã giao".equals(delistatus)) {
                        StringBuilder imagePathsBuilder = new StringBuilder();
                        for (int i = 1; i <= 5; i++) {
                            Part filePart = request.getPart("deliveryImage" + i + "_" + bookingID);
                            if (filePart != null && filePart.getSize() > 0) {
                                String fileName = UUID.randomUUID().toString() + ".png";
                                // Upload lÃªn Supabase Storage
                                String publicUrl = SupabaseStorageUtil.uploadFile("motor-images", fileName, filePart.getInputStream(), "image/png");
                                if (publicUrl != null) {
                                    if (imagePathsBuilder.length() > 0) imagePathsBuilder.append(",");
                                    imagePathsBuilder.append(publicUrl);
                                }
                            }
                        }
                        
                        String imagePaths = imagePathsBuilder.toString();
                        if (imagePaths.isEmpty()) {
                            // Fallback cho form cÅ© náº¿u cÃ³
                            Part filePart = request.getPart("deliveryImage_" + bookingID);
                            if (filePart != null && filePart.getSize() > 0) {
                                String fileName = UUID.randomUUID().toString() + ".png";
                                String publicUrl = SupabaseStorageUtil.uploadFile("motor-images", fileName, filePart.getInputStream(), "image/png");
                                if (publicUrl != null) {
                                    imagePaths = publicUrl;
                                }
                            }
                        }
                        
                        String fuel = request.getParameter("checklistFuel_" + bookingID);
                        String helmets = request.getParameter("checklistHelmets_" + bookingID);
                        String raincoats = request.getParameter("checklistRaincoats_" + bookingID);
                        String note = request.getParameter("checklistNote_" + bookingID);
                        
                        if (fuel != null) {
                            String noteClean = note != null ? note.replace("\"", "\\\"").replace("\n", " ") : "";
                            String checklistJson = String.format("{\"fuel\":\"%s\", \"helmets\":%s, \"raincoats\":%s, \"note\":\"%s\"}", 
                                                                fuel, helmets != null && !helmets.isEmpty() ? helmets : "0", 
                                                                raincoats != null && !raincoats.isEmpty() ? raincoats : "0", noteClean);
                            BookingDAO.getInstance().updateDeliveryStatusWithChecklist(delistatus, bookingID, imagePaths, checklistJson);
                        } else if (!imagePaths.isEmpty()) {
                            BookingDAO.getInstance().updateDeliveryStatusWithImage(delistatus, bookingID, imagePaths);
                        } else {
                            BookingDAO.getInstance().updateDeliveryStatus(delistatus, bookingID);
                        }
                    } else {
                        BookingDAO.getInstance().updateDeliveryStatus(delistatus, bookingID);
                    }
                } else {
                    BookingDAO.getInstance().updateBookingStatus(bookingID, "Đã xác nhận");
                    BookingDAO.getInstance().updateDeliveryStatus("Chưa giao", bookingID);
                }
            }
        }
        //--------------------------------------------------------------------------------
        Account accountStaff = (Account) session.getAttribute("account");
        //Hủy đơn (báo lỗi của Staff)
        String cancelReason = request.getParameter("cancelreason");
        String timeBook = request.getParameter("timeBook");
        String cusId = request.getParameter("cusId");

        if (cusId != null && !cusId.isEmpty()) {
            Account accountCus = AccountDAO.getInstance().getAccountbyCustomerId(Integer.parseInt(cusId));
            if (cancelReason != null) {
                com.smartride.dto.Staff staff = StaffDAO.getInstance().getStaffbyAccountID(accountStaff.getAccountId());
                String staffId = (staff != null) ? staff.getStaffID() : "STAFF00001";
                CancellationDAO.getInstance().insertCancellation(cancelReason, bookingID, staffId);
                BookingDAO.getInstance().updateBookingStatus(bookingID, "Đã hủy");

                // Ghi nháº­n Lý do Há»§y vÃ o Chat Ä‘á»ƒ lÃ m tin nháº¯n Ä‘áº§u tiÃªn trong cuá»™c há»™i thoáº¡i Há»— trá»£
                try {
                    com.smartride.dao.ChatMessageDAO.getInstance().insertMessage(
                        bookingID, 
                        accountStaff.getAccountId(), 
                        "STAFF", 
                        "ThÃ´ng bÃ¡o Há»§y ÄÆ¡n: " + cancelReason
                    );
                } catch (Exception e) { e.printStackTrace(); }

                // Realtime Notification & Refund logic
                Payment payment = PaymentDAO.getInstance().getPayMentbyBookingId(bookingID);
                boolean isPaid = false;
                String amountStr = "";
                if (payment != null) {
                    if ("Đã thanh toán".equalsIgnoreCase(payment.getPaymentStatus()) || "Success".equalsIgnoreCase(payment.getPaymentStatus())) {
                        isPaid = true;
                        amountStr = String.format("%,.0f", payment.getPaymentAmount()) + " VNÄ";
                    }
                }
                
                String notifTitle = "ÄÆ¡n thuÃª xe " + bookingID + " đã bị từ chối";
                String notifMessage = "Lý do: " + cancelReason;
                String link = "bookingHistoryDetail?bookingId=" + bookingID; // default link
                
                if (isPaid) {
                    notifMessage += ". Sá»‘ tiá»n cáº§n hoÃ n láº¡i: <strong>" + amountStr + "</strong>. Vui lÃ²ng click vÃ o Ä‘Ã¢y Ä‘á»ƒ cung cáº¥p Sá»‘ tÃ i khoáº£n hoÃ n tiá»n.";
                    link = "refundRequest.jsp?bookingId=" + bookingID;
                } else {
                    notifMessage += ". Vui lÃ²ng cáº­p nháº­t láº¡i thÃ´ng tin vÃ  Ä‘áº·t láº¡i Ä‘Æ¡n má»›i.";
                }
                
                NotificationDAO.getInstance().insertNotification(accountCus.getAccountId(), notifTitle, notifMessage, link);
            }

            String emailContent = ""
                    + "<h3><strong>SmartRide </strong>xin chÃ o quÃ½ khÃ¡ch, </h3>"
                    + "<p>MÃ£ Ä‘Æ¡n hÃ ng: <strong>" + bookingID + "</strong> của quý khách đã bị hủy trong quá trình xử lý </p>"
                    + "<p>Thá»i gian Ä‘áº·t: " + timeBook + " </p>"
                    + "<p>Lý do há»§y: <strong>" + cancelReason + "</strong></p>"
                    + "<p>Vui lÃ²ng cáº­p nháº­t láº¡i thÃ´ng tin chÃ­nh xÃ¡c vÃ  Ä‘áº·t láº¡i Ä‘Æ¡n thuÃª xe nhÃ©!</p>"
                    + "<p>SmartRide xin cáº£m Æ¡n, chÃºc quÃ½ khÃ¡ch má»™t ngÃ y vui váº»! </p>";
            SendEmail.sendVerificationEmail(accountCus.getEmail(), emailContent);
        }
        //--------------------------------------------------------------------------------
        //Há»§y Ä‘Æ¡n (cá»§a khÃ¡ch hÃ ng)  -> staff confirm
        String cancelBookingID = request.getParameter("cancelBookId");
        if (cancelBookingID != null && !cancelBookingID.isEmpty()) {
            Staff staff = StaffDAO.getInstance().getStaffbyAccountID(accountStaff.getAccountId());
            String staffId = staff != null ? staff.getStaffID() : "STAFF00001";
            CancellationDAO.getInstance().updateCancellationByStaff(staffId, cancelBookingID);BookingDAO.getInstance().updateBookingStatus(cancelBookingID, "Đã hủy");
        }
        //--------------------------------------------------------------------------------
        //Gia háº¡n (cá»§a khÃ¡ch hÃ ng) -> staff confirm
        String extendBookId = request.getParameter("extendBookId");
        if (extendBookId != null && !extendBookId.isEmpty()) {
            Staff staff = StaffDAO.getInstance().getStaffbyAccountID(accountStaff.getAccountId());
            String staffId = staff != null ? staff.getStaffID() : "STAFF00001";
            boolean updated = ExtensionDAO.getInstance().updateExtensionByStaff(staffId, extendBookId);
            if (updated) {
                com.smartride.dto.Extension ext = ExtensionDAO.getInstance().getExtensionByBookingID(extendBookId);
                if (ext != null) {
                    BookingDAO.getInstance().updateBookingEndDateAndPrice(extendBookId, ext.getNewEndDate(), ext.getExtensionFee());
                }
            }
        }
        
        //Staff tu tao Don Gia han cho Khach
        String staffExtendAction = request.getParameter("action");

        if ("mark_paid".equals(staffExtendAction)) {
            String bId = request.getParameter("bookingId");
            if (bId != null) {
                ExtensionDAO.getInstance().markExtensionPaid(bId);
            }
            response.sendRedirect("manageBooking");
            return;
        }

        if ("staff_extend".equals(staffExtendAction)) {
            String bId = request.getParameter("bookingId");
            String previousEnd = request.getParameter("previousEndDate");
            String newEnd = request.getParameter("newEndDate");
            String extFeeStr = request.getParameter("extensionFee");
            
            if (bId != null && newEnd != null && extFeeStr != null) {
                double extFee = 0;
                try {
                    extFee = Double.parseDouble(extFeeStr.replace(",", "").replace(".", ""));
                } catch(Exception e){}
                
                // 1. Them vao bang Extension voi StaffID luon
                Staff staff = StaffDAO.getInstance().getStaffbyAccountID(accountStaff.getAccountId());
                String staffId = staff != null ? staff.getStaffID() : "STAFF00001";
                
                ExtensionDAO.getInstance().addExtension(previousEnd, newEnd, extFee, bId);
                ExtensionDAO.getInstance().updateExtensionByStaff(staffId, bId);
                // staff creating it means customer hasn't paid online, they pay cash
                ExtensionDAO.getInstance().markExtensionUnpaid(bId);

                
                // 2. Cap nhat vao Booking
                BookingDAO.getInstance().updateBookingEndDateAndPrice(bId, newEnd, extFee);
                
                response.sendRedirect("manageBooking");
                return;
            }
        }
        //--------------------------------------------------------------------------------
       
        //--------------------------------------------------------------------------------
        BookingDAO.getInstance().markOverdueBookings();
        List<Booking> bookings = BookingDAO.getInstance().getAllBookings();
        List<Cancellation> cancels = CancellationDAO.getInstance().getAllCancellation();
        List<Extension> extend = ExtensionDAO.getInstance().getAllExtension();
        Map<String, Map<String, Integer>> motorcycleDetailsMap = new HashMap<>();
        Map<String, List<String>> motorcyclePlatesMap = new HashMap<>();
        Map<String, Payment> paymentsMap = new HashMap<>();

        for (Booking book : bookings) {
            Map<String, Integer> motorcycleDetails = BookingDAO.getInstance().getMotorcycleDetailsByBookingID(book.getBookingID());
            motorcycleDetailsMap.put(book.getBookingID(), motorcycleDetails);
            
            List<String> plates = BookingDAO.getInstance().getMotorcyclePlatesByBookingID(book.getBookingID());
            motorcyclePlatesMap.put(book.getBookingID(), plates);
            
            Payment payment = PaymentDAO.getInstance().getPayMentbyBookingId(book.getBookingID());
            if (payment != null) {
                paymentsMap.put(book.getBookingID(), payment);
            }
        }
        request.setAttribute("motorcycleDetailsMap", motorcycleDetailsMap);
        session.setAttribute("motorcyclePlatesMap", motorcyclePlatesMap);
        session.setAttribute("paymentsMap", paymentsMap);
        session.setAttribute("bookings", bookings);
        session.setAttribute("cancels", cancels);
        session.setAttribute("extend", extend);
        request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}


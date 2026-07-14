package com.smartride.controller;

import com.smartride.constant.SendEmail;
import com.smartride.dao.AccountDAO;
import com.smartride.dao.BookingDAO;
import com.smartride.dao.CancellationDAO;
import com.smartride.dao.ExtensionDAO;
import com.smartride.dao.StaffDAO;
import com.smartride.dto.Account;
import com.smartride.dto.Booking;
import com.smartride.dto.Cancellation;
import com.smartride.dto.Extension;
import com.smartride.dto.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ManageBookingServlet", urlPatterns = {"/manageBooking"})
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
        List<Booking> bookings = BookingDAO.getInstance().getAllBookings();
        List<Cancellation> cancels = CancellationDAO.getInstance().getAllCancellation();
        List<Extension> extend = ExtensionDAO.getInstance().getAllExtension();
        Map<String, Map<String, Integer>> motorcycleDetailsMap = new HashMap<>();
        Map<String, List<String>> motorcyclePlatesMap = new HashMap<>();
        for (Booking book : bookings) {
            Map<String, Integer> motorcycleDetails = BookingDAO.getInstance().getMotorcycleDetailsByBookingID(book.getBookingID());
            motorcycleDetailsMap.put(book.getBookingID(), motorcycleDetails);

            List<String> plates = BookingDAO.getInstance().getMotorcyclePlatesByBookingID(book.getBookingID());
            motorcyclePlatesMap.put(book.getBookingID(), plates);
        }
        session.setAttribute("motorcycleDetailsMap", motorcycleDetailsMap);
        session.setAttribute("motorcyclePlatesMap", motorcyclePlatesMap);
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
                BookingDAO.getInstance().updateBookingStatus(bookingID, "Đã thanh toán");
                com.smartride.dao.PaymentDAO daoP = com.smartride.dao.PaymentDAO.getInstance();
                java.time.LocalDateTime currentDateTime = java.time.LocalDateTime.now();
                java.time.format.DateTimeFormatter outputFormatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String paymentDateText = currentDateTime.format(outputFormatter);
                // Tìm giá tiền từ form (hoặc để 0 vì Admin duyệt thủ công)
                daoP.addPayment(bookingID, "Nhận chuyển khoản (Thủ công)", paymentDateText, 0, "Giao dịch thành công");

                com.smartride.dao.MotorcycleStatusDAO daoMS = com.smartride.dao.MotorcycleStatusDAO.getInstance();
                com.smartride.dao.BookingDetailDAO daoBD = com.smartride.dao.BookingDetailDAO.getInstance();
                List<com.smartride.dto.BookingDetail> listBD = daoBD.getListBookingDetails(bookingID);
                for(com.smartride.dto.BookingDetail bd : listBD) {
                    int mcId = bd.getMotorcycleDetailID();
                    if(mcId > 0) {
                        daoMS.insertMotorcycleStatus(mcId, "STAFF00001", "Đã thanh toán cọc", paymentDateText, "Xác nhận thủ công bởi Admin");
                    }
                }
            } else {
                String delistatus = request.getParameter("delistatus_" + bookingID);
                if (delistatus != null && !delistatus.isEmpty()) {
                    BookingDAO.getInstance().updateDeliveryStatus(delistatus, bookingID);
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
                CancellationDAO.getInstance().insertCancellation(cancelReason, bookingID, StaffDAO.getInstance().getStaffbyAccountID(accountStaff.getAccountId()).getStaffID());
                BookingDAO.getInstance().updateBookingStatus(bookingID, "Đã hủy");
            }

            String emailContent = ""
                    + "<h3><strong>SmartRide </strong>xin chào quý khách, </h3>"
                    + "<p>Mã đơn hàng: <strong>" + bookingID + "</strong> của quý khách đã bị hủy trong quá trình xử lý </p>"
                    + "<p>Thời gian đặt: " + timeBook + " </p>"
                    + "<p>Lý do hủy: <strong>" + cancelReason + "</strong></p>"
                    + "<p>Vui lòng cập nhật lại thông tin chính xác và đặt lại đơn thuê xe nhé!</p>"
                    + "<p>SmartRide xin cảm ơn, chúc quý khách một ngày vui vẻ! </p>";
            SendEmail.sendVerificationEmail(accountCus.getEmail(), emailContent);
        }
        //--------------------------------------------------------------------------------
        //Hủy đơn (của khách hàng)  -> staff confirm
        String cancelBookingID = request.getParameter("cancelBookId");
        if (cancelBookingID != null && !cancelBookingID.isEmpty()) {
            Staff staff = StaffDAO.getInstance().getStaffbyAccountID(accountStaff.getAccountId());
            String staffId = staff != null ? staff.getStaffID() : "STAFF00001";
            CancellationDAO.getInstance().updateCancellationByStaff(staffId, cancelBookingID);
        }
        //--------------------------------------------------------------------------------
        //Gia hạn (của khách hàng) -> staff confirm
        String extendBookId = request.getParameter("extendBookId");
        if (extendBookId != null && !extendBookId.isEmpty()) {
            Staff staff = StaffDAO.getInstance().getStaffbyAccountID(accountStaff.getAccountId());
            String staffId = staff != null ? staff.getStaffID() : "STAFF00001";
            ExtensionDAO.getInstance().updateExtensionByStaff(staffId, extendBookId);
        }
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        List<Booking> bookings = BookingDAO.getInstance().getAllBookings();
        List<Cancellation> cancels = CancellationDAO.getInstance().getAllCancellation();
        List<Extension> extend = ExtensionDAO.getInstance().getAllExtension();
        Map<String, Map<String, Integer>> motorcycleDetailsMap = new HashMap<>();

        for (Booking book : bookings) {
            Map<String, Integer> motorcycleDetails = BookingDAO.getInstance().getMotorcycleDetailsByBookingID(book.getBookingID());
            motorcycleDetailsMap.put(book.getBookingID(), motorcycleDetails);
        }
        request.setAttribute("motorcycleDetailsMap", motorcycleDetailsMap);
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

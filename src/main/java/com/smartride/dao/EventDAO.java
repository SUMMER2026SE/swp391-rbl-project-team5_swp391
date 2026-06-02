package com.smartride.dao;

import com.smartride.dto.Event;
import com.smartride.util.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventDAO implements Serializable {

    private static EventDAO instance;
    private Connection conn = DBUtil.makeConnection();

    private EventDAO() {
    }

    public static EventDAO getInstance() {
        if (instance == null) {
            instance = new EventDAO();
        }
        try {
            if (instance.conn == null || instance.conn.isClosed()) {
                instance.conn = DBUtil.makeConnection();
            }
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return instance;
    }

    public List<Event> getAllEvent() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "	\"EventID\", \"EventTitle\",\n"
                + "    TO_CHAR(\"CreatedDate\", 'DD-MM-YYYY') AS \"CreatedDate\",\n"
                + "    TO_CHAR(\"StartDate\", 'DD-MM-YYYY') AS \"StartDate\",\n"
                + "    TO_CHAR(\"EndDate\", 'DD-MM-YYYY') AS \"EndDate\",\n"
                + "	\"Content\", \"EventImage\", \"Discount\", \"StaffID\"\n"
                + "FROM \"Event\";";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int eventId = rs.getInt(1);
                String eventTitle = rs.getString(2);
                String createdDate = rs.getString(3);
                String startDate = rs.getString(4);
                String endDate = rs.getString(5);
                String content = rs.getString(6);
                String eventImg = rs.getString(7);
                double discount = rs.getDouble(8);
                String staffID = rs.getString(9);
                Event c = new Event(eventId, eventTitle, createdDate, startDate, endDate, content, eventImg, discount, staffID);
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Event> getPagingEvent(int index) {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "	\"EventID\", \"EventTitle\",\n"
                + "    TO_CHAR(\"CreatedDate\", 'DD-MM-YYYY') AS \"CreatedDate\",\n"
                + "    TO_CHAR(\"StartDate\", 'DD-MM-YYYY') AS \"StartDate\",\n"
                + "    TO_CHAR(\"EndDate\", 'DD-MM-YYYY') AS \"EndDate\",\n"
                + "	\"Content\", \"EventImage\", \"Discount\", \"StaffID\"\n"
                + "FROM \"Event\" ORDER BY \"EventID\" OFFSET ? LIMIT 9;";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (index - 1) * 9);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event c = new Event(
                    rs.getInt(1), 
                    rs.getString(2), 
                    rs.getString(3), 
                    rs.getString(4), 
                    rs.getString(5), 
                    rs.getString(6), 
                    rs.getString(7), 
                    rs.getDouble(8), 
                    rs.getString(9)
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getTotalEvent() {
        String sql = "SELECT COUNT(*) FROM \"Event\"";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Event getEventbyID(int id) {
        String sql = "SELECT \"EventID\", \"EventTitle\", \n"
                + "    TO_CHAR(\"CreatedDate\", 'DD-MM-YYYY'), \n"
                + "    TO_CHAR(\"StartDate\", 'DD-MM-YYYY'), \n"
                + "    TO_CHAR(\"EndDate\", 'DD-MM-YYYY'), \n"
                + "    \"Content\", \"EventImage\", \"Discount\", \"StaffID\" \n"
                + "FROM \"Event\" WHERE \"EventID\" = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt(1));
                event.setEventTitle(rs.getString(2));
                event.setCreatedDate(rs.getString(3));
                event.setStartDate(rs.getString(4));
                event.setEndDate(rs.getString(5));
                event.setContent(rs.getString(6));
                event.setEventImage(rs.getString(7));
                event.setDiscount(rs.getDouble(8));
                event.setStaffID(rs.getString(9));
                return event;
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return null;
    }

    public Event getActiveEvent() {
        String sql = "SELECT \"EventID\", \"EventTitle\", \n"
                + "    TO_CHAR(\"CreatedDate\", 'DD-MM-YYYY'), \n"
                + "    TO_CHAR(\"StartDate\", 'DD-MM-YYYY'), \n"
                + "    TO_CHAR(\"EndDate\", 'DD-MM-YYYY'), \n"
                + "    \"Content\", \"EventImage\", \"Discount\", \"StaffID\" \n"
                + "FROM \"Event\" \n"
                + "WHERE CURRENT_DATE >= \"StartDate\" AND CURRENT_DATE <= \"EndDate\" \n"
                + "ORDER BY \"Discount\" DESC LIMIT 1;";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt(1));
                event.setEventTitle(rs.getString(2));
                event.setCreatedDate(rs.getString(3));
                event.setStartDate(rs.getString(4));
                event.setEndDate(rs.getString(5));
                event.setContent(rs.getString(6));
                event.setEventImage(rs.getString(7));
                event.setDiscount(rs.getDouble(8));
                event.setStaffID(rs.getString(9));
                return event;
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return null;
    }

    public List<Event> searchEventByName(String textSearch) {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT \"EventID\", \"EventTitle\", \n"
                + "    TO_CHAR(\"CreatedDate\", 'DD-MM-YYYY'), \n"
                + "    TO_CHAR(\"StartDate\", 'DD-MM-YYYY'), \n"
                + "    TO_CHAR(\"EndDate\", 'DD-MM-YYYY'), \n"
                + "    \"Content\", \"EventImage\", \"Discount\", \"StaffID\" \n"
                + "FROM \"Event\" WHERE \"EventTitle\" ILIKE ?;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + textSearch + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Event c = new Event(
                    rs.getInt(1), 
                    rs.getString(2), 
                    rs.getString(3), 
                    rs.getString(4), 
                    rs.getString(5), 
                    rs.getString(6), 
                    rs.getString(7), 
                    rs.getDouble(8), 
                    rs.getString(9)
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void addNewEvent(Event event) {
        try {
            String sql = "INSERT INTO \"Event\" (\"EventTitle\", \"CreatedDate\", \"StartDate\", \"EndDate\", \"Content\", \"EventImage\", \"Discount\", \"StaffID\") "
                    + "VALUES (?, CURRENT_DATE, TO_DATE(?, 'DD-MM-YYYY'), TO_DATE(?, 'DD-MM-YYYY'), ?, ?, ?, ?)";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, event.getEventTitle());
            stm.setString(2, event.getStartDate());
            stm.setString(3, event.getEndDate());
            stm.setString(4, event.getContent());
            stm.setString(5, event.getEventImage());
            stm.setDouble(6, event.getDiscount());
            stm.setString(7, event.getStaffID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteEvent(String id) {
        try {
            String sql = "DELETE FROM \"Event\" WHERE \"EventID\" = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            try {
                stm.setInt(1, Integer.parseInt(id));
            } catch (NumberFormatException e) {
                stm.setString(1, id);
            }
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updateEvent(Event event) {
        try {
            String sql = "UPDATE \"Event\"\n"
                    + "    SET \n"
                    + "        \"EventTitle\" = ?,\n"
                    + "        \"CreatedDate\" = TO_DATE(?, 'DD-MM-YYYY'),\n"
                    + "        \"StartDate\" = TO_DATE(?, 'DD-MM-YYYY'),\n"
                    + "        \"EndDate\" = TO_DATE(?, 'DD-MM-YYYY'),\n"
                    + "        \"Content\" = ?,\n"
                    + "        \"EventImage\" = ?,\n"
                    + "        \"Discount\" = ?,\n"
                    + "        \"StaffID\" = ?\n"
                    + "    WHERE\n"
                    + "        \"EventID\" = ?;";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, event.getEventTitle());
            stm.setString(2, event.getCreatedDate());
            stm.setString(3, event.getStartDate());
            stm.setString(4, event.getEndDate());
            stm.setString(5, event.getContent());
            stm.setString(6, event.getEventImage());
            stm.setDouble(7, event.getDiscount());
            stm.setString(8, event.getStaffID());
            stm.setInt(9, event.getEventID());
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error updating Event: " + e.getMessage());
        }
    }
}

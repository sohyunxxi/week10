<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Calendar" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team = (String)session.getAttribute("team");
    String tel = (String)session.getAttribute("tel");
    int idx = (Integer)session.getAttribute("idx");
    
    if (name == null) {
        response.sendRedirect("login.jsp");
    }

    String eventContent = request.getParameter("eventContent");
    String startTimeHour = request.getParameter("hourHidden");
    String startTimeMinute = request.getParameter("minuteHidden");
    

    String eventDate = request.getParameter("eventDate");
    if (eventDate == null || eventDate.trim().isEmpty()) {
        // eventDate가 null이거나 비어 있는 경우에 대한 처리
        out.println(eventDate);
        out.println(eventContent);
        out.println(startTimeHour);
        out.println(startTimeMinute);
        return;  // 또는 예외 처리를 진행하거나 적절한 방식으로 처리하세요.
    }
    String yearParam = request.getParameter("year");
    int eventYear = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : 2023;

    int month = Integer.parseInt(eventDate.split("월")[0].trim());
    int day = Integer.parseInt(eventDate.split("월")[1].split("일")[0].trim());

    Calendar calendar = Calendar.getInstance();
    calendar.set(eventYear, month - 1, day, Integer.parseInt(startTimeHour), Integer.parseInt(startTimeMinute), 0);
    java.sql.Timestamp eventTimestamp = new java.sql.Timestamp(calendar.getTimeInMillis());

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10", "Sohyunxxi", "1234");

    String sql = "INSERT INTO event (user_idx, event_content, start_time) VALUES (?, ?, ?)";
    PreparedStatement query = connect.prepareStatement(sql);

    query.setInt(1, idx);
    query.setString(2, eventContent);
    query.setTimestamp(3, eventTimestamp);

    int result = query.executeUpdate();

    if (result > 0) {
        response.sendRedirect("mainCalendar.jsp");
    }

    out.println("Received Month: " + month + "<br>");
    out.println("Received Day: " + day + "<br>");
%>

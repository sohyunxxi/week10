<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id");
    String pwValue = request.getParameter("pw");
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10", "Sohyunxxi", "1234");

        String sql = "SELECT * FROM user WHERE id = ? AND pw = ?";

        PreparedStatement query = connect.prepareStatement(sql);

        query.setString(1, idValue);
        query.setString(2, pwValue);

        rs = query.executeQuery();

        if (rs.next()) {
            int userIdx = rs.getInt("idx");
            String dbId = rs.getString("id");
            String dbPw = rs.getString("pw");

            if (pwValue.equals(dbPw)) {
                session.setAttribute("userIdx", userIdx);
                session.setAttribute("id", dbId);
                session.setAttribute("pw", dbPw);
                response.sendRedirect("mainCalendar.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    } 
    catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>


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
    //예외처리
    ResultSet rs= null;

    
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");
   
        String sql = "SELECT * FROM user WHERE id= ?";

        
        PreparedStatement query = connect.prepareStatement(sql);
  
        query.setString(1,idValue); 
        
        rs=query.executeQuery();
        if(rs.next()){
            String dbId = rs.getString("id");
            String dbpw = rs.getString("pw");
            int idx = rs.getInt("user_idx");
            String tel = rs.getString("tel");
            String team = rs.getString("department");
            String role = rs.getString("role");
            String name = rs.getString("name");
            if(pwValue.equals(dbpw)){
                session.setAttribute("userId", idValue);
                session.setAttribute("userPw", pwValue);
                session.setAttribute("idx", idx);
                session.setAttribute("tel", tel);
                session.setAttribute("team", team);
                session.setAttribute("role", role);
                session.setAttribute("userName", name);
                response.sendRedirect("mainCalendar.jsp");
                return; 
            } else {
                response.sendRedirect("login.jsp");
                return; 
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    %>
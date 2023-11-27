<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%
    request.setCharacterEncoding("utf-8");

    //Connector 파일 불러오기
    Class.forName("com.mysql.jdbc.Driver");

    // 데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6","Sohyunxxi","1234");


    String sql = "SELECT * FROM user where id = ?";

    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,userName);

        String name = "";
        String id = "";
        String password = "";
        String email = "";
        Date birth = new Date(); 
        int tel = 0;
        String address = "";
        String gender = ""; 

    ResultSet rs = query.executeQuery();
    if (rs.next()) {
        name = rs.getString("name");
        id = rs.getString("id");
        password = rs.getString("pw");
        email = rs.getString("email");
        birth = rs.getDate("birth");
        tel = rs.getInt("tel");
        address = rs.getString("address");
        gender = rs.getString("gender"); 
    }

%>
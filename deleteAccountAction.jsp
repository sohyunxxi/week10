<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
    request.setCharacterEncoding("utf-8");
    String userName = (String)session.getAttribute("username");
    String pwValue = request.getParameter("pw_value");
    if (userName==null){
        response.sendRedirect("signIn.html");
    }
    Class.forName("com.mysql.jdbc.Driver");

    // 데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6","Sohyunxxi","1234");

    //SQL 만들기
    String sql = "DELETE FROM user WHERE id= ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,userName);

        //query 전송
    query.executeUpdate();  
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
        <script>
            alert("회원 정보를 삭제합니다. 안녕~");
            location.href = "login.jsp";
        </script>
 </body>
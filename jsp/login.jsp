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
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link type="text/css" rel="stylesheet" href="../css/login.css">
</head>
<body>
    <h1 id="mainFont">LOG IN</h1>
    <form action="loginAction.jsp">
        <div id="loginBox">
            <div class="insertBox">
                <span>아이디 : </span>
                <input id="idBox" type="text" length="14" maxlength="12">
            </div>
            <div class="insertBox">
                <span>비밀번호 : </span>
                <input id="pwBox"type="password" length="18" maxlength="16">
            </div>
            <button id="button" onclick="checkNull()">로그인</button>
        </div>
    </form>
    <div id="linkBox">
        <a class="linkFont" href="findId.html">아이디 찾기</a>
        <a id="middleLinkFont" href="findPw.html">비밀번호 찾기</a>
        <a class="linkFont" href="makeAccount.html">회원가입</a>
    </div>
</body>
<script src="../js/makeAccount.js"></script>
</html>
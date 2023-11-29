<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
    
    request.setCharacterEncoding("utf-8");
    String email = request.getParameter("email");
    ResultSet rs = null;
    String id="";
    String message ="";
    String redirectPage="";
    //데이터베이스 통신 코드

    //Connector 파일 불러오기
    Class.forName("com.mysql.jdbc.Driver");

    // 데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6","Sohyunxxi","1234");

    //SQL 만들기
    String sql = "SELECT id FROM user WHERE name=? AND tel=?";
    PreparedStatement query = connect.prepareStatement(sql);

    query.setString(1,email);
    query.setInt(2,tel);

        //query 전송
    rs = query.executeQuery();

    
 
    if (rs.next() )  {
        id = rs.getString("id");
        message = "아이디 : "+ id;
        redirectPage = "login.jsp";
    }else{
        message = "계정이 존재하지 않습니다! 회원가입을 해 주세요.";
        redirectPage = "makeAccount.jsp";
    } 

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link type="text/css" rel="stylesheet" href="../css/findId.css">
</head>
<body>
    <h1 id="mainFont">아이디 찾기</h1>
    <form>
        <div id="loginBox">
            <div class="insertBox">
                <span id="nameFont">이름 : </span>
                <input id="idBox" type="text" length="14" maxlength="12">
            </div>
            <div class="insertBox">
                <span>전화번호 : </span>
                <input id="pwBox" type="password" length="18" maxlength="16">
            </div>
            <button id="button" onclick="searchId()">아이디 찾기</button>
        </div>
    </form>
    <script src="../js/makeAccount.js"></script>
</body>
</html>
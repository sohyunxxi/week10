<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link type="text/css" rel="stylesheet" href="../css/makeAccount.css">
</head>

<body>
    
    <h1 id="mainFont">회원가입</h1>
    <form action="loginAction.jsp" onsubmit="return checkNoInput()">
        <div id="loginBox">
            <div class="insertBox">
                <span id="nameFont" class="fontSize">이름 : </span>
                <input id="nameBox" placeholder="필수 입력 사항입니다." name="name" type="text" length="14" maxlength="12">
            </div>
            <div class="insertBox">
                <span id="idFont" class="fontSize">아이디 : </span>
                <input id="idBox" placeholder="4~10자리 사이" name="id" type="text" length="18" maxlength="16">
                <button id="checkButton" onclick="checkDuplicate()">중복확인</button>
            </div>
            <div class="insertBox">
                <span class="fontSize">비밀번호 : </span>
                <input id="pwBox" placeholder="4~16자리 사이" name="pw" type="password" length="18" maxlength="16">
            </div>
            <div class="insertBox">
                <span class="fontSize">재확인 비밀번호 : </span>
                <input id="comfirmPwBox" placeholder="4~16자리 사이" name="confirmPw" type="password" length="18" maxlength="16">
            </div>
            <div class="insertBox">
                <span class="fontSize">전화번호 : </span>
                <input id="numBox" placeholder="(-) 없이 입력해주세요." name="tel" type="password" length="18" maxlength="16">
            </div>
            <div class="insertBox">
                <span id="selectTeam" class="fontSize">부서명 : </span>
                <div class="selectFont">
                    <input type="radio" name="team" value="디자인" onclick="selectTeam(this.value)"> 디자인
                    <input type="radio" name="team" value="개발" onclick="selectTeam(this.value)"> 개발
                </div>
            </div>
            <div class="insertBox">
                <span id="selectOcc" class="fontSize">직급선택 : </span>
                <div id="selectBox">
                    <input type="radio" name="company" onclick="selectTeam(this.value)" value="팀장"> 팀장
                    <input type="radio" name="company" onclick="selectTeam(this.value)" value="팀원"> 팀원
                </div>
            </div>
        </div>
    </form>
    <button id="button" onclick="checkInput()">회원가입 하기</button>

    <script src="../js/makeAccount.js"></script>
</body>

</html>
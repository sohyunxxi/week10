<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link type="text/css" rel="stylesheet" href="../css/login.css">
</head>
<body>
    <h1 id="mainFont">LOG IN</h1>
    <form action="loginAction.jsp" onsubmit="return checkNull()">
        <div id="loginBox">
            <div class="insertBox">
                <span>아이디 : </span>
                <input id="idBox" type="text" length="14" maxlength="12">
            </div>
            <div class="insertBox">
                <span>비밀번호 : </span>
                <input id="pwBox" type="password" length="18" maxlength="16">
            </div>
            <button id="button" onclick="checkNull()">로그인</button>
        </div>
    </form>
    <div id="linkBox">
        <a class="linkFont" href="findId.jsp">아이디 찾기</a>
        <a id="middleLinkFont" href="findPw.jsp">비밀번호 찾기</a>
        <a class="linkFont" href="makeAccount.jsp">회원가입</a>
    </div>
</body>
<script src="../js/makeAccount.js"></script>
</html>
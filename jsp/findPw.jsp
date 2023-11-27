<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <link type="text/css" rel="stylesheet" href="../css/findPw.css">
</head>
<body>
    <h1 id="mainFont">비밀번호 찾기</h1>
    <div id="loginBox">
        <div class="insertBox">
            <span id="nameFont">이름 : </span>
            <input id="nameBox" type="text" length="14" maxlength="12">
        </div>
        <div class="insertBox">
            <span>아이디 : </span>
            <input id="idBox" type="password" length="18" maxlength="16">
        </div>
        <div class="insertBox">
            <span>전화번호 : </span>
            <input id="pwBox"type="password" length="18" maxlength="16">
        </div>
        <button id="button" onclick="searchPw()">비밀번호 찾기</button>
    </div>
    <script src="../js/makeAccount.js"></script>
</body>
</html>
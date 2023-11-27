<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 수정</title>
    <link type="text/css" rel="stylesheet" href="../css/updateInfo.css">
</head>

<body>
    <header>
        <h1 id="mainFont">내 정보 수정</h1>
    </header>
    <main>
        <div id="loginBox">
            <div class="insertBox">
                <span id="nameFont">이름 : </span>
                <span id="nameFont">이소현 </span>
            </div>
            <div class="insertBox">
                <span id="idFont">아이디 : </span>
                <span id="nameFont">sohyunxxi</span>

            </div>
            <div id="pwInsertBox">
                <span id="pwFont">비밀번호 : </span>
                <input id="pwBox" type="password" placeholder="4자 이상 16자 이하로 입력해주세요." value="1234메롱"></span>
            </div>
            <div id="confirmInsertBox">
                <span>재확인 비밀번호 : </span>
                <input id="confirmPwBox" type="password" placeholder="4자 이상 16자 이하로 입력해주세요." value="1234메롱"></span>
            </div>
            <div id="telInsertBox">
                <span id="telFont">전화번호 : </span>
                <input id="telBox" value="01032431578" placeholder="-(하이픈)은 제외한 숫자만 입력해주세요."></span>
            </div>
            <div id="teamInsertBox">
                <span id="selectTeam">부서명 : </span>
                <div class="selectFont">
                    <input type="radio" name="team" value="디자인"> 디자인
                    <input type="radio" name="team" value="개발" checked> 개발
                </div>
            </div>
            <div id="occInsertBox">
                <span id="selectOcc">직급선택 : </span>
                <div id="selectBox">
                    <input type="radio" name="company" value="팀장"> 팀장
                    <input type="radio" name="company" value="팀원" checked> 팀원
                </div>
            </div>
        </div>
    </main>
    <footer>
        <img src="../image/back.png" id="backImg" onclick="moveBackEvent()">
        <div id="buttonBox">
            <button class="footerButtons" onclick="updateEvent()">완료</button>
        </div>
    </footer>
    <script src="../js/showInfo.js"></script>
</body>

</html>
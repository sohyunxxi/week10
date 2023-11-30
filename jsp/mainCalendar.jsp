<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team =(String)session.getAttribute("team");
    int tel = (Integer)session.getAttribute("tel");
    if (name==null){
        response.sendRedirect("login.jsp");
    }
    
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인페이지</title>
    <link type="text/css" rel="stylesheet" href="../css/mainCalendar.css">
</head>

<body onload="presentMonth()">
    <header>
        <div id="yearBox">
            <button onclick="previousYearEvent()" class="yearButton"><img class="yearImage"
                    src="../image/year_left.png"></button>
            <h1 id="year">2023</h1>
            <button onclick="nextYearEvent()" class="yearButton"><img class="yearImage"
                    src="../image/year_right.png"></button>
        </div>
        <form>
            <div id="months">
                <button class="monthButton" value="1" onclick="daysOfMonth(this)">1</button>
                <button class="monthButton" value="2" onclick="daysOfMonth(this)">2</button>
                <button class="monthButton" value="3" onclick="daysOfMonth(this)">3</button>
                <button class="monthButton" value="4" onclick="daysOfMonth(this)">4</button>
                <button class="monthButton" value="5" onclick="daysOfMonth(this)">5</button>
                <button class="monthButton" value="6" onclick="daysOfMonth(this)">6</button>
                <button class="monthButton" value="7" onclick="daysOfMonth(this)">7</button>
                <button class="monthButton" value="8" onclick="daysOfMonth(this)">8</button>
                <button class="monthButton" value="9" onclick="daysOfMonth(this)">9</button>
                <button class="monthButton" value="10" onclick="daysOfMonth(this)">10</button>
                <button class="monthButton" value="11" onclick="daysOfMonth(this)">11</button>
                <button class="monthButton" value="12" onclick="daysOfMonth(this)">12</button>
            </div>
        </form>
    </header>
    <hr id="divideLine">
    <nav>
        <div id="navShortMenu">
            <img class="menuIcon" src="../image/shortMenu.png" onclick="showHidden()">
        </div>

        <div id="hidden">
            <img id="cancelMenuIcon" src="../image/close.png" onclick="closeMenu()">
            <h2><%=name %> 님</h2>
            <span class="userInfoFont">ID : <%=id %></span>
            <span class="userInfoFont">부서명 : <%=team%></span>
            <span class="userInfoFont">전화번호 : <%=tel %></span>
            <div id="buttonBox">
                <button class="navButton"><a class="noColor" href="showInfo.jsp">내 정보</a></button>
                <button class="navButton"><a class="noColor" href="logout.jsp">로그아웃</a></button>
            </div>
            <hr class="lineColor">
            <span id="teamList">팀원 목록</span>
            <hr class="lineColor">
            <div id="peopleBox">
                <span class="navInfo"><a class="noColor" href="j.html">강정연 (gongsil)</a></span>
                <span class="navInfo"><a class="noColor" href="k.html">왕준혁 (king)</a></span>
                <span class="navInfo"><a class="noColor" href="h.html">조희주 (heeju)</a></span>
            </div>

        </div>
    </nav>

    <main>

    </main>

    <div id="modal">

        <div id="innerModal">
            <span class="close" onclick="closeModalEvent()">&times;</span>
            <h1 id="modalDate">모달 날짜 나오는곳</h1>
            <span id="planCount">+3</span>
            <hr>
            <hr>
            <div id="planBox">
                <div class="modalPlan">
                    <span class="planTime">
                        <div class="modalButtonsHidden">
                            <button onclick="timeFront('minute')"><img class="modalButtonPic"
                                    src="../image/upButton.png"></button>
                            <button onclick="timeBack('minute')"><img class="modalButtonPic"
                                    src="../image/downButton.png"></button>
                        </div>11 :
                        <div class="modalButtonsHidden">
                            <button onclick="timeFront('minute')"><img class="modalButtonPic"
                                    src="../image/upButton.png"></button>
                            <button onclick="timeBack('minute')"><img class="modalButtonPic"
                                    src="../image/downButton.png"></button>
                        </div>30
                    </span>
                    <span class="planContext">정연 팀원 밥 약속</span>
                    <div class="modalButtons">
                        <button class="modalPlanButton" onclick="updatePlanEvent(event)">수정</button>
                        <button class="modalPlanButton" onclick="deletePlanEvent(event)">삭제</button>
                    </div>
                </div>
                <div class="modalPlan">
                    <span class="planTime">
                        <div class="modalButtonsHidden">
                            <button onclick="timeFront('minute')"><img class="modalButtonPic"
                                    src="../image/upButton.png"></button>
                            <button onclick="timeBack('minute')"><img class="modalButtonPic"
                                    src="../image/downButton.png"></button>
                        </div>15 :
                        <div class="modalButtonsHidden">
                            <button onclick="timeFront('minute')"><img class="modalButtonPic"
                                    src="../image/upButton.png"></button>
                            <button onclick="timeBack('minute')"><img class="modalButtonPic"
                                    src="../image/downButton.png"></button>
                        </div>30
                    </span>
                    <span class="planContext">준혁 팀원 밥 약속</span>
                    <div class="modalButtons">
                        <button class="modalPlanButton" onclick="updatePlanEvent(event)">수정</button>
                        <button class="modalPlanButton" onclick="deletePlanEvent(event)">삭제</button>
                    </div>
                </div>
                <div class="modalPlan">
                    <span class="planTime">
                        <div class="modalButtonsHidden">
                            <button onclick="timeFront('minute')"><img class="modalButtonPic"
                                    src="../image/upButton.png"></button>
                            <button onclick="timeBack('minute')"><img class="modalButtonPic"
                                    src="../image/downButton.png"></button>
                        </div>18 :
                        <div class="modalButtonsHidden">
                            <button onclick="timeFront('minute')"><img class="modalButtonPic"
                                    src="../image/upButton.png"></button>
                            <button onclick="timeBack('minute')"><img class="modalButtonPic"
                                    src="../image/downButton.png"></button>
                        </div>30
                    </span>
                    <span class="planContext">희주 팀원 밥 약속</span>
                    <div class="modalButtons">
                        <button class="modalPlanButton" onclick="updatePlanEvent(event)">수정</button>
                        <button class="modalPlanButton" onclick="deletePlanEvent(event)">삭제</button>
                    </div>
                </div>
            </div>
            <hr>
            <h3>일정 추가</h3>
            <hr>
            <div id="modalTimeBox">
                <span>일정 시간</span>
                <div class="modalTime">
                    <div class="modalButtons">
                        <button onclick="timeFront('hour')"><img class="modalButtonPic"
                                src="../image/upButton.png"></button>
                        <button onclick="timeBack('hour')"><img class="modalButtonPic"
                                src="../image/downButton.png"></button>
                    </div>
                    <span class="modalTimeNum hour">00</span>

                    <span class="modalTimeNum">시</span>
                </div>
                <div class="modalTime">
                    <div class="modalButtons">
                        <button onclick="timeFront('minute')"><img class="modalButtonPic"
                                src="../image/upButton.png"></button>
                        <button onclick="timeBack('minute')"><img class="modalButtonPic"
                                src="../image/downButton.png"></button>
                    </div>
                    <span class="modalTimeNum minute">00</span>
                    <span class="modalTimeNum">분</span>
                </div>
            </div>
            <div id="planInputBox">
                <span>일정 내용</span>
                <textarea class="planInput" placeholder="최대 50자까지 적을 수 있습니다. " cols="55" rows="5"
                    maxlength="50"></textarea>
            </div>
            <button class="modalPlanButton">등록</button>
        </div>

    </div>

    <div id="blackBox">

    </div>


    <script src="../js/calender.js"></script>
</body>

</html>
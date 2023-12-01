<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Timestamp" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team =(String)session.getAttribute("team");
    String tel = (String)session.getAttribute("tel");
    int idx = (Integer)session.getAttribute("idx");

    if (name==null){
        response.sendRedirect("login.jsp");
    }
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");

    String sql = "SELECT user_idx, id, name FROM user WHERE department= ? AND role = '팀원'";
    PreparedStatement query = connect.prepareStatement(sql);

    query.setString(1,team);

    ResultSet rs= null;
    rs=query.executeQuery();
    ResultSet result = query.executeQuery();

    ArrayList<String> nameList= new ArrayList<String>();
    ArrayList<String> idList= new ArrayList<String>();

    while(result.next()){ // next가 가능할 때까지 반복문을 돌린다.
        String t_id=result.getString(2);// 첫번째 컬럼
        String t_name=result.getString(3);// 두번째 컬럼
        nameList.add("\""+t_name +"\"");
        idList.add("\""+t_id+"\"");
    }

    String eventSql = "SELECT event_idx, start_time, event_content FROM event WHERE user_idx = ? ORDER BY start_time ASC";
    PreparedStatement eventQuery = connect.prepareStatement(eventSql);
    eventQuery.setInt(1, idx);

    ResultSet eventRs = eventQuery.executeQuery();

    
        ArrayList<String> timeList = new ArrayList<>();
        ArrayList<String> dayList = new ArrayList<>();

        ArrayList<String> eventList = new ArrayList<>();
        ArrayList<Integer> eventIdx = new ArrayList<>();
    
        while (eventRs.next()) {
            int e_eventIdx = eventRs.getInt(1);
            LocalDateTime e_time = eventRs.getObject(2, LocalDateTime.class);
            
            // 년, 월, 일 추출
            int year = e_time.getYear();
            int month = e_time.getMonthValue();
            int day = e_time.getDayOfMonth();
        
            String formattedTimeDay = String.format("%04d-%02d-%02d", year, month, day);
            String formattedTime = String.format("%02d:%02d", e_time.getHour(), e_time.getMinute());
            String e_eventContent = eventRs.getString(3);
    
            eventIdx.add(e_eventIdx);  // event_idx를 ArrayList<Integer>에 저장
            timeList.add("\"" + formattedTime + "\"");
            dayList.add("\"" + formattedTimeDay + "\"");

            eventList.add("\"" + e_eventContent + "\"");
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
            <button onclick="previousYearEvent()" class="yearButton">
                <img class="yearImage" src="../image/year_left.png">
            </button>
                    <form action="makeEvent.jsp">
                        <h1 id="year" name="year">2023</h1>
                        <input type="hidden" id="yearHidden" name="year" value="2023">
                    </form>
            <button onclick="nextYearEvent()" class="yearButton"><img class="yearImage"
                    src="../image/year_right.png"></button>
        </div>
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
    </header>
    <hr id="divideLine">
    <nav>
        <div id="navShortMenu">
            <img class="menuIcon" src="../image/shortMenu.png" onclick="showHidden()">
        </div>

        <div id="hidden">
            <img id="cancelMenuIcon" src="../image/close.png" onclick="closeMenu()">
            <h2><%=name %> 님</h2>
            <span class="userInfoFont">ID : <%=id %> </span>
            <span class="userInfoFont">부서명 : <%=team%> </span>
            <span class="userInfoFont">전화번호 : <%=tel %> </span>
            <div id="buttonBox">
                <button class="navButton"><a class="noColor" href="showInfo.jsp">내 정보</a></button>
                <button class="navButton"><a class="noColor" href="logout.jsp">로그아웃</a></button>
            </div>
            <hr class="lineColor">
            <span id="teamList">팀원 목록</span>
            <hr class="lineColor">
            <div id="peopleBox">
                
            </div>

        </div>
    </nav>

    <main>

    </main>

    <div id="modal">

        <div id="innerModal">
            <span class="close" onclick="closeModalEvent()">&times;</span>
            <form action="makeEvent.jsp">
                <h2 id="modalDate" >모달 날짜 나오는곳</h2>
                <input type="hidden" id="eventDate" name="eventDate" value="날짜">
            <span id="planCount">+3</span>
            <hr>
            <hr>
            <div id="planBox">
                <!-- 
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
                -->
            </div>
            <hr>
            <h3>일정 추가</h3>
            <hr>
           
                <div id="modalTimeBox">
                    <span>일정 시간</span>
                    <div class="modalTime">
                        <div class="modalButtons">
                            <button type="button" onclick="timeFront('hour')"><img class="modalButtonPic"
                                    src="../image/upButton.png"></button>
                            <button type="button" onclick="timeBack('hour')"><img class="modalButtonPic"
                                    src="../image/downButton.png"></button>
                        </div>
                        <span class="modalTimeNum hour">00</span>
                        <input type="hidden" name="hourHidden" class="modalTimeNum" value="00">

                        <span class="modalTimeNum">시</span>
                    </div>
                    <div class="modalTime">
                        <div class="modalButtons">
                            <button type="button" onclick="timeFront('minute')"><img class="modalButtonPic"
                                    src="../image/upButton.png"></button>
                            <button type="button" onclick="timeBack('minute')"><img class="modalButtonPic"
                                    src="../image/downButton.png"></button>
                        </div>
                        <span class="modalTimeNum minute">00</span>
                        <input type="hidden" name="minuteHidden" class="modalTimeNum" value="00">
                        <span class="modalTimeNum">분</span>
                    </div>
                </div>
                <div id="planInputBox">
                    <span>일정 내용</span>
                    <textarea class="planInput" name="eventContent" placeholder="최대 50자까지 적을 수 있습니다. " cols="55" rows="5"
                        maxlength="50"></textarea>
                </div>
                <button class="modalPlanButton">등록</button>
            </form>
        </div>

    </div>

    <div id="blackBox">

    </div>


    <script src="../js/calender.js"></script>
</body>
<script>
    var day = 0;
    var selectedButton = null;
    var selectedMonth = 0;
    var eventDateMatch = "";

    var idList = <%=idList%>;
    var nameList = <%=nameList%>;
    var modalCompareDate = "";
    var matchingIndices = [];

    // 팀원 목록을 동적으로 생성하여 추가
    var peopleBox = document.getElementById("peopleBox");
        for (var i = 0; i < idList.length; i++) {
            var span = document.createElement("span");
            span.className = "navInfo";
            var a = document.createElement("a");
            a.className = "noColor";
            a.href = "#";
            a.innerText = nameList[i] + " (" + idList[i] + ")";
            span.appendChild(a);
            peopleBox.appendChild(span);
        }




    function daysOfMonth(button) {
        if (button.value == 2) {
            day = 28;

        }
        else if (button.value == 1 || button.value == 3 || button.value == 5 || button.value == 7 || button.value == 8 || button.value == 10 || button.value == 12) {
            day = 31;
        }
        else {
            day = 30;
        }
        changeButtonColorEvent(button);


    }

    function changeButtonColorEvent(button) {

        if (selectedButton && selectedButton.tagName === 'BUTTON') {
            selectedButton.removeAttribute("id");
        }

        button.id = "selected";

        selectedButton = button;
        selectedMonth = button.value;
        console.log(selectedMonth);
        console.log(button.value);


        makeCalendarEvent(day);
    }

    function presentMonth() {
        var now = new Date();	// 현재 날짜랑 시간
        var month = now.getMonth() + 1;	// 월만 쏙 빼오기

        // 아래와 같이 수정하여 버튼 객체를 만들어서 전달
        var button = document.querySelector('.monthButton[value="' + month + '"]');
        daysOfMonth(button);

        console.log(month); //배경화면 띄우기
    }

    function previousYearEvent() {
        var year = document.getElementById('year');
        var yearHidden = document.getElementById('yearHidden');

        if (year) {
            var num = parseInt(year.textContent);
            var numHidden = parseInt(yearHidden.value);
            if (num > 0) {
                year.innerText = (num - 1).toString().padStart(4, '0');
                yearHidden.value = (numHidden - 1).toString().padStart(4, '0');
            }
        }
    }

    function nextYearEvent() {
        var year = document.getElementById('year');
        var yearHidden = document.getElementById('yearHidden');
        if (year) {
            var num = parseInt(year.textContent);
            var numHidden = parseInt(yearHidden.value);
            if (num < 9999) {
                year.innerText = (num + 1).toString().padStart(4, '0');
                yearHidden.value = (numHidden + 1).toString().padStart(4, '0');
            }
        }
    }
    function makeCalendarEvent(day) {
        var calendarBox = document.getElementsByTagName("main")[0];
        calendarBox.innerHTML = "";
        var days = document.createElement("div");
        days.id = "dayBox";
        calendarBox.appendChild(days);
        days.innerHTML = "";
        for (var i = 0; i < day; i++) {
            var dayBox = document.createElement("div");
            dayBox.className = "calendarDay";
            dayBox.setAttribute("onclick", "openModalEvent(" + selectedMonth + "," + (i + 1) + ")");
            dayBox.textContent = i + 1;
            days.appendChild(dayBox);
            if (i == 18) {
                var count = (document.createElement("span"));
                dayBox.appendChild(count);
                count.textContent = "+3";
                count.setAttribute("class", "countFont")
            }
            if (i == 5) {
                var count = (document.createElement("span"));
                dayBox.appendChild(count);
                count.textContent = "+9";
                count.setAttribute("class", "countFont")
            }
            if (i == 20) {
                var count = (document.createElement("span"));
                dayBox.appendChild(count);
                count.textContent = "+1";
                count.setAttribute("class", "countFont")
            }
            if ((i + 1) % 7 == 0) {
                days.appendChild(document.createElement("br"));
            }

        }
    }

    function showHidden() {
        var hidden = document.getElementById('hidden');
        var black = document.getElementById('blackBox');
        hidden.style.right = "0";
        black.style.display = "block";
    }
    function closeMenu() {
        var hidden = document.getElementById('hidden');
        var black = document.getElementById('blackBox');
        hidden.style.right = "-320px";
        black.style.display = "none";
    }
    //event 붙이기
    function closeModalEvent() {
            var modal = document.getElementById('modal');
            modal.style.display = 'none';
        }
        function updatePlanEvent(event) {
            var parentDiv = event.target.closest('.modalPlan');
            var timeSpan = parentDiv.querySelector('.planTime');
            var eventSpan = parentDiv.querySelector('.planContext');
            var editButton = parentDiv.querySelector('.modalButtons button');
            var modalButtonsHidden = parentDiv.querySelector('.modalButtonsHidden');
            if (timeSpan.style.display === 'none') {
                // 이미 수정 중인 경우, 저장 처리
                var hourInput = parentDiv.querySelector('.modalTimeNum.hour');
                var minuteInput = parentDiv.querySelector('.modalTimeNum.minute');
                timeSpan.textContent = hourInput.textContent + ' :' + minuteInput.textContent;
                eventSpan.textContent = document.getElementsByClassName('planInput')[0].value;

                // 숨겼던 기존 요소 다시 표시
                timeSpan.style.display = '';
                eventSpan.style.display = '';
                hourInput.style.display = 'inline';
                minuteInput.style.display = 'inline';
                modalButtonsHidden.style.display = "flex";

                // input text와 textarea 제거
                parentDiv.removeChild(hourInput);
                parentDiv.removeChild(minuteInput);
                parentDiv.removeChild(document.getElementsByClassName('planInput')[0]);

                // 다시 수정 버튼으로 변경
                editButton.textContent = '수정';
            } else {
                // 수정 시작
                // 현재 값 저장
                var currentTime = timeSpan.textContent;
                var currentEvent = eventSpan.textContent;

                // 시간과 분 추출
                var [hour, minute] = currentTime.match(/\d+/g);
                // input 요소 생성
                var hourInput = document.createElement('span');
                hourInput.className = 'modalTimeNum hour';
                hourInput.textContent = hour;

                var minuteInput = document.createElement('span');
                minuteInput.className = 'modalTimeNum minute';
                minuteInput.textContent = minute;

                var planInput = document.createElement('textarea');
                planInput.classList = 'planInput';
                planInput.placeholder = '최대 50자까지 적을 수 있습니다. ';
                planInput.cols = '55';
                planInput.rows = '5';
                planInput.maxLength = '50';
                planInput.value = currentEvent;

                // 기존 요소 숨기기
                timeSpan.style.display = 'none';
                eventSpan.style.display = 'none';
                modalButtonsHidden.style.display = "none";

                // 생성한 요소 추가
                parentDiv.insertBefore(hourInput, timeSpan);
                parentDiv.insertBefore(document.createTextNode('시 '), timeSpan.nextSibling);
                parentDiv.insertBefore(minuteInput, timeSpan.nextSibling.nextSibling);
                parentDiv.insertBefore(planInput, eventSpan);
                parentDiv.insertBefore(document.createTextNode('분'), timeSpan.nextSibling.nextSibling.nextSibling);

                // 수정 버튼 클릭 시 저장 및 원상복구
                editButton.textContent = '저장';
            }
        }

        function deletePlanEvent(event) {
            var eventIdx = document.getElementById("eventIdxInput").value;
            location.href='deletePlan.jsp?eventIdx=' + eventIdx;
        }
        
        function timeBack(unit) {
            var numElement = document.querySelector('.modalTimeNum.' + unit);
            var hiddenInputElement = document.querySelector('input[name=' + unit + 'Hidden]');

            if (numElement && hiddenInputElement) {
                var currentNum = parseInt(numElement.textContent);

                if (currentNum > 0) {
                    numElement.textContent = (currentNum - 1).toString().padStart(2, '0');
                    hiddenInputElement.value = numElement.textContent;
                }
            }
        }

        function timeFront(unit) {
            var numElement = document.querySelector('.modalTimeNum.' + unit);
            var hiddenInputElement = document.querySelector('input[name=' + unit + 'Hidden]');

            if (numElement && hiddenInputElement) {
                var currentNum = parseInt(numElement.textContent);
                if (unit === 'hour' && currentNum < 23) {
                    numElement.textContent = (currentNum + 1).toString().padStart(2, '0');
                    hiddenInputElement.value = numElement.textContent;
                } else if (unit === 'minute' && currentNum < 59) {
                    numElement.textContent = (currentNum + 1).toString().padStart(2, '0');
                    hiddenInputElement.value = numElement.textContent;
                }
            }
        }

        
    function openModalEvent(selectedMonth, day) {

        var modal = document.getElementById('modal');
        var modalDate = document.getElementById('modalDate');
        var eventDate = document.getElementById('eventDate');

        // 전달받은 날짜를 모달 내부의 텍스트로 설정
        eventDate.value = selectedMonth + "월 " + day + "일 ";
        modalDate.textContent = selectedMonth + "월 " + day + "일 " + "일정";
        console.log(eventDate.value);
        modalCompareDate = eventDate.value;
        console.log(modalCompareDate);


        modal.style.display = 'flex';
        matchingIndices=[];
        doAdditionalWork();
    }

    function doAdditionalWork() {
        
        eventDateMatch = modalCompareDate.match(/(\d{1,2})월 (\d{1,2})일/);
        console.log(modalCompareDate);
        console.log(eventDateMatch);
        if (eventDateMatch != null) {
            var modalDay = "2023-" + eventDateMatch[1] + "-" + (eventDateMatch[2] < 10 ? '0' : '') + eventDateMatch[2];

            var dayList = <%=dayList%>;
            console.log(dayList);
            console.log(i, modalDay);
            console.log(i, modalDay == dayList[i]);


            for (var i = 0; i < dayList.length; i++) {
                console.log(modalDay == dayList[i]);
                if (modalDay == dayList[i]) {
                    matchingIndices.push(i);
                }
            }
            console.log(matchingIndices);
            var timeList = <%=timeList%>;
            console.log(timeList);
            var eventList = <%=eventList%>;
            var eventIdx = <%=eventIdx%>;
            var modalDate = document.getElementById("eventDate");
            console.log(modalCompareDate);



            for (var i = 0; i < matchingIndices.length; i++) {
                console.log(matchingIndices);
                {
                    var div = document.createElement("div");
                    var planDiv = document.createElement("div"); // 일정을 나타내는 요소와 modalbuttons를 묶는 div
                    var span = document.createElement("span");
                    var hidden = document.createElement("input");
                    var updateButton = document.createElement("button");
                    var deleteButton = document.createElement("button");
                    var buttonDiv = document.createElement("div"); // 수정, 삭제 버튼을 감싸는 div

                    hidden.type = "hidden";
                    hidden.name = "eventIdx"; // name 속성 추가
                    span.className = "planContext";
                    span.innerText = "일정시간 " + timeList[matchingIndices[i]] + " 일정내용 " + eventList[matchingIndices[i]];
                    hidden.value = eventIdx[matchingIndices[i]]; // 특정 인덱스 사용
                    hidden.id = "eventIdxInput"; 

                    buttonDiv.className = "modalButtons";

                    updateButton.className = "modalPlanButton";
                    updateButton.type = "button";
                    updateButton.innerText = "수정";
                    updateButton.onclick = function () {
                        updatePlanEvent(event, eventIdx[matchingIndices[i]]); // 수정 버튼 클릭 시 updatePlanEvent 함수 호출
                    };

                    deleteButton.className = "modalPlanButton";
                    deleteButton.type = "button";
                    deleteButton.innerText = "삭제";
                    deleteButton.setAttribute('onclick', 'deletePlanEvent()');
                    

                    // div에 span, hidden, form 추가
                    div.appendChild(span);
                    div.appendChild(hidden);

                    // buttonDiv에 버튼 추가
                    buttonDiv.appendChild(updateButton);
                    buttonDiv.appendChild(deleteButton);

                    // planDiv에 div, buttonDiv 추가
                    planDiv.appendChild(div);
                    planDiv.appendChild(buttonDiv);

                    // planDiv에 modalPlan 클래스 추가
                    planDiv.classList.add("modalPlan");

                    // planDiv를 planBox에 추가
                    planBox.appendChild(planDiv);

                    console.log(matchingIndices);
                }


            }

            console.log(dayList);
            console.log(modalDay);

        }

       




    }



</script>
</html>


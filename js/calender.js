var day = 0;
var selectedButton = null;
var selectedMonth = 0;

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
            yearHidden.value =  (numHidden - 1).toString().padStart(4, '0');
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
            yearHidden.value =  (numHidden + 1).toString().padStart(4, '0');
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

function openModalEvent(selectedMonth, day) {

    var modal = document.getElementById('modal');
    var modalDate = document.getElementById('modalDate');
    var eventDate = document.getElementById('eventDate');

    // 전달받은 날짜를 모달 내부의 텍스트로 설정
    eventDate.value = selectedMonth + "월 " + day + "일 ";
    modalDate.textContent = selectedMonth + "월 " + day + "일 " + "일정";
    console.log(eventDate.value);
    

    modal.style.display = 'flex'; 
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
    var parentDiv = event.target.closest('.modalPlan');
    parentDiv.style.display = "none";
}
function closeModalEvent() {
    var modal = document.getElementById('modal');
    modal.style.display = 'none';
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




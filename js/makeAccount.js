function checkDuplicate() {
    var idInput = document.getElementById('idBox');

    if (idInput.value.trim() === '') {
        alert('아이디를 입력하세요.');
    }
    else {
        alert("해당 아이디는 사용 가능합니다 / 해당 아이디는 중복이 아닙니다!");
    }

}


function checkNull() {
    var idInput = document.getElementById('idBox');
    var pwInput = document.getElementById('pwBox');

    if (idInput.value.trim() === '' || pwInput.value.trim() === '') {
        alert('아이디와 비밀번호를 입력하세요.');
    } else {
        location.href = "../html/mainCalendar.html";
    }
}

function searchPw() {
    var idInput = document.getElementById('idBox');
    var name = document.getElementById('nameBox');
    var tel = document.getElementById('pwBox');

    if (idInput.value.trim() === '' || tel.value.trim() === '' || name.value.trim() === '') {
        alert('아이디와 이름, 전화번호를 제대로 입력해 주세요.');
    } else {
        alert('비밀번호는 어쩌구 입니다.');
        location.href = "../html/login.html";
    }
}

function searchId() {
    var idInput = document.getElementById('idBox');
    var tel = document.getElementById('pwBox');

    if (idInput.value.trim() === '' || tel.value.trim() === '') {
        alert('이름과 전화번호를 입력하세요.');
    } else {
        alert('아이디는 어쩌구 입니다.');
        location.href = "../html/login.html";
    }
}



function checkNoInput() {
    var nameInput = document.getElementById('nameBox');
    var idInput = document.getElementById('idBox');
    var pwInput = document.getElementById('pwBox');
    var confirmPwInput = document.getElementById('comfirmPwBox');
    var numInput = document.getElementById('numBox');
    var teamInputs = document.querySelectorAll('input[name="team"]');
    var companyInputs = document.querySelectorAll('input[name="company"]');
    var phoneNumberRegex = /^\d+$/;  // 숫자만 허용하는 정규표현식

    if (nameInput.value.trim() === '' ||
        idInput.value.trim() === '' ||
        pwInput.value.trim() === '' ||
        confirmPwInput.value.trim() === '' ||
        numInput.value.trim() === '') {
        alert('모든 필수 입력란을 채워주세요.');
    } else if (!/^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/.test(pwInput.value.trim())) {
        alert('비밀번호는 6~16자리이며, 숫자, 영어, 특수문자가 각각 하나 이상 포함되어야 합니다.');
    } else if (pwInput.value.trim() !== confirmPwInput.value.trim()) {
        alert('비밀번호와 확인 비밀번호가 일치하지 않습니다.');
    } else if (!phoneNumberRegex.test(numInput.value.trim())) {
        alert('전화번호는 숫자만 입력해주세요.');
    } else if (!validateRadioSelection(teamInputs) || !validateRadioSelection(companyInputs)) {
        alert('부서명과 직급을 선택해주세요.');
    } else {
        alert('회원가입에 성공하였습니다.');
        location.href = "../html/logIn.html";
    }
}

function validateRadioSelection(radioInputs) {
    for (var i = 0; i < radioInputs.length; i++) {
        if (radioInputs[i].checked) {
            return true;
        }
    }
    return false;
}


function selectTeam(value) {//성별 작성
    var team = value;
    console.log('Selected Team:', team);
    // 이 부분에서 서버로 값을 전달하거나 변수에 저장하는 등의 작업을 수행할 수 있습니다.
}
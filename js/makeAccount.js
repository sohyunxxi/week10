function checkIdDuplicate() {
    var idInput = document.getElementById('idBox');
    var idValue = idInput.value.trim();
    var idRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,12}$/;

    if (idValue === '') {
        alert('아이디를 입력하세요.');
    } else if (!idRegex.test(idValue)) {
        alert('아이디는 영어와 숫자를 포함하여 4자리 이상 12자리 이하로 설정해주세요.');
    } else {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'checkIdDuplicate.jsp', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.send('id=' + idValue);

        // 응답값 확인 및 처리
        var isDuplicate = xhr.responseText.trim() === 'true';
        if (isDuplicate) {
            alert('이미 사용 중인 아이디입니다.');
        } else {
            // 아이디 사용 가능한 경우 모달 창 열기
            modalOpen('아이디 사용 가능합니다!');
        }
    }
}



function modalOpen(response) {
    var modalText = document.getElementById('modalText');
    var useIdButton = document.getElementById('useIdButton');
    var modal = document.getElementById('myModal');
    var idInput = document.getElementById('idBox');
    var checkButton = document.getElementById('checkButton');

    if (response === 'true') {
        modalText.textContent = '해당 아이디는 중복입니다. 다른 아이디를 사용해 주세요.';
        useIdButton.style.display = 'none';
        idInput.disabled = true; // 아이디 입력 상자를 비활성화
        checkButton.style.display = 'none'; // 중복 확인 버튼을 숨김
    } else {
        modalText.textContent = '해당 아이디는 사용이 가능합니다.';
        useIdButton.style.display = 'inline-block';
    }

    // Show the modal
    modal.style.display = 'block';
}

function useId() {
    // 아이디 입력 상자 숨기기
    var idInput = document.getElementById('idBox');
    console.log(idInput.value);

    idInput.setAttribute('type', 'hidden');

    // 중복 확인 버튼 숨기기
    var checkButton = document.getElementById('checkButton');
    checkButton.style.display = 'none';

    // 모달 창 닫기
    closeModal();

    // 여기서부터는 숨긴 input 값을 활용하는 로직
    var temp = idInput.value;
    var div = document.createElement("div");
    // div.id = "idBox";
    var idAppendBox = document.getElementById("idAppendBox");
    idAppendBox.appendChild(div);
    div.innerHTML = temp;
    console.log(idInput.value);

}


function closeModal() {
    // 모달 창 닫기
    var modal = document.getElementById('myModal');
    modal.style.display = 'none';
}



function checkNull() {
    var idInput = document.getElementById('idBox');
    var pwInput = document.getElementById('pwBox');

    if (idInput.value.trim() === '' || pwInput.value.trim() === '') {
        alert('아이디와 비밀번호를 입력하세요.');
    } else {
        location.href="../jsp/loginAction.jsp"
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
        location.href = "../jsp/login.jsp";
    }
}

function searchId() {
    var idInput = document.getElementById('idBox');
    var tel = document.getElementById('pwBox');

    if (idInput.value.trim() === '' || tel.value.trim() === '') {
        alert('이름과 전화번호를 입력하세요.');
    } else {
        alert('아이디는 어쩌구 입니다.');
        location.href = "../jsp/login.jsp";
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
    var idRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,12}$/;  // 영어와 숫자를 포함하고, 4자리 이상 12자리 이하

    if (nameInput.value.trim() === '' ||
        idInput.value.trim() === '' ||
        pwInput.value.trim() === '' ||
        confirmPwInput.value.trim() === '' ||
        numInput.value.trim() === '') {
        alert('모든 필수 입력란을 채워주세요.');
    } else if (!idRegex.test(idInput.value.trim())) {
        alert('아이디는 영어와 숫자를 포함하여 4자리 이상 12자리 이하로 설정해주세요.');
    } else if (!/^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/.test(pwInput.value.trim())) {
        alert('비밀번호는 6~16자리이며, 숫자, 영어, 특수문자가 각각 하나 이상 포함되어야 합니다.');
    } else if (pwInput.value.trim() !== confirmPwInput.value.trim()) {
        alert('비밀번호와 확인 비밀번호가 일치하지 않습니다.');
    } else if (!phoneNumberRegex.test(numInput.value.trim())) {
        alert('전화번호는 숫자만 입력해주세요.');
    } else if (!validateRadioSelection(teamInputs) || !validateRadioSelection(companyInputs)) {
        alert('부서명과 직급을 선택해주세요.');
    } else {
       // alert('회원가입에 성공하였습니다. 로그인해 주세요');
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
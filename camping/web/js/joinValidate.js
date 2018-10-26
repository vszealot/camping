/*회원가입 유효성 검사*/
function validate() {
	// 아이디가 적합한지 검사할 정규식
	var re = /^[a-zA-Z0-9]{4,12}$/ 
	//패스워드가 적합한지 검사할 정규식
	var re1 = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,15}$/ 
	// 이메일이 적합한지 검사할 정규식
	var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	var userId = document.getElementById("userId");
	var userEmail = document.getElementById("userEmail");
	var nickName = document.getElementById("nickName");
	var password = document.getElementById("password");
	var passwordCheck = document.getElementById("passwordCheck");

	
	if (!check(re, userId, "아이디는 4~12자의 영문 대소문자와 숫자로만 입력")) {
		return false;
	}
	if(userEmail.value=="") {
        alert("이메일을 입력해 주세요");
        userEmail.focus();
        return false;
    }
	if(!check(re2, userEmail, "적합하지 않은 이메일 형식입니다.")) {
        return false;
    }
	if(nickName.value==""){
		alert("닉네임을 입력해주세요");
		nickName.focus();
		return false;
	}
	if (!check(re1, password, "패스워드는 비밀번호는 영문 숫자 특수문자의 조합으로 8자리 이상을 입력")) {
		return false;
	}
	if(join.password.value != join.passwordCheck.value) {
        alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
        join.passwordCheck.value = "";
        join.passwordCheck.focus();
        return false;
    }
	alert("회원가입이 완료되었습니다.");
}

function check(re, what, message) {
    if(re.test(what.value)) {
        return true;
    }
    alert(message);
    what.value = "";
    what.focus();
    //return false;
}

// AJAX 아이디, 닉네임, 이메일 중복검사--------------------------------
// 아이디 중복 검사
function checkId(){
	 var inputed = $('#userId').val();

	 $.ajax({
		 type:"GET",
		 data : {"userId":inputed},
		 dataType:"text",
         url : "checkId.do",
         error : function(){
        	 console.log("실패");
         },
         success : function(data) {
        	 if(inputed==""){
        		 $('#checkText').html('<p style="color:red">아이디를 입력하세요</p>');
        	 }else{
        		 if(data>0) {
        			 $('#checkText').html('<p style="color:red">이미 등록된 아이디입니다</p>');
        		 }else{
        			 $('#checkText').html('<p style="color:green">등록 가능한 아이디입니다</p>');
        		 }
        	 }
         }
	 });
}
//닉네임 중복검사
function checkNickname(){
	 var inputed = $('#nickName').val();

	 $.ajax({
		 type:"GET",
		 data : {"nickName":inputed},
		 dataType:"text",
        url : "checkNickname.do",
        error : function(){
       	 console.log("실패");
        },
        success : function(data) {
        	if(inputed==""){
        		$('#checkText2').html('<p style="color:red">닉네임을 입력하세요</p>');
        	}else{
        		if(data>0) {
        			$('#checkText2').html('<p style="color:red">이미 등록된 닉네입입니다</p>');
       		 	}else{
       		 		$('#checkText2').html('<p style="color:green">등록 가능한 닉네임입니다</p>');
       		 	}
        	}
        }
	 });
}
//비밀번호 일치 검사
function checkpwd(){
	var pwd = document.getElementById("password").value;
    var pwdCheck = document.getElementById("passwordCheck").value;

    if (pwd != pwdCheck) {
    	$('#checkText3').html('<p style="color:red">비밀번호가 일치하지 않습니다</p>');
        return false;
    }else if(pwd == pwdCheck){
    	$('#checkText3').html('<p style="color:green">비밀번호가 일치합니다</p>');
    	  return true;
    }
}











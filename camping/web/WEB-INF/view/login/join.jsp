<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 회원가입 유효성 검사 -->
<script>
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
</script> 
</head>
<body>

<!--  -->
<div id="loginjoin">
	<a href="./?mod=login&amp;iframe=Y">로그인</a>
	<a href="./?mod=join&amp;iframe=Y" class="active">회원가입</a>
</div>

<div id="pages_join">
	<form name="join" action="joinProc.do" method="post" onsubmit="return validate()">
		<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="userId" id="userId"/></td>
		</tr>	
		<tr>	
			<td>이메일</td>
			<td><input type="text" name="userEmail" id="userEmail"/></td>
		</tr>
		<tr>	
			<td>닉네임</td>
			<td><input type="text" name="nickName" id="nickName"/></td>
		</tr>
		<tr>	
			<td>패스워드</td>
			<td><input type="password" name="password" id="password"/></td>
		</tr>
		<tr>	
			<td>패스워드 확인</td>
			<td><input type="password" name="passwordCheck" id="passwordCheck"/></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="회원등록">  
			</td>
		</tr>
		</table>
	</form>
</div>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- 회원가입 유효성 검사 -->
<script src="<c:url value="/js/joinValidate.js" />"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>

<!--  -->
<div id="loginjoin">
	<a href="login.do">로그인</a>
	<a href="join.do" class="active">회원가입</a>
</div>

<div id="pages_join">
	<form name="join" action="joinProc.do" method="post" onsubmit="return validate()">
		<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="userId" id="userId" placeholder="아이디를 입력하세요" oninput="checkId()"/></td>
<!-- 			<td><input type="button" onclick="checkId()" value="아이디 중복검사"/></td> -->
			<td><div id="checkText"></div></td>
		</tr>	
		<span id="result"></span>
		<tr>	
			<td>이메일</td>
			<td><input type="text" name="userEmail" id="userEmail" placeholder="이메일을 입력하세요"/></td>
		</tr>
		<tr>	
			<td>닉네임</td>
			<td><input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" oninput="checkNickname()"/></td>
			<td><div id="checkText2"></div></td>
		</tr>
		<tr>	
			<td>패스워드</td>
			<td><input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요"/></td>
		</tr>
		<tr>	
			<td>패스워드 확인</td>
			<td><input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호를 다시 입력하세요" oninput="checkpwd()"/></td>
			<td><div id="checkText3"></div></td>
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
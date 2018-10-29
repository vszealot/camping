<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- 로그인 유효성 검사 -->
<script src="<c:url value="/js/loginValidata.js" />"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

</head>
<body>

<!-- 로그인/회원가입 탭 -->
<div id="loginjoin">
	<a href="login.do">로그인</a>
	<a href="join.do" class="active">회원가입</a>
</div>

<!-- 로그인 페이지 -->
<div id="pages_login">
	<form action="loginProc.do" method="post">
		<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="userId"/></td>
		</tr>	
		<tr>	
			<td>패스워드</td>
			<td><input type="password" name="password"/></td>
		</tr>
		<!-- <tr>
			<td>
				<input type="checkbox"  name="useCookie">로그인 유지  
			</td>
		</tr> -->
		<!-- 로그인 일치 확인 -->
		<tr>
			<td colspan="2"><div id="checkText"></div></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="로그인"/>  
				<a href="searchIdPassword.do">아이디/비밀번호 찾기</a>
			</td>
		</tr>
		</table>
	</form>
	
</div>

</body>
</html>
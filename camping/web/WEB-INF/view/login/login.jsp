<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 로그인/회원가입 탭 -->
<div id="loginjoin">
	<a href="./?mod=login&amp;iframe=Y" class="active">로그인</a>
	<a href="./?mod=join&amp;iframe=Y">회원가입</a>
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
		<tr>
			<td>
				<input type="checkbox"  name="useCookie">로그인 유지  
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit"  value="로그인">  
			</td>
		</tr>
		</table>
	</form>
	
</div>

</body>
</html>
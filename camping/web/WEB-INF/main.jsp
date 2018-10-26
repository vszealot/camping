<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	div#header{
		background-color: #BDBDBD;
	}
</style>
</head>
<body>
<div id="header">
	<div id="logo">
		<h1>
			<a href="./">
				<img src="" alt="캠핑가즈아(로고)">
			</a>
		</h1>
	</div>
	
	<div id="topmenu">
		<ul>
			<li>
				<a href="">전체</a>
			</li>
			<li>
				<a href="">글램핑/카라반</a>
			</li>
			<li>
				<!-- //캠핑장소 검색------------------------------------------------------------ -->
			<form method="post"  action="searchProc.do">
				<input type="text" name="searchWord" id="searchWord">
				<input type="submit" value="검색" />
				</form>
			
			</li>
			<li>
			<c:if test="${empty logOK }">
				<a href="/camping/login.do">로그인</a>
				<a href="/camping/join.do">회원가입</a>
			</c:if>
			<c:if test="${!empty logOK }">
				<a href="/camping/logout.do">로그아웃</a>
				<b>${logOK.nickName}</b>님이 환영합니다.
			</c:if>
			</li>
		</ul>
	</div>
</div>

<!-- 로그인/회원가입 hover -->
<script>
$(document).ready(function(){
	$(".topmenu li").hover(
	function(){
		$(this).children('ul').hide();
		$(this).children('ul').show();
	},
	function () {
		$('ul', this).hide();            
	});
});
</script>


</body>
</html>
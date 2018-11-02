<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
	div#header{
		background-color: #151515;
		height: 120px;
		weight: 100%;
		position: relative;
	}
	.logo{
		float:left;
	}
	.login{
		float:right;
	}
	.login ul{
		padding: 20px;
	}
	li{
		list-style: none;
	}
	.login li a{
		padding-right: 20px;
	}
	.topmenu{
		padding-left: 200px;
		position: absolute;
		bottom: 10px;
		font-size: 20px;
		font-family: "나눔고딕";
		font-weight: bold;
		color: black;
	}
	.topmenu li{
		float:left;
		padding-left: 50px;
	}
</style>
</head>
<body>
<div id="header">
	<div class="logo">
		<a href="./">
			<img src="image/campingLogo_213x120_수정.jpg" alt="캠핑가즈아(로고)">
		</a>
	</div>
	
	<div class="login">
		<ul>
			<li>
			<c:if test="${empty logOK }">
				<a href="/camping/login.do" class="loginBtn">로그인</a>
				<a href="/camping/join.do" class="joinBtn">회원가입</a>
				
			</c:if>
			<c:if test="${!empty logOK}">
				<b>${logOK.nickName}</b>님이 환영합니다.
				<a href="/camping/logout.do">로그아웃</a>
				<a href="/camping/update.do">회원정보수정</a>
				<!-- 마스터 계정 로그인 -->
				<c:if test="${logOK.userId eq 'master'}">
					<a href="">공지사항 등록</a>
					<a href="">캠핑장 등록 대기</a>
					<a href="/camping/userInfo.do">회원목록조회</a>
				</c:if>
			</c:if>
			</li>
		</ul>
	</div>
	
	<div class="topmenu">
		<ul>
			<li>
			<!-- //캠핑장소 검색------------------------------------------------------------ -->
				<form method="post"  action="searchProc.do">
					<input type="text" name="searchWord" id="searchWord">
					<input type="submit" value="검색" />
				</form>
			</li>
			<li>
				<a href="">전체</a>
			</li>
			<li>
				<a href="">글램핑/카라반</a>
			</li>
			<li><a href="marketListSearch.do">유저 장터</a></li>
			<li><a href="">후기 게시판</a></li>
			<li><a href="">질문 게시판</a></li>
		</ul>
	</div>
</div><!-- end header -->


</body>
</html>
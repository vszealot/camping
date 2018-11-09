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
div#header {
	background-color: #151515;
	height: 120px;
	weight: 100%;
	position: relative;
}

.logo {
	float: left;
}

.login {
	float: right;
}

.login ul {
	padding: 20px;
}

li {
	list-style: none;
}

.login li a {
	padding-right: 20px;
}

.topmenu {
	padding-left: 200px;
	position: absolute;
	bottom: 10px;
	font-size: 20px;
	font-family: "나눔고딕";
	font-weight: bold;
	color: black;
}

.topmenu li {
	float: left;
	padding-left: 50px;
}

.hello {
	color: white;
	display: inline-block;
	padding-right: 20px;
}

.topmenu a:link {
	color: white;
	text-decoration: none;
}

.topmenu a:visited {
	color: white;
	text-decoration: none;
}

.topmenu a:hover {
	color: blue;
	text-decoration: none;
}
th{
	text-align: center;
}
.dropbtn{
	background-color: #151515;
	padding: 0px;
	border: 0px;
	outline: none;
	font-weight: bold;
}
/* 쪽지함 */
.dropdown {
    position: relative;
    display: inline-block;
}
.dropdown-content {
    display: none;
    background-color: #f1f1f1;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    text-align: center;
    width: 150px;
}
.show {display: block;}
.dropdown a:hover {background-color: #ddd;}
.dropdown-content a {
    color: black;
    padding: 8px 0px;
    text-decoration: none;
    display: block;
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
				<div class="hello">
					<div class="dropdown">
					<button onclick="myFunction()" class="dropbtn">${logOK.nickName}</button>님이 환영합니다
						
					</div>
				</div>
				<a href="/camping/logout.do">로그아웃</a>
				<a href="/camping/update.do">회원정보수정</a>
				<!-- 마스터 계정 로그인 -->
				<c:if test="${logOK.grade eq '운영자'}">
					<a href="/camping/notice.do">공지사항 등록</a>
					<a href="/camping/campEnrollWait.do">캠핑장 등록 대기</a>
					<a href="/camping/userInfoView.do">회원목록조회</a>
				</c:if>
				<!-- 쪽지함 -->
				<div id="myDropdown" class="dropdown-content">
					<a href="/camping/noteReceiveView.do">쪽지함 보기</a>
				</div>
			</c:if>
			</li>
		</ul>
	</div>
	
	<div class="topmenu">
		<ul>
			
			<li>
				<a href="">전체</a>
			</li>
			<li>
				<a href="">글램핑/카라반</a>
			</li>
			<li><a href="marketListSearch.do">유저 장터</a></li>
			<li><a href="reviewListSearch.do">후기 게시판</a></li>
			<li><a href="qnaListSearch.do">질문 게시판</a></li>
		</ul>
	</div>
</div><!-- end header -->

<!-- 쪽지함 -->
<script>
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
</script>

</body>
</html>
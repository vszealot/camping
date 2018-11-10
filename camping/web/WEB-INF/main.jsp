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
/* 따봉! */
.thumbsup{
	position: absolute;
    top: 0px;
    right: 150px;
}
.recommendbutton{
background-image: url("/camping/image2/주먹.png");
	width: 64px;
    height: 64px;
    position: absolute;
    top: 50px;
    right: 350px;
}

.recommendbutton:hover{
background-image: url("/camping/image2/따봉.png");
}

.recommendcount{
	position: absolute;
    top: 115px;
    right: 375px;
    font-size: large;
    color: orange;
}


* {
font-family: 'Jua', sans-serif;
font-weight : 500;
letter-spacing: 1.5px;
}
.campname{
	padding-top : 6px;
  font-family: 'Jua', sans-serif;
  font-size:20px;
  letter-spacing: 1.5px;
}
.distance{
	color:#FF8224;
	font-family: 'Jua', sans-serif;
	font-weight: 500;
	font-size:15px;
	letter-spacing: 1.5px;
}


.addr{
	color:#363636;
	font-family: 'Jua', sans-serif;
	font-weight: 100;
	font-size:13px;
	letter-spacing: 1.5px;
}

.phone{
	color:#363636;
	font-family: 'Jua', sans-serif;
	font-weight: 100;
	font-size:13px;
	letter-spacing: 1.5px;
}
div#select_box {
    position: relative;
    display: inline-block;
    width: 200px;
    height: 34px;
    background: url(http://cfile1.uf.tistory.com/image/27423E43565F8EF627B215) 0 center no-repeat;
}

div#select_box label {
  position: absolute;
  font-size: 13px;
  font-family: 'Jua', sans-serif;
  color: #fff;
  top: 9px;
  left: 12px;
  letter-spacing: 2px;
  font-weight: 500;
}

div#select_box select#color {
  width: 100%;
  height: 32px;
  min-height: 32px;
  line-height: 32px;
  padding: 0 10px;
  opacity: 0;
  filter: alpha(opacity=0);
  /* IE 8 */
}

.search{
padding-left:40px;
padding-bottom: 5px;
}
/* 검색창 css */
.green_window {
	display: inline-block;
	width: 366px; height: 34px;
	border: 3px solid #212121;
	background: white;
}
.input_text {
	width: 348px; height: 21px;
	margin: 6px 0 0 9px;
	border: 0;
	line-height: 21px;
	font-size: 16px;
	font-family: 'Jua', sans-serif;
	outline: none;
}
.sch_smit2 {
	width: 54px; height: 34px;
	margin: 0; border: 0;
	vertical-align: top;
	background: white;
	color: white;
	font-size:16px;
	border-radius: 1px;
	cursor: pointer;
	font-family: 'Jua', sans-serif;
}
.sch_smit2:hover {
	background: #747474;
}

.sch_smit {
	width: 54px; height: 34px;
	margin: 0; border: 0;
	vertical-align: top;
	background: #212121;
	color: white;
	font-size:16px;
	border-radius: 1px;
	cursor: pointer;
	font-family: 'Jua', sans-serif;
}
.sch_smit:hover {
	background: #747474;
}


.button-7{
  width:68px;
  height:34px;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 5px 5px;
  display:inline-grid;
}
.normal{
  font-family: 'Jua', sans-serif;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:33px;
  transition:all 1s ease;
  z-index:2;
  position:relative;
}

.special{
	font-family: 'Jua', sans-serif;
  font-size:16px;
  text-decoration:none;
  line-height:33px;
  transition:all 1s ease;
  z-index:2;
  position:relative;
	color:orange;
}

.eff-7{
  width:68px;
  height:34px;
  border:0px solid #34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
  box-sizing:border-box;
}
.button-7:hover .eff-7{
  border:20px solid #6799FF;
}
.button-7:hover a{
  color:#fff;
}



.camptable{
border-bottom :1px solid gray;
border-top:1px solid gray;
width:100%;
padding:0px;

}

.body{
width : 1519px;
height : 690px;
overflow-y: hidden;
overflow-x: hidden;
padding:0px;
margin:0;

}

/* img : 캠핑장 사진 태그 */
.img{
padding: 10px;
marding: 10px;

}
.pagination{
margin-left: auto;
margin-right: auto;
display:table;
}
.inline{
display : inline;
}
ul{
list-style: none;
}
.left-box {
	overflow-y: scroll;
	padding : 0px;
	margin : 0px;
	display: inline-block;
	width: 512px;
	height:520px;
	border-top: 1px solid gray;
	font-size: 12px;
	
}

.right-box {
	padding : 0px;
	margin : 0px;
	display: inline-block;
	position : absolute;
	top:120px;
	width: 1007px;
	height:600px;
	border: 1px solid white;
}
/* 사이드 정보 css */
.scroll-menu{
    top: 120px;
    right: 780px;
    cursor: pointer;
}

.scroll-menu:hover{
  opacity: 0.9;
}

.side-open{
    top: 120px;
    right: 0px;
    cursor: pointer;
}

.side-open:hover{
  opacity: 0.5;
}


.sidebar{
height:85.5%;
width:800px;background-color:#F6F6F6;position:fixed; top:120px; right:0px;z-index:1; overflow-x : hidden; overflow-y : scroll;}
.sideblock{
text-align:left;
display:block;border:none;white-space:normal;float:none;outline:0;

}

.sidedarkgrey{z-index: 3;color:black!important;background-color:#F6F6F6!important};
.sideanimate{position:relative;animation:animateright 0.8s}@keyframes animateright{from{right:600px;opacity:0} to{right:0;opacity:1}}


.sideitem{
width:100%;
display:block;
padding:8px 16px;
border:none;
white-space:normal;
float:none;
outline:0;
text-align:center;
};

.sidelarge{font-size:18px!important}


.w3-container:after,.w3-container:before{content:"";display:table;clear:both};
.weather-temp{
	overflow:scroll;
	/* overflow-x:hidden;
	overflow-y:hidden; */
}
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
	color: black;
	font-family: 'Jua', sans-serif;
	font-weight : 500;
	letter-spacing: 1.5px;
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
					<c:if test="${logOK.noteCnt ne 0}">
						<div id="noteCnt" style="background-color:red; border-radius:1em; height:15px;width:15px; text-align:center;vertical-align:middle; ">
							${logOK.noteCnt}
						</div>
					</c:if>
					<button onclick="myFunction()" class="dropbtn">${logOK.nickName}</button>님이 환영합니다
						
					</div>
				</div>
				<a href="/camping/logout.do">로그아웃</a>
				<a href="/camping/update.do">회원정보수정</a>
				<!-- 마스터 계정 로그인 -->
				<c:if test="${logOK.grade eq '운영자'}">
					<a href="/camping/noticeListSearch.do">공지사항 등록</a>
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
				<a href="campList.do">전체</a>
			</li>
			<li>
				<a href="carvanList.do">글램핑/카라반</a>
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
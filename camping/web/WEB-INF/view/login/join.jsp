<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/main.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

<!--css---------------------------------------------->

<!-- 회원가입 유효성 검사 -->
<script src="<c:url value="/js/joinValidate.js" />"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<style type="text/css">
	.loginjoin{
    	text-align: center;
    	font-size: 40px;
    	margin-top: 50px;
    }
    .loginjoin a{
    	padding: 20px;
    }
    .pages_join{
    	margin: 550px;
    	margin-bottom: 350px;
    	margin-top: 60px; 
    }
     .btn btn-primary{
    	width: 150px;
    }
</style>

</head>
<body>

<!-- 로그인/회원가입 탭 -->
<div class="loginjoin">
	<a href="login.do">로그인</a>
	<a href="join.do" class="active">회원가입</a>
</div>

<div class="pages_join">
	<form name="join" action="joinProc.do" method="post" onsubmit="return validate()">
		<div class="form-group">
			<label for="userId">아이디</label><br><br>
			<input type="text" class="form-control" name="userId" id="userId" placeholder="아이디를 입력하세요" oninput="checkId()" required/></td>
			<br>
			<div id="checkText"></div>
		</div>
		<span id="result"></span>
		
		<div class="form-group">
			<label for="userEmail">이메일</label><br><br>
			<input type="text" class="form-control" name="userEmail" id="userEmail" placeholder="이메일을 입력하세요" required/>
		</div>
		
		<div class="form-group">
			<label for="nickName">닉네임</label><br><br>
			<input type="text" class="form-control" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" oninput="checkNickname()" required/>
			<div id="checkText2"></div>
		</div>
		
		<div class="form-group">	
			<label for="password">패스워드</label><br><br>
			<input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요" required/>
		</div>
		
		<div class="form-group">
			<label for="passwordCheck">패스워드 확인</label><br><br>
			<input type="password" class="form-control" name="passwordCheck" id="passwordCheck" placeholder="비밀번호를 다시 입력하세요" oninput="checkpwd()" required/>
			<div id="checkText3"></div>
		</div><br><br>
		
		<input type="submit" class="btn btn-primary" value="회원등록">  
	</form>
</div>


</body>
</html>
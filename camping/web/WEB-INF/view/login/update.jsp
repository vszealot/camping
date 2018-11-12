<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/main.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<script src="<c:url value="/js/updateValidate.js" />"></script>

<!-- css -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

<!--css---------------------------------------------->
<style type="text/css">
	.updateTop{
    	text-align: center;
    	font-size: 40px;
    	margin-top: 50px;
    }
    .pages_update{
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
<div class="updateTop">
	회원정보수정
</div>
<div class="pages_update">
	<form method="POST" name="regForm">
		<div class="form-group">
			<label for="userId">아이디</label><br><br>
			<input type="text" id="userId" name="userId" value="${logOK.userId }" readonly="readonly" class="form-control">
		</div>	
		<div class="form-group">
			<label for="userEmail">이메일</label><br><br>
			<input type="text" id="userEmail" name="userEmail" value="${logOK.userEmail }" class="form-control" required>
		</div>	
		<div class="form-group">
			<label for="nickName">닉네임</label><br><br>
			<input type="text" id="nickName" name="nickName" value="${logOK.nickName }" oninput="checkNickname()" class="form-control" required>
			<div id="checkText"></div>
		</div>
		<div class="form-group">
			<label for="password">현재 비밀번호</label><br><br>
			<input type="password" id="password" name="password" placeholder="현재 비밀번호를 입력하세요" oninput="checkpassword()" class="form-control" required>
			<div id="checkText2"></div>
		</div>
		<div class="form-group">
			<label for="newPassword">비밀번호</label><br><br>
			<input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호를 입력하세요" class="form-control" required>
		</div>
		<div class="form-group">
			<label for="newPasswordCheck">비밀번호 확인</label><br><br>
			<input type="password" id="newPasswordCheck" name="newPasswordCheck" placeholder="비밀번호를 다시 입력하세요" oninput="checkpwd()" class="form-control" required>
			<div id="checkText3"></div>
		</div><br><br>	
		
		<input type="button" value="회원정보 수정" id="update_btn" class="btn btn-primary"/>
		<div class="updateTop">
			회원탈퇴
		</div><br><br>

		<div class="form-group">
				<label for="Password2">비밀번호</label><br><br>
				<input type="password" id="Password2" name="Password" placeholder="비밀번호를 입력하세요" oninput="checkpassword2()" class="form-control" required>
				<div id="checkText4"></div>
		</div>
		<div class="form-group">
				<label for="PasswordCheck2">비밀번호 확인</label><br><br>
				<input type="password" id="PasswordCheck2" name="PasswordCheck" placeholder="비밀번호를 다시 입력하세요" oninput="checkpwd2()" class="form-control" required>
		</div>
		<input type="button" value="회원 탈퇴" id="delete_btn" class="btn btn-primary"/><br>
	</form>
</div>
</body>
</html>
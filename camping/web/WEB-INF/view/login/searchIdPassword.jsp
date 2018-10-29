<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script>
$(document).on('click','#findId',function(){
	var userEmail=$('#userEmail').val();
	var nickName=$('#nickName').val();
	
	var postData={'userEmail':userEmail, 'nickName':nickName};
	console.log(postData);
	$.ajax({
		url:'findingId.do',
		type:'POST',
		data:postData,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    dataType : "json",
	    success: function(data){
		    var idfind=data.userId;
	    	if(idfind=='null'){
	    		alert('정보를 다시 입력해주세요');
	    	}else{
		    	$("#idList").html("<p>"+"회원님의 정보로 등록된 아이디는 : "+idfind+"입니다.</p>")
	    	} 
	    },
	    error: function(XMLHttpRequset,textStatus,errorThrown){
	   		alert('정보를 다시 입력해주세요');
	    }
	});
});
</script>

</head>
<body>
<!-- 로그인/회원가입 탭 -->
<div id="loginjoin">
	<a href="login.do">로그인</a>
	<a href="join.do" class="active">회원가입</a>
</div>
<h1>아이디 비밀번호 찾기</h1>

	<form>
		이메일 <input type="text" name="userEmail" id="userEmail" placeholder="abc@abc.com"><br>
		닉네임 <input type="text" name="nickName" id="nickName"><br>
	</form>
	<button id="findId">아이디 찾기</button>
	<br>
	<br>

	<span id="idList"></span>

	<form action="findPassword.do" method="post">
		아이디 <input type="text" name="userId" id="userId"><br>
		이메일 <input type="text" name="userEmail" id="userEmail" placeholder="abc@abc.com"><br>
		<input type="submit" id="findPassword" value="비밀번호 찾기">
	</form>
	
</body>
</html>
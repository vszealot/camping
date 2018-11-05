<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script src="<c:url value="/js/searchIdPassword.js" />"></script>
<script type="text/javascript">
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

<style type="text/css">
	.serachTop{
    	text-align: center;
    	font-size: 40px;
    	margin-top: 50px;
    }
    .search{
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
<div class="serachTop">
	<h1>아이디 비밀번호 찾기</h1>
</div>
<div class="search">
	<form>
		<div class="form-group">
			<label for="userEmail">이메일</label><br><br>
			<input type="text" name="userEmail" id="userEmail" placeholder="abc@abc.com" class="form-control" required>
		</div>
		<div class="form-group">
			<label for="nickName">닉네임</label><br><br>
			<input type="text" name="nickName" id="nickName" class="form-control" required><br>
		</div>
	</form>
	<button id="findId" class="btn btn-primary">아이디 찾기</button>
	<br>
	<br>

	<span id="idList"></span>

	<form action="findPassword.do" method="post">
		<div class="form-group">
			<label for="userId">아이디</label><br><br>
			<input type="text" name="userId" id="userId" class="form-control" required><br>
		</div>
		<div class="form-group">
			<label for="userEmail">이메일</label><br><br>
			<input type="text" name="userEmail" id="userEmail" placeholder="abc@abc.com" class="form-control" required><br>
		</div>
		<input type="submit" id="findPassword" value="비밀번호 찾기" class="btn btn-primary">
	</form>
</div>	
</body>
</html>
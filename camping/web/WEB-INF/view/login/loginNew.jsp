<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<!-- 로그인 유효성 검사 -->
<script src="<c:url value="/js/loginValidata.js" />"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- 로그인 API -->
<script src="<c:url value="/js/loginAPI.js" />"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="http://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
<style type="text/css">
    .loginjoin{
    	text-align: center;
    	font-size: 40px;
    	margin-top: 50px;
    }
    .loginjoin a{
    	padding: 20px;
    }
    .login{
    	margin: 550px;
    	margin-bottom: 350px;
    	margin-top: 60px; 
    }
    .searchIdPassword{
    	float: right;
    }
    .btn btn-primary{
    	width: 150px;
    }
    .loginAPI{
    	text-align: center;
    }
    .facebookBtn{
    	display: inline-block;
    	padding: 10px;
    	height: 50px;
    	width: 100px;
    }
    .naverBtn{
    	display: inline-block;
    	padding: 10px;
    	height: 50px;
    	width: 100px;
    }
    .checkText{
    	font-size: 15px;
    	color: red;
    }
</style>
</head>
<body>
<!-- 로그인/회원가입 탭 -->
<div class="loginjoin">
	<a href="login.do">로그인</a>
	<a href="join.do" class="active">회원가입</a>
</div>

<!-- 로그인 페이지 -->
<div class="login">
	<form action="loginProc.do" method="post">
		 <div class="form-group">
		 	 <label for="userId">아이디</label><br><br>
           	 <input type="text" class="form-control" name="userId" id="userId" placeholder="아이디를 입력하세요" required/>
		 </div><br><br>
		
		 <div class="form-group">
		 	 <label for="password">패스워드</label><br><br>
           	 <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요" required/>
		 </div><br>

		<div id="checkText" class="checkText">일치하는 아이디나 비밀번호가 존재하지 않습니다</div><br><br>

		<!-- 로그인 버튼 -->
		<input type="submit" value="로그인" class="btn btn-primary" style= "width:226px;"/><br><br>  
		
		
		<!-- 아이디/비밀번호 찾기 -->
		<div class="searchIdPassword">
			<a href="searchIdPassword.do">아이디/비밀번호 찾기</a>
		</div>
	</form><br><br><br>
	
	<!-- 로그인 API -->
	<div class="loginAPI">
	
	<!-- 페이스북 버튼 추가-->
	<fb:login-button scope="public_profile, email" onlogin="checkLoginState();" class="facebookBtn"></fb:login-button>
	
	<!-- 카카오 버튼 추가 -->
	<a id="kakao-login-btn" class="kakaoBtn"></a>
	
	<!-- 네이버 버튼 추가 -->
	<div id="naverIdLogin" class="naverBtn"></div>
		<script type="text/javascript">
			var naverLogin = new naver.LoginWithNaverId({
				clientId : "jdmecvH11xnoP5rU67xq",
				callbackUrl : "http://localhost:8088/camping/callback.do",
				isPopup : false,
				loginButton : {
					color : "green",
					type : 2,
					height : 30
				},
				callbackHandle: true
			});
	
			naverLogin.init();
		</script>
	<!-- ************************************************************************** -->
		<!-- <script type="text/javascript">
		Kakao.init('6ba4bb8eff3e395e059315260d154426');
	
		// 카카오 로그인 버튼을 생성합니다.
		  Kakao.Auth.createLoginButton({
			container : '#kakao-login-btn',
			success : function(authObj) {
				console.log(JSON.stringify(authObj));
				Kakao.API.request({
					url:'/v2/user/me',
					data:{
						"property_keys":"kakao_account.email"
					},
					success:function(data){
						console.log(data.properties);
						kakaoAPI(data.properties.nickname);
					},
					fail:function(error){
						console.log("실패");
					}
				});//end Kakap.API.request
			},
			fail : function(err) {
				console.log(JSON.stringify(err));
			}
		});  
	</script> -->
	</div>
</div>
</body>
</html>
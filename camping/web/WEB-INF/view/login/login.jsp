<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- 로그인 유효성 검사 -->
<script src="<c:url value="/js/loginValidata.js" />"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- 로그인 API -->
<script src="<c:url value="/js/loginAPI.js" />"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="http://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>

</head>
<body>
<!-- 로그인/회원가입 탭 -->
<div id="loginjoin">
	<a href="login.do">로그인</a>
	<a href="join.do" class="active">회원가입</a>
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
		<!-- <tr>
			<td>
				<input type="checkbox"  name="useCookie">로그인 유지  
			</td>
		</tr> -->
		<!-- 로그인 일치 확인 -->
		<tr>
			<td colspan="2"><div id="checkText"></div></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="로그인"/>  
				<a href="searchIdPassword.do">아이디/비밀번호 찾기</a>
			</td>
		</tr>
		</table>
	</form>

	<!-- 로그인 API -->
	<!-- 페이스북 버튼 추가-->
	<fb:login-button scope="public_profile, email" onlogin="checkLoginState();"></fb:login-button>
	
	<!-- 카카오 버튼 추가 -->
	<a id="kakao-login-btn"></a>

	<!-- 네이버 버튼 추가 -->
	<div id="naverIdLogin"></div>
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
		<script type="text/javascript">
// 		Kakao.init('6ba4bb8eff3e395e059315260d154426');

// 		"required_scopes": [
// 		    "talk_message"
// 		 ]
		
		// 카카오 로그인 버튼을 생성합니다.
		 /* Kakao.Auth.createLoginButton({
			container : '#kakao-login-btn',
			success : function(authObj) {
				console.log(JSON.stringify(authObj));
				Kakao.API.request({
					url:'/v2/user/me',
					"allowed_scopes":[
						"account_email"
					],
					success:function(data){
						console.log(data.properties);
						console.log(data.kakao_account.has_email);
						console.log(data.kakao_account.email);
					},
					fail:function(error){
						
					}
				});//end Kakap.API.request
			},
			fail : function(err) {
				console.log(JSON.stringify(err));
			}
		});  */
	</script>






	</div>
</body>
</html>
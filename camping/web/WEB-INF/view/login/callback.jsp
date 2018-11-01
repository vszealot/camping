<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<script>
	var naverLogin = new naver.LoginWithNaverId({
		clientId : "jdmecvH11xnoP5rU67xq",
		callbackUrl : "http://localhost:8088/camping/callback.do",
		isPopup : false,
		callbackHandle: true
	});
	
	naverLogin.init();
	
	/* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
	window.addEventListener('load', function () {
		naverLogin.getLoginStatus(function (status) {
			if (status) {
				/* (5) 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
				var email = naverLogin.user.getEmail();
				if( email == undefined || email == null) {
					alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
// 					return;
				}
				
// 				var email = naverLogin.user.getEmail();
				var strArray=email.split('@');
				var userId=strArray[0];
				
				$.ajax({
					type:"POST",
					 data : {"userId":userId,
						 	 "userEmail":email,
						 	 "nickName":userId},
			         url : "facebook.do",
			         error : function(){
			        	 console.log("실패");
			         },
			         success : function(data) {
			        	 console.log("성공");
//				        	 location.href="http://localhost:8088/camping/campList.do";
			         }//end success
				});//end ajax
				
				location.href="http://localhost:8088/camping/campList.do";
			} else {
				alert("callback 처리에 실패하였습니다.");
			}
			
		});
	});
</script>
</body>
</html>
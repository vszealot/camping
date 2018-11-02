
// ** 페이스북 로그인 **----------------------------------------
window.fbAsyncInit = function() {
	FB.init({
		appId : '999388243577972',
		cookie : true,
		xfbml : true,
		version : 'v3.2'
	});

	FB.AppEvents.logPageView();

};

(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id))
		return;
	js = d.createElement(s);
	js.id = id;
	js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&autoLogAppEvents=1&version=v3.2&appId=999388243577972';
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function checkLoginState() {
	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
	});
}

function statusChangeCallback(response) {
	console.log('statusChangeCallback');
	if (response.status === 'connected') {
		console.log(response.authResponse.accessToken);
		API();
	} else {
		document.getElementById('status').innerHTML = 'Please log '
				+ 'into this app.';
	}
}

function API() {
	FB.api('/me',{fields: 'email, name, id'}, function(response) {
		// ** JSON형태 정보 *******************
		console.log(JSON.stringify(response));
		console.log('Successful login for: ' + response.name);
		//**********************************
		
		//ajax로 JSON파일 controller로 전송
		var strArray=response.email.split('@');
		var userId=strArray[0];
		var userEmail=response.email;
		
//		console.log(userId);
//		console.log(userEmail);
//		console.log(nickName);
		
		$.ajax({
			type:"POST",
			 data : {"userId":userId,
				 	 "userEmail":userEmail,
				 	 "nickName":userId},
	         url : "facebook.do",
	         error : function(){
	        	 console.log("실패");
	         },
	         success : function(data) {
	        	 console.log("성공");
	        	 location.href="http://localhost:8088/camping/campList.do";
	         }//end success
		});//end ajax
		
	});
}

/*FB.logout(function(response) {

});*/

// ** 카카오톡 로그인 API **--------------------------------------------------------
/*function kakaoAPI(nickname) {
	console.log("callback")
//	console.log(nickname);
	
	var userId=nickname;
	var nickName=nickname;
	
	$.ajax({
		type:"POST",
		 data : {"userId":userId,
			 	 "userEmail":null,
			 	 "nickName":userId},
         url : "facebook.do",
         error : function(){
        	 console.log("실패");
         },
         success : function(data) {
        	 console.log("성공");
        	 location.href="http://localhost:8088/camping/campList.do";
         }//end success
	});//end ajax
}
*/



// ** 네이버 로그인 API **--------------------------------------------------------














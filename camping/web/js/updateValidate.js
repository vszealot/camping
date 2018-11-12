// 회원 수정 버튼 클릭시 
	function checkNickname(){
		// 원래 로그인된 닉네임과 입력한 닉네임이 다르면(닉네임을 변경한 경우) => DB가서 중복성검사
		if("${logOK.nickName }"!=$('#nickName').val()){
			
			var inputed = $('#nickName').val();

			 $.ajax({
				 type:"GET",
				 data : {"nickName":inputed},
				 dataType:"text",
		        url : "checkNickname.do",
		        error : function(){
		       	 console.log("실패");
		        },
		        success : function(data) {
		        	if(inputed==""){
		        		$('#checkText').html('<p style="color:red">닉네임을 입력하세요</p>');
		        	}else{
		        		if(data>0) {
		        			$('#checkText').html('<p style="color:red">이미 등록된 닉네입입니다</p>');
		       		 	}else{
		       		 		$('#checkText').html('<p style="color:green">등록 가능한 닉네임입니다</p>');
		       		 	}
		        	}
		        }
			 });
		}
	}
	//비밀번호 수정----------------------------------------------
	//현재 비밀번호 동일한지 체크
	function checkpassword(){
		var inputed = $('#password').val();

		 $.ajax({
			 type:"GET",
			 data : {"password":inputed},
			 dataType:"text",
	        url : "checkPassword.do",
	        error : function(){
	       	 console.log("실패");
	        },
	        success : function(data) {
	        	if(inputed==""){
	        		$('#checkText2').html('<p style="color:red">비밀번호를 입력하세요</p>');
	        	}else{
	        		if(data>0) {
	        			$('#checkText2').html('<p style="color:green">비밀번호가 일치합니다</p>');
	       		 	}else{
	       		 		$('#checkText2').html('<p style="color:red">비밀번호가 일치하지 않습니다</p>');
	       		 	}
	        	}
	        }
		 });
	}
	//새 비밀번호 동일한지 체크
	//비밀번호 일치 검사
	function checkpwd(){
		var pwd = document.getElementById("newPassword").value;
	    var pwdCheck = document.getElementById("newPasswordCheck").value;
	    
	    if (pwd != pwdCheck) {
	    	$('#checkText3').html('<p style="color:red">비밀번호가 일치하지 않습니다</p>');
	        return false;
	    }else if(pwd == pwdCheck){
	    	$('#checkText3').html('<p style="color:green">비밀번호가 일치합니다</p>');
	    	  return true;
	    }
	}
	//회원정보 수정버튼 클릭----------------------------------------
	function check(re, what, message) {
	    if(re.test(what.value)) {
	        return true;
	    }
	    alert(message);
	    what.value = "";
	    what.focus();
	    //return false;
	}
	
	$(document).ready(function(){
		$("#update_btn").click(function(){
		    if (document.getElementById("newPassword").value.length<8){
		    	alert("패스워드는 비밀번호는 영문 숫자 특수문자의 조합으로 8자리 이상을 입력");
		    	document.getElementById("newPassword").value="";
		    	document.getElementById("newPassword").value.focus();
		    	return false;
			}else{
				var retVal = confirm("정보를 수정하시겠습니까?");
				
				var re1 = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,15}$/ 
				    
			
				if(retVal==true){
					document.regForm.action="updateProc.do";
					document.regForm.submit();
				}
			}
		});
	});
	//회원 탈퇴 버튼 클릭----------------------------------------
	$(document).ready(function(){
		$("#delete_btn").click(function(){
			var retVal = confirm("탈퇴하시겠습니까?");
			if(retVal==true){
				document.regForm.action="deleteProc.do";
				document.regForm.submit();
			}
		});
	});
	//현재 비밀번호 동일한지 체크
	function checkpassword2(){
		var inputed = $('#Password2').val();

		 $.ajax({
			 type:"GET",
			 data : {"password":inputed},
			 dataType:"text",
	        url : "checkPassword.do",
	        error : function(){
	       	 console.log("실패");
	        },
	        success : function(data) {
	        	if(inputed==""){
	        		$('#checkText4').html('<p style="color:red">비밀번호를 입력하세요</p>');
	        	}else{
	        		if(data>0) {
	        			$('#checkText4').html('<p style="color:green">비밀번호가 일치합니다</p>');
	       		 	}else{
	       		 		$('#checkText4').html('<p style="color:red">비밀번호가 일치하지 않습니다</p>');
	       		 	}
	        	}
	        }
		 });
	}
	//새 비밀번호 동일한지 체크
	//비밀번호 일치 검사
	function checkpwd2(){
		var pwd = document.getElementById("Password2").value;
	    var pwdCheck = document.getElementById("PasswordCheck2").value;

	    if (pwd != pwdCheck) {
	    	$('#checkText5').html('<p style="color:red">비밀번호가 일치하지 않습니다</p>');
	        return false;
	    }else if(pwd == pwdCheck){
	    	$('#checkText5').html('<p style="color:green">비밀번호가 일치합니다</p>');
	    	  return true;
	    }
	}
	
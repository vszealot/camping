<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/main.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>
$(function(){
	$(document).mouseup(function(e) {
		if ($(e.target).parents('.dropMenu').length == 0) {
			$('.dropMenu li').removeClass('expand');
			$('.dropMenu ul').hide();
		}
	});
	$(".dropMenu>li:has(ul)>a").each( function() {
		$(this).html( $(this).html()+' &or;' );
	});
	$(".dropMenu ul li:has(ul)")
		.find("a:first")
		.append("<p style='float:right;margin:-3px'>&#9656;</p>");

	$(".dropMenu li>a").click(function(){
		var li = $(this).parent();
		var ul = li.parent()
		ul.find('li').removeClass('expand');
		ul.find('ul').not(li.find('ul')).hide();
		li.children('ul').toggle();
		if( li.children('ul').is(':visible') || li.has('ul')) {
			li.addClass('expand');
		}
	});
});

//ENTER 안먹게 하는것
function preventReturnKey(e) {
    if(e.keyCode==13 && e.srcElement.type != 'textarea')
    return false;
}

//confirm & submit
function submitFunc(){
	var retVal = confirm("전송하시겠습니까?");
	
	if(retVal==true){
		var inputed=$('#recv_name').val();
		var inputed2=$('#sent_name').val();
		var inputed3=$('#title').val();
		var inputed4=$('#note').val();
		
		$.ajax({
			type:"POST",
			 data : {"recv_name":inputed,
				 	 "sent_name":inputed2,
				 	 "title":inputed3,
				 	 "note":inputed4,
				 	 },
	         url : "sendingNoteFunc.do",
	         error : function(){
	        	 console.log("실패");
	         },
	         success : function(data) {
	        	 console.log("성공");
	        	 location.href="http://localhost:8088/camping/sendingNote.do";
	         }//end success
		});//end ajax	
	}
}

</script>
<style>
	.wrapper{
		width: 60%;
		margin-left: 250px;
	}
	.dropdown { 
		margin: 0;
		padding: 0; 
		float: left;
	}
	.dropMenu{
		padding: 0px;
		margin-top: 10px;
	}
	.dropMenu li:hover { background: blue; }
	.dropMenu li.expand { background: white; }
	.dropMenu a {
		color: black;
		display: block;
		padding: 10px 20px;
		text-decoration: none;
	}
	.dropMenu ul {
		 background: #eee;
		 border: 1px solid silver;
		 display: none;
		 padding: 0;
		 position: absolute;
		 left: 0;
		 top: 100%;
		 width: 180px;
	}
	.dropMenu ul li { float: none; }
	.dropMenu ul li.expand { background: #ddd; }
	.dropMenu ul li.expand a { color: black; }
	.dropMenu ul a { color: black; }
	.dropMenu ul ul { left: 100%; top: 0; }
	
	.noteTitle{
		text-align: center;
		margin-top: 0px;
		display: inline-block;
		width: 100%;
	}
	.noteTitle .title{
		display: inline-block;
	}
	.btns{
		float: right;
		padding-top: 30px;
	}
	.table table-bordered{
		border: none;
	}
	.middle{
		width: 100%;
		text-align: center;
	}
	
}
</style>

</head>
<body>

<div class="wrapper">
	<div class="header">
		<!-- 받은쪽지함/보낸쪽지함 선택 -->
		<div class="dropdown">
			<ul class="dropMenu">
				<li><a href="#">쪽지함 선택</a>
					<ul>
						<li><a href="/camping/noteReceiveView.do">받은 쪽지함</a></li>
						<li><a href="/camping/noteSendView.do">보낸 쪽지함</a></li>
					</ul>
				</li>
			</ul>			
		</div>
		<div class="noteTitle">
			<h1 class="title">쪽지 보내기</h1>
		</div>
	</div><br><br>
	
	<div class="middle">
		<form method="POST" action="sendingNoteFunc.do" onkeypress="return preventReturnKey(event)">
			<div class="form-group">
				<label for="recv_name" style="width:150px;">받는 사람</label>
				<input type="text" id="recv_name" name="recv_name" style="width:300px;" required>
			</div>
			<div class="form-group">
				<label style="width:150px;">보내는 사람</label>
				<input type="text" value="${logOK.nickName }" readonly="readonly" id="sent_name" name="sent_name" style="width:300px;" required>
			</div>
			<div class="form-group">
				<label style="width:150px;">제목</label>
				<input type="text" id="title" name="title" style="width:300px;" required>
			</div>
			<div class="form-group" style="vertical-align: top;">
				<label for="note" style="width:150px;">내용</label>
				<textarea id="note" name="note" style="width:300px; height:150px;" required></textarea>
			</div><br>
			<input type="button" value="전송" onclick="submitFunc()" class="btn btn-primary" style="margin-left:300px;"/><br><br>  
		</form>
	</div>
	
	<div class="footer">
	
	</div>
</div>
</body>
</html>
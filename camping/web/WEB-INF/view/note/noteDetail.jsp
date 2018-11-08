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
			<h1 class="title">쪽지 상세내용</h1>
			<div class="btns">
				<button onclick="history.back()">쪽지 목록</button>
				<button>답장</button>
			</div>
		</div>
	</div><br><br>
	
	<div class="middle">
		<table class="table table-bordered">
			<tr>
				<td style="background-color:#D8D8D8;">보낸 사람</td>
				<td style="width: 50em;"><%=request.getParameter("sent_name") %></td>
			</tr>
			<tr>
				<td style="background-color:#D8D8D8;">받는 사람</td>
				<td><%=request.getParameter("recv_name") %></td>
			</tr>
			<tr>
				<td style="background-color:#D8D8D8;">제목</td>
				<td><%=request.getParameter("title") %></td>
			</tr>
			<tr>
				<td style="background-color:#D8D8D8;">내용</td>
				<td><%=request.getParameter("note") %></td>
			</tr>
			
		</table>
	</div>
	
	<div class="footer">
	
	</div>
</div>
</body>
</html>
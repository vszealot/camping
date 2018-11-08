<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/main.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<!-- 쪽지함 css -->
<script src="//code.jquery.com/jquery.min.js"></script>
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

function detailView(sent_name,recv_name,title,note){
// 	window.location.href = "http://localhost:8088/camping/noteDetail.do?sent_name=" 
// 			+sent_name+"&recv_name="+recv_name+"&title="+title+"&note="+note;
	
	var method="POST";
	var params={'sent_name':sent_name,'recv_name':recv_name,'title':title,'note':note};
	var form = document.createElement("form");
	form.setAttribute("method", method);
	form.setAttribute("action", "http://localhost:8088/camping/noteDetail.do");
	
	for(var key in params) {
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", key);
		hiddenField.setAttribute("value", params[key]);
		form.appendChild(hiddenField);
	}
	document.body.appendChild(form);
	form.submit();
}
	
function checkBoxAll(){
	
	if($("#checkAll").prop("checked")){
        $("input[name=chkInfo]").prop("checked",true);
    }else{
        $("input[name=chkInfo]").prop("checked",false);
    }
}

function sendingNote(){
	window.location.href = "http://localhost:8088/camping/sendingNote.do";
}

</script>

<style>
	.wrapper{
		width: 70%;
		margin-left: 200px;
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
	.middle{
		
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
			<h1 class="title">받은 쪽지함</h1>
			<div class="btns">
				<button onclick="sendingNote()">쪽지 쓰기</button>
				<button onclick="checkBoxAll()">전체 선택</button>
				<button>삭제</button>
			</div>
		</div>
	</div><br><br>
	
	<div class="middle">
		<table class="table table-bordered">
			<tr>
				<th style="width: 2em;">
					체크 <input type="checkbox" id="checkAll" value="">
				</th>
				<th style="width: 8em;">From</th>
				<th style="width: 16em;" >제목</th>
				<th style="width: 8em;">받은 날짜</th>
			</tr>
				<c:if test="${!empty listNote}">
					<c:forEach items="${listNote}" var="list">
						<tr>
							<td style="width: 2em;">
								<input type="checkbox" name="chkInfo" value="">
							</td>
							<td style="width: 8em;">${list.sent_name }</td>
							<td style="width: 16em;" >
								<a href="javascript:detailView('${list.sent_name}','${list.recv_name}','${list.title}','${list.note}')">
									${list.title }
								</a>
							</td>
							<td style="width: 8em;">
								<fmt:formatDate value="${list.date_sent }" pattern="yyyy-MM-dd" />
							</td>
							
						</tr>
					</c:forEach>
				</c:if>
		</table>
	</div>
		
	<div class="footer">
		
	</div>

</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/main.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	/* function changeSelect(){
		var changeSelect=document.getElementById("gradeSelect");
		var selectValue = changeSelect.options[changeSelect.selectedIndex].value;
// 		alert(selectValue);
		
		var inputed=0;
		
		inputed = $('#user').text();
		console.log(inputed);
		
		var retVal = confirm("변경하시겠습니까?");
		if(retVal==true){
			alert(selectValue);
			
			$.ajax({
				type:"POST",
				 data : {"userId":inputed,
					 	"grade":selectValue},
		         url : "userGradeUpdate.do",
		         error : function(){
		        	 console.log("실패");
		         },
		         success : function(data) {
		        	 console.log("성공");
		        	 location.href="http://localhost:8088/camping/userInfoView.do";
		         }//end success
			});//end ajax
		}

	}   */
 
	function btnclick(i,str){
		var inputed= gradeSelect[i].options[gradeSelect[i].selectedIndex].value;
		
		var retVal = confirm("변경하시겠습니까?");
		if(retVal==true){
			$.ajax({
				type:"POST",
				 data : {"userId":str,
					 	"grade":inputed},
		         url : "userGradeUpdate.do",
		         error : function(){
		        	 console.log("실패");
		         },
		         success : function(data) {
		        	 console.log("성공");
		        	 location.href="http://localhost:8088/camping/userInfoView.do";
		         }//end success
			});//end ajax
		}
	}
	
</script>

<style>
	.grade{
		display: inline-block;
	}
</style>

</head>
<body>
<section class="container">
	<h2>회원목록</h2><br>
	
	<table class="table table-bordered">
		<tr>
			<th style="width: 8em;">ID</th>
			<th style="width: 16em;">이메일</th>
			<th style="width: 8em;" >닉네임</th>
			<th style="width: 8em;">회원 등급</th>
			<th style="width: 4em;">등급 수정</th>
			<th style="width: 2em;">탈퇴</th>
		</tr>
		
		<c:if test="${!empty listUser }">
		<!-- 목록 시작 -->
			<c:forEach items="${listUser}" var="list" varStatus="i">
				<tr>
					<td><span id="user">${list.userId }</span></td>
					<td>${list.userEmail }</td>
					<td>${list.nickName }</td>
					<td>${list.grade }</td>
					<td>
						<div class="grade">
							<select id="gradeSelect" name="gradeSelect" class="gradeSelect">
								<option value="운영자" <c:if test="${list.grade eq '운영자' }">selected</c:if> >운영자</option>
  								<option value="일반회원" <c:if test="${list.grade eq '일반회원' }">selected</c:if> >일반회원</option>
							</select>
 							<button id="gradeBtn" class="btn btn-default" onclick="btnclick(${i.count-1},'${list.userId}')">변경</button>
						</div>
					</td>
					<td>탈퇴</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	
	
	<!-- <a role="button" href="userInfoView.do" class="btn btn-default">회원조회</a> -->
</section>
</body>
</html>
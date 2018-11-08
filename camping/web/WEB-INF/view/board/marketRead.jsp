<%@page import="org.springframework.web.util.WebUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/main.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body id="body1">
	<section class="container">
	<h2>유저 장터</h2>
	<table role="form"></table>
		<form role="form" method="post" autocomplete="off" action="marketInsert.do" enctype="multipart/form-data">
			<input type="hidden" id="page" name="page" value="${page.page}" readonly="readonly"> 
			<input type="hidden" id="perPageNum" name="perPageNum" value="${page.perPageNum}" readonly="readonly">
			<input type="hidden" id="searchType" name="searchType" value="${page.searchType}" readonly="readonly"> 
			<input type="hidden" id="keyword" name="keyword" value="${page.keyword}" readonly="readonly">
			<input type="hidden" id="postNo" name="postNo" value="${read.postNo}" readonly="readonly" />
			<input type="hidden" id="title" name="title" value="${read.title}" readonly="readonly" />
			<textarea style="display: none;" id="content" name="content" readonly="readonly">${read.content}</textarea>
			<input type="hidden" id="nickName" name="nickName" value="${read.nickName}" readonly="readonly" />
			<input type="hidden" id="image" name="image" value="${read.image}" readonly="readonly" /><br>
			<input type="hidden" id="click" name="click" value="${read.click}" readonly="readonly" /><br> 
			<input type="hidden" id="reccnt" name="reccnt" value="${read.recCnt}" readonly="readonly" />
			<!-- 게시물 내용 -->
			<table class="table">
				<tr>
					<th style="width: 5em;">${read.nickName}</th>
					<th style="width: 30em;"><fmt:formatDate value="${read.regDate}" pattern="yyyy-MM-dd HH:mm" /></th>
					<th style="width: 5em;" >조회 : ${read.click}</th>
				</tr>
				<tr>
					<td style="text-align: center;" colspan="3"><h3>${read.title}</h3></td>
				</tr>
				<tr>
					<td style="height: 200px;" colspan="3">
						<c:forEach items="${image}" var="image">
							<img src="storage/${image.STORED_FILE_NAME}" class="img-thumbnail"><br><br>
						</c:forEach>
						${read.content}
					</td>
				</tr>
				<tr>
					<td colspan="3">
					<div class="form-inline">
						<div class="form-group">
							<label for="file" class="col-sm-12 control-label">파일명 : </label>
						</div>
						<c:forEach items="${image}" var="image">
							<div class="form-group">
								<input type="text" readonly="readonly" class="form-control input-sm" value="${image.ORIGINAL_FILE_NAME}"/>
							</div>
						</c:forEach>
					</div>
					</td>
				</tr>
				<tr><td><!-- 밑줄생기기용 --></td></tr>
			</table>
			<div style="text-align: center;">
				<a role="button" class="btn btn-default" href="javascript:updateRecommend('${logOK.nickName}')"><span>추천<br>${read.recCnt}</span></a>
			</div>
			<div class="text-right">
				<button class="btn btn-default" id="list_btn">목록</button>&nbsp;
				<c:if test="${logOK.nickName eq read.nickName}">
					<button class="btn btn-default" id="modify_btn">수정</button>&nbsp;
					<button class="btn btn-default" id="delete_btn">삭제</button>
				</c:if>
				<c:if test="${logOK.nickName ne read.nickName}">
					<button class="btn btn-default" disabled="disabled" id="modify_btn">수정</button>&nbsp;
					<button class="btn btn-default" disabled="disabled">삭제</button>
				</c:if>
			</div>

		</form>
		
		<!-- 게시물 끝 -->
		<br><br>
		<!-- 댓글시작 -->
		<div id="reply">
			<table id="replytable" class="table">
				<c:forEach items="${repList}" var="repList">
					<tr>
						<td style="width: 5em;">${repList.nickName}</td>
						<td style="width: 30em;">${repList.content}</td>
						<td style="width: 6em;"><fmt:formatDate value="${repList.regDate}" pattern="MM.dd HH:mm:ss" />&nbsp;
							<c:if test="${logOK.nickName eq repList.nickName}">
								<input type="image" src="image/delete_btn.jpg" class="replyDelete" value="${repList.rNo}" alt="삭제">
							</c:if>
							<c:if test="${logOK.nickName ne repList.nickName}">
							<input type="image" src="image/delete_btn.jpg" class="replyDelete" style="opacity:0.2" disabled="disabled" value="${repList.rNo}" alt="삭제">
							</c:if>
						</td>
					</tr>
				</c:forEach>
				
			</table>
			<hr>

			<!-- 댓글끝 -->
			<!-- 댓글입력 -->
			<section class="replyForm">
				<form role="form" method="post" autocomplete="off">
					<input type="hidden" id="postNo" name="postNo" value="${read.postNo}" readonly="readonly" />
					<input type="hidden" id="page" name="page" value="${page.page}" readonly="readonly" />
					<input type="hidden" id="perPageNum" name="perPageNum" value="${page.perPageNum}" readonly="readonly" />
					<input type="hidden" id="searchType" name="searchType" value="${page.searchType}" readonly="readonly" />
					<input type="hidden" id="keyword" name="keyword" value="${page.keyword}" readonly="readonly" />
					
					<div class="form-group">
						<input type="text" id="nickName2" name="nickName" class="col-sm-1 control-label" value="${logOK.nickName}" readonly="readonly">
						<div class="col-sm-10">
							<textarea placeholder="내용을 입력하세요." rows="1" id="content2" name="content" class="form-control"></textarea>
						</div>
					</div>
					<button type="button" class="repSubmit">작성</button>
				</form>
			</section><br><br><br>
			<!-- 댓글입력끝 -->
		</div>
	</section>
</body>
<script>
	// 폼을 변수에 저장
	var formObj = $("form[role='form']");

	// 목록 버튼 클릭
	$("#list_btn").click(function() {
		formObj.attr("action", "marketListSearch.do");
		formObj.attr("method", "post");
		formObj.submit();
	});

	// 수정 버튼 클릭
	$("#modify_btn").click(function() {
		formObj.attr("action", "marketModify.do");
		formObj.attr("method", "post");
		formObj.submit();

	});

	// 삭제 버튼 클릭
	$("#delete_btn").click(function() {
		if (confirm("삭제하시겠습니까?")) {
			formObj.attr("action", "marketDelete.do");
			formObj.attr("method", "post");
			formObj.submit();
		}else{
			formObj.attr("action", "marketRead.do");
			formObj.attr("method", "post");
			formObj.submit();
		}
	});
	
	// 폼을 변수에 저장
	var formObj2 = $(".replyForm form[role='form']");
	
	// 댓글 삭제 버튼 클릭
	$(".replyDelete").click(function() {
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				type:"post",
				url:"marketReplyDelete.do",
				data:{
					postNo:"${read.postNo}",
					page:"${page.page}",
					perPageNum:"${page.perPageNum}",
					searchType:"${page.searchType}",
					keyword:"${page.keyword}",
					nickName:$("#nickName2").val(),
					content:$("#content2").val(),
					rNo:$(this).val()
				},
				success:function(data){
					$("#body1").html(data);
				}
			});
		}
	});
	
	// 댓글 작성 클릭
	$(".repSubmit").click(function(){
		$.ajax({
			type:"post",
			url:"marketReplyWrite.do",
			data:{
				postNo:"${read.postNo}",
				page:"${page.page}",
				perPageNum:"${page.perPageNum}",
				searchType:"${page.searchType}",
				keyword:"${page.keyword}",
				nickName:$("#nickName2").val(),
				content:$("#content2").val()
			},
			success:function(data){
				$("#body1").html(data);
			}
		});
	})
	
 	// 추천 버튼 클릭
	function updateRecommend(id){
		if(id==""){
			alert("로그인 하셔야 추천할 수 있습니다.");
		}else{
			$.ajax({
				type:"POST",
				url:"marketUpdateRecommend.do",
				data:{
					postNo:"${read.postNo}",
					page:"${page.page}",
					perPageNum:"${page.perPageNum}",
					searchType:"${page.searchType}",
					keyword:"${page.keyword}",
					nickName:"${logOK.nickName}"
				},
				success:function(data){
					$("#body1").html(data);
				}
			});
		}

	}
</script>
</html>
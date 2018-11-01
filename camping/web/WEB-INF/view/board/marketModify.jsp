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
<body>
	<section class="container">
	<h2>유저 장터</h2>
	<div style="width: 50em;margin: 0 auto;">
		<form role="form" method="post" autocomplete="off" action="marketUpdate.do">
			<input type="hidden" id="page" name="page" value="${page.page}" readonly="readonly"> 
			<input type="hidden" id="perPageNum" name="perPageNum" value="${page.perPageNum}" readonly="readonly">
			<input type="hidden" id="searchType" name="searchType" value="${page.searchType}" readonly="readonly"> 
			<input type="hidden" id="keyword" name="keyword" value="${page.keyword}" readonly="readonly">
			<input type="hidden" id="postNo" name="postNo" value="${modify.postNo}"/>
			<div class="form-group">
				<!-- <label for="title" class="col-sm-2 control-label">글 제목</label> -->
				<div class="col-sm-12">
					<input type="text" id="title" name="title" class="form-control" value="${modify.title}"/>
				</div>
			</div>
			<div class="form-group">
				<!-- <label for="content" class="col-sm-2 control-label">글 내용</label> -->
				<div class="col-sm-12">
					<textarea id="content" name="content" class="form-control" style="height: 300px">${modify.content}</textarea>
				</div>
			</div>
			<div class="form-group">
				<!-- <label for="nickName" class="col-sm-2 control-label">작성자</label> -->
				<div class="col-sm-12">
					<input type="text" id="nickName" name="nickName" class="form-control" value="${modify.nickName}"/>
				</div>
			</div>
			<div class="form-group">
				<!-- <label for="image" class="col-sm-2 control-label">이미지 경로</label> -->
				<div class="col-sm-12">
					<input type="text" id="image" name="image" class="form-control" value="${modify.image}" />
				</div>
			</div>
			<div style="text-align: center;">
				<button class="btn btn-default" type="submit">수정</button>&nbsp;<button class="btn btn-default" id="cancel_btn">취소</button>
			</div>
<%-- 			<p>
				<label for="title">글 제목</label><input type="text" id="title" name="title" value="${modify.title}"/>
			</p>
			<p>
				<label for="content">글 내용</label>
				<textarea id="content" name="content">${modify.content}</textarea>
			</p>
			<p>
				<label for="image">이미지 경로</label><input type="text" id="image" name="image" value="${modify.image}"/>
			</p>
			<p>
				<button type="submit">수정</button><button id="cancel_btn">취소</button>
			</p> --%>
		</form>
	</div>
	</section>
</body>
<script>
	// 폼을 변수에 저장
	var formObj = $("form[role='form']");

	// 취소 버튼 클릭
	$("#cancel_btn").click(function() {
		formObj.attr("action", "marketRead.do?postNo=" + $("#postNo").val());
		formObj.attr("method", "post");
		formObj.submit();
	});
</script>
</html>
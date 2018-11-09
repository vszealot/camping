<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ include file="/WEB-INF/main.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="container">
	<h2>공지</h2>
	<div style="width: 50em;margin: 0 auto;">
		<form id="fr" name="fr" role="form" method="post" autocomplete="off" action="noticeUpdate.do" enctype="multipart/form-data">
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
					<input type="text" id="nickName" name="nickName" class="form-control" value="${modify.nickName}" readonly="readonly"/>
				</div>
			</div>
			<div id="fileDiv">
				<div class="form-group">
					<label for="file" class="col-sm-12 control-label">사진 등록</label>
				</div>
				<c:forEach items="${image}" var="image" varStatus="i">
					<div class="form-group">
						<input type="hidden" id="IDX" name="IDX_${i.index}" value="${image.IDX}">
						<input type="file" id="file_${i.index}" name="file_${i.index}" class="col-sm-9"/>
						<label class="col-sm-2">${image.ORIGINAL_FILE_NAME}</label>
						<a href="#this" class="btn btn-default" id="delete" name="delete">삭제</a>
					</div>
				</c:forEach>
			</div>
			<div style="text-align: center;">
				<a href="#this" class="btn btn-default" id="addFile">파일 추가</a>&nbsp;
				<button type="button" class="btn btn-default" onclick="check()">수정</button>&nbsp;
				<button class="btn btn-default" id="cancel_btn">취소</button>
			</div>
		</form>
	</div>
	</section>
</body>
<script>
	// 폼을 변수에 저장
	var formObj = $("form[role='form']");

	// 취소 버튼 클릭
	$("#cancel_btn").click(function() {
		formObj.attr("action", "noticeRead.do?postNo=" + $("#postNo").val());
		formObj.attr("method", "post");
		formObj.submit();
	});
	
	var gfv_count = '${fn:length(image)+1}';

	$("#addFile").on("click", function(e){ //파일 추가 버튼
	    e.preventDefault();
	    fn_addFile();
	});
	 
	$("a[name='delete']").on("click", function(e){ //삭제 버튼
	    e.preventDefault();
	    fn_deleteFile($(this));
	});

	function fn_addFile(){
	    var str = "<div class='form-group'><input type='file' id='file' name='file_"+(gfv_count++)+"' class='col-sm-11'/>";
	    	str += "<a href='#this' class='btn btn-default' id='delete' name='delete'>삭제</a></div>";

	    $("#fileDiv").append(str);
	    $("a[name='delete']").on("click", function(e){ //삭제 버튼
	        e.preventDefault();
	        fn_deleteFile($(this));
	    });
	}
	 
	function fn_deleteFile(obj){
	    obj.parent().remove();
	}
	
	function check() {
		if(title.value==''){
			alert("제목을 입력하세요");
			fr.title.focus();
			return false;
		}
		if(content.value==''){
			alert("내용을 입력하세요");
			fr.content.focus();
			return false;
		}
		fr.submit();
	}
</script>
</html>
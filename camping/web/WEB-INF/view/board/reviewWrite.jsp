<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/main.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="container">
	<h2>후기 게시판</h2>
	<div style="width: 50em;margin: 0 auto;">
		<form id="fr" name="fr" role="form" method="post" autocomplete="off" action="reviewInsert.do" enctype="multipart/form-data">
			<div class="form-group">
				<!-- <label for="title" class="col-sm-2 control-label">글 제목</label> -->
				<div class="col-sm-12">
					<input placeholder="제목을 입력하세요" type="text" id="title" name="title" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<!-- <label for="content" class="col-sm-2 control-label">글 내용</label> -->
				<div class="col-sm-12">
					<textarea placeholder="내용을 입력하세요" id="content" name="content" class="form-control" style="height: 300px"></textarea>
				</div>
			</div>
			<div class="form-group">
				<!-- <label for="nickName" class="col-sm-2 control-label">작성자</label> -->
				<div class="col-sm-12">
					<input value="${logOK.nickName}" readonly="readonly" type="text" id="nickName" name="nickName" class="form-control" />
				</div>
			</div>
			<div id="fileDiv">
				<div class="form-group">
					<label for="file" class="col-sm-12 control-label">사진 등록</label>
				</div>
				<div class="form-group">
					<input type="file" id="file" name="file_0" class="col-sm-11"/>
					<a href="#this" class="btn btn-default" id="delete" name="delete">삭제</a>
				</div>
			</div>
			<div style="text-align: center;">
				<a href="#this" class="btn btn-default" id="addFile">파일 추가</a>&nbsp;
				<button type="button" class="btn btn-default" onclick="check()">작성</button>&nbsp;
				<a role="button" href="reviewListSearch.do" class="btn btn-default">취소</a>
			</div>
		</form>
		</div>
	</section>
</body>
<script>
var gfv_count = 1;

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
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
	<h2>유저 장터</h2>
	<div style="width: 50em;margin: 0 auto;">
		<form role="form" method="post" autocomplete="off" action="marketInsert.do" enctype="multipart/form-data">
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
				<a href="#this" class="btn btn-default" id="addFile">파일 추가</a>
				<button class="btn btn-default" type="submit">작성</button>
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

</script>
</html>
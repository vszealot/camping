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
		<form role="form" method="post" autocomplete="off" action="marketInsert.do">
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
					<input placeholder="닉네임입력 세션받으면 없앨거임" type="text" id="nickName" name="nickName" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<!-- <label for="image" class="col-sm-2 control-label">이미지 경로</label> -->
				<div class="col-sm-12">
					<input placeholder="이미지경로" type="text" id="image" name="image" class="form-control" />
				</div>
			</div>
			<div style="text-align: center;">
				<button class="btn btn-default" type="submit">작성</button>
			</div>
		</form>
		</div>
	</section>
</body>
</html>
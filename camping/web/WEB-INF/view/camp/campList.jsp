<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.left-box {
	display: inline-block;
	width: 49%;
	border: 1px solid black;
}

.right-box {
	display: inline-block;
	width: 49%;
	border: 1px solid black;
}
</style>
</head>
<body>
	이름 거리 주소 전화번호	<br>
	<div class='left-box'>
		<table border="1">
			<tr>
				<th>이름</th>
				<th>거리x</th>
				<th>거리y</th>
				<th>주소</th>
				<th>전번</th>
			</tr>
			<c:if test="${!empty campList}">
				<c:forEach items="${campList}" var="ob">
					<tr>
						<td>${ob.campName}</td>
						<td>${ob.x}</td>
						<td>${ob.y}</td>
						<td>${ob.addr1}</td>
						<td>${ob.phone}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>
	<div class='right-box'>오른쪽</div>
</body>
</html>
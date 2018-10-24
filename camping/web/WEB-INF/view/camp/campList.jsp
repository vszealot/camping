<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/main.jsp" %>
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
	<br>
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
		<div>	<!-- 페이정 처리 시작 -->
			<ul>
				<c:if test="${page.prev}">
					<li><a href="campList.do${page.makeQuery(page.startPage - 1)}">이전</a></li>
				</c:if>

				<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
					<li><a href="campList.do${page.makeQuery(idx)}">${idx}</a></li>
				</c:forEach>

				<c:if test="${page.next && page.endPage > 0}">
					<li><a href="campList.do${page.makeQuery(page.endPage + 1)}">다음</a></li>
				</c:if>
			</ul>
		</div>	<!-- 페이징 처리 끝 -->
	</div>
	<div class='right-box'>오른쪽</div>
</body>
</html>
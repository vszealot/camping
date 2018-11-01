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
	<section id="container">
		<h2>글 목록</h2>

		<table>
			<tr>
				<th>글 번호</th>
				<th>글 제목</th>
				<th>작성자</th>
				<th>작성일자</th>
			</tr>

			<!-- 목록 시작 -->
			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.postNo}</td>
					<td><a href="marketRead.do?postNo=${list.postNo}">${list.title}</a></td>
					<td>${list.nickName}</td>
					<td><fmt:formatDate value="${list.regDate}"
							pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
			<!-- 목록 끝 -->
		</table>
		<div class="search">
			<select name="searchType">
				<option value="w"
					<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
				<option value="t"
					<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
				<option value="c"
					<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
				<option value="n"
					<c:out value="${scri.searchType eq 'n' ? 'selected' : ''}"/>>작성자</option>
				<option value="tc"
					<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
			</select> <input type="text" name="keyword" id="keywordInput"
				value="${scri.keyword}" />
	
			<button id="searchBtn">검색</button>
		</div>
		<div>
			<ul>
				<c:if test="${page.prev}">
					<li><a href="marketListPage.do${page.makeQuery(page.startPage - 1)}">이전</a></li>
				</c:if>

				<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
					<li><a href="marketListPage.do${page.makeQuery(idx)}">${idx}</a></li>
				</c:forEach>

				<c:if test="${page.next && page.endPage > 0}">
					<li><a href="marketListPage.do${page.makeQuery(page.endPage + 1)}">다음</a></li>
				</c:if>
			</ul>
		</div>

	</section>
	<a href="marketListPage.do">목록으로</a>
	<a href="marketWrite.do">글쓰기</a>
</body>
<script>
	$(function() {
		$('#searchBtn').click(
				function() {
					self.location = "marketListSearch.do"
							+ '${page.makeQuery(1)}'
							+ "&searchType="
							+ $("select option:selected").val()
							+ "&keyword="
							+ encodeURIComponent($('#keywordInput')
									.val());
				});
	});
</script>
</html>
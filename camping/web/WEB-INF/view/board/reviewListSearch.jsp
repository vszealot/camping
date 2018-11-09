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
		<h2>후기 게시판</h2>

		<table class="table table-bordered">
			<tr>
				<th style="width: 4em;">번호</th>
				<th style="width: 40em;">제목</th>
				<th style="width: 8em;" >글쓴이</th>
				<th style="width: 8em;">등록일</th>
				<th style="width: 4em;">조회</th>
				<th style="width: 4em;">추천</th>
			</tr>

			<!-- 목록 시작 -->
			<c:forEach items="${list}" var="list">
				<tr>
					<td style="text-align: center;">${list.postNo}</td>
					<td><a href="javascript:updateClick('${list.click}','${list.postNo}')">${list.title} <span style="font-size: 0.85em">[${list.repCnt}]</span></a></td>
					<td>${list.nickName}</td>
					<td style="text-align: center;"><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd" /></td>
					<td style="text-align: center;">${list.click}</td>
					<td style="text-align: center;">${list.recCnt}</td>
				</tr>
			</c:forEach>
			<!-- 목록 끝 -->
		</table>
						
		<div class="search row">
			<div class="col-xs-2 col-sm-2">
				<select name="searchType" class="form-control">
					<option value=""  <c:out value="${page.searchType == null ? 'selected' : ''}"/>>-----</option>
					<option value="t" <c:out value="${page.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
					<option value="c" <c:out value="${page.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
					<option value="n" <c:out value="${page.searchType eq 'n' ? 'selected' : ''}"/>>작성자</option>
					<option value="tc" <c:out value="${page.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
				</select> 
			</div>
			<div class="col-xs-8 col-sm-8">
				<div class="input-group">
					<input type="text" name="keyword" id="keywordInput" value="${page.keyword}" class="form-control"/>
					<span class="input-group-btn">
						<button onkeypress="JavaScript:press(this.form)" class="btn btn-default" id="searchBtn">검색</button>
					</span>
				</div>
			</div>
			<c:if test="${!empty logOK}">
				<a role="button" href="reviewWrite.do" class="btn btn-default">글쓰기</a>
			</c:if>
			<c:if test="${empty logOK}">
				<button class="btn btn-default" disabled="disabled">글쓰기</button>
			</c:if>&nbsp;
			<a role="button" href="reviewListSearch.do" class="btn btn-default">글목록</a>
		</div>
		<div class="col-md-offset-3">
			<ul class="pagination">
				<c:if test="${page.prev}">
					<li><a href="reviewListSearch.do${page.makeSearch(page.startPage - 1)}">이전</a></li>
				</c:if>

				<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
					<li <c:out value="${page.page == idx ? 'class=active' : ''}"/>>
					<a href="reviewListSearch.do${page.makeSearch(idx)}">${idx}</a></li>
				</c:forEach>

				<c:if test="${page.next && page.endPage > 0}">
					<li><a href="reviewListSearch.do${page.makeSearch(page.endPage + 1)}">다음</a></li>
				</c:if>
			</ul>
		</div>			
</section>
</body>
<script>
	// 검색
	$(function() {
		$('#searchBtn').click(
				function() {
					self.location = "reviewListSearch.do"
							+ '${page.makeQuery(1)}'
							+ "&searchType="
							+ $("select option:selected").val()
							+ "&keyword="
							+ encodeURIComponent($('#keywordInput')
									.val());
				});
	});
	
	// 조회 수 증가 + 조회
	function updateClick(idx1,idx2){
 		$.ajax({
			type:"GET",
			url:"reviewUpdateClick.do?click="+ idx1 +"&postNo=" + idx2,
			success:function(data){
				location.href = "reviewRead.do?postNo="+ idx2 +"&page=${page.page}&perPageNum=${page.perPageNum}&"
								+"searchType=${page.searchType}&keyword=${page.keyword}";
			}
		});
	};
	
	// 엔터키 입력
    $("#keywordInput").keydown(function (key) {
 
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
            search();
        }
    });
	
	// 검색
    search = function (){
		self.location = "reviewListSearch.do"
			+ '${page.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword="
			+ encodeURIComponent($('#keywordInput')
					.val());
    };


</script>
</html>
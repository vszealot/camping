<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
javascript:pageList('${page.startPage - 1}')
</body>
<script>
function pageList(idx){
	var url = "campListAjax.do?page="+idx+"&perPageNum=10";
	$.ajax({
		type:"GET",
		url:url,
		success:function(data){
			var txt = "<tr>\r\n" + 
					"<th>이름</th>\r\n" + 
					"<th>거리x</th>\r\n" + 
					"<th>거리y</th>\r\n" + 
					"<th>주소</th>\r\n" + 
					"<th>전번</th>\r\n" + 
					"</tr>\r\n" + 
					"\r\n";
			$.each(data, function(idx, val) {
				txt += "<tr>\r\n" + 
					"<td>"+val.campName+"</td>\r\n" + 
					"<td id=\"lat\">"+val.x+"</td>\r\n" + 
					"<td id=\"lng\">"+val.y+"</td>\r\n" + 
					"<td><a href=\"javascript:abcd('"+val.x+"','"+val.y+"','"+val.campName+"','"+val.phone+"','"+val.addr1+"')\">"+val.addr1+"</a></td>\r\n" + 
					"<td>"+val.phone+"</td>\r\n" + 
					"</tr>\r\n";
			});

			$("#listTable").html(txt);
			
		}
	
	});
	pageList2(idx);
}
function pageList2(idx){

	var url2 = "campListAjax2.do?page="+idx+"&perPageNum=10";
	$.ajax({
		type:"GET",
		url:url2,
		success:function(data){
			var txt = "<ul>\r\n";
			if(data.prev){
				txt += "<li><a href=\"javascript:pageList('"+(data.startPage-1)+"')\">이전</a></li>\r\n";
			}
			for (var idx = data.startPage; idx <= data.endPage; idx++) {
				txt += "<li><a href=\"javascript:pageList('"+idx+"')\">"+idx+"</a></li>\r\n";
			}
			if(data.next && data.endPage > 0){
				txt += "<li><a href=\"javascript:pageList('"+(data.endPage+1)+"')\">다음</a></li>\r\n";
			}
			txt += "</ul>";
			
			$("#paging").html(txt);
		}
	});
}
</script>
</html>
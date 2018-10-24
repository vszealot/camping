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
	height: 350px;
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
						<td id="lat">${ob.x}</td>
						<td id="lng">${ob.y}</td>
						<td><a href="javascript:abcd('${ob.x}','${ob.y}','${ob.campName}','${ob.phone}','${ob.addr1}')">${ob.addr1}</a></td>
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
	<div id="map" class='right-box'>오른쪽</div>
	
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=43a46b979e2786b9e26b07fb83133bf1&libraries=clusterer,services"></script>
<script>


function abcd(x,y,name,phone,addr){
	
    
	//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
    var infowindow = new daum.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(x, y), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 

	
	// 지도에 마커를 표시하는 함수입니다

	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new daum.maps.Marker({
	        map: map,
	        position: new daum.maps.LatLng(x, y) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    daum.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	    	infowindow.setContent('<div class="placeinfo">' +'<span class="title2">' + name + '</span>' +'<br>'+
	    			'<span title="' + addr + '">' + addr + '</span>' + '<br>' +
                    '<span class="tel">' +phone + '</span>' +'<br>' +
                    '</div>' + 
                    '<div class="after"></div>'
	    	);
	        infowindow.open(map, marker);
	    });




}


 var infowindow = new daum.maps.InfoWindow({zIndex:1});
	var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
		center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
		level : 14
	// 지도의 확대 레벨 
	});

	// 마커 클러스터러를 생성합니다 
	var clusterer = new daum.maps.MarkerClusterer({
		map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		minLevel : 10
	// 클러스터 할 최소 지도 레벨 
	});
	
	// 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
	var url = "http://localhost:8088/camping/JSONServerList.jsp"
	$.getJSON(url, function(data) {
		// 데이터에서 좌표 값을 가지고 마커를 표시합니다
		// 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
		var markers = $(data).map(function(index, entry) {
			//alert(entry.lat + "  " + entry.lng);
			return new daum.maps.Marker({
				position : new daum.maps.LatLng(entry.lat, entry.lng)
			});
		});
		
		// 클러스터러에 마커들을 추가합니다
		clusterer.addMarkers(markers);
		
		daum.maps.event.addListener(markers, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + "텍스트" + '</div>');
	        infowindow.open(map, markers);
	    });
		
	});
	

	 
</script>
</html>
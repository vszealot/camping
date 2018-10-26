<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/main.jsp"%>
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

.w3-sidebar{height:100%;width:800px;background-color:#F6F6F6;position:fixed; top:0px; right:10px;z-index:1;overflow:auto};
.w3-bar-block{
width:100%;
min-width:100%;
width:100%;text-align:left;padding:8px 16px;
text-align:center;

width:100%;display:block;padding:8px 16px;text-align:left;border:none;white-space:normal;float:none;outline:0;

}

.w3-dark-grey{color:#fff!important;background-color:#F6F6F6!important};
.w3-animate-right{position:relative;animation:animateright 0.8s}@keyframes animateright{from{right:600px;opacity:0} to{right:0;opacity:1}}


.w3-bar-item{padding:8px 16px;float:right;width:auto;border:none;display:block;outline:0;
width:100%;display:block;padding:8px 16px;text-align:left;border:none;white-space:normal;float:none;outline:0;
text-align:center;};

.w3-button{width:100%};
.w3-large{font-size:18px!important}


.w3-button:hover{color:#000!important;background-color:#ccc!important}


.w3-white{position:fixed; top:50%; right:0px;color:#000!important;background-color:#fff!important}

.w3-xxlarge{font-size:20px!important}

.w3-container:after,.w3-container:before{content:"";display:table;clear:both};
</style>

</head>
<body>
	<br>
	<div class='left-box'>
	<input type="button" value="거리순"><input type="button" value="조회순"><input type="button" value="추천순">
	<select name="loc">
	    <option value="">지역별</option>
	    <option value="서울">서울</option>
	    <option value="경기">경기</option>
	    <option value="인천">인천</option>
	    <option value="강원">강원</option>
	    <option value="충청남도">충남</option>
	    <option value="대전">대전</option>
	    <option value="충청북도">충북</option>
	    <option value="세종">세종</option>
	    <option value="부산">부산</option>
	    <option value="울산">울산</option>
	    <option value="대구">대구</option>
	    <option value="경상북도">경북</option>
	    <option value="경상남도">경남</option>
	    <option value="전라남도">전남</option>
	    <option value="광주">광주</option>
	    <option value="전라북도">전북</option>
	    <option value="제주">제주</option>
	</select>
		<table id="listTable" border="1">
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
						<td><a
							href="javascript:abcd('${ob.x}','${ob.y}',
							'${ob.campName}','${ob.phone}','${ob.addr1}','${ob.addr2}')" onclick="w3_open()">${ob.addr1}</a></td>
						<td>${ob.phone}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div>
			<!-- 페이정 처리 시작 -->
			<ul>
				<c:if test="${page.prev}">
					<li><a href="campList.do?page=${page.startPage - 1}">이전</a></li>
				</c:if>

				<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
					<li><a href="javascript:pageList('${idx}')">${idx}</a></li>
				</c:forEach>

				<c:if test="${page.next && page.endPage > 0}">
					<li><a href="campList.do?page=${page.endPage + 1}">다음</a></li>
				</c:if>
			</ul>
		</div>
		<!-- 페이징 처리 끝 -->
	</div>
	<!-- 맵 div   -->
	<div id="map" class='right-box'>오른쪽</div>
	
	
	<!-- 사이드 정보 나오게 하는 곳   -->
	<div class = scroll-menu>
<div class="w3-sidebar w3-bar-block w3-dark-grey w3-animate-right" style="display:none" id="mySidebar">
  <button class="w3-bar-item w3-button w3-large"
  onclick="w3_close()">Close &times;</button>

</div>


<div>
  <button class="w3-button w3-white w3-xxlarge" onclick="w3_open()">&#9776;</button>
  
</div>
	</div>
	
	

<script>
//스크롤바를 따라 움직이는 반응형----------------------------------------------------
$(function() {

	  $(document).ready(function() {

	    var scrollOffset = $('.scroll-menu').offset();

	    $(window).scroll(function() {
	      if ($(document).scrollTop() > scrollOffset.top) {
	        $('.scroll-menu').addClass('scroll-fixed');
	      }
	      else {
	        $('.scroll-menu').removeClass('scroll-fixed');
	      }
	    });
	  } );

	});

// 사이드 메뉴 여는 기능----------------------------------------------------------	
function 
	w3_open() {
		document.getElementById("mySidebar").style.display = "block";
	}
	function w3_close() {
		document.getElementById("mySidebar").style.display = "none";
	}
</script>

</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=43a46b979e2786b9e26b07fb83133bf1&libraries=clusterer,services"></script>
<script type="text/javascript">
	
	function abcd(x, y, name, phone, addr, addr2) {
		lat = x;
		lng = y;
		
		

		//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new daum.maps.InfoWindow({
			zIndex : 1
		});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(x, y), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);

		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new daum.maps.MapTypeControl();

		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new daum.maps.ZoomControl();
		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
		// 지도에 마커를 표시하는 함수입니다

		// 마커를 생성하고 지도에 표시합니다
		var marker = new daum.maps.Marker({
			map : map,
			position : new daum.maps.LatLng(x, y)
		});

		// 마커에 클릭이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'click', function() {
			// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			infowindow.setContent('<div class="placeinfo">'
					+ '<span class="title2">' + name + '</span>' + '<br>'
					+ '<span title="' + addr + '">' + addr + '</span>' + '<br>'
					+ '<span class="tel">' + phone + '</span>' + '<br>'
					+ '</div>' + '<div class="after"></div>');
			infowindow.open(map, marker);
		});

	}

	var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
		center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
		level : 14
	// 지도의 확대 레벨 
	});
	
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new daum.maps.MapTypeControl();

	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

	// 마커 클러스터러를 생성합니다 
	var clusterer = new daum.maps.MarkerClusterer({
		map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		minLevel : 10
	// 클러스터 할 최소 지도 레벨 
	});

	// 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다

	//-----------------------------------------------------------------------------------------
	var result = new Array();
	<c:forEach items="${campListMap}" var="ob">
	var json = new Object();
	json.lat = "${ob.x}";
	json.lng = "${ob.y}";
	result.push(json);
	</c:forEach>

	var url = "http://localhost:8088/camping/JSONServerList.jsp"
	//$.getJSON(url, function(data) {
	//	alert(JSON.stringify(data));
		// 데이터에서 좌표 값을 가지고 마커를 표시합니다
		// 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
		var markers = $(result).map(function(index, entry) {
			//alert(entry.lat + "  " + entry.lng);
			return new daum.maps.Marker({
				position : new daum.maps.LatLng(entry.lat, entry.lng)
			});
		});

		// 클러스터러에 마커들을 추가합니다
		clusterer.addMarkers(markers);

	//});
	
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
}
</script>
</html>
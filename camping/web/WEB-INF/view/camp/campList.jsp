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
.inline{
display : inline;
}
ul{
list-style: none;
}
.left-box {
	display: inline-block;
	width: 35%;
	border: 1px solid black;
	font-size: 12px;
}

.right-box {
	display: inline-block;
	position : fixed;
	width: 64%;
	height: 550px;
	border: 1px solid black;
}

.w3-sidebar{height:800px;width:800px;background-color:#F6F6F6;position:fixed; top:21%; right:10px;z-index:1;overflow:auto};
.w3-bar-block{
width:100%;
min-width:100%;
width:100%;text-align:left;padding:8px 16px;
text-align:center;

width:100%;display:block;padding:8px 16px;text-align:left;border:none;white-space:normal;float:none;outline:0;

}

.w3-dark-grey{color:black!important;background-color:#F6F6F6!important};
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
.weather-temp{
	overflow:scroll;
	/* overflow-x:hidden;
	overflow-y:hidden; */
}

</style>
<script src="<c:url value="/js/weather.js" />"></script>
<script src="<c:url value="/js/tour.js" />"></script>
<script src="<c:url value="/js/dust.js" />"></script>
<script src="<c:url value="/js/distance.js" />"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

</head>
<body>
	<br>
	<div class='left-box'>
	<input type="button" value="거리순" onclick="javascript:seqdistn()"><input type="button" value="조회순"><input type="button" value="추천순">
	<select id="searchWord" name="searchWord" onchange="javascript:selectloc(this)">
	    <option value="" selected>지역별</option>
	    <option value="서울특별시">서울특별시</option>
	    <option value="경기도">경기도</option>
	    <option value="인천광역시">인천광역시</option>
	    <option value="강원도">강원도</option>
	    <option value="충청남도">충청남도</option>
	    <option value="대전광역시">대전광역시</option>
	    <option value="충청북도">충청북도</option>
	    <option value="세종시">세종시</option>
	    <option value="부산광역시">부산광역시</option>
	    <option value="울산광역시">울산광역시</option>
	    <option value="대구광역시">대구광역시</option>
	    <option value="경상북도">경상북도</option>
	    <option value="경상남도">경상남도</option>
	    <option value="전라남도">전라남도</option>
	    <option value="광주광역시">광주광역시</option>
	    <option value="전라북도">전라북도</option>
	    <option value="제주도">제주도</option>
	</select>
		<form name="frm" action="javascript:selectloc()">
				<input type="text" id="search">
				<input type="submit" value="검색" />
		</form>
		<table id="listTable" border="1">
			
			<%-- <c:if test="${!empty campList}">

				<c:forEach items="${campList}" var="ob"> --%>
					<!-- <tr id = "tr"> -->
						<%-- <td>${ob.campName}</td>
						<td id="lat">${ob.x}</td>
						<td id="lng">${ob.y}</td>
						<td><a href="javascript:abcd('${ob.x}','${ob.y}','${ob.campName}','${ob.phone}','${ob.addr1}','${ob.addr2}')" onclick="w3_open()">${ob.addr1}</a></td>
						<td>${ob.phone}</td> --%>
					<!-- </tr> -->
				<%-- </c:forEach>
			</c:if> --%>
		</table>
		
		<div id="paging">
			<!-- 페이정 처리 시작 -->
			<ul>
				<c:if test="${page.prev}">
					<li class='inline'><a href="javascript:pageList('${page.startPage - 1}')">이전</a></li>
				</c:if>

				<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
					<li class='inline'><a href="javascript:pageList('${idx}')">${idx}</a></li>
				</c:forEach>

				<c:if test="${page.next && page.endPage > 0}">
					<li class='inline'><a href="javascript:pageList('${page.endPage + 1}')">다음</a></li>
				</c:if>
			</ul>
		</div>
		<!-- 페이징 처리 끝 -->
	</div>
   <div id="map" class='right-box'></div>
   
	
	
	<!-- 사이드 정보 나오게 하는 곳   -->
	<div class = scroll-menu>
<div class="w3-sidebar w3-bar-block w3-dark-grey w3-animate-right" style="display:none" id="mySidebar">
  <button class="w3-bar-item w3-button w3-large"
  onclick="w3_close()">Close &times;</button>

	<div class="vis-weather">
        <h3 class="vh_hide" style='position:relative; left:40px'>날씨정보</h2>
        <p class="weather-date" style='position:relative; left:40px'></p>
        <ul>
            <li><div class="weather-temp" style='text-align:center;'></div></li>
        </ul>
         <h3 class="vh_hide" style='position:relative; left:40px'>미세먼지</h2>
        <ul>
            <li class="dust-state"></li>
        </ul>
        <h3 class="vh_hide" style='position:relative; left:40px'>주변 관광정보</h2>
        <div class="tour-info"></div>
    </div>
</div>

<div>
  <button class="w3-button w3-white w3-xxlarge" onclick="w3_open()">&#9776;</button>
  
</div>
	</div>
	
	

<script>
//스크롤바를 따라 움직이는 반응형----------------------------------------------------
//$(function() {

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

//	});

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

//주소 클릭했을 때의 function------------------------------------------------------------
	function abcd(x, y, name, phone, addr, addr2) {
		$("#map").empty();
		var latitude;
		var longitude;
		var distn;
		
	
		dust(addr);
		tour(x,y);
		//날씨 그리드_x,y구하기
		var url = "weather.do?addr1="+addr+"&addr2="+addr2;
		$.ajax({
			
			type:"GET",
			url:url,
			error:function(){
				console.log("통신실패");
			},
			success:function(data){
				console.log(data + "!!!!!!!!!!!!!!")
				realTimeWeather(data.grid_x,data.grid_y);
			}
		
		});

		//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new daum.maps.InfoWindow({
			zIndex : 1
		});

		mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(x, y), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);
		map.setMapTypeId(daum.maps.MapTypeId.HYBRID)

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
					+ '<span class="dis"></span>' + '<br>'
					+ '</div>' + '<div class="after"></div>');
			infowindow.open(map, marker);
		});

	}
	
	//----------------------------------------------------------------------------------
	var selectedWord=null;
	var result = new Array();
	var count=0;
	var lat1=0;
	var lng1=0;
	var searchWord;
	if("${page.searchWord}"){
		searchWord = "${page.searchWord}";
	}
	<c:forEach items="${campListMap}" var="ob">
	var json = new Object();
	
	json.lat = "${ob.x}";
	json.lng = "${ob.y}";
	
	count=count+1;
	json.addr1 ="${ob.addr1}";
	json.addr2 ="${ob.addr2}";
	json.campName ="${ob.campName}";
	json.phone ="${ob.phone}";
	result.push(json);
	
	
	</c:forEach>
	
	if (!!navigator.geolocation) 
	  {
	navigator.geolocation.getCurrentPosition(successCallback,errorCallback);
	
	  }
	else
	  {
	    alert("이 브라우저는 Geolocation를 지원하지 않습니다");
	  }
	function successCallback(position)
	  {
		 latitude = position.coords.latitude;
		 longitude = position.coords.longitude;
		 var txt="<tr><th>이름</th><th>거리</th><th>주소</th><th>전번</th></tr>";
		 <c:forEach items="${campList}" var="ob">
			txt += "<tr><td>${ob.campName}</td>";
			txt += "<td>" + distance("${ob.x}","${ob.y}",latitude, longitude) + "km</td>";
			txt += "<td><a href=\"javascript:abcd(\'${ob.x}\',\'${ob.y}\',\'${ob.campName}\',\'${ob.phone}\',\'${ob.addr1}\',\'${ob.addr2}\')\" onclick=\"w3_open()\">${ob.addr1}</a></td>\r\n";
			txt += "<td>${ob.phone}</td></tr>";
			 </c:forEach>
		
		$("#listTable").html(txt);
	  }
	  
	  function errorCallback(error)
	  {
	    alert(error.message);
	  }    
	 //지도 지역에따라 표시하는 기능 + 줌까지 조절----------------------------------------------------------------------------
		
		  var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
				center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
				level : 13
			// 지도의 확대 레벨 
			});
	
		  map.setMapTypeId(daum.maps.MapTypeId.HYBRID)
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
		
	
	
	
	/*  <c:forEach items="${campListMap}" var="ob">
	
	var lat = "${ob.x}";
	var lng = "${ob.y}";
		if(navigator.geolocation){
			alert("지원됨");
			navigator.geolocation.getCurrentPosition(displayLocation,displayerr);
		}else{
			alert("지원안됨");
		}
		function displayLocation(position){
			latitude = position.coords.latitude; 
			longitude = position.coords.longitude;
			console.log(distance(lat, lng, latitude, longitude));
		}
		function displayerr(error){
			var errorTypes = {
					0:"알려지지 않은  에러",
					1:"사용자가 권한 거부",
					2:"위치 찾을 수 없음",
					3:"요청 응답 초과",
			};
	
			var errmsg = errorTypes[error.code];
			errmsg = errmsg + "  " + error.message;
	
			console.log(errmsg);

	</c:forEach>  */

	//var url = "http://localhost:8088/camping/JSONServerList.jsp"
	//$.getJSON(url, function(data) {
	//	alert(JSON.stringify(data));
		// 데이터에서 좌표 값을 가지고 마커를 표시합니다
		// 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
		var markers = $(result).map(function(index, entry) {
			
			return new daum.maps.Marker({
				position : new daum.maps.LatLng(entry.lat, entry.lng)
			});
		}); 

		// 클러스터러에 마커들을 추가합니다
		clusterer.addMarkers(markers);

	//});
	//거리순으로 데이터 나타내기
	function seqdistn(){
			
			if (!!navigator.geolocation) 
			  {
				navigator.geolocation.getCurrentPosition(successCallback,errorCallback);
			
			  }
			else
			  {
			    alert("이 브라우저는 Geolocation를 지원하지 않습니다");
			  }
			/* var distan = new Array();
			var distan2 = new Array();
			var addr = new Array();
			var phone = new Array();
			var cname = new Array(); */
			var test = [];
			function successCallback(position)
			  {
				 latitude = position.coords.latitude;
				 longitude = position.coords.longitude;
				 $(result).map(function(index, entry) {
					 	test.push({distan:distance(entry.lat,entry.lng,latitude, longitude),
					 		addr1:entry.addr1,phone:entry.phone,cname:entry.campName,x:entry.lat,y:entry.lng,addr2:entry.addr2});
					 	})
				 test.sort(function(a,b){
					 return parseFloat(a.distan) - parseFloat(b.distan);

				 });
				 
				 var txt = "<tr>\r\n" + 
					"<th>이름</th>\r\n" + 
					"<th>거리</th>\r\n" + 
					"<th>주소</th>\r\n" + 
					"<th>전번</th>\r\n" + 
					"</tr>\r\n" + 
					"\r\n";
					
				 $(test).map(function(index, entry) {
					 txt += "<tr>\r\n<td>"+entry.cname+"</td>\r\n";
					 txt += "<td>" + entry.distan + "km</td>\r\n";
					 txt += "<td><a href=\"javascript:abcd('"+entry.x+"','"+entry.y+"','"+entry.cname+"','"+entry.phone+"','"+entry.addr1+"','"+entry.addr2+"')\" onclick=\"w3_open()\">"+entry.addr1+"</a></td>\r\n" +
						"<td>"+entry.phone+"</td>\r\n" + 
						"</tr>\r\n";
				 });
				 
				 $("#listTable").html(txt);
						 /* distan[index]=distance(entry.lat,entry.lng,latitude, longitude);
						 distan2[index]=distance(entry.lat,entry.lng,latitude, longitude);
						 addr[index]=entry.addr;
						 phone[index]=entry.phone;
						 cname[index]=entry.campName; */
						 
						 $("#map").empty();	 
				  var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
						center : new daum.maps.LatLng(latitude, longitude), // 지도의 중심좌표 
						level : 12
					// 지도의 확대 레벨 
					});
						 
						 var imageSrc = '/camping/image/홈.png', // 마커이미지의 주소입니다    
						    imageSize = new daum.maps.Size(64, 69), // 마커이미지의 크기입니다
						    imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
						    
						    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
						    markerPosition = new daum.maps.LatLng(latitude, longitude); // 마커가 표시될 위치입니다
						    
						 // 마커를 생성합니다
						    var marker = new daum.maps.Marker({
						        position: markerPosition, 
						        image: markerImage // 마커이미지 설정 
						    });

						    // 마커가 지도 위에 표시되도록 설정합니다
						    marker.setMap(map);  
			
			
				  map.setMapTypeId(daum.maps.MapTypeId.HYBRID)
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
						 
				var markers = $(result).map(function(index, entry) {
					
					return new daum.maps.Marker({
						position : new daum.maps.LatLng(entry.lat, entry.lng)
					});
				}); 

				// 클러스터러에 마커들을 추가합니다
				clusterer.addMarkers(markers);		 
						 
				
			  }
			  
			  function errorCallback(error)
			  {
			    alert(error.message);
			  }
		}
	
	
	var latitude=0;
	var longitude=0;
	
	
		function pageList(idx){
			console.log(idx+"!!!!!!!!!!!!!!!!!!!!!!1")			
		
			if(selectedWord==null){
				var url = "campListAjax.do?page="+idx+"&perPageNum=10";
			}else{
				var url = "campListAjax.do?page="+idx+"&perPageNum=10&searchWord="+selectedWord ;
			}
				
			
			
			$.ajax({
				type:"GET",
				url:url,
				success:function(data){
						console.log(data);
						if (!!navigator.geolocation) 
						  {
						navigator.geolocation.getCurrentPosition(successCallback,errorCallback);
						
						  }
						else
						  {
						    alert("이 브라우저는 Geolocation를 지원하지 않습니다");
						  }
						function successCallback(position)
						  {
							 latitude = position.coords.latitude;
							 longitude = position.coords.longitude;
							 var txt = "<tr>\r\n" + 
								"<th>이름</th>\r\n" + 
								"<th>거리</th>\r\n" + 
								"<th>주소</th>\r\n" + 
								"<th>전번</th>\r\n" + 
								"</tr>\r\n" + 
								"\r\n";
							$.each(data, function(idx, val) {
								txt += "<tr>\r\n<td>"+val.campName+"</td>\r\n";
								txt += "<td>" + distance(val.x, val.y, latitude, longitude) + "km</td>\r\n";
								txt += "<td><a href=\"javascript:abcd('"+val.x+"','"+val.y+"','"+val.campName+"','"+val.phone+"','"+val.addr1+"','"+val.addr2+"')\" onclick=\"w3_open()\">"+val.addr1+"</a></td>\r\n" +
								"<td>"+val.phone+"</td>\r\n" + 
								"</tr>\r\n";
							});

							
							$("#listTable").html(txt);
						  }
						  
						  function errorCallback(error)
						  {
						    alert(error.message);
						  }    
				}
			
			});
			pageList2(idx);
		}
		function pageList2(idx){
			
			if(selectedWord==null){
				var url2 = "campListAjax2.do?page="+idx+"&perPageNum=10";
			}else{
				var url2 = "campListAjax2.do?page="+idx+"&perPageNum=10&searchWord="+selectedWord ;
			}
			
			$.ajax({
				type:"GET",
				url:url2,
				error:function(){
				},
				success:function(data){
					var txt = "<ul>\r\n";
					if(data.prev){
						txt += "<li class='inline'><a href=\"javascript:pageList('"+(data.startPage-1)+"')\">이전</a></li>\r\n";
					}
					for (var idx = data.startPage; idx <= data.endPage; idx++) {
						txt += "<li class='inline'><a href=\"javascript:pageList('"+idx+"')\">"+idx+"</a></li>\r\n";
					}
					if(data.next && data.endPage > 0){
						txt += "<li class='inline'><a href=\"javascript:pageList('"+(data.endPage+1)+"')\">다음</a></li>\r\n";
					}
					txt += "</ul>";
					
					$("#paging").html(txt);
				}
			});
		}
		
		
		function selectloc(selectedloc){
			
			if(frm.search.value==""){
			selectedWord = selectedloc.value;
			}else{
				selectedWord = frm.search.value;
			}
			
			$("#search").val("");
			
			console.log(frm.search.value);
			
			var url3="searchProc.do?searchWord="+selectedWord;
			 $.ajax({
			type:"GET",
			url:url3,
			error:function(){
				console.log("통신실패");
			},
			success:function(data){
				console.log("${page.endPage}");
				
				 var txt = "<tr>\r\n" + 
					"<th>이름</th>\r\n" + 
					"<th>거리</th>\r\n" + 
					"<th>주소</th>\r\n" + 
					"<th>전번</th>\r\n" + 
					"</tr>\r\n" + 
					"\r\n";
				$.each(data, function(idx, val) {
					txt += "<tr>\r\n<td>"+val.campName+"</td>\r\n";
					txt += "<td>" + distance(val.x, val.y, latitude, longitude) + "km</td>\r\n";
					txt += "<td><a href=\"javascript:abcd('"+val.x+"','"+val.y+"','"+val.campName+"','"+val.phone+"','"+val.addr1+"','"+val.addr2+"')\" onclick=\"w3_open()\">"+val.addr1+"</a></td>\r\n" +
					"<td>"+val.phone+"</td>\r\n" + 
					"</tr>\r\n";
				});
				
				
				$("#listTable").html(txt);
				
				$("#map").empty();
				
				
				var url = 'https://dapi.kakao.com/v2/local/search/address.json?';
				
				url += 'query=' + selectedWord;

				headerParams = {
					'Authorization' : 'KakaoAK 3ed68aab065fe82c31c31252abc29b98'
				};
				$.ajax({
					type : 'get',
					url : url,
					async : false,
					headers : headerParams,
					data : [],
					dataType : 'json',
					processData : false,
					success : function(data) {
						console.log(data);
						lat1 = data.documents[0].y;
						lng1 = data.documents[0].x;
						
						console.log(lat1);
						console.log(lng1);
					}
				}); 
				
			 var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
					center : new daum.maps.LatLng(lat1, lng1), // 지도의 중심좌표 
					level : 10
				// 지도의 확대 레벨 
				});
			 map.setMapTypeId(daum.maps.MapTypeId.HYBRID)
			 
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
				var markers = $(result).map(function(index, entry) {
					
					return new daum.maps.Marker({
						position : new daum.maps.LatLng(entry.lat, entry.lng)
					});
				}); 
				
				clusterer.addMarkers(markers);
			 	var pagetxt;
				//페이지 처리...----------------------------------------------------
					var url2 = "campListAjax2.do?page="+1+"&perPageNum=10&searchWord="+selectedWord ;
				
				$.ajax({
					type:"GET",
					url:url2,
					error:function(){
					},
					success:function(data){
						var txt = "<ul>\r\n";
						if(data.prev){
							txt += "<li class='inline'><a href=\"javascript:pageList('"+(data.startPage-1)+"')\">이전</a></li>\r\n";
						}
						for (var idx = data.startPage; idx <= data.endPage; idx++) {
							txt += "<li class='inline'><a href=\"javascript:pageList('"+idx+"')\">"+idx+"</a></li>\r\n";
						}
						if(data.next && data.endPage > 0){
							txt += "<li class='inline'><a href=\"javascript:pageList('"+(data.endPage+1)+"')\">다음</a></li>\r\n";
						}
						txt += "</ul>";
						
						$("#paging").html(txt);
					}
				});
				
			}
			
			})
			
			
		}
		
		
		
</script>
</html>
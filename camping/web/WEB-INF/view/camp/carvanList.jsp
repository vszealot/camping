<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/main.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Hi+Melody|Jua&amp;subset=korean" rel="stylesheet">
<script src="<c:url value="/js/weather.js" />"></script>
<script src="<c:url value="/js/tour.js" />"></script>
<script src="<c:url value="/js/dust.js" />"></script>
<script src="<c:url value="/js/distance.js" />"></script>
<script src="<c:url value="/js_carvan/selectloc_carvan.js" />"></script>
<script src="<c:url value="/js_carvan/seqdistn_carvan.js" />"></script>
<script src="<c:url value="/js_carvan/inquiry_carvan.js" />"></script>
<script src="<c:url value="/js/update.js"/>"></script>
<script src="<c:url value="/js/seqrecommendcarvan.js"/>"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

</head>
<body class="body">
	
	<div class="button-7">
    <div class="eff-7"></div>
    <a class="special" href="javascript:updateId('${logOK.nickName}')" style="text-decoration: none;">업데이트순</a>
  	</div>

	<div class="button-7">
    <div class="eff-7"></div>
    <a class="normal" href="javascript:seqdistn_carvan(1)" style="text-decoration: none;"> 거리순 </a>
  	</div>
  	
  	<div class="button-7">
    <div class="eff-7"></div>
    <a class="normal" href="javascript:inquiry_carvan()" style="text-decoration: none;"> 조회순 </a>
  	</div>
  	
  	<div class="button-7">
    <div class="eff-7"></div>
    <a class="normal"href="javascript:seqrecommendcarvan()" style="text-decoration: none;"> 추천순 </a>
  	</div>
  	
  	<div id="select_box">
  	<label class="label" for="color">지역을 선택하세요</label>
	<select class="searchWord" id="color" name="searchWord" title="select color" onchange="javascript:selectloc_carvan(this)">
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
	</div>
		<form class="search" id="search" name="frm" action="javascript:selectloc_carvan()">
		<span class='green_window'>
			<input type='text' id="search" class='input_text' />
		</span>
		<button type='submit' class='sch_smit'>검색</button>
		</form>
		
		
		<div class='left-box'>
		<div id="paging1">
			<!-- 페이정 처리 시작 -->
			<ul class='pagination pagination-sm'>
				<c:if test="${page.prev}">
					<li class='page-item'><a class='page-link' href="javascript:pageList('${page.startPage - 1}')">&lt;&lt;</a></li>
				</c:if>

				<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
					<li class='page-item'><a class='page-link' href="javascript:pageList('${idx}')">${idx}</a></li>
				</c:forEach>

				<c:if test="${page.next && page.endPage > 0}">
					<li class='page-item'><a class='page-link' href="javascript:pageList('${page.endPage + 1}')">&gt;&gt;</a></li>
				</c:if>
			</ul>
		</div>
		<div id="listTable"></div>
		<div id="paging2">
			<!-- 페이정 처리 시작 -->
			<ul class='pagination pagination-sm'>
				<c:if test="${page.prev}">
					<li class='page-item'><a class='page-link' href="javascript:pageList('${page.startPage - 1}')">&lt;&lt;</a></li>
				</c:if>

				<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
					<li class='page-item'><a class='page-link' href="javascript:pageList('${idx}')">${idx}</a></li>
				</c:forEach>

				<c:if test="${page.next && page.endPage > 0}">
					<li class='page-item'><a class='page-link' href="javascript:pageList('${page.endPage + 1}')">&gt;&gt;</a></li>
				</c:if>
			</ul>
		</div>
		<!-- 페이징 처리 끝 -->
	</div>
	
   <div id="map" class='right-box'></div>
   
	
	
	<!-- 사이드 정보 나오게 하는 곳   -->
	
<div class="sidebar sideblock sidedarkgrey sideanimate" style="display:none" id="mySidebar">
<table style='border:1;'>
<tr><td><div style="border: 2px solid #33333324; width:20px; padding:1px; height: 602px;position: fixed;font-family: 'Jua', sans-serif;background-color: dimgrey; text-align:left;padding-top: 275px;" class = scroll-menu>
닫<br><br><br>기</div></td>
<td>
	<div class="vis-weather">
	<br><br><br><br><br><br>
		<h3 class="vh_hide" style='position:relative; left:40px'>캠핑장 정보</h3>
		<h3 class="thumbsup">이 캠핑장이 마음에 드신다면 '따봉'해주세요!!</h3>
		<input type="hidden" id="hiddenaddr" value="">
		<a role="button" class="recommendbutton" href="javascript:updateRecommend('${logOK.nickName}')"></a>
		<span class = "recommendcount" id="reccnt"></span>
		<p style='position:relative; left:60px'>시설 이용정보</p>
		<div class="campfacility"></div>
		<br>
		<div class="campsitenum" style='position:relative; left:60px;'></div>
		<br>
		<div class="usingfee" style='position:relative; left:60px;'></div>
		<br>
		<div class="usingtime" style='position:relative; left:60px;'></div>
		<br>
        <h3 class="vh_hide" style='position:relative; left:40px'>날씨정보</h3>
        <p class="weather-date" style='position:relative; left:40px'></p>
        <ul>
            <li><div class="weather-temp" style='text-align:center;'></div></li>
        </ul>
         <h3 class="vh_hide" style='position:relative; left:40px'>미세먼지</h3>
        <ul>
            <li class="dust-state"></li>
        </ul>
        <h3 class="vh_hide" style='position:relative; left:40px'>주변 관광정보</h3>
        <div class="tour-info"></div>
    </td>
    </tr>
    
    </table>
</div>

<div>
<div style="border: 2px solid #33333324; width:17.5px; padding:1px; height: 602px;position: fixed;font-family: 'Jua', sans-serif;background-color: dimgrey; text-align:left;padding-top: 275px;" class = side-open>
열<br><br><br>기</div>
  
</div>
	</div>
	
	

<script>
//스크롤바를 따라 움직이는 반응형----------------------------------------------------
//$(function() {

	  $(document).ready(function() {

	    var scrollOffset = $('.side-open').offset();

	    $(window).scroll(function() {
	      if ($(document).scrollTop() > scrollOffset.top) {
	        $('.side-open').addClass('scroll-fixed');
	      }
	      else {
	        $('.side-open').removeClass('scroll-fixed');
	      }
	    });
	  } );
	  
	  
	  var currentPosition = parseInt($("#scroll-menu").css("top"));
	  
	  $(window).scroll(function() {
		  var position = $(window).scrollTop();
		  $("#sidebox").stop().animate({
			  "top":position+currentPosition+"px"},1000);
		  });


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
$("div.scroll-menu").click(
		function()
		{
			w3_close();
		});
		
$("div.side-open").click(
		function()
		{
			w3_open();
		});		
//주소 클릭했을 때의 function------------------------------------------------------------
	function abcd(x, y, name, phone, addr, addr2) {
		$('#hiddenaddr').val(addr);
		$.ajax({
			type:"GET",
			url:"reccount.do?addr1="+addr,
			success:function(data){
				$('#reccnt').html(data);
			}
		})
		
		
		$.ajax({
			type:"GET",
			url:"inquiryUp.do?addr1="+addr,
			error:function(){
				console.log("통신실패");
			},
			success:function(data){
				console.log(data);
			}
		})
	
	
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
		
		
		//캠핑장 정보가져오기
		$.ajax({
			
			type:"GET",
			url:"campdetail.do?addr1="+addr,
			error:function(){
				console.log("통신실패");
			},
			success:function(data){
				var strArray = data.conv.split(' ');
				var counting=0;
				var campinfo = "<table><tr>"
				for(var i=0;i<strArray.length;i++){
					if(strArray[i]=="상하수도"||strArray[i]=="상하수시설"){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/수도.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'수도시설'+"</li></ul><td>"
						counting++;
					}
					if(strArray[i]=="샤워장"){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/샤워장.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'샤워장'+"</li></ul><td>"
						counting++;
					}
					
					
					if(strArray[i]=="취사장"||strArray[i]=="취사"||strArray[i]=="식기세척장"){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/취사장.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'취사장'+"</li></ul><td>"
						counting++;
					}
					if(strArray[i]=="물놀이시설"||strArray[i]=="수영장"||strArray[i=="물놀이장"]){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/수영장.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'수영장'+"</li></ul><td>"
						counting++;
					}
					if(strArray[i]=="화장실"||strArray[i]=="야외화장실"||strArray[i]=="화장실(남여)"){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/화장실.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'화장실'+"</li></ul><td>"
						counting++;
					}
					if(counting>5){
						campinfo += "</tr><tr>";
						counting = 0;
					}
					if(strArray[i]=="전기"){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/전기.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'전기'+"</li></ul><td>"
						counting++;
					}
					if(counting>5){
						campinfo += "</tr><tr>";
						counting = 0;
					}
					if(strArray[i]=="매점"){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/매점.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'매점'+"</li></ul><td>"
					}
					if(counting>5){
						campinfo += "</tr><tr>";
						counting = 0;
					}
					if(strArray[i]=="놀이터"){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/놀이터.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'놀이터'+"</li></ul><td>"
					}
					if(counting>5){
						campinfo += "</tr><tr>";
						counting = 0;
					}
					if(strArray[i]=="세척기"){
						campinfo += "<td style='width:140px'><ul style='width:140px'><li style='width:140px'><img style='width: 100px; height: 100px; padding: 5px; left: 15px; position: relative;' src='/camping/image2/세탁기.png'></li><li style='left: 15px; position: relative;text-align:center'>"+'세탁기'+"</li></ul><td>"
					}
					if(counting>5){
						campinfo += "</tr><tr>";
						counting = 0;
					}
				}
				
				campinfo += "</tr></table>"
				
				$('.campfacility').html(campinfo);
					console.log(data.siteNum +"!!!!!!!!!!!!!!!!!!!!!!!!!!");
				if(data.siteNum){
					var campsitenum = "<span style='color:orange'><span style='color:black'>설치 가능한 사이트 수 : </span>"+data.siteNum+"동 설치 가능</span>";
				}else{
					var campsitenum = "<span style='color:orange'>정보 없음</span>";
				}
				$('.campsitenum').html(campsitenum);
				
				
				
				if(data.usePee){
					var usingfee = "<span style='color:orange'><span style='color:black'>요금정보 : </span>"+data.usePee+"</span>";
				}else{
					var usingfee = "<span style='color:orange'>정보 없음</span>";
				}
				$('.usingfee').html(usingfee);
				
				
				if(data.useTime){
					var usingtime = "<span style='color:orange'><span style='color:black'>이용가능 시간 : </span>"+data.useTime+"</span>";
				}else{
					var usingtime = "<span style='color:orange'>정보 없음</span>";
				}
				$('.usingtime').html(usingtime);
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
	
	<c:forEach items="${carvanListMap}" var="ob">
	var json = new Object();
	
	json.lat = "${ob.x}";
	json.lng = "${ob.y}";
	
	count=count+1;
	json.addr1 ="${ob.addr1}";
	json.addr2 ="${ob.addr2}";
	json.campName ="${ob.campName}";
	json.phone ="${ob.phone}";
	json.image = "${ob.image}";
	json.campType = "${ob.campType}";
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
		 var txt="<div class='listTable'><table class='camptable'><tbody>";
		 var camptype;
		 <c:forEach items="${carvanList}" var="ob">
				txt += "<tr style='border-bottom :1px solid gray;border-top:1px solid gray;'><td>\r\n<div class='img'><img src=\'${ob.image}\' width='180px'></div></td>"
			if("${ob.campType}"=="야영장"){
				txt += "<td style='width:320px;padding:5px;margin:5px;'><ul style='margin:0;padding:0;'><li><div style='background-color:#87003A;color:white;text-align:center;font-size: 15px; padding-bottom: 5px; padding-top: 5px; width: 80px;' class='camptype'>"+"야영장"+"</div></li>\r\n";
			}else{
				txt += "<td style='width:320px;padding:5px;margin:5px;'><ul style='margin:0;padding:0;'><li><div style='background-color:#2FED28;color:white;text-align:center;font-size: 15px; padding-bottom: 5px; padding-top: 5px; width: 130px;' class='camptype'>"+"글램핑 / 카라반"+"</div></li>\r\n";
			}
			txt += "<li><div class='campname'><a style='text-decoration:none;' href=\"javascript:abcd(\'${ob.x}\',\'${ob.y}\',\'${ob.campName}\',\'${ob.phone}\',\'${ob.addr1}\',\'${ob.addr2}\')\" onclick=\"w3_open()\">${ob.campName}</a><br></div></li>\r\n";
			txt += "<li><div class='distance'>" + distance("${ob.x}","${ob.y}",latitude, longitude) + "km</div></li>\r\n";
			txt += "<li><div class='addr'>${ob.addr1}</div></li>\r\n";
			txt += "<li><div class='phone'>${ob.phone}</div></li></ul></td></tr>\r\n";
			 </c:forEach>
			txt += "</tbody></table></div>\r\n";
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
	
	
	
	var latitude=0;
	var longitude=0;
	
	
		function pageList(idx){
			console.log(idx+"!!!!!!!!!!!!!!!!!!!!!!1")			
		
			if(selectedWord==null){
				var url = "carvanListAjax.do?page="+idx+"&perPageNum=10";
			}else{
				var url = "carvanListAjax.do?page="+idx+"&perPageNum=10&searchWord="+selectedWord ;
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
							 var txt = "<div class='listTable'><table class='camptable'><tbody>";
							$.each(data, function(idx, val) {
								txt += "<tr style='border-bottom :1px solid gray;border-top:1px solid gray;'><td>\r\n<div class='img'><img src='"+val.image+"' width='180px'></div></td>";
								if(val.campType=="야영장"){
									txt += "<td style='width:320px;padding:5px;margin:5px;'><ul style='margin:0;padding:0;'><li><div style='background-color:#87003A;color:white;text-align:center;font-size: 15px; padding-bottom: 5px; padding-top: 5px; width: 80px;' class='camptype'>"+"야영장"+"</div></li>\r\n";
								}else{
									txt += "<td style='width:320px;padding:5px;margin:5px;'><ul style='margin:0;padding:0;'><li><div style='background-color:#2FED28;color:white;text-align:center;font-size: 15px; padding-bottom: 5px; padding-top: 5px; width: 130px;' class='camptype'>"+"글램핑 / 카라반"+"</div></li>\r\n";
								}
								txt += "<li><div class='campname'><a style='text-decoration:none;' href=\"javascript:abcd('"+val.x+"','"+val.y+"','"+val.campName+"','"+val.phone+"','"+val.addr1+"','"+val.addr2+"')\" onclick=\"w3_open()\">"+val.campName+"</a><br></div></li>\r\n";
								txt += "<li><div class='distance'>" + distance(val.x, val.y, latitude, longitude) + "km</div></li>\r\n";
								txt += "<li><div class='addr'>"+val.addr1+"</div></li>\r\n" +
								"<li><div class='phone'>"+val.phone+"</div></li></ul></td></tr>\r\n";
							});

							txt += "</tbody></table></div>\r\n";
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
				var url2 = "carvanListAjax2.do?page="+idx+"&perPageNum=10";
			}else{
				var url2 = "carvanListAjax2.do?page="+idx+"&perPageNum=10&searchWord="+selectedWord ;
			}
			
			$.ajax({
				type:"GET",
				url:url2,
				error:function(){
				},
				success:function(data){
					var txt = "<ul class='pagination pagination-sm'>\r\n";
					if(data.prev){
						txt += "<li class='page-item'><a class='page-link' href=\"javascript:pageList('"+(data.startPage-1)+"')\">&lt;&lt;</a></li>\r\n";
					}
					for (var idx = data.startPage; idx <= data.endPage; idx++) {
						txt += "<li class='page-item'><a class='page-link' href=\"javascript:pageList('"+idx+"')\">"+idx+"</a></li>\r\n";
					}
					if(data.next && data.endPage > 0){
						txt += "<li class='page-item'><a class='page-link' href=\"javascript:pageList('"+(data.endPage+1)+"')\">&gt;&gt;</a></li>\r\n";
					}
					txt += "</ul>";
					
					$("#paging1").html(txt);
					$("#paging2").html(txt);
				}
			});
		}
		
		function updateRecommend(id){
			if(id==""){
				alert("로그인 하셔야 추천할 수 있습니다.");
			}else{
				var addr = $("#hiddenaddr").val(); 
				$.ajax({
					type:"GET",
					url:"campUpdateRecommend.do?addr1="+addr+"&nickName="+id,
					success:function(data){
						$('#reccnt').html(data);
					}
				});
			}

		}
		
		
		
		
</script>
</html>
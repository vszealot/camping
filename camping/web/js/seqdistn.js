//거리순으로 데이터 나타내기
	function seqdistn(z){
			
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
					 		addr1:entry.addr1,phone:entry.phone,cname:entry.campName,x:entry.lat,y:entry.lng,addr2:entry.addr2,image:entry.image});
					 	})
				 test.sort(function(a,b){
					 return parseFloat(a.distan) - parseFloat(b.distan);

				 });
				 var txt = new Array();
				 var txt2 = new Array();
					console.log(test[0]);
					
					for(var i=1;i<175;i++){
						txt[i] = "<div class='listTable'><table class='camptable'><tbody>"
					for(var j=(i-1)*(10)+1;j<10*(i)+1;j++){
						 txt[i] += "<tr style='border-bottom :1px solid gray;border-top:1px solid gray;'><td>\r\n<div class='img'><img src='"+test[j-1].image+"' width='180px'></div></td>"
						 txt[i] += "<td style='width:320px;padding:5px;margin:5px;'><ul style='margin:0;padding:0;'><li><div class='campname'><a style='text-decoration:none;' href=\"javascript:abcd('"+test[j-1].x+"','"+test[j-1].y+"','"+test[j-1].cname+"','"+test[j-1].phone+"','"+test[j-1].addr1+"','"+test[j-1].addr2+"')\" onclick=\"w3_open()\">"+test[j-1].cname+"</a><br></div></li>\r\n";
						 txt[i] += "<li><div class='distance'>" + test[j-1].distan + "km</div></li>\r\n";
						 txt[i] += "<li><div class='addr'>"+test[j-1].addr1+"</div></li>\r\n" +
							"<li><div class='phone'>"+test[j-1].phone+"</div></li></ul></td></tr>\r\n"; 
						 
						
					}
					
						txt[i] += "</tbody></table></div>\r\n";
						
						
					}
					
					console.log(txt[z]);
						txt2[1] = "<ul class='pagination pagination-sm' style='margin-left: auto; margin-right:auto;'>\r\n";
						for(var i=1;i<11;i++){
						txt2[1] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+i+"')\">"+i+"</a></li>\r\n";
						}
						txt2[1] += "<li class='page-item '><a class='page-link' href=\"javascript:seqdistn('"+11+"')\">"+">>"+"</a></li>\r\n";
						
						txt2[1] +=  "</ul>\r\n";
						
						
						txt2[2] = "<ul class='pagination pagination-sm'>\r\n";
						txt2[2] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+10+"')\">"+"<<"+"</a></li>\r\n";
						for(var i=11;i<21;i++){
						txt2[2] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+i+"')\">"+i+"</a></li>\r\n";
						}
						txt2[2] += "<li class='inline'><a class='page-link' href=\"javascript:seqdistn('"+21+"')\">"+">>"+"</a></li>\r\n";
						
						txt2[1] +=  "</ul>\r\n";
						
						
						txt2[3] = "<ul class='pagination pagination-sm'>\r\n";
						txt2[3] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+20+"')\">"+"이전"+"</a></li>\r\n";
						for(var i=21;i<31;i++){
						txt2[3] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+i+"')\">"+i+"</a></li>\r\n";
						}
						txt2[3] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+41+"')\">"+"다음"+"</a></li>\r\n";
						
						txt2[3] +=  "</ul>\r\n";
						
						
						txt2[4] = "<ul class='pagination pagination-sm'>\r\n";
						txt2[4] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+30+"')\">"+"이전"+"</a></li>\r\n";
						for(var i=31;i<41;i++){
						txt2[4] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+i+"')\">"+i+"</a></li>\r\n";
						}
						txt2[4] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+51+"')\">"+"다음"+"</a></li>\r\n";
						
						txt2[4] +=  "</ul>\r\n";
						
						
						txt2[5] = "<ul class='pagination pagination-sm'>\r\n";
						txt2[5] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+40+"')\">"+"이전"+"</a></li>\r\n";
						for(var i=41;i<51;i++){
						txt2[5] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+i+"')\">"+i+"</a></li>\r\n";
						}
						txt2[5] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+61+"')\">"+"다음"+"</a></li>\r\n";
						
						txt2[5] +=  "</ul>\r\n";
						
						
						txt2[6] = "<ul class='pagination pagination-sm'>\r\n";
						txt2[6] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+50+"')\">"+"이전"+"</a></li>\r\n";
						for(var i=51;i<61;i++){
						txt2[6] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+i+"')\">"+i+"</a></li>\r\n";
						}
						txt2[6] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+71+"')\">"+"다음"+"</a></li>\r\n";
						
						txt2[6] +=  "</ul>\r\n";
						
						
						
						txt2[7] = "<ul class='pagination pagination-sm'>\r\n";
						txt2[7] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+60+"')\">"+"이전"+"</a></li>\r\n";
						for(var i=61;i<71;i++){
						txt2[7] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+i+"')\">"+i+"</a></li>\r\n";
						}
						txt2[7] += "<li class='page-item'><a href=\"javascript:seqdistn('"+81+"')\">"+"다음"+"</a></li>\r\n";
						
						txt2[7] +=  "</ul>\r\n";
						
						
						
						txt2[8] = "<ul class='pagination pagination-sm'>\r\n";
						txt2[8] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+70+"')\">"+"이전"+"</a></li>\r\n";
						for(var i=71;i<81;i++){
						txt2[8] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+i+"')\">"+i+"</a></li>\r\n";
						}
						txt2[8] += "<li class='page-item'><a class='page-link' href=\"javascript:seqdistn('"+91+"')\">"+"다음"+"</a></li>\r\n";
						
						txt2[8] +=  "</ul>\r\n";
						
						
						
						
					
					insertseq(z);
					function insertseq(z){
						$("#listTable").html(txt[z]);
						if(z<=10){
						$("#paging1").html(txt2[1]);
						$("#paging2").html(txt2[1]);
						}else if(10<z<=20){
							$("#paging1").html(txt2[2]);	
							$("#paging2").html(txt2[2]);	
						}else if(20<z<=30){
							$("#paging1").html(txt2[3]);	
							$("#paging2").html(txt2[3]);	
						}
					}
					
					
					
				/*	for(var i=0;i<174;i++){
						
						for(var j=i*10;i<10*(i+1);i++){
							
						}
					}
					*/
					
				 $(test).map(function(index, entry) {
					
				 });
				 
					
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
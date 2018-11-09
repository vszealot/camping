function selectloc_carvan(selectedloc){
	
	
			if(frm.search.value==""){
			selectedWord = selectedloc.value;
			$("label").html(selectedloc.value);
			}else{
				selectedWord = frm.search.value;
			}
			
			$("#search").val("");
			
			
			var url3="searchProc_carvan.do?searchWord="+selectedWord;
			 $.ajax({
			type:"GET",
			url:url3,
			error:function(){
				console.log("통신실패");
			},
			success:function(data){
				 var txt ="<div class='listTable'><table class='camptable'><tbody>"
				$.each(data, function(idx, val) {
					txt += "<tr style='border-bottom :1px solid gray;border-top:1px solid gray;'><td>\r\n<div class='img'><img src='"+val.image+"' width='180px'></div></td>"
					if(val.campType=="야영장"){
						txt += "<td style='width:320px;padding:5px;margin:5px;'><ul style='margin:0;padding:0;'><li><div style='background-color:#87003A;color:white;text-align:center;font-size: 15px; padding-bottom: 5px; padding-top: 5px; width: 80px;' class='camptype'>"+"야영장"+"</div></li>\r\n";
					}else{
						txt += "<td style='width:320px;padding:5px;margin:5px;'><ul style='margin:0;padding:0;'><li><div style='background-color:#2FED28;color:white;text-align:center;font-size: 15px; padding-bottom: 5px; padding-top: 5px; width: 130px;' class='camptype'>"+"글램핑 / 카라반"+"</div></li>\r\n";
					}
					txt += "<li><div class='campname'><a style='text-decoration:none;' href=\"javascript:abcd('"+val.x+"','"+val.y+"','"+val.campName+"','"+val.phone+"','"+val.addr1+"','"+val.addr2+"')\" onclick=\"w3_open()\">"+val.addr1+"</a><br></div></li>\r\n";
					txt += "<li><div class='distance'>" + distance(val.x, val.y, latitude, longitude) + "km</div></li>\r\n";
					txt += "<li><div class='addr'>"+val.addr1+"</div></li>\r\n" +
					"<li><div class='phone'>"+val.phone+"</div></li></ul></td></tr>\r\n"; 
				});
				
				 	txt+= "</tbody></table></div>\r\n";
				
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
						lat1 = data.documents[0].y;
						lng1 = data.documents[0].x;
						
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
					var url2 = "carvanListAjax2.do?page="+1+"&perPageNum=10&searchWord="+selectedWord ;
				
				$.ajax({
					type:"GET",
					url:url2,
					error:function(){
					},
					success:function(data){
						console.log(data.startPage + data.endPage+"selectloc");
						var txt ="<ul class='pagination pagination-sm' style='margin-left: auto; margin-right:auto;'>\r\n";
						if(data.prev){
							txt += "<li class='page-item'><a class='page-link' href=\"javascript:pageList('"+(data.startPage-1)+"')\">이전</a></li>\r\n";
						}
						for (var idx = data.startPage; idx <= data.endPage; idx++) {
							txt += "<li class='page-item'><a class='page-link' href=\"javascript:pageList('"+idx+"')\">"+idx+"</a></li>\r\n";
							console.log(idx);
						}
						if(data.next && data.endPage > 0){
							txt += "<li class='page-item'><a class='page-link' href=\"javascript:pageList('"+(data.endPage+1)+"')\">다음</a></li>\r\n";
						}
						txt += "</ul>";
						
						$("#paging1").html(txt);
						$("#paging2").html(txt);
					}
				});
				
			}
			
			})
			
			
			
			
			
		}
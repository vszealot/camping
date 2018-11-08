function tour(x,y){
	var apikey = 'yEFgAlg8KiTrtdiifs9DSROxSqspwOJf1TUHvYF0RPUpi%2B%2B8ivWHLwKxWYRM%2BH%2Bp41FJKJokzeAOJLAZJXCwPg%3D%3D';
	var url = 'http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList';
	url += "?ServiceKey=" + apikey;
	url += "&mapX="+y;
	url += "&mapY="+x;
	url += "&radius=3000&listYN=Y&arrange=O&MobileOS=ETC&MobileApp=aa&pageNo=1&numOfRows=100&_type=json";
	
	$('.tour-info').html("");

	$.ajax({
		url : url,
		crossOrigin: true, 
		type:"GET",
		error : function() {
			console.log("데이터 가져오기 실패");
		},
		success : function(data) {
			console.log(data);
			
			var items = data.response.body.items.item;
			var cat1 = new Array();
			var cat2 = new Array();
			var cat3 = new Array();
			var firstimage = new Array();
			var firstimage2 = new Array();
			var mapX = new Array();
			var mapY = new Array();
			var tel = new Array();
			var title = new Array();
			var addr = new Array();
			var num = 0;
			var category = new Array();
			var tourhtml = '<ul>';
			$.each(items, function(index,entry){
				
				//index갯수 정의-----------------------------------------
				if(data.response.body.items.item[index].contentid){
					num=num+1;
				}
			});
			
			for(var i=0;i<num;i++){
				cat1[i] = data.response.body.items.item[i].cat1;
				cat2[i] = data.response.body.items.item[i].cat2;
				cat3[i] = data.response.body.items.item[i].cat3;
				firstimage[i] = data.response.body.items.item[i].firstimage;
				firstimage2[i] = data.response.body.items.item[i].firstimage2;
				tel[i] = data.response.body.items.item[i].tel;
				title[i] = data.response.body.items.item[i].title;
			}
			
			
			
			for(var i=0;i<num;i++){
			var url = "tour.do?catcode1="+cat1[i]+"&catcode2="+cat2[i]+"&catcode3="+cat3[i];
			
			
			$.ajax({
				
				type:"GET",
				url:url,
				async: false,
				error:function(){
					console.log("통신실패");
				},
				success:function(data){
					category[i] = data.cat1 +">"+ data.cat2 +">"+ data.cat3;
				}
			});
			
				tourhtml +="<li><ul><li>"+category[i]+"</li>" +
				 				   "<li>"+ title[i]+ "</li>";
				 	if(firstimage[i]){
				 		tourhtml+="<li><img src='"+firstimage[i]+"' width='200px'/></li>";
				 	}else{
				 		tourhtml+="<li>이미지 없음</li>";
				 	}
					if(tel[i]){	
						tourhtml += "<li>"+ tel[i]+"</li></ul></li><br>"; 
								  
					}else{
						tourhtml +=	"<li>연락처 없음</li></ul></li><br>";  
					}
			
			
			}
			tourhtml +="</ul>";
			$('.tour-info').html(tourhtml);
		}
		
		
	});
	
}
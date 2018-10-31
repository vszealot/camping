function realTimeWeather(x, y) {
	var today = new Date();
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var day = today.getDate();
	var hours = today.getHours();
	var minutes = today.getMinutes();
	$('.weather-date').html(
			month + "월 " + day + "일 " + week[today.getDay()] + "요일");

	/*
	 * 기상청 30분마다 발표 30분보다 작으면, 한시간 전 hours 값
	 */
	if(hours==5||hours==8||hours==11||hours==14||hours==17||hours==20||hours==23){
		if(minutes<10){
			hours=hours-3;
		}
	}
	if(hours==2){
		if(minutes<10){
			hours=23;
			day=day-1;
		}
	}
	
		if(hours==3 ||hours==6||hours==9||hours==12||hours==15||hours==18||hours==21){
			hours=hours-1;
			if(hours==0){
				hours=23;
				day=day-1;
				
			}
		}
		if(hours==4 ||hours==7||hours==10||hours==13||hours==16||hours==19||hours==22){
			hours = hours - 2;
			if(hours==1){
				hours=23;
				day=day-1;
			}
		}

		
		/*
		 * if (hours < 0) { // 자정 이전은 전날로 계산 today.setDate(today.getDate() - 1);
		 * day = today.getDate(); month = today.getMonth() + 1; year =
		 * today.getFullYear(); hours = 23; }
		 */

	/*
	 * example 9시 -> 09시 변경 필요
	 */

	if (hours < 10) {
		hours = '0' + hours;
	}
	if (month < 10) {
		month = '0' + month;
	}
	if (day < 10) {
		day = '0' + day;
	}
	
	today = year + "" + month + "" + day;

	/* 좌표 */
	var _nx = x, _ny = y, 
	apikey = "yEFgAlg8KiTrtdiifs9DSROxSqspwOJf1TUHvYF0RPUpi%2B%2B8ivWHLwKxWYRM%2BH%2Bp41FJKJokzeAOJLAZJXCwPg%3D%3D", 
	ForecastGribURL = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData";
	ForecastGribURL += "?ServiceKey=" + apikey;
	ForecastGribURL += "&base_date=" + today;
	ForecastGribURL += "&base_time=" + hours + "00";
	ForecastGribURL += "&nx=" + _nx + "&ny=" + _ny;
	ForecastGribURL += "&pageNo=1&numOfRows=225";
	ForecastGribURL += "&_type=json";


	
	$.ajax({
		url : ForecastGribURL,
		crossOrigin: true, 
		type:"GET",
		error : function() {
			console.log("데이터 가져오기 실패");
		},
		success : function(msg) {
			console.log(msg);
			// alert(JSON.stringify(msg));
			/*
			 * console.log("데이터 가져오기 성공"); var text = msg.responseText;
			 * console.log(msg.responseText); var re = /(<([^>]+)>)/g; var t =
			 * text.replace(re,""); // HTML 태그 모두 공백으로 대체 text = '[' + t + ']';
			 */			// var weather = JSON.stringify(ForecastGribURL.responseXML)
			// var rain_state = msg.response.body.items.item[1].obsrValue;
		
			// var json = JSON.stringify(msg);
			// var json =
			// {"response":{"header":{"resultCode":"0000","resultMsg":"OK"},"body":{"items":{"item":[{"baseDate":20181030,"baseTime":"0900","category":"PTY","nx":72,"ny":71,"obsrValue":0},{"baseDate":20181030,"baseTime":"0900","category":"REH","nx":72,"ny":71,"obsrValue":43},{"baseDate":20181030,"baseTime":"0900","category":"RN1","nx":72,"ny":71,"obsrValue":0},{"baseDate":20181030,"baseTime":"0900","category":"T1H","nx":72,"ny":71,"obsrValue":12},{"baseDate":20181030,"baseTime":"0900","category":"UUU","nx":72,"ny":71,"obsrValue":2.5},{"baseDate":20181030,"baseTime":"0900","category":"VEC","nx":72,"ny":71,"obsrValue":277},{"baseDate":20181030,"baseTime":"0900","category":"VVV","nx":72,"ny":71,"obsrValue":-0.2}]},"numOfRows":7,"pageNo":1,"totalCount":8}}}
			// console.log(json);
			// json = $.parseJSON(json);
			// var test = json['response'];
			// alert(test);
			// alert(json);
			var items = msg.response.body.items.item;
			var num=0;
			var num1=0;
			var num2=0;
			var num3=0;
			var num4=0;
			var num5=0;
			var date = new Array();
			var time = new Array();
			var skyValue = new Array();
			var t3hValue = new Array();
			var ptyValue = new Array();
			var popValue = new Array();
			var rehValue = new Array();
			$.each(items, function(index,entry){
				
				// 기상 상태 데이터 추출
				if(msg.response.body.items.item[index].category=="SKY"){
					date[num] = msg.response.body.items.item[index].fcstDate;
					time[num] = msg.response.body.items.item[index].fcstTime;
					skyValue[num1] = msg.response.body.items.item[index].fcstValue;
					num=num+1;
					num1=num1+1;
						
				}
				// 기온 데이터 추출
				if(msg.response.body.items.item[index].category=="T3H"){
					t3hValue[num2]=msg.response.body.items.item[index].fcstValue;
					num2=num2+1;
				}
				// 비오는지 안오는지 데이터 추출
				if(msg.response.body.items.item[index].category=="PTY"){
					ptyValue[num3]=msg.response.body.items.item[index].fcstValue;
					num3=num3+1;
				}
				
				// 강수확률 추출
				if(msg.response.body.items.item[index].category=="POP"){
					popValue[num4]=msg.response.body.items.item[index].fcstValue;
					num4=num4+1;
				}
				
				// 습도 추출
				if(msg.response.body.items.item[index].category=="REH"){
					rehValue[num5]=msg.response.body.items.item[index].fcstValue;
					num5=num5+1;
				}
				
			});
			
			//날짜 계산하기
			
			var today = new Date();
			var year = today.getFullYear();
			var month = today.getMonth() + 1;
			var day = today.getDate();
			
			if (month < 10) {
				month = '0' + month;
			}
			if (day < 10) {
				day = '0' + day;
			}
			
			var yymmddtoday = year +""+ month +""+ day;
			
			if(month==01||month==03||month==05||month==07||month==08||month==10||month==12){
				if(day==31){
					day=1;
					month=month+1;
					if(month==13){
						month=1;
					}
					if (month < 10) {
						month = '0' + month;
					}
					if (day < 10) {
						day = '0' + day;
					}
					var yymmddtomorrow = year +""+ month +""+ day;
					
				}else{
				day = day+1;
				if (month < 10) {
					month = '0' + month;
				}
				if (day < 10) {
					day = '0' + day;
				}
				var yymmddtomorrow = year +""+ month +""+ day;
				}
				
				
				var today1 = new Date();
				var year1 = today1.getFullYear();
				var month1 = today1.getMonth() + 1;
				var day1 = today1.getDate();
				if(day1==30){
					day1=1;
					month1=month1+1;
					if(month1==13){
						month1=1;
					}
					if (month1 < 10) {
						month1 = '0' + month1;
					}
					if (day1 < 10) {
						day1 = '0' + day1;
					}
					var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
				}else if(day1==31){
					day1=2;
					month1=month1+1;
					if(month1==13){
						month1=1;
					}
					if (month1 < 10) {
						month1 = '0' + month1;
					}
					if (day1 < 10) {
						day1 = '0' + day1;
					}
					var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
				}else{
				day1 = day1+2;
				if (month1 < 10) {
					month1 = '0' + month1;
				}
				if (day1 < 10) {
					day1 = '0' + day1;
				}
				var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
			}
			}
			var today = new Date();
			var year = today1.getFullYear();
			var month = today1.getMonth() + 1;
			var day = today1.getDate();
			if(month==4||month==6||month==9||month==11){
				if(day==30){
					day=1;
					month=month+1;
					if(month==13){
						month=1;
					}
					if (month < 10) {
						month = '0' + month;
					}
					if (day < 10) {
						day = '0' + day;
					}
					var yymmddtomorrow = year +""+ month +""+ day;
				}else{
				day = day+1;
				if (month < 10) {
					month = '0' + month;
				}
				if (day < 10) {
					day = '0' + day;
				}
				var yymmddtomorrow = year +""+ month +""+ day;
				}
				
				var today1 = new Date();
				var year1 = today1.getFullYear();
				var month1 = today1.getMonth() + 1;
				var day1 = today1.getDate();
				if(day1==29){
					day1=1;
					month1=month1+1;
					if(month1==13){
						month1=1;
					}
					if (month1 < 10) {
						month1 = '0' + month1;
					}
					if (day1 < 10) {
						day1 = '0' + day1;
					}
					var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
				}else if(day1==30){
					day1=2;
					month1=month1+1;
					if(month1==13){
						month1=1;
					}
					if (month1 < 10) {
						month1 = '0' + month1;
					}
					if (day1 < 10) {
						day1 = '0' + day1;
					}
					var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
				}else{
				day1 = day1+2;
				if (month1 < 10) {
					month1 = '0' + month1;
				}
				if (day1 < 10) {
					day1 = '0' + day1;
				}
				var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
			}
			}
			var today = new Date();
			var year = today1.getFullYear();
			var month = today1.getMonth() + 1;
			var day = today1.getDate();
			if(month==2){
				if(day==28){
					day=1;
					month=month+1;
					if(month==13){
						month=1;
					}
					if (month < 10) {
						month = '0' + month;
					}
					if (day < 10) {
						day = '0' + day;
					}
					var yymmddtomorrow = year +""+ month +""+ day;
				}else{
				day = day+1;
				if (month < 10) {
					month = '0' + month;
				}
				if (day < 10) {
					day = '0' + day;
				}
				var yymmddtomorrow = year +""+ month +""+ day;
				}
				
				
				var today1 = new Date();
				var year1 = today1.getFullYear();
				var month1 = today1.getMonth() + 1;
				var day1 = today1.getDate();
				if(day1==27){
					day1=1;
					month1=month1+1;
					if(month1==13){
						month1=1;
					}
					if (month1 < 10) {
						month1 = '0' + month1;
					}
					if (day1 < 10) {
						day1 = '0' + day1;
					}
					var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
				}else if(day1==28){
					day=2;
					month1=month1+1;
					if(month1==13){
						month1=1;
					}
					if (month1 < 10) {
						month1 = '0' + month1;
					}
					if (day1 < 10) {
						day1 = '0' + day1;
					}
					var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
				}else{
				day1 = day1+2;
				if (month1 < 10) {
					month1 = '0' + month1;
				}
				if (day1 < 10) {
					day1 = '0' + day1;
				}
				var yymmddtomorrow2 = year1 +""+ month1 +""+ day1;
			}
			}
			
			
			var sky;
			var rain = "비소식 없음";
			var today;
			var time1;
			var table = "<table style='text-align:center;'><tr>";
			
			console.log(yymmddtoday);
			console.log(yymmddtomorrow);
			console.log(yymmddtomorrow2);
					for(var i = 0; i<num;i++){
						if(date[i]==yymmddtoday){
							today = "오늘";
						}
						if(date[i]==yymmddtomorrow){
							today = "내일";
						}
						if(date[i]==yymmddtomorrow2){
							today = "모레";
						}
						if(typeof(time[i])=="string"){
							time[i]=parseInt(time[i]);
						};
						console.log(time[i]);
						//console.log(time[i]);
						switch(time[i]){
						case 0 :
							time1 = "오전 0시";
							break;
						
						case 300 :
							time1 = "오전 3시";
							break;
							
						case 600 :
							time1 = "오전 6시";
							break;
							
						case 900 :
							time1 = "오전 9시";
							break;
							
						case 1200 :
							time1 = "오후 12시";
							break;
							
						case 1500 :
							time1 = "오후 3시";
							break;
							
						case 1800 :
							time1 = "오후 6시";
							break;
							
						case 2100 :
							time1 = "오후 9시";
							break;
						}
						table +="<th>"+today+"<br>"+time1+"</th>";
					}
				table += "</tr><tr>";
					for(var i = 0; i<num;i++){
						if(ptyValue[i] != 0){
							switch(ptyValue[i]){
							case 1:
								sky="<img src='/camping/image/비많음.png' width='110px'/>";
								break;
							case 2:
								sky="<img src='/camping/image/눈.png' width='110px'/>";
								break;
							case 3:
								sky="<img src='/camping/image/눈.png' width='110px'/>";
								break;
							}
						}else if(ptyValue[i] == 0){
							switch (skyValue[i]){
							case 1:
								sky="<img src='/camping/image/맑음.png' width='110px'/>";
								break;
							case 2:
								sky="<img src='/camping/image/구름조금, 구름많음.png' width='110px'/>";
								break;
							case 3:
								sky="<img src='/camping/image/구름조금, 구름많음.png' width='110px'/>";
								break;
							case 4:
								sky="<img src='/camping/image/흐림.png' width='110px'/>";
								break;
							}
	 					}
						table += "<td>" + sky + "</td>";
					}
				table += "</tr><tr>";
					for(var i = 0; i<num;i++){
						table += "<td>기온 : " + t3hValue[i] + "℃</td>";
					}
				table += "</tr><tr>";
					for(var i = 0; i<num;i++){
						table += "<td>강수확률 : " + popValue[i] + "%</td>";
					}
				table += "</tr><tr>";
					for(var i = 0; i<num;i++){
						table += "<td>습도 : " + rehValue[i] + "%</td>";
					}
				table += "</tr></table>"
			
			$('.weather-temp').html(table);
			/*$('#RN1').html("시간당강수량 : " + item5 + "mm");
			if (item3 != 0) {
				switch (item3) {
				case 1:
					$('.weather-state-text').html("비");
					break;
				case 2:
					$('.weather-state-text').html("비/눈");
					break;
				case 3:
					$('.weather-state-text').html("눈");
					break;
				}
			} else {
				switch (item7) {
				case 1:
					$('.weather-state-text').html("맑음");
					break;
				case 2:
					$('.weather-state-text').html("구름조금");
					break;
				case 3:
					$('.weather-state-text').html("구름많음");
					break;
				case 4:
					$('.weather-state-text').html("흐림");
					break;
				}
			} // if 종료
*/		}
	});
	
}
/*
 * function rplLine(value) { if (value != null && value != "") { return
 * value.replace(/\n/g, "\\n"); } else { return value; } }
 */
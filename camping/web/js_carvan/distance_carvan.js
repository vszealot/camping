/*function distance(lat, lng, latitude, longitude) {*/
	/*var key = '3ed68aab065fe82c31c31252abc29b98';
	var url = 'https://dapi.kakao.com/v2/local/geo/transcoord.json?';

	var x = 0, y = 0, x1 = 0, y1 = 0;
	url += 'x=' + lng + '&y=' + lat + '&input_coord=WGS84&output_coord=WTM';

	console.log(url);

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
			x = data.documents[0].x;
			y = data.documents[0].y;
		}
	});
	url2 = 'https://dapi.kakao.com/v2/local/geo/transcoord.json?';
	url2 += 'x=' + longitude + '&y=' + latitude
			+ '&input_coord=WGS84&output_coord=WTM'
	$.ajax({
		type : 'get',
		url : url2,
		async : false,
		headers : headerParams,
		data : [],
		dataType : 'json',
		processData : false,
		success : function(data) {
			x1 = data.documents[0].x;
			y1 = data.documents[0].y;
		}
	});
	//console.log(x);
	//console.log(y);
	//console.log(x1);
	//console.log(y1);
	if (x > x1) {
		var calcx = (x-x1);
	}else{
		calcx = (x1-x);
	}
	calcx = Math.pow(calcx,2);


	if (y > y1) {
		var calcy = (y-y1);
	}else{
		calcy = (y1-y);
	}
	
	calcy = Math.pow(calcy,2);
	
	calc = Math.sqrt(calcx+calcy);
	
	calc = calc/1000;
	
	return calc.toFixed(2);*/
	
	function distance(lat1, lon1, lat2, lon2) {
		var lat1 = parseFloat(lat1);
		var lat2 = parseFloat(lat2);
	      var R = 6371; // km
	      var dLat = (lat2-lat1).toRad();
	      var dLon = (lon2-lon1).toRad(); 
	      var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
	              Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) * 
	              Math.sin(dLon/2) * Math.sin(dLon/2); 
	      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
	      var d = R * c;
	      return d.toFixed(2);
	    }
	    Number.prototype.toRad = function() {
	      return this * Math.PI / 180;
	    }

/*}*/



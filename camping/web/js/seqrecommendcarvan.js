function seqrecommendcarvan(){
	
	$.ajax({
		type:"GET",
		url:"recommendseqcarvan.do",
		error:function(){
			console.log("통신실패");
		},
		success:function(data){
			 var txt ="<div class='listTable'><table class='camptable'><tbody>"
					$.each(data, function(idx, val) {
						txt += "<tr style='border-bottom :1px solid gray;border-top:1px solid gray;'><td>\r\n<div class='img'><img src=\'"+val.image+"\' width='180px'></div></td>"
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
					
					 	txt+= "</tbody></table></div>\r\n";
					
					$("#listTable").html(txt);
		}
	})
}
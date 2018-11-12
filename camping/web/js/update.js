function updateId(id) {

	if (id == "") {
		alert("로그인 하셔야 입력할 수 있습니다.");
	} else {
		update();
	}
}
function update() {

	var txt = "<form name='updatecamp' action=\"javascript:registcamp()\"><div><img style='position: relative;top: 13px; left: 131px;' src='/camping/image2/tent.png'><div style ='position: relative; font-size: 20px; left: 140px; top:37px;display: inline; width: 145px; padding-left: 10px; padding-right: 10px; padding-bottom: 5px;'>캠 핑 장  등 록</div></div>";

	txt += "<br><br><div style = 'position: relative; left: 20px;'class=\"camp-input-group\">"
			+ "<label for=\"campName\">캠핑장 이름</label><br>"
			+ "<input style='position: relative; left: 10px; width: 200px;' type=\"text\" name=\"campName\" id=\"campName\" placeholder=\"캠핑장 이름을 입력하세요\"/></div><br><br>";

	txt += "<div style = 'position: relative; left: 20px;' class=\"camp-input-group\">"
			+ "<label for=\"campType\">캠핑장 타입</label><br>"
			+ "<input style='position: relative; left: 10px;' type=\"radio\"  name=\"campType\" id=\"campType\" value=1><div style='display: inline; position: relative; left: 15px; bottom: 2px;'>야영장</div>"
			+ "<input style='position: relative; left: 30px;' type=\"radio\"  name=\"campType\" id=\"campType\" value=2><div style='display: inline; position: relative; left: 36px; bottom: 2px;'>카라반</div></div><br><br>";

	txt += "<div style = 'position: relative; left: 20px;' class=\"camp-input-group\">"
			+ "<label for=\"addr1\">캠핑장 주소</label><br>"
			+ "<input style='position: relative; left: 10px; width: 250px;' type=\"text\" name=\"addr1\" id=\"addr1\" placeholder=\"캠핑장 주소를 입력하세요\"/></div><br><br>";

	txt += "<div style = 'position: relative; left: 20px;' class=\"camp-input-group\">"
			+ "<label for=\"phone\">캠핑장 연락처</label><br>"
			+ "<input style='position: relative; left: 10px; width: 180px;' type=\"text\" name=\"phone\" id=\"phone\" placeholder=\"000-0000-0000\"/></div><br><br>";

	txt += "<div style = 'position: relative; left: 20px;' class=\"camp-input-group\">"
			+ "<label for=\"usePee\">이용요금 정보</label><br>"
			+ "<input style='position: relative; left: 10px; width: 200px;' type=\"text\" name=\"usePee\" id=\"usePee\" placeholder=\"성수기 : 0000원, 비성수기:0000원\"/></div><br><br>";

	txt += "<div style = 'position: relative; left: 20px;' class=\"camp-input-group\">"
			+ "<label for=\"siteNum\">설치 가능한 사이트 수</label><br>"
			+ "<input style='position: relative; left: 10px; width: 130px;' type=\"text\" name=\"siteNum\" id=\"siteNum\" placeholder=\"숫자만 입력하세요\"/></div><br><br>";

	txt += "<div style = 'position: relative; left: 20px;' class=\"camp-input-group\">"
			+ "<label for=\"useTime\">이용시간 정보</label><br>"
			+ "<input style='position: relative; left: 10px; width: 220px;' type=\"text\" name=\"useTime\" id=\"useTime\" placeholder=\"오전 00시 부터 오후 00시까지\"/></div><br><br>";

	txt += "<div style = 'position: relative; left: 20px;' class=\"camp-input-group\">"
			+ "<label for=\"conv\">캠핑장 시설</label><br>"
			+ "<input style='position: relative; left: 10px;'type=\"checkbox\"  name=\"conv\" id=\"conv\" value='놀이터'><div style='display: inline; position: relative; left: 15px; bottom: 2px;'>놀이시설</div>"
			+ "<input style='position: relative; left: 30px;' type=\"checkbox\"  name=\"conv\" id=\"conv\" value='매점'><div style='display: inline; position: relative; left: 35px; bottom: 2px;'>매점</div>"
			+ "<input style='position: relative; left: 50px;' type=\"checkbox\"  name=\"conv\" id=\"conv\" value='샤워장'><div style='display: inline; position: relative; left: 55px; bottom: 2px;'>샤워장</div>"
			+ "<input style='position: relative; left: 70px;' type=\"checkbox\"  name=\"conv\" id=\"conv\" value='세탁기'><div style='display: inline; position: relative; left: 75px; bottom: 2px;'>세탁기</div>"
			+ "<input style='position: relative; left: 90px;' type=\"checkbox\"  name=\"conv\" id=\"conv\" value='상하수도'><div style='display: inline; position: relative; left: 95px; bottom: 2px;'>상하수도</div>"
			+ "<input style='position: relative; left: 110px;' type=\"checkbox\"  name=\"conv\" id=\"conv\" value='물놀이시설'><div style='display: inline; position: relative; left: 115px; bottom: 2px;'>물놀이 시설</div><br><br>"
			+ "<input style='position: relative; left: 10px;' type=\"checkbox\"  name=\"conv\" id=\"conv\" value='전기'><div style='display: inline; position: relative; left: 15px; bottom: 2px;'>전기</div>"
			+ "<input style='position: relative; left: 30px;' type=\"checkbox\"  name=\"conv\" id=\"conv\" value='취사장'><div style='display: inline; position: relative; left: 35px; bottom: 2px;'>취사장</div>"
			+ "<input style='position: relative; left: 50px;' type=\"checkbox\"  name=\"conv\" id=\"conv\" value='화장실'><div style='display: inline; position: relative; left: 55px; bottom: 2px;'>화장실</div></div><br><br>"
			+ "<input style='position: relative; left: 10px;' style = 'position: relative; left: 200px;' type=\"submit\" class=\"camp-input-group\" value=\"캠핑장등록\"><br><br></form>";

	console.log(txt);
	$('#listTable').html(txt);

	$("#paging1").html("");
	$("#paging2").html("");

}

function registcamp() {
	var conv = "";
	var campName = document.getElementById("campName").value;
	if ($('input[name="campType"]:checked').val() == 1) {
		var campType = "야영장";
	} else {
		var campType = "카라반";
	}
	var addr1 = document.getElementById("addr1").value;
	var phone = document.getElementById("phone").value;
	var usePee = document.getElementById("usePee").value;
	var siteNum = parseInt(document.getElementById("siteNum").value);
	var useTime = document.getElementById("useTime").value;
	$("input:checkbox:checked").each(function(index) {
		conv += $(this).val() + " ";

	});
	var image = "/camping/캠핑장이미지/고라데이마을.jpg";
	var x;
	var y;
	var searchcount = 0;
	var recommendcount = 0;
	$.ajax({
		type : 'get',
		url : 'https://dapi.kakao.com/v2/local/search/address.json?query='
				+ addr1,
		async : false,
		headers : {
			'Authorization' : 'KakaoAK 3ed68aab065fe82c31c31252abc29b98'
		},
		error : function() {
			alert("주소가 잘못되었습니다.");
		},
		success : function(data) {
			console.log(data.documents.length);
			if (data.documents.length == 1) {
				x = data.documents[0].y;
				y = data.documents[0].x;

				$.ajax({
					url : "insertcamp.do?campName=" + campName + "&campType="
							+ campType + "&x=" + x + "&y=" + y + "&addr1="
							+ addr1 + "&siteNum=" + siteNum + "&phone=" + phone
							+ "&conv=" + conv + "&useTime=" + useTime
							+ "&image=" + image + "&searchcount=" + searchcount
							+ "&recommendcount=" + recommendcount + "&usePee="
							+ usePee,
					type : "GET",
					error : function() {
						console.log("통신실패")
					},
					success : function(data) {
						console.log("입력성공!!!");
					}
				});
			} else {
				alert("주소가 잘못되었습니다.");
			}
		}
	});

	/*	*/

}
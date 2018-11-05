
$(document).on('click','#findId',function(){
	var userEmail=$('#userEmail').val();
	var nickName=$('#nickName').val();
	
	var postData={'userEmail':userEmail, 'nickName':nickName};
	console.log(postData);
	$.ajax({
		url:'findingId.do',
		type:'POST',
		data:postData,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    dataType : "json",
	    success: function(data){
		    var idfind=data.userId;
	    	if(idfind=='null'){
	    		alert('정보를 다시 입력해주세요');
	    	}else{
		    	$("#idList").html("<p>"+"회원님의 정보로 등록된 아이디는 : "+idfind+"입니다.</p>")
	    	} 
	    },
	    error: function(XMLHttpRequset,textStatus,errorThrown){
	   		alert('정보를 다시 입력해주세요');
	    }
	});
});
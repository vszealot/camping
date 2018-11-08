function dust(addr){
	
	console.log(addr);
	//날짜구하기
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
	
	var yymmddtoday = year +"-"+ month +"-"+ day;
	
	//주소구하기
	var strArray = addr.split(' ');
	
	var sido = strArray[0];
	var si = strArray[1];
	var dong = strArray[2];
	switch(sido){
	case '서울특별시':
		sido = '서울';
		break;
	case '부산광역시':
		sido = '부산';
		break;
	case '대구광역시':
		sido = '대구';
		break;
	case '인천광역시':
		sido = '인천';
		break;
	case '광주광역시':
		sido = '광주';
		break;
	case '대전광역시':
		sido = '대전';
		break;
	case '울산광역시':
		sido = '울산';
		break;
	case '경기도':
		sido = '경기';
		break;
	case '강원도':
		sido = '강원';
		break;
	case '충청북도':
		sido = '충북';
		break;
	case '충청남도':
		sido = '충남';
		break;
	case '전라북도':
		sido = '전북';
		break;
	case '전라남도':
		sido = '전남';
		break;
	case '경상남도':
		sido = '경남';
		break;
	case '경상북도':
		sido = '경북';
		break;
	case '제주도':
		sido = '제주';
		break;
	}
	
	var serviceKey='yEFgAlg8KiTrtdiifs9DSROxSqspwOJf1TUHvYF0RPUpi%2B%2B8ivWHLwKxWYRM%2BH%2Bp41FJKJokzeAOJLAZJXCwPg%3D%3D';
	var url = 'http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureSidoLIst?'+
		'sidoName='+sido+'&searchCondition=DAILY&pageNo=1&numOfRows=10&ServiceKey='+serviceKey+'&ver=1.3';
	var num=0;
	var pm10;
	var pm25;
	var so2;
	var co;
	var o3;
	var no2;
	
	console.log(url);
	$.ajax({
		url : url,
		crossOrigin: true, 
		type:"GET",
		error : function() {
			console.log("데이터 가져오기 실패");
		},
		success : function(data) {
			//xml을 json으로 변환
			var json = xml2json(data, " ");
			//json의 객체화
			json = eval("("+json+")");
			console.log(json);
			var items = json.response.body.items.item
			$.each(items, function(index,entry){
				//index갯수 정의-----------------------------------------
				if(json.response.body.items.item[index].cityName){
					num=num+1;
				}
			});
			
			for(var i = 0 ; i<num;i++){
				if(json.response.body.items.item[i].cityName==si){
					pm10=parseInt(json.response.body.items.item[i].pm10Value);
					pm25=parseInt(json.response.body.items.item[i].pm25Value);
					so2=parseFloat(json.response.body.items.item[i].so2Value);
					co=parseFloat(json.response.body.items.item[i].coValue);
					o3=parseFloat(json.response.body.items.item[i].o3Value);
					no2=parseFloat(json.response.body.items.item[i].no2Value);
					
					console.log(pm10+" "+pm25+" "+no2+" "+co+" "+so2);
				}else{
					pm10=parseInt(json.response.body.items.item[1].pm10Value);
					pm25=parseInt(json.response.body.items.item[1].pm25Value);
					so2=parseFloat(json.response.body.items.item[1].so2Value);
					co=parseFloat(json.response.body.items.item[1].coValue);
					o3=parseFloat(json.response.body.items.item[1].o3Value);
					no2=parseFloat(json.response.body.items.item[1].no2Value);
					if(pm10==NaN){
						pm10="?";
					}
					if(pm25==NaN){
						pm25="?";
					}
					
					if(so2==NaN){
						so2="?";
					}
					
					if(co==NaN){
						co="?";
					}
					
					if(o3==NaN){
						o3="?";
					}
					
					if(no2==NaN){
						no2="?";
					}
				}
			}
			if(pm10<=30){
				pm10 = "좋음";
			}else if(pm10 >=31 && pm10 <=80){
				pm10 = "보통";
			}else if(pm10 >=81 && pm10 <=150){
				pm10 = "나쁨";
			}else if(pm10 >=151 ){
				pm10 = "매우 나쁨";
			}
			
			if(pm25<=15){
				pm25 = "좋음";
			}else if(pm25 >=16 && pm25 <=35){
				pm25 = "보통";
			}else if(pm25 >=36 && pm25 <=75){
				pm25 = "나쁨";
			}else if(pm25 >=76 ){
				pm25 = "매우 나쁨";
			}
			
			if(o3<=0.03){
				o3 = "좋음";
			}else if(o3 >=0.031 && o3 <=0.09){
				o3 = "보통";
			}else if(o3 >=0.091 && o3 <=0.15){
				o3 = "나쁨";
			}else if(o3 >=0.151 ){
				o3 = "매우 나쁨";
			}
			
			if(no2<=0.03){
				no2 = "좋음";
			}else if(no2 >=0.031 && no2 <=0.06){
				no2 = "보통";
			}else if(no2 >=0.061 && no2 <=0.2){
				no2 = "나쁨";
			}else if(no2 >=0.201 ){
				no2 = "매우 나쁨";
			}
			
			if(co<=2){
				co = "좋음";
			}else if(co >=2.01 && co <=9){
				co = "보통";
			}else if(co >=9.01 && co <=15){
				co = "나쁨";
			}else if(co >=15.01 ){
				co = "매우 나쁨";
			}
			
			if(so2<=0.02){
				so2 = "좋음";
			}else if(so2 >=0.021 && so2 <=0.05){
				so2 = "보통";
			}else if(so2 >=0.051 && so2 <=0.15){
				so2 = "나쁨";
			}else if(so2 >=0.151 ){
				so2 = "매우 나쁨";
			}
			
			
			
			console.log(pm10 + " " +pm25+ " " +no2+ " " +co+ " " +so2);
			
			html = "<table style='text-align:center; '><tr><th style='width:100px;'>pm10</th><th style='width:100px;'>pm25</th><th style='width:100px;'>이산화질소</th><th style='width:100px;'>일산화가스</th><th style='width:100px;'>오존</th></tr>";
			html += "<tr><td>"+pm10+"</td><td>"+pm25+"</td><td>"+no2+"</td><td>"+co+"</td><td>"+o3+"</td></tr></table>";
			
			$('.dust-state').html(html);
			
			
		}
		
		
	});
	
	//데이터를 가공...
	
	
}

//XML to JSON
/*	This work is licensed under Creative Commons GNU LGPL License.

License: http://creativecommons.org/licenses/LGPL/2.1/
Version: 0.9
Author:  Stefan Goessner/2006
Web:     http://goessner.net/ 
*/
function xml2json(xml, tab) {
var X = {
  toObj: function(xml) {
     var o = {};
     if (xml.nodeType==1) {   // element node ..
        if (xml.attributes.length)   // element with attributes  ..
           for (var i=0; i<xml.attributes.length; i++)
              o["@"+xml.attributes[i].nodeName] = (xml.attributes[i].nodeValue||"").toString();
        if (xml.firstChild) { // element has child nodes ..
           var textChild=0, cdataChild=0, hasElementChild=false;
           for (var n=xml.firstChild; n; n=n.nextSibling) {
              if (n.nodeType==1) hasElementChild = true;
              else if (n.nodeType==3 && n.nodeValue.match(/[^ \f\n\r\t\v]/)) textChild++; // non-whitespace text
              else if (n.nodeType==4) cdataChild++; // cdata section node
           }
           if (hasElementChild) {
              if (textChild < 2 && cdataChild < 2) { // structured element with evtl. a single text or/and cdata node ..
                 X.removeWhite(xml);
                 for (var n=xml.firstChild; n; n=n.nextSibling) {
                    if (n.nodeType == 3)  // text node
                       o["#text"] = X.escape(n.nodeValue);
                    else if (n.nodeType == 4)  // cdata node
                       o["#cdata"] = X.escape(n.nodeValue);
                    else if (o[n.nodeName]) {  // multiple occurence of element ..
                       if (o[n.nodeName] instanceof Array)
                          o[n.nodeName][o[n.nodeName].length] = X.toObj(n);
                       else
                          o[n.nodeName] = [o[n.nodeName], X.toObj(n)];
                    }
                    else  // first occurence of element..
                       o[n.nodeName] = X.toObj(n);
                 }
              }
              else { // mixed content
                 if (!xml.attributes.length)
                    o = X.escape(X.innerXml(xml));
                 else
                    o["#text"] = X.escape(X.innerXml(xml));
              }
           }
           else if (textChild) { // pure text
              if (!xml.attributes.length)
                 o = X.escape(X.innerXml(xml));
              else
                 o["#text"] = X.escape(X.innerXml(xml));
           }
           else if (cdataChild) { // cdata
              if (cdataChild > 1)
                 o = X.escape(X.innerXml(xml));
              else
                 for (var n=xml.firstChild; n; n=n.nextSibling)
                    o["#cdata"] = X.escape(n.nodeValue);
           }
        }
        if (!xml.attributes.length && !xml.firstChild) o = null;
     }
     else if (xml.nodeType==9) { // document.node
        o = X.toObj(xml.documentElement);
     }
     else
        alert("unhandled node type: " + xml.nodeType);
     return o;
  },
  toJson: function(o, name, ind) {
     var json = name ? ("\""+name+"\"") : "";
     if (o instanceof Array) {
        for (var i=0,n=o.length; i<n; i++)
           o[i] = X.toJson(o[i], "", ind+"\t");
        json += (name?":[":"[") + (o.length > 1 ? ("\n"+ind+"\t"+o.join(",\n"+ind+"\t")+"\n"+ind) : o.join("")) + "]";
     }
     else if (o == null)
        json += (name&&":") + "null";
     else if (typeof(o) == "object") {
        var arr = [];
        for (var m in o)
           arr[arr.length] = X.toJson(o[m], m, ind+"\t");
        json += (name?":{":"{") + (arr.length > 1 ? ("\n"+ind+"\t"+arr.join(",\n"+ind+"\t")+"\n"+ind) : arr.join("")) + "}";
     }
     else if (typeof(o) == "string")
        json += (name&&":") + "\"" + o.toString() + "\"";
     else
        json += (name&&":") + o.toString();
     return json;
  },
  innerXml: function(node) {
     var s = ""
     if ("innerHTML" in node)
        s = node.innerHTML;
     else {
        var asXml = function(n) {
           var s = "";
           if (n.nodeType == 1) {
              s += "<" + n.nodeName;
              for (var i=0; i<n.attributes.length;i++)
                 s += " " + n.attributes[i].nodeName + "=\"" + (n.attributes[i].nodeValue||"").toString() + "\"";
              if (n.firstChild) {
                 s += ">";
                 for (var c=n.firstChild; c; c=c.nextSibling)
                    s += asXml(c);
                 s += "</"+n.nodeName+">";
              }
              else
                 s += "/>";
           }
           else if (n.nodeType == 3)
              s += n.nodeValue;
           else if (n.nodeType == 4)
              s += "<![CDATA[" + n.nodeValue + "]]>";
           return s;
        };
        for (var c=node.firstChild; c; c=c.nextSibling)
           s += asXml(c);
     }
     return s;
  },
  escape: function(txt) {
     return txt.replace(/[\\]/g, "\\\\")
               .replace(/[\"]/g, '\\"')
               .replace(/[\n]/g, '\\n')
               .replace(/[\r]/g, '\\r');
  },
  removeWhite: function(e) {
     e.normalize();
     for (var n = e.firstChild; n; ) {
        if (n.nodeType == 3) {  // text node
           if (!n.nodeValue.match(/[^ \f\n\r\t\v]/)) { // pure whitespace text node
              var nxt = n.nextSibling;
              e.removeChild(n);
              n = nxt;
           }
           else
              n = n.nextSibling;
        }
        else if (n.nodeType == 1) {  // element node
           X.removeWhite(n);
           n = n.nextSibling;
        }
        else                      // any other node
           n = n.nextSibling;
     }
     return e;
  }
};
if (xml.nodeType == 9) // document node
  xml = xml.documentElement;
var json = X.toJson(X.toObj(X.removeWhite(xml)), xml.nodeName, "\t");
return "{\n" + tab + (tab ? json.replace(/\t/g, tab) : json.replace(/\t|\n/g, "")) + "\n}";
}
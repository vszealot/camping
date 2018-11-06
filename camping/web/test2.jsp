<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function check_value(i) 
{ 
   var v=game[i].options[game[i].selectedIndex].value;
   alert(v);
} 
</script> 
</head>
<body>
<c:forEach begin="1" end="3" varStatus="i">
	<select id='game' size='1'> 
	   <option value=1> 1 </option>
	    <option value=2> 2</option>
	    <option value=3> 3</option>
	</select>
	<input type="button" value="클릭" onclick="check_value(${i.count})"> 
	<br><br>
</c:forEach> 	
 <!--  	<select id='game' size='1'> 
	    <option value=1> 1 
	    <option value=2> 2
	    <option value=3> 3
	</select>
	<input type="button" value="클릭" onclick="check_value(1)"> 
	<br><br>
	
	<select id='game' size='1'> 
	    <option value=1> 1 
	    <option value=2> 2
	    <option value=3> 3
	</select>
	<input type="button" value="클릭" onclick="check_value(2)">  -->
</body>
</html>
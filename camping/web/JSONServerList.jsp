<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	Connection conn=null;
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(
				"jdbc:oracle:thin:@192.168.1.137:1521:xe",
				"dc", "1234");
		System.out.println("접속 성공!!!");
	}catch(Exception e){
		e.printStackTrace();		
	}
	//---------------------------------------------------------------------
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{
		pstmt=conn.prepareStatement("SELECT X,Y FROM CAMPING_TEST");
		rs=pstmt.executeQuery();
		
		JSONObject jsonMain = new JSONObject();
		JSONArray jArray = new JSONArray();	
		
		while(rs.next())
		{
			JSONObject jObject = new JSONObject();
			jObject.put("lat", rs.getDouble("X"));
			jObject.put("lng", rs.getDouble("Y"));
			 
			jArray.add(0, jObject);
		}		
		//jsonMain.put("List", jArray);	
		//out.println(jsonMain.toJSONString());
		out.println(jArray.toJSONString());
		
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		try{
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e){}
	}
%>

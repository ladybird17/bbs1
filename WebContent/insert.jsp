<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbConn.jsp" %>

<%
request.setCharacterEncoding("UTF-8");

/* 클라이언트에서 요청한 데이터 받아오기 */
String title = request.getParameter("title");
String writer = request.getParameter("writer");
String comment = request.getParameter("comment");

Statement stmt = null;

try{
	String query = "INSERT INTO bbs ";
	query += "(title, comments, writer, cDate, views, likes)";
	query += "VALUES ('"+title+"', '"+comment+"', '";
	query += writer+"', now(), 0, 0)";
	/* 
	num은 자동생성되기때문에 생략해도 무관.
	now()는 현재날짜,시각나옴.
	조회와 추천 기본값을 0으로 해두면 입력을 생략할 수 있다.
	*/
	
	stmt = conn.createStatement();
	int result = stmt.executeUpdate(query);
	
	out.println("게시물을 등록했습니다.");
	
	
}
catch (SQLException ex){
	out.println("게시물 등록을 실패했습니다.<br>");
	out.println("SQLException : "+ex.getMessage());
}
finally{
	if (stmt != null){
		stmt.close();
	}
	if (conn != null){
		conn.close();
	}
	
	/*
	지정한 시간 이후에 페이지 이동
	finally에 넣어서 정상작동하거나 등록실패했을때 모두
	원래 목록화면으로 넘어갈 수 있도록함
	*/
	response.setHeader("Refresh", "3;URL=list.jsp");
}
%>
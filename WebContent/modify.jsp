<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정하기</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	%>
	
	<%@ include file="dbConn.jsp" %>
	<%
	/* 데이터 불러오기 */
	
	ResultSet rs = null;
	Statement stmt = null;
	
	try{
		String query = "SELECT title, comments, cDate, views, likes ";
		query += "FROM bbs ";
		query += "WHERE num = "+num;
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
		rs.next();
		
	%>
		<form action="update.jsp" method="post">
			<label for="title">제목 : </label>
			<input type="text" id="title" name="title"
			value='<%= rs.getString("title") %>'><br>
			<label for="comments">내용</label>
			<textarea rows="5" cols="80" id="comments" name="comments">
			<%= rs.getString("comments") %>
			</textarea><br><br>
			<button type="submit">수정</button>
			<button type="reset">취소</button>
			
		</form>	
		
	<%
	}
	catch (SQLException ex){
		out.println("데이터를 불러오는데 오류가 발생했습니다.<br>");
		out.println("SQLException : "+ ex.getMessage());
	}
	finally {
		if(rs != null){
			rs.close();
		}
		if(stmt != null){
			stmt.close();
		}
		if(conn != null){
			conn.close();
		}
	}
	%>
</body>
</html>
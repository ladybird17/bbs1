<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택한 글 확인</title>
<style type="text/css">
	table{
		width : 100%;
		border : 1px solid black;
		border-collapse : collapse;
	}
	
	td, th{
		border : 1px solid black;
	}

	.container {
		width : 960px;
		margin : 0px auto;
	}
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String number = request.getParameter("num");
	int num = Integer.parseInt(number);
	%>
	<%@ include file="dbConn.jsp" %>
	
	<%
	/* SELECT문을 사용하여 지정한 1개의 글의 내용을 가져오기 */
	
	ResultSet rs = null;
	Statement stmt = null;
	/* PreparedStatement psmt = null; */
	
	try{
		String query = "SELECT title, comments, writer, cDate, ";
		query += "views, likes "; 
		query += "FROM bbs ";
		query += "WHERE num="+num;
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
		while(rs.next()){
			String title = rs.getString("title");
			String comments = rs.getString("comments");
			String writer = rs.getString("writer");
			String cDate = rs.getString("cDate");
			String views = rs.getString("views");
			String likes = rs.getString("likes");
			
			/* out.println(title +"<br>");
			out.println(comments +"<br>");
			out.println(writer +"<br>");
			out.println(cDate +"<br>");
			out.println(views +"<br>");
			out.println(likes); */
	%>
			<div class="container">
				<table>
					<thead>
						<tr>
							<th colspan=3> <%= rs.getString("title")%> </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><%= rs.getString("writer")%></td>
							<td><%= rs.getString("views")%></td>
							<td><%= rs.getString("likes")%></td>
						</tr>
						<tr>
							<td colspan=3><%= rs.getString("comments")%></td>
						</tr>
						
					</tbody>
				</table>
			</div>
			<a href="./list.jsp">목록으로</a>
			<a href="./modify.jsp?num=<%=num%>">수정하기</a>
	<%
		}
	}
	catch (SQLException ex){
		out.println("글 조회를 실패했습니다.<br>");
		out.println("SQLException : "+ ex.getMessage());
	}
	finally{
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
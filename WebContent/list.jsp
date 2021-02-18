<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 게시판의 전체 리스트 불러오기 -->
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 전체 목록</title>
<style type="text/css">
	table{
		width : 100%;
		border : 1px solid black;
		border-collapse : collapse;
	}
	
	td, th{
		border : 1px solid black;
	}
	
	/*
	문제1. 화면의 크기를 가로너비 960px로 변경하고 화면을 중앙정렬
	*/
	.container {
		width : 960px;
		margin : 0px auto;
	}
</style>
</head>
<body>
	<!-- 기존에 만들어진 파일을 불러와서 실행 -->
	<%@ include file="dbConn.jsp" %>
	<div class = "container">
		<table>
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회</th>
					<th>추천</th>
				</tr>
			</thead>
			<tbody>
				<%
				/* SQL 쿼리(select문) 실행 후 그 결과값을 받아오는 데이터 타입 */
				ResultSet rs = null;
				/* 실제 SQL 쿼리를 실행하기 위해 사용 */
				Statement smt = null;
				
				try{
					
					String query = "SELECT * FROM bbs";
					
					smt = conn.createStatement();
					rs = smt.executeQuery(query);
					/*
					SELECT문 실행시 executeQuery()사용
					INSERT, UPDATE, DELETE문 실행시 executeUpdate 사용
					*/
					
					while(rs.next()){
						String num = rs.getString("num");
						String title = rs.getString("title");
						String writer = rs.getString("writer");
						String cDate = rs.getString("cDate");
						String views = rs.getString("views");
						String likes = rs.getString("likes");
				%>
						<tr>
							<td><%= num %></td>
							<td><a href="./select.jsp?num=<%= num %>"> <%=title%> </a></td>
							<td><%= writer %></td>
							<td><%= cDate %></td>
							<td><%= views %></td>
							<td><%= likes %></td>
						</tr>
				<%
					}
				}
				catch(SQLException ex){
					out.println("bbs 테이블에서 게시글 목록 조회를 실패했습니다.");
					out.println("SQLException : "+ ex.getMessage());
				}
				finally{
					if (rs != null){
						rs.close();
					}
					if (smt != null){
						smt.close();
					}
					if (conn != null){
						conn.close();
					}
				}
				%>
			</tbody>
		</table>
		<!-- <button id="btn_write">글쓰기</button> -->
		<a href="write.jsp">글쓰기</a>
	</div>
</body>
</html>
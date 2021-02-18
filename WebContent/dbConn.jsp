<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- java의 sql 관련 라이브러리를 사용하기 위해 import함 -->
<%@ page import = "java.sql.*" %>

<%
Connection conn = null;
try{
	/* jdbc를 이용하여 mysql접속후 bbs1이라는 db를 사용한다는 뜻 */
	String url = "jdbc:mysql://localhost:3306/bbs1?serverTimezone=UTC&characterEncoding=UTF-8";
	
	/* 사용자 id, pw */
	String userId = "springb";
	String userPw = "asdf1234";
	
	/* jdbc 드라이버 이름 */
	Class.forName("com.mysql.cj.jdbc.Driver");
	/* DriverManager를 통해서 실제 데이터베이스와 연결 */
	conn = DriverManager.getConnection(url, userId, userPw);
	out.println("데이터 베이스에 연결을 성공했습니다.");
}
catch (SQLException ex){
	out.println("데이터 베이스 연결을 실패했습니다.");
	out.println("SQLException : "+ ex.getMessage());
}
%>
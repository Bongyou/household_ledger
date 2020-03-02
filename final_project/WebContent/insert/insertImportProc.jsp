<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.use.FetchDao" %>
<%@ page import="my.entry.EntryDao" %>
<%@ page import="my.util.ConnUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>기입</title>
</head>
<body>
<%
	String loginId=(String)session.getAttribute("loginId");
	String date1 = (String)request.getParameter("year");
	String date2 = (String)request.getParameter("month");
	String date4 = (String)request.getParameter("day");
	int date1_1 = Integer.parseInt(date1);
	int date2_2 = Integer.parseInt(date2);
	int date4_4 = Integer.parseInt(date4);
	String sort = (String)request.getParameter("sort");
	String money = (String)request.getParameter("money");
	String gname = (String)request.getParameter("gname");
	
	java.sql.Statement st = null;
	Connection conn = null;
	PreparedStatement ps = null;
	try{
		conn = ConnUtil.getConnection();
		String sql = "insert into user_"+loginId+"(id, date1, date2, date4, sort, gname, price) values(?,?,?,?,?,?,?)";
		ps = conn.prepareStatement(sql);
		ps.setString(1, loginId);
		ps.setInt(2, date1_1);
		ps.setInt(3, date2_2);
		ps.setInt(4, date4_4);
		ps.setString(5, sort);
		ps.setString(6, gname);
		ps.setString(7, money);
		ps.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}finally {
		ConnUtil.close(ps, conn);
		pageContext.forward("insertImport.jsp?userid="+loginId);
	}
%>
</body>
</html>
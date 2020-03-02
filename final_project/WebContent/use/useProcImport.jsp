<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.use.FetchDao" %>
<%@ page import="my.entry.EntryDao" %>
<%@ page import="my.util.ConnUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<% 	
	request.setCharacterEncoding("UTF-8");
	String loginId=(String)session.getAttribute("loginId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>월별 지출내역</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="useCss.css">
</head>
<body>
<%
	String years = (String)request.getParameter("year");
	String years2 = (String)request.getParameter("year2");
	String months = (String)request.getParameter("month");
	String months2 = (String)request.getParameter("month2");
	String days = (String)request.getParameter("day");
	String days2 = (String)request.getParameter("day2");
	int years_1 = Integer.parseInt(years);
	int years_2 = Integer.parseInt(years2);
	int months_1 = Integer.parseInt(months);
	int months_2 = Integer.parseInt(months2);
	int days_1 = Integer.parseInt(days);
	int days_2 = Integer.parseInt(days2);
%>
	<div class="user" align="center">
		<em>
		<%
			out.println(years_1+"년     "+months_1+"월     "+days_1+"일      ~"+years_2+ "년     "+months_2+"월     "+days_2+"일     수입내역");
		%>
	
	</div>
	<br><br>
	<div class="container">
				<ul class="responsive-table">
					<li class="table-header">
						<div class="col col-1">Date</div>
						<div class="col col-2">분류</div>
						<div class="col col-3">이름</div>
						<div class="col col-4">가격</div>
					</li>
		<% 
			Connection conn=null;
			PreparedStatement ps=null;
			ResultSet rs=null;
			try{
				conn=ConnUtil.getConnection();
				String sql="select * from user_"+loginId;
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				while(rs.next()){
					String id=rs.getString("id");
					if(loginId.equals(id.trim())){
						int d_years = rs.getInt("date1");
						int d_months = rs.getInt("date2");
						int d_days = rs.getInt("date4");
						String money = rs.getString("price");
						if(d_years >= years_1 && d_years <= years_2){
							if(d_months >= months_1 && d_months <= months_2){
								if(d_days >= days_1 && d_days <= days_2){
									if(money == null){
										continue;
		%>
										<li class="table-row">
						<div class="col col-1">
							<%= rs.getInt("date1") %>
							<%= rs.getInt("date2") %>
							<%= rs.getInt("date4") %>
						</div>
						<div class="col col-2">
							<%= rs.getString("sort") %>
						</div>
						<div class="col col-3">
							<%= rs.getString("gname") %>
						</div>
						<div class="col col-4">
							<%= rs.getString("price") %>
						</div>
					</li>
		<%
									}
								}
									
							}
						}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnUtil.close(ps, conn);
		}
	%>
			</ul>
							</div>
</body>
</html>
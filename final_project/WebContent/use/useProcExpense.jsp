<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.use.FetchDao" %>
<%@ page import="my.entry.EntryDao" %>
<%@ page import="my.util.ConnUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<% request.setCharacterEncoding("UTF-8");
	String loginId=(String)session.getAttribute("loginId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사용내역 출력페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="../css/useCss.css">
<link type = "text/css" rel = "stylesheet" href = "../css/n 3.css">
</head>
<body>
<% 	
	String year = (String)request.getParameter("year");
	String year2 = (String)request.getParameter("year2");
	String month = (String)request.getParameter("month");
	String month2 = (String)request.getParameter("month2");
	String day = (String)request.getParameter("day");
	String day2 = (String)request.getParameter("day2");
	int year_1 = Integer.parseInt(year);
	int year_2 = Integer.parseInt(year2);
	int month_1 = Integer.parseInt(month);
	int month_2 = Integer.parseInt(month2);
	int day_1 = Integer.parseInt(day);
	int day_2 = Integer.parseInt(day2);
%>
	<div class="user" align="center">
		<em>
		<%
			out.println(year_1+"년     "+month_1+"월     "+day_1+"일      ~"+year_2+ "년     "+month_2+"월     "+day_2+"일     지출내역");
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
						int d_year = rs.getInt("date1");
						int d_month = rs.getInt("date2");
						int d_day = rs.getInt("date4");
						String money = rs.getString("price2");
							if(d_year > year_1 && d_year < year_2){
								if(d_month >= month_1){
									if((d_day >= day_1 && d_day <= day_2) || (d_day <= day_1 && d_day >= day_2) || (d_day >= day_1 && d_day >= day_2) || (d_day <= day_1 && d_day <= day_2)){
										if(money ==null)
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
							<%= rs.getString("price2") %>
						</div>
					</li>
										<%
									}
								}else if(d_year == year_1 && d_year == year_2){
									if(d_month >= month_1 && d_month <= month_2){
										if((d_day >= day_1 && d_day <= day_2) || (d_day <= day_1 && d_day >= day_2) || (d_day >= day_1 && d_day >= day_2) || (d_day <= day_1 && d_day <= day_2)){
											if(money == null)
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
							<%= rs.getString("price2") %>
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
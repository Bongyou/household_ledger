<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.entry.EntryDao" %>
<%@ page import="my.util.ConnUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<% request.setCharacterEncoding("UTF-8");
String loginId=(String)session.getAttribute("loginId"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수입 조회</title>
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
	<form>
	<p>
		<input type="button" id = "logout1" onclick="logout()" value="로그아웃">
	</p>
	<script>
		function logout(){
			var x = confirm("로그아웃 하시겠습니까?");
			if(x==true){
				location.href="../log/logoutProc.jsp";
			}
			else {
				return;
			}
		}
	</script>
	</form>
	<div class="user" align="center">
		<em>
		<%
			out.println(loginId);
		%>
		</em>
		<%
			out.println("님의 수입내역");
		%>
	</div>
	<div style= "margin-top : 40px;">
		<h1 style ="display : inline; margin-left : 500px; margin-top : 500px;">날짜</h1>
		<h1 style ="display: inline; margin-left : 400px;margin-top : 100px;">항목</h1>
		<div>
			<div>	
				<div style = "margin-top : 20px; margin-left :350px;">
					<form action="useProcImport.jsp" method="post" name="form" >
						<h3>시작</h3>
						 <select  id = "size10" name = "year">
							<option value = 2018>2018</option>
							<option value = 2019>2019</option>
							<option value = 2020>2020</option>
							<option value = 2021>2021</option>
							<option value = 2022>2022</option>
							<option value = 2023>2023</option>
						</select>
						<h3>년</h3>
					
						<select id = "size2" name = "month">
							<script>
								for(var i=0;i<12;i++){
									document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
								}
							</script>
						</select>
						<h3>월</h3>
				
						<select id = "size2" name = "day">
							<script>
								for(var i=0;i<31;i++){
									document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
								}
							</script>
						</select>
						<h3>일</h3>
						<br><br>
						<h3>종료</h3>
						<select  id = "size11" name = "year2">
							<option value = 2018>2018</option>
							<option value = 2019>2019</option>
							<option value = 2020>2020</option>
							<option value = 2021>2021</option>
							<option value = 2022>2022</option>
							<option value = 2023>2023</option>
						</select>
						<h3>년</h3>
						
						<select id = "size2" name = "month2">
							<script>
								for(var i=0;i<12;i++){
									document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
								}
							</script>
						</select>
						<h3>월</h3>
				
						<select id = "size2" name = "day2">
							<script>
								for(var i=0;i<31;i++){
									document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
								}
							</script>
						</select>
						<h3>일</h3>
						<br><br>
						<button>검색</button>
						<br><br><br>
					</form>
				</div>
					<form action = "useProcImport2.jsp" method = "POST" style = "position : absolute; left: 840px; top : 140px;">
						<select id = "size2" name = "sort" style= "margin-left : 110px;">
							<option>용돈</option>
							<option>아르바이트</option>
							<option>기타</option>
						</select>
						<button>검색</button>
					</form>
				</div>
			</div>
		</div>
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
					String money = rs.getString("price");
					if(loginId.equals(id.trim())){
						if(money != null){
		%>
		<li class="table-row">
				<div class="col col-1">
					<%= rs.getInt("date1") %>년
					<%= rs.getInt("date2") %>월
					<%= rs.getInt("date4") %>일
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
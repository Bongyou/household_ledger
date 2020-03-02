

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>수입/지출 기록</title>
<style>
	body{
		background-image : url("background_insert.JPG");
		background-repeat : no-repeat;
		background-size : 100%;
		background-position : center;
		background-attachment : fixed;
	}
	#button1{
		border-radius : 30px;
		color : lightblue;
		background-color : white;
		height : 70px;
		width : 210px;
		font-size : 20px;
		border-color : lightblue;
	}
	#button2{
		border-radius : 30px;
		color : lightblue;
		background-color : white;
		height : 70px;
		width : 210px;
		font-size : 20px;
		border-color : lightblue;
	}
	
	#pos1{
		margin-left : 650px;
		margin-top : 50px;
	}
	
	#pos2{
		margin-left : 650px;
		margin-top : 100px;
	}
	
	#pos3{
		margin-left : 200px;
	}
	#a{
		margin-left : 100px;
	}
	#p{
		padding-top : 20px;
		margin-left : 40px;
		color : red;
		font-size : 20px;
	}
	#st{
		font-size : 100px;
		color : blue;
	}
	#size{
		width : 150px;
		height : 40px;
		color : black;
		font-size : 15px;
	}
	#size2{
		width : 70px;
		height : 40px;
		color : black;
		font-size : 15px;
	}
	#size3{
		width : 120px;
		height : 40px;
		color : black;
		font-size : 10px;
	}
	.btn {
      	padding: 10px 20px;
      	background-color: #333;
      	color: #f1f1f1;
      	border-radius: 0;
      	transition: .2s;
	}
	.btn:hover, .btn:focus {
      	border: 1px solid #333;
      	background-color: #fff;
      	color: #000;
	}
	#logout1{
		position : fixed;
		left : 1510px;
		top : 20px;
		height : 40px;
		width : 100px;
	} 
</style>
</head>
<body>
<form>
	<p align="right">
		<input type="button" class="btn pull-right" id = "logout1" onclick="logout()" value="로그아웃">
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
			out.println("님의 지출내역");
		%>
	</div>
	
<div class="row">
    <div class="col-sm-4" id = "pos1">
      <p class="text-center" id = "st"><strong>지출 입력</strong></p><br>
      <a href="#demo" data-toggle="collapse">
      <div id = "pos3"><button id = "button1">지출</button></div>
      </a>
      <div id="demo" class="collapse">
      		<form id = "p" method = "POST" action = "insertExpenseProc.jsp">
			날짜 
				 <select  id = "size" name = "year">
					<option value = 2023>2023</option>
					<option value = 2022>2022</option>
					<option value = 2021>2021</option>
					<option value = 2020>2020</option>
					<option value = 2019>2019</option>
					<option value = 2018>2018</option>
				</select>
			년
				<select id = "size2" name = "month">
				<script>
					for(var i=0;i<12;i++){
						document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
					}
				</script>
				</select>
			월
				<select id = "size2" name = "day">
				<script>
						for(var i=0;i<32;i++){
							document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
						}
				</script>
				</select>
			일<br><br>
			항목 :
			<select id = "size2" name = "sort">
					<option>식비</option>
					<option>교통비</option>
					<option>간식</option>
					<option>생활비</option>
					<option>음주가무</option>
					<option>기타</option>
			</select>
			내용 : 
			<input type = "text" id = "size3" name = "gname">
			금액:
			<input type = "text" id = "size3" name = "money">
			<input type = "submit" value = "입력">
			</form>
      </div>
    </div>
</div>
<script>
</script>
</body>
</html>
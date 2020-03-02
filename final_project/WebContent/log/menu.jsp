<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="my.member.MemberDao" %>
<% 
	int rst=0;
	MemberDao dao=new MemberDao();
	String id = (String)request.getParameter("userid"); 
	String passwd = (String)request.getParameter("userpasswd"); 
	rst=dao.loginCheck(id, passwd);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">	
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link type = "text/css" rel = "stylesheet" href = "../css/n 3.css">
<title>Main Menu</title>
	<style>
		body{

			background-repeat: no-repeat;
		  	background-size: 100%;
		   	background-position: center;
		   	background-attachment: fixed;
			
		}
		h1{
			margin-top : 60px;
		}
		#insert{
			margin : 100px;
			background-color : white;
			color : red;		
			width : 100px;	
			height : 50px;
		}
		#use{
			margin : 100px;
			background-color : white;
			color : red;
			width : 100px;	
			height : 50px;			
		}
		#graphic{
			margin : 100px;
			background-color : white;
			color : red;	
			width : 100px;	
			height : 50px;		
		}
		img{
			margin-left : 350px;
			background-position : center;
			position : absolute;
		}
		#logindesign{
			padding-top : 30px;
			display : inline;
			color : green;
			font-size : 30px;
			padding-left : 300px;
			decoration : none;
		}
		
		#loginP{
			display : inline;
			color : black;
			decoration : none;
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
<body style= "background-image: url(back.jpg);">
	<p id = logindesign><%=id %><p id = "loginP">님 로그인중</p></p>
	<form name = "form1" method = "post">
	<p align="right">
		<input type="button" class="btn pull-right" id = "logout1" onclick="logout()" value="로그아웃">
	</p>
	<script>
		function logout(){
			var x = confirm("로그아웃 하시겠습니까?");
			if(x==true){
				location.replace('logoutProc.jsp');
			}
			else {
				return;
			}
		}
		
		function insert_go(){
			location.href="../insert/insertmenu.jsp";
		}
		
		function use_go(){
			location.href="../use/usemenu.jsp";
		}
		
		function graphic_go(){
			location.href="../graphic/graphicForm.jsp";
		}
	</script>
	<center>
	<h1 style = "font-size : 60px; font-family: SFMono-Regular, Menlo, Monaco, Consolas;"> 스마트 가계부 </h1>
	</center>
		<center>
			<input type = "button" value = "기입" id = "insert" class="btn-info" onclick="insert_go()">
			<input type = "button" value = "조회" id = "use" class="btn-info" onclick="use_go()">
			<input type = "button" value = "비교그래프" id = "graphic" class="btn-info" onclick="graphic_go()">
		</center>
	</form>
	<br/>
</body>
</html>
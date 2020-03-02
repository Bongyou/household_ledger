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
	<title>로그인 확인</title>
	</head>
	<body>
		<%
			if(rst==2){
				session.setAttribute("loginId", id);
				session.setMaxInactiveInterval(60*60);
		%>
			<script type="text/javascript">
				<% pageContext.forward("menu.jsp?userid="+id+"&userpasswd="+passwd);%>
			</script>
		<%
			}
			else if(rst==1) {
		%>
			<script type="text/javascript">
				alert("비밀번호가 틀렸습니다.");
				history.go(-1);
			</script>
		<%
			}
			else {
		%>
			<script type="text/javascript">
				alert("존재하지 않는 계정입니다.");
				history.go(-1);
			</script>
		<%
			}
		%>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="my.member.MemberDao"/>
<%
	int rst=0;
	String id=(String)request.getParameter("id");
	rst=dao.idCheck(id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디중복확인</title>
</head>
<body>

<%
	if(rst==1){
%>
		이미 사용중인 아이디입니다.
<% 	}
	else {
%>
		사용가능한 아이디입니다.
<%
	}
%>
</body>
</html>
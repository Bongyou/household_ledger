<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dao" class="my.member.MemberDao"/>
<jsp:useBean id="vo" class="my.member.MemberVo"/>
<jsp:setProperty property="*" name="vo"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int rst;
	request.setCharacterEncoding("UTF-8");
	rst=dao.insertMember(vo);
	if(rst!=0){
%>
	<script type="text/javascript">
		location.replace('../log/loginForm.jsp');
	</script>
<%
	}
	else {
%>
	<script type="text/javascript">
		alert("회원가입실패");
		history.go(-1);
	</script>
<%
	}
%>
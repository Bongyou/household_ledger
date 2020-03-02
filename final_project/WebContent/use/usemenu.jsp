<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link type = "text/css" rel = "stylesheet" href = "../css/n 3.css">


<title>조회 메뉴</title>
<script>
	//지출(소비)
	function expenseMoney(){
		location.href = "expenseForm.jsp";
	}
	//수입
	function importMoney(){
		location.href = "importForm.jsp";
	}
</script>
<style>
	#button1{
		display : inline;
		color : lightblue;
		height : 300px;
		width : 400px;
		font-size : 80px;


	}
	#button2{
		display : inline;
		color : lightblue;
		height : 300px;
		width : 400px;
		font-size : 80px;
		margin-left: 100px;
	}
	#st{
		margin-top : 250px;
		margin-left : 500px;
	}
	
	.btn {
      padding: 10px 20px;
      background-color: #333;
      color: #f1f1f1;
      border-radius: 0;
      transition: .2s;
}
	.btn:hover, .btn:focus {
      border: 3px solid red;
      background-color: #fff;
      color: #000;
}
</style>
</head>
<body>
<div id = "st">
<input type = "button" class = "btn" id = "button1" onclick = "expenseMoney();" value = "지출  조회">
<input type = "button" class = "btn" id = "button2" onclick = "importMoney();" value = "수입 조회">
</div>
</body>
</html>
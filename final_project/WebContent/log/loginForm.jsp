<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="dao" class="my.member.MemberDao"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link type = "text/css" rel = "stylesheet" href = "../css/n 3.css">
	
	<title>loginForm</title>
		<script type="text/javascript">
			function loginCheck(){
				var regx= /^[a-zA-Z0-9]*$/;
				var id=document.form.id.value;
				var passwd=document.form.passwd.value;
				
				if(id.length==0||id==null){
					alert("아이디를 입력하시오");
					document.form.id.focus();
					return;
				}
			
				if(!regx.test(id)){
					alert("아이디는 영어, 숫자만 입력가능합니다.");
					document.form.id.focus();
					return false;
				}
				
				if(passwd.length<6||passwd==null){
					alert("비밀번호는 6자 이상 입력해야합니다.");
					document.form.passwd.focus();
					return;
				}
			
				document.form.submit();
			}
		</script>
		<script type = "text/javascript">
			function idcheck(){
				var ids = document.getElementById('ID');
				var ids2 = ids.value;
				if(ids2 == null || ids2.length <1){
					alert("중복체크할 아이디를 입력하시오.");
					return 0;
				}
				else{
					var url="../member/idCheck.jsp?id="+ids2;
					window.open(url,"get","height=180,width=300");
				}
			}
		</script>
	  
	  	<style>
      		.form-group:nth-child(1) label{display: block;} 
      		.form-group:nth-child(1) input[type=text]{width: 80%; display: inline-block} 
      		.form-group:nth-child(1) input[type=button]{margin-left:10px;} 

      		.form-group:nth-child(7) label{display: block;} 		
      		.form-group:nth-child(7) input{float: left; width: 30%; margin-right: 3%;} 
      		.form-group:nth-child(7) p{float: left; margin-right: 3%;} 
      		.form-group:nth-child(7) select{width: 26%; height: 34px; margin-left: 2%; border-radius:4px;} 
     
		    #pos_canel{background-color: black; color:white; height:45px; width:100px; position : fixed; left : 7%; }
     		#pos_sign{background-color: black; color:white; height:45px; width:100px; position : fixed; left : 76%; }
     
   			#pos_sign:hover, #pos_canel:hover {
				border: 1px solid #333;
      			background-color: #fff;
      			color: #000;
     			}  
		    .main{   
		     	background-image: url(background.JPG);
		   		background-repeat: no-repeat;
		  		background-size: 100%;
		   		background-position: center;
		   		background-attachment: fixed;
			}
			#ID_Check{
				
				position : absolute;
				left : 450px;
				top : 63px;
			}
		</style>
</head>
<body class = main>
	<div class = "slide" id = "photo">
	   <div id="myCarousel" class="carousel slide" data-ride="carousel">
	
	   <!-- Wrapper for slides -->
	   <div class="carousel-inner" role="listbox">
	     <div class="item active">
	      <img src="2.jpg">   
	     </div>
	
	     <div class="item">
	      <img src="3.jpg">     
	     </div>
	   
	     <div class="item">
	      <img src="4.jpg">    
	     </div>
	   </div>
	   </div>
	</div>
	
	<form action="../log/loginProc.jsp" method="post" name="form">
		<div id = "pos1">
			<input id = "size1" class = "form-control" type = "text" name = "userid" size = "20" placeholder="ID" onfocus = "this.value =''">
      	    <br>
      	    <input id = "size1" class = "form-control" type = "password" name = "userpasswd" size = "20" placeholder="PW" onfocus = "this.value =''">
       	    <br><br>
      	    <input type = "submit" value = "Loign" class="btn pull-left">
     	    <input type = "button" class="btn pull-right" data-toggle="modal" data-target="#myModal" value = "Sign Up">
   		</div>
	</form>
	
   <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h4>Sign up</h4>
         </div>
      
         <div class="modal-body" style = "padding:7%">
            <form action = "../member/regFormProc.jsp" method = "POST">
               <div class="form-group">   
                  <label for="ID"><span class="glyphicon glyphicon-user"></span>ID</label>
                  <input type="text" class="form-control" maxLength = "20" name="id" id="ID" required>
                  <input class = "btn btn-primary"  type = "button" value = "중복체크" id = "ID_Check" onclick = "idcheck();">
               </div>
         
               <div class="form-group"> 
                  <label for="PW"><span class="glyphicon glyphicon-lock"></span>Password</label> 
                  <input type="password" class="form-control" maxLength = "20" name="passwd" id="PW1" required> 
               </div> 
         
               <div class="form-group"> 
                  <label for="PW2"><span class="glyphicon glyphicon-lock"></span>Password Check</label> 
                  <input type="password" class="form-control" maxLength = "20" name="passwd2" id="PW2" onchange = "pwcheck()" required> 
               </div>
         
               <div class="form-group"> 
                  <label for="NAME"><span class="glyphicon glyphicon-user"></span>Name</label>
                  <input type="text" class="form-control" maxLength = "20" name="name" id="name" required>
               </div>
         
               <div class="form-group"> 
                  <label for="GENDER"><span class="glyphicon glyphicon-heart"></span>Gender</label>
                  <div class="radio_wrap"> 
                     <label for="gender1">MALE</label> 
                     <input type="radio" value="m" name="gender" required> 
                     <label for="gender2">FEMALE</label> 
                     <input type="radio" value="f" name="gender" required> 
                  </div> 
               </div>   
               <div class="modal-footer">
                  <input type="submit" id = "pos_sign" value = "Sign up" >
                  <input type="button" id = "pos_canel" value = "cancel" data-dismiss="modal">
               </div>               
            </form>
         </div>
      </div>
    </div>
</div>
 
<script>
    function domain1(){ 
      var sel = document.getElementById('sel'); 
      var domain=document.getElementById('domain'); 
      if(sel.value==''){//직접 입력 선택 
         domain.readOnly=false; 
         domain.value=''; 
         domain.focus(); 
      }else{ 
         domain.value = sel.value; 
         domain.readOnly=true;//수정 불가 
      } 
    }
    function pwcheck(){
        var x = document.getElementById("PW1");
        var y = document.getElementById("PW2");
        
      
        if(x.value != y.value){
            alert("비밀번호가 일치하지 않습니다.");
            x.value = "";
            y.value = "";
        }
        else{
            alert("비밀번호가 일치합니다.");
        }
    }
 </script>
	
	<script>
		function sign(){
			 location.replace('member/regFormImpl.jsp');
		}
	</script>
</body>
</html>
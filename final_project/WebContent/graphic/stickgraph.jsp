<%@ page language="java" contentType="text/html; charset=utf-8" import="java.sql.*"
pageEncoding="utf-8" %>

<!doctype html>
<% request.setCharacterEncoding("utf-8"); %>
<%
	Connection conn=null;
	PreparedStatement pstmt=null;
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url="jdbc:mysql://localhost/youtube?useSSL=false";
%>

<html>
	<head>
		<meta charset="utf-8">
		<title>JDBC 테스트</title>
		<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
		<style>
			svg{width:500px; height: 400px; border:1px solid black;}
			.pie {fill:orange; stroke:black;}
			.total{font-size : 9pt; text-anchor:middle;}
			.pieNum{font_size:10px; text-anchor:middle;}
		</style>
	</head>
	<body>
	<center><hr></center>
	<%
		int pricesum =0;   //지출 전체
		int pricetong =0;   //통신비 전체
		int pricesik =0;   //식비 전체
		int pricecha =0;   //차비 전체
		int pricegong =0;   //공과금 전체
		int pricegi =0;      //기타 전체

		try{
		   Class.forName(jdbc_driver);
		   conn = DriverManager.getConnection(jdbc_url,"root","319418");
		   String sql = "select date1, date2, date4, sort, gname, price2 from user_scv0319";
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();

		   int i =1;

		   //테스트용 출력
		   out.println("#등록목록(테스트용)"+"<br>");
		   while(rs.next()){
			  out.println(i+" : "+rs.getString(1)+", "+rs.getString(2)+", "+rs.getString(3)+", "+rs.getString(4)+", "+rs.getString(5)+", "+rs.getString(6)+"<BR>");
			  i++;
		 	}
	 %>

	   <form name=form1 method=post action=opensource.jsp>

	   시작날짜(년,월,일) : 
	   <select name="year1">
	   <script>
		  for(var i=2018;i<2050;i++)
		  {
			 document.write("<option value='"+i+"'>"+i+"</option>");
		  }
	   </script>


	   </select>

	   <select name="month1">
	   <script>
		  for(var i=0;i<12;i++)
		  {
			 document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
		  }
	   </script>
	   </select>

	   <select name="day1">
	   <script>
		  for(var i=0;i<31;i++)
		  {
			 document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
		  }
	   </script>
	   </select>
	   <br>


	   종료일: 
	   <select name="day2">
	   <script>
		  for(var i=0;i<31;i++)
		  {
			 document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
		  }
	   </script>
	   </select>
	   <br>



	   <input type="submit" value="입력">

	   </form>

	   <%
	   String sqlrange = "select date1, date2, date4, sort, gname, price2 from user_scv0319 where date1=?&&date2=?&&date4>=?&&date4<=?";
	   pstmt = conn.prepareStatement(sqlrange);

	   pstmt.setString(1,request.getParameter("year1"));
	   pstmt.setString(2,request.getParameter("month1"));
	   pstmt.setString(3,request.getParameter("day1"));
	   pstmt.setString(4,request.getParameter("day2"));

	   rs = pstmt.executeQuery();
	   out.println("<hr>");

	   i=0;

	   while(rs.next()){
		  out.println(i+" : "+rs.getString(1)+", "+rs.getString(2)+", "+rs.getString(3)+", "+rs.getString(4)+", "+rs.getString(5)+", "+rs.getString(6)+ "<BR>");
		  i++;
	   }

	   String totalsum = "select sum(price2) from user_scv0319 where date1=?&&date2=?&&date4>=?&&date4<=?";
	   pstmt = conn.prepareStatement(totalsum);

	   pstmt.setString(1,request.getParameter("year1"));
	   pstmt.setString(2,request.getParameter("month1"));
	   pstmt.setString(3,request.getParameter("day1"));
	   pstmt.setString(4,request.getParameter("day2"));

	   rs = pstmt.executeQuery();

	   while(rs.next()){
		  pricesum=rs.getInt(1);   //총 지출 합 세팅.. 밑에 코드도 다 같은 방법임.
		  out.println("총 지출 : "+rs.getInt(1));
		  out.println("<BR>");

	   }

	   String totaltong = "select sum(price2) from user_scv0319 where sort='통신비'&&date1=?&&date2=?&&date4>=?&&date4<=?";
	   pstmt = conn.prepareStatement(totaltong);
	   pstmt.setString(1,request.getParameter("year1"));
	   pstmt.setString(2,request.getParameter("month1"));
	   pstmt.setString(3,request.getParameter("day1"));
	   pstmt.setString(4,request.getParameter("day2"));

	   rs = pstmt.executeQuery();

	   while(rs.next())
	   {
		  pricetong=rs.getInt(1);      
		  out.println("총 통신비 : "+rs.getInt(1));
		  out.println("<BR>");
	   }

	   String totalsik = "select sum(price2) from user_scv0319 where sort='식품'&&date1=?&&date2=?&&date4>=?&&date4<=?";
	   pstmt = conn.prepareStatement(totalsik);
	   pstmt.setString(1,request.getParameter("year1"));
	   pstmt.setString(2,request.getParameter("month1"));
	   pstmt.setString(3,request.getParameter("day1"));
	   pstmt.setString(4,request.getParameter("day2"));

	   rs = pstmt.executeQuery();

	   while(rs.next()){
		  pricesik=rs.getInt(1);   
		  out.println("총 식비 : "+rs.getInt(1));
		  out.println("<BR>");
	   }

	   String totalcha = "select sum(price2) from user_scv0319 where sort='차비'&&date1=?&&date2=?&&date4>=?&&date4<=?";
	   pstmt = conn.prepareStatement(totalcha);
	   pstmt.setString(1,request.getParameter("year1"));
	   pstmt.setString(2,request.getParameter("month1"));
	   pstmt.setString(3,request.getParameter("day1"));
	   pstmt.setString(4,request.getParameter("day2"));

	   rs = pstmt.executeQuery();

	   while(rs.next()){
		  pricecha=rs.getInt(1);   
		  out.println("총 차비 : "+rs.getInt(1));
		  out.println("<BR>");
	   }

	   String totalgong = "select sum(price2) from user_scv0319 where sort='공과금'&&date1=?&&date2=?&&date4>=?&&date4<=?";
	   pstmt = conn.prepareStatement(totalgong);
	   pstmt.setString(1,request.getParameter("year1"));
	   pstmt.setString(2,request.getParameter("month1"));
	   pstmt.setString(3,request.getParameter("day1"));
	   pstmt.setString(4,request.getParameter("day2"));

	   rs = pstmt.executeQuery();

	   while(rs.next()){
		  pricegong=rs.getInt(1);
		  out.println("총 공과금 : "+rs.getInt(1));
		  out.println("<BR>");
	   }

	   String totalgi = "select sum(price2) from user_scv0319 where sort='기타'&&date1=?&&date2=?&&date4>=?&&date4<=?";
	   pstmt = conn.prepareStatement(totalgi);
	   pstmt.setString(1,request.getParameter("year1"));
	   pstmt.setString(2,request.getParameter("month1"));
	   pstmt.setString(3,request.getParameter("day1"));
	   pstmt.setString(4,request.getParameter("day2"));

	   rs = pstmt.executeQuery();

	   while(rs.next()){
		  pricegi=rs.getInt(1);
		  out.println("총 기타 : "+rs.getInt(1));
		  out.println("<BR>");
	   }
	   rs.close();
	   pstmt.close();
	   conn.close();
	}

	catch(Exception e){
	   System.out.println(e);
	}

	%>
			<h1>원 그래프 표시</h1>
			<svg id="myGraph"></svg>
			<script>
			var svgWidth=500;   //svg요소의 넓이
			var svgHeight=400;  //svg 요소의 높이
			var dataSet = [<%out.println(pricegi);%>,<%out.println(pricesik);%>,<%out.println(pricetong);%> ,<%out.println(pricegong);%>,<%out.println(pricecha);%>]; //데이터셋, 비율을 나타냄
			var dataSet2 = ["기타","식비","통신비", "공과금", "차비"]; //데이터셋, 비율을 나타냄
			var color=d3.scale.category20(); //d3.js가 준비한 표준 10색을 지정. color는 함수가 되는것임. 변수가 아님.

			//원 그래프의 좌표값을 계산하는 메서드, 수치등을 반환하는것이 아니라 함수를 반환, 이 함수를 이용하여 부채꼴의 좌표를 계산.
			var pie = d3.layout.pie()

			//원 그래프의 안쪽 반지름, 바깥쪽 반지름 설정
			var arc = d3.svg.arc().innerRadius(60).outerRadius(150);


			//원 그래프 그리기
			var pieElements = d3.select("#myGraph")
			.selectAll("g")  //g 요소 지정
			.data(pie(dataSet)) //데이터를 요소에 연결

			//데이터 추가
			.enter() //데이터 수만큼 반복
			.append("g") //중심 계산을 위해 그룹화하기.

			//원 그래프의 중심으로 함
			.attr("transform", "translate("+svgWidth/2+", "+svgHeight/2+")")



			pieElements
			.append("path")
			.attr("class", "pie")   //css 클래스 설정

			/* 애니메이션을 지정하기 위해서 주석처리.
			.attr("d", arc) //부채꼴 지정
			*/

			/* 위에 color배열을 사용지 않을때 그래프의 색을 지정하는 방법, 이 코드를 사용할 경우 위의 var color을 주석처리해야함.
			.style("fill", function(d,i){
				//배열 안의 색을 반환
				return ["red", "orange", "yellow", "blue", "#3f3"][i];
			})
			*/



			//위에서 설정한 color을 사용할 때 그래프를 색칠하는 방법, 이 코드를 사용하려면 var color=d3.scale.category10();를 사용해야함.
			.style("fill", function(d,i){
				return color(i);
			})


			//애니메이션 처리부분, 애니메이션같은 경우 배열 첫번째부터 애니메이션이 시작됌.
			.transition()
			.duration(1000)
			<%--
			.delay(function(d,i){
				return i*500;
			})
			--%>
			.ease("linear")  //움직임을 직선적으로 표현하기 위해 추가.(없어도 돼는 코드)
			.attrTween("d", function(d,i){
				var interpolate = d3.interpolate(
					//각 부분의 시작 각도
					{startAngle : d.startAngle, endAngle : d.startAngle},
					//각 부분의 종료 각도
					{startAngle : d.startAngle, endAngle : d.endAngle }
				);
				return function(t){
					return arc(interpolate(t)); //시간에 따라 처리
				}
			})
			//여기까지가 애니메이션 적용부분.

			//중앙에 총 합 표시
			var textElements = d3.select("#myGraph")
			.append("text")         //text요소 추가
			.attr("class", "total") //css클래스 설정

			//가운데에 표시
			.attr("transform", "translate("+svgWidth/2+", "+(svgHeight/2+5)+")")
			.text("합계:" + d3.sum(dataSet)) //합계 표시

			//각각 요소 숫자값 표시.
			pieElements
			.append("text")
			.attr("class", "pieNum")
			.attr("transform", function(d,i){
				//부채꼴의 중심으로 함(무게 중심 계산)
				return "translate("+arc.centroid(d)+")";
			})
			.text(function(d,i){
			   if(dataSet[i]!=0)
				  {
					  return dataSet2[i]/*+d.value*/; //값 표시
				  }
			})
			</script>
	</body>
</html>
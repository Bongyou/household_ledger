<%@ page language="java" contentType="text/html; charset=utf-8" import="java.sql.*" pageEncoding="utf-8" %>
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
			svg{
				width:700px;
				height:600px;
				border: 1px solid black;
			}
			.bar{
				fill:orange;
			}
			/*
			.barNum{
				font-size:9pt;
				text-anchor: middle;
			}
			*/
			.barNum{
				font-size:9pt;
				text-anchor : end;
				writing-mode :tb;
				glyph-orientation-vertical:90;
			}
			.axis text{
				font-family:sans-serif;
				font-size:11px;
			}
			.axis path,.axis line{
				fill:none;
				stroke:black;
			}
			.axis_x line{
				fill:none;
				stroke:black;
			}
			.barName{
				font-size:9pt;
				text-anchor:middle;
			}
		</style>
	</head>
	<body>
		<p>#등록 목록</p>
		<%
			int[] dayprice = new int[7];  //각 날짜마다 지출 배열
			int[] dayday = new int[7];   //1주일의 날짜 배열

			try{
		   		Class.forName(jdbc_driver);
		   		conn = DriverManager.getConnection(jdbc_url,"root","319418");
		   		String sql = "select date1,date2,date4, sort, gname, price2 from user_scv0319";
		   		pstmt = conn.prepareStatement(sql);
		   		ResultSet rs = pstmt.executeQuery();

		   		int i =1;

		   		out.println("#등록목록(테스트용)"+"<br>");
		   		while(rs.next()){
			  		out.println(i+" : "+rs.getString(1)+", "+rs.getString(2)+", "+rs.getString(3)+", "+rs.getString(4)+", "+rs.getString(5)+", "+rs.getString(6)+"<BR>");
			  		i++;
		   		}

		   		rs.close();
		   		pstmt.close();
		   		conn.close();
			}catch(Exception e){
		   System.out.println(e);
			}
		%>
		<form name=form1 method=post action=opensource2.jsp>
	   		시작날짜(년,월,일)로부터 1주일 검색: 
	   		<select name="year1">
	   			<script>
		  			for(var i=2018;i<2050;i++){
			 			document.write("<option value='"+i+"'>"+i+"</option>");
		  			}
	   			</script>
			</select>

	   		<select name="month1">
				<script>
			 		for(var i=0;i<12;i++){
						document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
			 		}
		  		</script>
	   		</select>

	   		<select name="day1">
	   			<script>
		  			for(var i=0;i<31;i++){
			 			document.write("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
		  			}
	   			</script>
	   		</select>
	   		<br>
	   		<br>
	   		<input type="submit" value="입력">
		</form>

		<%
			try{
			   Class.forName(jdbc_driver);
			   conn = DriverManager.getConnection(jdbc_url,"root","319418");
			   String sql = "select date1, date2, date4, sort, gname, price2 from user_scv0319";
			   pstmt = conn.prepareStatement(sql);
			   ResultSet rs = pstmt.executeQuery();

			   int i =1;

			   String sqlrange = "select sum(price2) from user_scv0319 where date1=?&&date2=?&&date4=?";
			   pstmt = conn.prepareStatement(sqlrange);

			   String str1;

			   for(int j=0; j<7; j++){
				  str1 = request.getParameter("day1");
				  int a = Integer.parseInt(str1);

				  if(a+j>=32) //날짜가 32일을 넘어가면 나가지게 만듬.
					 break;

				  dayday[j] = a+j;   
				  str1 = a+j+"";

				  pstmt.setString(1,request.getParameter("year1"));
				  pstmt.setString(2,request.getParameter("month1"));
				  pstmt.setString(3,str1);

				  rs = pstmt.executeQuery();

				  while(rs.next()){
					 dayprice[j]=rs.getInt(1);
					 out.println(a+j+"일 총지출 : "+rs.getInt(1));
					 out.println("<br>");
				  }
			   }

			   /*
			   for(int k=0; k<7;k++){
				  out.println(dayprice[k]); //배열에 가격 잘 들어갔나 확인;
				  out.println(dayday[k]); //배열에 날짜 잘 들어갔나 확인;
			   }
			   */

			   rs.close();
			   pstmt.close();
			   conn.close();
			}catch(Exception e){
			   System.out.println(e);
			}
		%>
		<h1>세로형 막대 그래프를 표시</h1>
		<svg id="myGraph"></svg>
		<script>
			var svgWidth=500;   //svg요소의 넓이
			var svgHeight = 400; //svg 요소의 높이
			var offsetX=100;     //x좌표의 오프셋(어긋난 정도)
			var offsetY=-90;     //y좌표의 오프셋(어긋난 정도)
			var barElements;    //막대그래프의 막대 요소를 저장할 변수
			var dataSet = [<%=dayprice[0]%>, <%=dayprice[1]%>, <%=dayprice[2]%>, <%=dayprice[3]%>, <%=dayprice[4]%>, <%=dayprice[5]%>, <%=dayprice[6]%>];
			var dataMax =200000;       //데이터의 최대값
			var barWidth=20;        //막대의 넓이
			var barMargin=5;        //막대의 옆 간격

			//그래프 그리기
			barElements = d3.select("#myGraph")
			.selectAll("rect")  //rect요소를 지정
			.data(dataSet)  //데이터를 요소에 연결

			//데이터 추가
			barElements.enter() //데이터 수만큼 반복
			.append("rect") //데이터 수만큼 rect요소가 추가
			.attr("class", "bar")   //css클래스 설정
			.attr("height", 0)  //초깃값을 0으로 설정
			.attr("width", barWidth)  //넓이 지정
			.attr("x",function(d,i){
				//x좌표를 표시순서*25+offsetX;
				return i*(barWidth+barMargin)+offsetX;
			})
			.attr("y", svgHeight-offsetY) //그래프 가장 아래에 좌표를 설정

			//마우스 오버 이벤트 설정.
			.on("mouseover", function(){
				d3.select(this)     //마우스가 올라갔을 때 막대의 칠하기 스타일을 빨간색으로.
				.style("fill","red")
			})
			.on("mouseout", function(){
				d3.select(this)
				.style("fill","orange") //막대의 칠하기 스타일을 오렌지색으로.
			})

			//애니메이션 처리 : 여기부터 barElements.enter() 전까지가 추가한 곳

			.transition()
			.duration(1000) //애니메이션 기간(1초 동안 애니메이션 처리)

			.delay(function(d,i){
				return i*100;
			})

			.attr("y",function(d,i){    //y좌표를 지정
				return svgHeight-d*0.002-offsetY;     //y좌표를 계산
			})
			.attr("height", function(d,i){
				return d*0.002;
			})

			barElements.enter() //텍스트 요소 지정
			.append("text") //텍스트 요소 추가
			.attr("class", "barNum")    //css클래스 설정
			.attr("x", function(d,i){   //x좌표 지정
				return i*(barWidth+barMargin) +10+offsetX;    //막대그래프의 표시 간격을 맞춤
			})
			.attr("y", svgHeight-5-offsetY) //y좌표를 지정
			.text(function(d,i){    //데이터 표시
				return d;
			})

			//눈금을  표시하기 위한 스케일 설정
			var yScale = d3.scale.linear()      //스케일 설정
			.domain([0,dataMax])    //원래 크기
			.range([400,0])     //실체 출력 크기

			//세로방향의 눈금을 설정하여 표시
			d3.select("#myGraph").append("g")
			.attr("class","axis")
			.attr("transform", "translate("+offsetX+","+((svgHeight-400)-offsetY)+")")
			.call
			(
				d3.svg.axis()
				.scale(yScale)  //스케일 적용
				.orient("left")     //눈금의 표시 위치를 왼쪽으로 지정.
				//.ticks(10)           //눈금 간격, 기본10 ,없어도 됌
				//.tickValues([10,20,30,50,100,150,200,300])  //해당하는 값에 눈금 표시
				//.tickFormat(d3.format(".2f"))        //표시형식 지정
			)

			//가로방향의 선을 표시
			d3.select("#myGraph")
			.append("rect")
			.attr("class","axis_x")
			.attr("width",svgWidth)
			.attr("height",1)
			.attr("transform", "translate("+offsetX+","+(svgHeight-offsetY)+")")

			//막대의 레이블 표시
			barElements.enter()
			.append("text")
			.attr("class", "barName")
			.attr("x", function(d, i){  //x좌표를 지정
				return i*(barWidth+barMargin) + 10 +offsetX;    //막대그래프의 표시 간격을 맞춤
			})
			.attr("y",svgHeight-offsetY+15)
			.text(function(d,i){
				return ["<%=dayday[0]%>", "<%=dayday[1]%>", "<%=dayday[2]%>", "<%=dayday[3]%>", "<%=dayday[4]%>","<%=dayday[5]%>","<%=dayday[6]%>"][i];
			})
		</script>
	</body>
</html>
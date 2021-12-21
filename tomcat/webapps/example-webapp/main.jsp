<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.io.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.time.*" %>
<%@ page import ="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>web site</title>
</head>

<body>
<%
	String userId=null;
	if(session.getAttribute("userId")!=null)
	{
		userId=(String)session.getAttribute("userId");
	}
// 아이디 세션 받아오는 부분%>

 <%
  java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
  int currentMonth=cal.get(java.util.Calendar.MONTH);
  int currentDate=cal.get(java.util.Calendar.DATE);
  String Year=request.getParameter("year"); //나타내고자 하는 날짜
  String Month=request.getParameter("month");
  int year, month;
  if(Year == null && Month == null){ //처음 호출했을 때
  year=currentYear;
  month=currentMonth;
  }
  else { //나타내고자 하는 날짜를 숫자로 변환
   year=Integer.parseInt(Year);
   month=Integer.parseInt(Month);
   if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
   if(month>11) { month=0; year=year+1; }
  }
 //날짜 가져오기 %>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target=#bs-example-navbar-collapse-1
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">일정관리 웹</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class=active><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">일정보기</a></li>
			</ul>
			<% if(userId==null){ //로그인 되어 있지 않아서, userId 세션 할당 받지 못했고, 그로인해 userId가 null이라면
				%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
			} else{ //로그인 되어 있어서 userId로 세션을 할당 받았고, attribute
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
				
			<% }%>
		</div>
	</nav> 
<section style="display:flex; align-items: center">
<div align="left" style="color:blue; border:solid blue; width:400px; height:350px; margin-right:100px; margin-left:20px; padding:3% 3%">
<h1 align="center"> < 오늘 할 일 ></h1>
<%
	ResultSet rs;
	Connection conn;

	      try{
		  String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
		  String DB_USER="example_db_user";
		  String DB_PASSWORD="example_db_pass";
		  Class.forName("com.mysql.jdbc.Driver");
		  conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		 
		  String SQL= "SELECT * FROM duty ORDER BY date ASC";
		  PreparedStatement pstmt=conn.prepareStatement(SQL);
		  rs=pstmt.executeQuery();
		  while(rs.next()){                          //title ,info, id, date, weight
			String name = rs.getString(1);
			String date=rs.getString(4);
			LocalDate now = LocalDate.now();
			int day = now.getDayOfMonth();
	
		if(Integer.parseInt(date.substring(0,4))==year&&Integer.parseInt(date.substring(4,6))==(month+1)&&Integer.parseInt(date.substring(6))==day)
		{//해당하는 날짜에 맞춰 스케쥴 출력
			out.println("<h3 align='center'>"+rs.getString(3)+" : "+name+"</h3>"); //유저이름 : 할 일 이름 순으로 출력
		}
		
				} 
                        }catch(Exception e){
                        e.printStackTrace();
                        }
	
%>
</div>

<div align="center">
  <HR>
  <form  method="post" action='memoAction.jsp'>
   
   날짜 : <input type=text name=date size=8 style="margin-right:10px" placeholder="YYYYMMDD">
 <label for="weight">중요도 : </label>
<select name="weight" id="weight">
    <option value="">일정 중요도</option>
    <option value="최상">최상</option>
    <option value="상">상</option>
    <option value="중">중</option>
    <option value="하">하</option>
    <option value="최하">최하</option>
</select>
  일정이름 :  <input type=text name=title style="margin-right:10px">
   <input type=submit class="btn btn-primary"  value="추가">
  </form>

  <table border=0> 
   <tr>
    <td align=left width=200> <!-- 년 도-->
    <a href="main.jsp?year=<%out.print(year-1);%>&month=<%out.print(month);%>">◀</a>
    <% out.print(year); %>년
    <a href="main.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>">▶</a>
    </td>
    <td align=center width=300> <!-- 월 -->
    <a href="main.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>">◀</a>
    <% out.print(month+1); %>월
    <a href="main.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>">▶</a>
    </td>
    <td align=right width=200><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></td>
   </tr>
  </table>
  <table border=1 cellspacing=0> <!-- 달력 부분 -->
   <tr>
    <td width=100 style="text-align:center">일</td> <!-- 일=1 -->
    <td width=100 style="text-align:center">월</td> <!-- 월=2 -->
    <td width=100 style="text-align:center">화</td> <!-- 화=3 -->
    <td width=100 style="text-align:center">수</td> <!-- 수=4 -->
    <td width=100 style="text-align:center">목</td> <!-- 목=5 -->
    <td width=100 style="text-align:center">금</td> <!-- 금=6 -->
    <td width=100 style="text-align:center">토</td> <!-- 토=7 -->
   </tr>
   <tr height=30>
   <%
   cal.set(year, month, 1); //현재 월의 1일로 설정
   int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
   int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
   int br=0; //7일마다 줄 바꾸기
   for(int i=0; i<(startDay-1); i++) { //빈칸출력
    out.println("<td>&nbsp;</td>");
    br++;
    if((br%7)==0) {
     out.println("<br>");
    }
   }
   for(int i=1; i<=end; i++) { //날짜출력
    out.println("<td height=100 style='margin:0 0; vertical-align : top'>" + i );
   	try{
                          String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                          String DB_USER="example_db_user";
                          String DB_PASSWORD="example_db_pass";
                          Class.forName("com.mysql.jdbc.Driver");
                          conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                         
                          String SQL= "SELECT * FROM duty ORDER BY date ASC";
                          PreparedStatement pstmt=conn.prepareStatement(SQL);
                          rs=pstmt.executeQuery();
   		
		 while(rs.next()){                          //title ,info, id, date, weight
			String name = rs.getString(1);
			String date=rs.getString(4);
			
			if(Integer.parseInt(date.substring(0,4))==year&&Integer.parseInt(date.substring(4,6))==(month+1)&&Integer.parseInt(date.substring(6))==i)
			{//해당하는 날짜에 맞춰 스케쥴 출력 %>
				<a href='view.jsp?title=<%=URLEncoder.encode(name,"UTF-8")%>'><%=name%><br></a>
			<% }
			
		} 
	}catch(Exception e){
          e.printStackTrace();
          } 
		
		out.println("</td>");
   	
   		
    br++;
    if((br%7)==0 && i!=end) {
     out.println("</tr><tr height=30>");
    }
   }
   while((br++)%7!=0) //말일 이후 빈칸출력
    out.println("<td>&nbsp;</td>");
   %>
  </tr>
  </table>
  </div>
  </section>
  
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script> 
</body>
</html>

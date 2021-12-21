<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.io.*"%>
<%@ page import = "java.sql.*"%>
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
	
	String bbsTitle=null;

	if(request.getParameter("title") !=null)//bbs.jsp에서 글을 눌러 view로 넘어오는데 title을 가지고 넘어옴
	{
		bbsTitle=request.getParameter("title");
		//System.out.println(bbsTitle);
	}
	if(bbsTitle==null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 글 입니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	
//	Bbs bbs = new BbsDAO().getBbs(bbsTitle);
	
	String title=null;
	String info=null;
	String id=null;
	String date=null;
	String weight=null;	
	String SQL= "SELECT * FROM duty WHERE title = ?";
		
		try {
			  ResultSet rs;
		          Connection conn;
			  String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                         String DB_USER="example_db_user";
                         String DB_PASSWORD="example_db_pass";
                         Class.forName("com.mysql.jdbc.Driver");
                         conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			  PreparedStatement pstmt=conn.prepareStatement(SQL);
			  pstmt.setString(1,bbsTitle);
			  rs=pstmt.executeQuery();
			  while(rs.next())
			  {
				  //title ,info, id, date, weight
				  title=rs.getString(1);
				  info=rs.getString(2);
				  id=rs.getString(3);
				  date=rs.getString(4);
				  weight=rs.getString(5);
				 
			  }
		}catch(Exception e) {
			e.printStackTrace();
		}
%>
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
				<li><a href="main.jsp">메인</a></li>
				<li class=active><a href="bbs.jsp">일정보기</a></li>
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
	
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead><%-- 게시판목록 헤드 --%>
					<tr>
						<th colspan="3" style="background-color:#eeeeee; text-align:center;">일정보기</th>
					</tr>
				</thead>
				<tbody><%-- 게시판목록 몸체 --%>	
					<tr>
						<td style="width:20%;">일정 제목</td>
						<td colspan="2"><%= title %></td>
					</tr>
					<tr>
						<td>일정 작성자</td>
						<td colspan="2"><%= id %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= date %></td>
					</tr>
					<tr>
						<td>일정중요도</td>
						<td colspan="2"><%= weight %></td>
					</tr> 
					<tr>
						<td>일정내용</td>
						<td colspan="2" style="min-height:200px; text-align:left;"><%= info.replaceAll(" ", "&nbsp;").replaceAll("\n","<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<% if(userId != null && userId.equals(id)){
				%>
				<a href='update.jsp?title=<%=URLEncoder.encode(title,"UTF-8")%>'class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말 삭제하시겠습니까?')" href='deleteAction.jsp?title=<%=URLEncoder.encode(title,"UTF-8")%>'class="btn btn-primary">삭제</a>
				
			<%}%>
		</div>
	</div>

	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script> 
</body>
</html>

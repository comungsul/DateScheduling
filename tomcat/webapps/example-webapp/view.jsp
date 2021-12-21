<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.io.*"%>
<%@ page import ="java.net.URLEncoder" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
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
	}
	if(bbsTitle==null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 글 입니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	
	Bbs bbs = new BbsDAO().getBbs(bbsTitle);
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
			<a class="navbar-brand" href="main.jsp">일정 관리 웹</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class=active><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">전체 일정 보기</a></li>
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
				<thead><%-- 일정 헤드 --%>
					<tr>
						<th colspan="2" style="background-color:#eeeeee; text-align:center;">일정 보기</th>
					</tr>
				</thead>
				<tbody><%-- 일정 몸체 --%>
					<tr>
						<td style="width: 20%;">일정 이름</td>
						<td colspan="2"><%= bbs.getTitle() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">일정 날짜</td>
						<td colspan="2"><%= bbs.getDate() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">일정 중요도</td>
						<td colspan="2"><%= bbs.getWeight() %></td>
					</tr>	
					<tr>
						<td style="width: 20%;">일정 내용</td>
						<td colspan="2" style="min-height:200px; text-align:left;"><%= bbs.getInfo().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&rt;") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userId !=null&&userId.equals(bbs.getUserId()))
				{
					String title=bbs.getTitle();
			%>
			<a href='update.jsp?title=<%=URLEncoder.encode(title,"utf-8")%>' class="btn btn-primary">수정하기</a>
			<a href='deleteAction.jsp?title=<%=URLEncoder.encode(title,"utf-8")%>' class="btn btn-primary">삭제하기</a>
			<%} %>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script> 
</body>
</html>
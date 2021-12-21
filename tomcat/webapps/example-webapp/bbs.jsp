<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.io.*"%>
<%@ page import ="bbs.Bbs"%>
<%@ page import ="bbs.BbsDAO"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import ="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>web site</title>
<style type="text/css">
	a, a:hover{
	color:#000000;
	text-decoration:none;
	}
</style>
</head>

<body>
<%
	String userId=null;
	if(session.getAttribute("userId")!=null)
	{
		userId=(String)session.getAttribute("userId");
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
						<th style="background-color:#eeeeee; text-align:center;">날짜</th>
						<th style="background-color:#eeeeee; text-align:center;">일정이름</th>
						<th style="background-color:#eeeeee; text-align:center;">중요도</th>
						<th style="background-color:#eeeeee; text-align:center;">일정작성자</th>
					</tr>
				</thead>
				<tbody><%-- 게시판목록 몸체 --%>
					
					<% BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(bbsDAO.getPageNum());
					for(int i=0;i<list.size();i++){
					String name = list.get(i).getTitle();%>
					<tr>
						<td><%=list.get(i).getDate()%></td>
						<td><a href='view.jsp?title=<%=URLEncoder.encode(name,"UTF-8")%>'><%=list.get(i).getTitle()%></a></td>
						<td><%=list.get(i).getWeight()%></td>
						<td><%=list.get(i).getUserId()%></td>
					</tr>
					<%} %>
					
				</tbody>
			</table>
			<% if(userId!=null){%>
			<a href="writer.jsp" class="btn btn-primary pull-right">일정추가</a>
			<%} %>	
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script> 
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.io.*"%>
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
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead><%-- 게시판목록 헤드 --%>
					<tr>
						<th colspan="2" style="background-color:#eeeeee; text-align:center;">일정추가양식</th>
					</tr>
				</thead>
				<tbody><%-- 게시판목록 몸체 --%>
					<tr>
						<td><input type="text" class="form-control" placeholder="일정이름" name="title" maxlength="25"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control" placeholder="날짜(YYYYMMDD)" name="date" maxlength="25"></td>
					</tr>
					<tr>	
					<td><input type="text" class="form-control" placeholder="중요도" name="weight" maxlength="25"></td>
					</tr>	
					<tr>
						<td><textarea class="form-control" placeholder="내용" name="info" maxlength="25" style=height:350px;></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="일정추가">
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			
			
		</form>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script> 
</body>
</html>
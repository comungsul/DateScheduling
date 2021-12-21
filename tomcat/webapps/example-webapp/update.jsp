<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.io.*"%>
<%@ page import ="bbs.Bbs"%>
<%@ page import ="bbs.BbsDAO"%>
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
	Bbs bbs= new BbsDAO().getBbs(bbsTitle);
	if(!userId.equals(bbs.getUserId())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
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
				
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
						
		<form method="post" action='updateAction.jsp?<%=URLEncoder.encode(bbs.getTitle(),"UTF-8")%>'>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead><%-- 게시판목록 헤드 --%>
					<tr>
						<th colspan="2" style="background-color:#eeeeee; text-align:center;">일정수정양식</th>
					</tr>
				</thead>
				<tbody><%-- 게시판목록 몸체 --%>
					<tr>
						<td><input type="text" class="form-control" placeholder="일정이름" name="title" maxlength="25" value=<%=bbs.getTitle() %>></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control" placeholder="날짜" name="date" maxlength="25" value=<%= bbs.getDate() %>></td>
					</tr>
					<tr>	
					<td><input type="text" class="form-control" placeholder="중요도" name="weight" maxlength="25" value=<%=bbs.getWeight()%> ></td>
					</tr>	
					<tr>
						<td><textarea class="form-control" placeholder="내용" name="info" maxlength="25" style="height:350px;"><%=bbs.getInfo() %></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="일정수정">
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			
		</form>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script> 
</body>
</html>
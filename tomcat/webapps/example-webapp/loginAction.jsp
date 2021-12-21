<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userId"/> <%--user객체에 아이디 설정 --%>
<jsp:setProperty name="user" property="userPw"/><%--user객체에 비번 설정 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>web site</title>
</head>

<body>
	<%
		String userId=null;
		if(session.getAttribute("userId")!=null)
		{
			userId=(String) session.getAttribute("userId");
		}
		if(userId!=null)
		{
			PrintWriter script=response.getWriter();
			script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
			script.println("alert('이미 로그인이 되었습니다.')");
			script.println("location.href = 'main.jsp'"); //main으로 이동
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserId(),user.getUserPw());
		
		if(result==1){//로그인 성공시
			session.setAttribute("userId",user.getUserId());//유저아이디로 세션할당 후 메인으로 이동
			PrintWriter script=response.getWriter();
			script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
			script.println("location.href = 'main.jsp'"); //main으로 이동
			script.println("</script>");
		}
		
		else if(result==0){//비번 틀림
			PrintWriter script=response.getWriter();
			script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
			script.println("alert('비밀번호가 틀렸습니다.')"); //main으로 이동
			script.println("history.back()"); //이전 페이지로 다시보내버림->login.jsp
			script.println("</script>");
		}
		else if(result==-1){//id가 db에없슴
			PrintWriter script=response.getWriter();
			script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
			script.println("alert('존재하지 않는 아이디입니다.')"); //main으로 이동
			script.println("history.back()"); //이전 페이지로 다시보내버림->login.jsp
			script.println("</script>");
		}
		else if(result==-2){//db오류
			PrintWriter script=response.getWriter();
			script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
			script.println("alert('db오류 입니다.')"); //main으로 이동
			script.println("history.back()"); //이전 페이지로 다시보내버림->login.jsp
			script.println("</script>");
		}
	%>
</body>
</html>
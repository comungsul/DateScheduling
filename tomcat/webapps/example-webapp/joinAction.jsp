<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userId"/> <%--user객체에 아이디 설정 --%>
<jsp:setProperty name="user" property="userPw"/><%--user객체에 비번 설정 --%>
<jsp:setProperty name="user" property="userName"/><%--user객체에 이름 설정 --%>

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
	
		
	
		if(user.getUserId()==null||user.getUserName()==null||user.getUserPw()==null)
		{
			PrintWriter script=response.getWriter();
			script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
			script.println("쓰지 않은 사항이 있습니다."); //이런 스크립트문장을 자동적으로 생성
			script.println("history.back()"); //join으로 다시 이동
			script.println("</script>");
		}
		else
		{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);//유저 정보를 db에 넣는다.
			
			if(result==-1){//db오류 -> join의 db오류는 pk인 id중복일 경우
				PrintWriter script=response.getWriter();
				script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
				script.println("alert('비밀번호가 틀렸습니다.')"); //main으로 이동
				script.println("history.back()"); //이전 페이지로 다시보내버림->login.jsp
				script.println("</script>");
			}
			
			else{//유저 정보를 db에 잘 저장함
				session.setAttribute("userId",user.getUserId());//유저아이디로 세션할당 후 메인으로 이동
				PrintWriter script=response.getWriter();
				script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
				script.println("location.href='main.jsp'"); //회원가입 성공했으니 로그인시켜 메인으로 보냄
				script.println("</script>");
			}
			
		}
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.io.*" %>
<%@ page import ="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>

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
		userId=request.getParameter("userId");
		String userPw=request.getParameter("userPw");
		int result =3;
		ResultSet rs;
               Connection conn;
		String SQL="SELECT userPw FROM user where userId=?";
		try {
			String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                       String DB_USER="example_db_user";
                       String DB_PASSWORD="example_db_pass";
                      	Class.forName("com.mysql.jdbc.Driver");
                       conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userId); 
			rs=pstmt.executeQuery();
			
			if(rs.next()) { 
				if(rs.getString(1).equals(userPw)) {
					result= 1;
				}
				else result= 0;
			}
			else result=-1;
			
		}catch(Exception e) {
			e.printStackTrace();
			result= -2;
		}
		
		if(result==1){//로그인 성공시
			session.setAttribute("userId",userId);//유저아이디로 세션할당 후 메인으로 이동
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

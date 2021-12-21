<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import ="java.io.*" %>
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
	
		
	
		if(request.getParameter("userName")==null||request.getParameter("userId")==null||request.getParameter("userPw")==null)
		{
			PrintWriter script=response.getWriter();
			script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
			script.println("쓰지 않은 사항이 있습니다."); //이런 스크립트문장을 자동적으로 생성
			script.println("history.back()"); //join으로 다시 이동
			script.println("</script>");
		}
		else
		{
			int result = -6030;

			String userName=request.getParameter("userName");
			String userid=request.getParameter("userId");
			String userPw=request.getParameter("userPw");

			try {
				ResultSet rs;
				Connection conn;
				PreparedStatement pstmt;
				String SQL="INSERT INTO user VALUES(?,?,?)"; //name, id, pw
				String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                          	String DB_USER="example_db_user";
                          	String DB_PASSWORD="example_db_pass";
                          	Class.forName("com.mysql.jdbc.Driver");
                          	conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userName);
				pstmt.setString(2, userid);
				pstmt.setString(3, userPw);
				result=pstmt.executeUpdate();
			}catch(Exception e) {
			e.printStackTrace();
			}
			if(result==-6030) result=-1;
			
			if(result==-1){//db오류 -> join의 db오류는 pk인 id중복일 경우
				PrintWriter script=response.getWriter();
				script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
				script.println("alert('duplicated id')"); 
				script.println("history.back()"); //이전 페이지로 다시보내버림->join.jsp
				script.println("</script>");
			}
			
			else{//유저 정보를 db에 잘 저장함
				session.setAttribute("userId",userid);//유저아이디로 세션할당 후 메인으로 이동
				PrintWriter script=response.getWriter();
				script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
				script.println("location.href='main.jsp'"); //회원가입 성공했으니 로그인시켜 메인으로 보냄
				script.println("</script>");
			}
			
		}
	%>
</body>
</html>

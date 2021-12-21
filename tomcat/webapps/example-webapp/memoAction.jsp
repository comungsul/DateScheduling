<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.sql.*"%>
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
		if(userId==null)
		{
			PrintWriter script=response.getWriter();
			script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'"); //main으로 이동
			script.println("</script>");
		}//로그인이 안되었을 경우
	
		//로그인이 된 경우
		else{//일정이름, 일정날짜, 일정 중요도를 안썻다면
			if(request.getParameter("title")==null||request.getParameter("date")==null||request.getParameter("weight")==null)
			{
				PrintWriter script=response.getWriter();
				script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
				script.println("쓰지 않은 사항이 있습니다."); //이런 스크립트문장을 자동적으로 생성
				script.println("history.back()"); //join으로 다시 이동
				script.println("</script>");
			}
			else
			{//다 잘 썻다면
				ResultSet rs;
				Connection conn;

				String title=request.getParameter("title");
				String date=request.getParameter("date");
				String weight=request.getParameter("weight");	
				String info="none";			
				String SQL= "Insert INTO duty VALUES (?,?,?,?,?)";
		try {
				String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                          	String DB_USER="example_db_user";
                          	String DB_PASSWORD="example_db_pass";
                          	Class.forName("com.mysql.jdbc.Driver");
                          	conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				
				 PreparedStatement pstmt=conn.prepareStatement(SQL);
				 pstmt.setString(1, title);
				 pstmt.setString(2, info);
				 pstmt.setString(3, userId);
				 pstmt.setString(4, date);
				 pstmt.setString(5, weight);
				 
			}catch(Exception e) {
				e.printStackTrace();
			}

				
				
				
			
				
			}
			
		}
	
		
	%>
</body>
</html>

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
			userId=(String)session.getAttribute("userId");
		}
		
		String bbsTitle=null;
		if(request.getParameter("title") !=null)//전 페이지에서 title을 가지고 넘어옴
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
		
		//Bbs bbs= new BbsDAO().getBbs(bbsTitle);
		
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
		out.println("<h2>"+bbsTitle+"</h2>");
		if(!userId.equals(id)){
			out.println("<h1>"+"id :"+id+" userid: "+userId+"</h1>");
		}
		//로그인이 된 경우
		else{//일정이름, 일정날짜, 일정 중요도를 안썻다면
			if(request.getParameter("title")==null||request.getParameter("date")==null||request.getParameter("weight")==null||request.getParameter("info")==null)
			{
				PrintWriter script=response.getWriter();
				script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
				script.println("alert('쓰지 않은 사항이 있습니다.')"); //이런 스크립트문장을 자동적으로 생성
				script.println("history.back()"); //join으로 다시 이동
				script.println("</script>");
			}
			else
			{//다 잘 썻다면
				int result=-6030;
				SQL= "UPDATE duty SET title = ?, date = ?, weight = ?, info = ?";//유저 정보를 db에 넣는다.
			try {
				ResultSet rs;
				Connection conn;
			
				 String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                          	 String DB_USER="example_db_user";
                          	 String DB_PASSWORD="example_db_pass";
                          	 Class.forName("com.mysql.jdbc.Driver");
                          	 conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				 
				 PreparedStatement pstmt=conn.prepareStatement(SQL);
				 pstmt.setString(1, title);
				 pstmt.setString(2, date);
				 pstmt.setString(3, weight);
				 pstmt.setString(4, info);
				 
				 result=pstmt.executeUpdate();
				 
			}catch(Exception e) {
				e.printStackTrace();
			}
			if(result==-6030) result= -1; 
				
				if(result==-1){//db오류 
					PrintWriter script=response.getWriter();
					script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
					script.println("alert('일정수정에 실패했습니다.')"); //main으로 이동
					script.println("history.back()"); //이전 페이지로 다시보내버림->update.jsp
					script.println("</script>");
				}
				
				else{//작성된 글 정보를 db에 잘 넣음
					PrintWriter script=response.getWriter();
					script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
					script.println("location.href='bbs.jsp'"); //일정목록으로 돌아감
					script.println("</script>");
				}
				
			}
			
		}
	
		
	%>
</body>
</html>

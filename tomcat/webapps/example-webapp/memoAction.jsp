<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="bbs.Bbs" %>
<%@ page import ="bbs.BbsDAO" %>
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
				BbsDAO bbsDAO = new BbsDAO();
				String title=request.getParameter("title");
				String date=request.getParameter("date");
				String weight=request.getParameter("weight");
				int result = bbsDAO.writer(title,"none",userId,date,weight);//유저 정보를 db에 넣는다.
				
				if(result==-1){//db오류 
					PrintWriter script=response.getWriter();
					script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
					script.println("alert('글쓰기에 실패했습니다.')"); //main으로 이동
					script.println("history.back()"); //이전 페이지로 다시보내버림->login.jsp
					script.println("</script>");
				}
				
				else{//작성된 글 정보를 db에 잘 넣음
					PrintWriter script=response.getWriter();
					script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
					script.println("location.href='main.jsp'");//확인을 위해 다시 메인으로 
					script.println("</script>");
				}
				
			}
			
		}
	
		
	%>
</body>
</html>
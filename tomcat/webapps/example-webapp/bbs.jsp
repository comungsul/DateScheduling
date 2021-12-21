<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.io.*"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import ="java.net.URLEncoder" %>

<%@ page import="java.sql.*"%>


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
    }//userId
    
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
            <a class="navbar-brand" href="main.jsp">일정 관리 웹</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class=active><a href="bbs.jsp">전체 일정 보기</a></li>
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
                        <th style="background-color:#eeeeee; text-align:center;">내용</th>
                    </tr>
                </thead>
                <tbody><%-- 게시판목록 몸체 --%>
               
                    <% ResultSet rs;
                    Connection conn;
 
                      try{
                          String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                          String DB_USER="example_db_user";
                          String DB_PASSWORD="example_db_pass";
                          Class.forName("com.mysql.jdbc.Driver");
                          conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                         
                          String SQL= "SELECT * FROM duty ORDER BY date ASC";
                          PreparedStatement pstmt=conn.prepareStatement(SQL);
                            rs=pstmt.executeQuery();
                            while(rs.next())
                          { //title ,info, id, date, weight%>
                         <tr>
                            <% String title=rs.getString(1); %>
                            <td><%=rs.getString(4)%></td>
                            <td><a href='view.jsp?title=<%=URLEncoder.encode(title,"utf-8")%>'><%=title%></a></td>
                            <td><%=rs.getString(5)%></td>
                            <td><%=rs.getString(2)%></td>
                        </tr>
    
                          <%}
                        }catch(Exception e){
                        e.printStackTrace();
                        }%>
                       

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

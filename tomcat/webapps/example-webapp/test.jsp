<%@ page import="java.sql.*" contentType="text/html;charset=utf-8"%>
<%@ page import = "bbs.Bbs" %>
<%

  BbsDAO bbsDAO = new BbsDAO();
  String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&amp;autoReconnect=true&characterEncoding=utf8";
  String DB_USER="example_db_user";
  String DB_PASSWORD="example_db_pass";
 
  ResultSet rs;
  Connection conn;
  PreparedStatement pstmt;
  String sql = "SELECT * from user";
  try{
      Class.forName("com.mysql.jdbc.Driver");
      conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
      pstmt=conn.prepareStatement(sql);
      rs=pstmt.executeQuery();
      if(rs.next()){
         
          out.println(rs.getString(3));
          }
      else{ out.println("jojojojojo");}
     
     
     
      out.println("MYSQL CON SUC");
     
    }catch(Exception e){
    out.println(e);
    }
    
 %>

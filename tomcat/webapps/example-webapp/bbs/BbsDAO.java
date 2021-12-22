package bbs;

import bbs.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
//import java.time.*;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	private int pagenum;
	
	public BbsDAO() {
		try {
			String dbURL="jdbc:mysql://db:3306/example_db?useSSL=false&amp;autoReconnect=true&characterEncoding=utf8";
			String dbID="example_db_user";
			String dbPassword="example_db_user";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/*public int getNext() {
		String SQL= "SELECT date FROM duty ORDER BY date ASC";
		try {
			  PreparedStatement pstmt=conn.prepareStatement(SQL);
			  rs=pstmt.executeQuery();
			  if(rs.next()) {
				  System.out.println(rs.getString(getNext()));
			  }
			  return 1; 
		}catch(Exception e) {
			e.printStackTrace();
		}return -1;
	}*/
		
		
	public String getDate() {
		String SQL= "SELECT NOW()";
		try {
				 PreparedStatement pstmt=conn.prepareStatement(SQL);
				 rs=pstmt.executeQuery();
				 if(rs.next()) {
				     return rs.getString(1);
				 }

		}catch(Exception e) {
			e.printStackTrace();
		}return ""; 

	}
	
	public int writer(String title, String info, String userId, String date, String weight ) {
		String SQL= "Insert INTO duty VALUES (?,?,?,?,?)";
		try {
				 PreparedStatement pstmt=conn.prepareStatement(SQL);
				 pstmt.setString(1, title);
				 pstmt.setString(2, info);
				 pstmt.setString(3, userId);
				 pstmt.setString(4, date);
				 pstmt.setString(5, weight);
				 return pstmt.executeUpdate();
				 
			}catch(Exception e) {
				e.printStackTrace();
			}return -1; 

		}
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL= "SELECT * FROM duty ORDER BY date ASC";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			  PreparedStatement pstmt=conn.prepareStatement(SQL);
			  rs=pstmt.executeQuery();
			  while(rs.next())
			  {
				  //title ,info, id, date, weight
				  Bbs bbs = new Bbs();
				  bbs.setTitle(rs.getString(1));
				  bbs.setInfo(rs.getString(2));
				  bbs.setUserId(rs.getString(3));
				  bbs.setDate(rs.getString(4));
				  bbs.setWeight(rs.getString(5));
				  list.add(bbs);
			  }
		}catch(Exception e) {
			e.printStackTrace();
		}return list; //DB
	}
	
	public int getPageNum()
	{
		try{String SQL="SELECT COUNT(*) FROM duty";
		PreparedStatement pstmt=conn.prepareStatement(SQL);
		rs=pstmt.executeQuery();  
		pagenum=rs.getInt(1);
		return pagenum;
		
		}catch(Exception e) {
		e.printStackTrace();
	}return -1; //DB
	}
	
	public Bbs getBbs(String bbsTitle)
	{
		String SQL= "SELECT * FROM duty WHERE title = ?";
		
		try {
			  System.out.println(bbsTitle);
			  PreparedStatement pstmt=conn.prepareStatement(SQL);
			  pstmt.setString(1,bbsTitle);
			  rs=pstmt.executeQuery();
			  while(rs.next())
			  {
				  //title ,info, id, date, weight
				  Bbs bbs = new Bbs();
				  bbs.setTitle(rs.getString(1));
				  bbs.setInfo(rs.getString(2));
				  bbs.setUserId(rs.getString(3));
				  bbs.setDate(rs.getString(4));
				  bbs.setWeight(rs.getString(5));
				  return bbs;
			  }
		}catch(Exception e) {
			e.printStackTrace();
		}return null; //DB
	}
	
	public int update(String title, String date, String info, String weight)
	{
		String SQL= "UPDATE duty SET title = ?, date = ?, weight = ?, info = ? where title=?";
		try {
				 PreparedStatement pstmt=conn.prepareStatement(SQL);
				 pstmt.setString(1, title);
				 pstmt.setString(2, date);
				 pstmt.setString(3, weight);
				 pstmt.setString(4, info);
				 pstmt.setString(5, title);
				 return pstmt.executeUpdate();
				 
			}catch(Exception e) {
				e.printStackTrace();
			}return -1; 
	}
}

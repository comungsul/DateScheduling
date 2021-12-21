//실제로 DB에 접근하여 데이터를 넣고 빼고 하는 class
package bbs;

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
	
	public BbsDAO() { //db연결 객체 생성
		try {
			String dbURL="jdbc:mysql://localhost:3306/scheduling?useSSL=false&autoReconnection=true&characterEncoding=utf8";
			String dbID="root";
			String dbPassword="0603";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 일정 순서대로 받아오기
	/*public int getNext() {
		String SQL= "SELECT date FROM duty ORDER BY date ASC";
		try {
			  PreparedStatement pstmt=conn.prepareStatement(SQL);
			  rs=pstmt.executeQuery();
			  if(rs.next()) {
				  System.out.println(rs.getString(getNext()));
			  }
			  return 1; //첫 일정일 경우!!!(이부분을 날짜를 받아와야하나?)!!!!!
		}catch(Exception e) {
			e.printStackTrace();
		}return -1; //DB오류시 공백 출력
	}*/
		
		//현재 서버시간 받아오기
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
		}return ""; //DB오류시 공백 출력

	}
	//게시글 작성->db저장
	public int writer(String title, String info, String userId, String date, String weight ) {
		String SQL= "Insert INTO duty VALUES (?,?,?,?,?)";
		try {
				 PreparedStatement pstmt=conn.prepareStatement(SQL);
				 pstmt.setString(1, title);
				 pstmt.setString(2, info);
				 pstmt.setString(3, userId);
				 pstmt.setString(4, date);//작성시간x, 일정시간 
				 pstmt.setString(5, weight);
				 return pstmt.executeUpdate();//insert는 executeQuery대신 executeUpdate
				 
			}catch(Exception e) {
				e.printStackTrace();
			}return -1; //DB오류시 공백 출력

		}
	//일정순서대로 글 받아오기
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
		}return list; //DB오류시 공백 출력
	}
	
	public int getPageNum()//글의 총 개수
	{
		try{String SQL="SELECT COUNT(*) FROM duty";
		PreparedStatement pstmt=conn.prepareStatement(SQL);
		rs=pstmt.executeQuery();  
		pagenum=rs.getInt(1);
		return pagenum;
		
		}catch(Exception e) {
		e.printStackTrace();
	}return -1; //DB오류시 공백 출력
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
		}return null; //DB오류시 공백 출력
	}
	
	public int update(String title, String info, String date, String weight)
	{
		String SQL= "UPDATE duty SET title=?, info=?, date=?, weight=? where title=?;";
		try {
				 PreparedStatement pstmt=conn.prepareStatement(SQL);
				 pstmt.setString(1, title);
				 pstmt.setString(2, info);
				 pstmt.setString(3, date);//작성시간x, 일정시간 
				 pstmt.setString(4, weight);
				 pstmt.setString(5, title);
				 return pstmt.executeUpdate();//insert는 executeQuery대신 executeUpdate
				 
			}catch(Exception e) {
				e.printStackTrace();
			}return -1; //DB오류시 공백 출력
	}
	
	public int delete(String title)
	{
		String SQL= "DELETE FROM `duty` WHERE (`title` = ?);";
		try {
				 PreparedStatement pstmt=conn.prepareStatement(SQL);
				 pstmt.setString(1, title);
				 return pstmt.executeUpdate();//insert는 executeQuery대신 executeUpdate
				 
			}catch(Exception e) {
				e.printStackTrace();
			}return -1; //DB오류시 공백 출력
	}
	
	//public 
}
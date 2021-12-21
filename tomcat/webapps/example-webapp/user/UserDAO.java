package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL="jdbc:mysql://db:3306/example_db?useSSL=false&amp;autoReconnect=true&characterEncoding=utf8";
			String dbID="example_db_user";
			String dbPassword="example_db_pass";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int login(String userId, String userPw) {
		String SQL="SELECT userPw FROM user where userId=?";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userId); 
			rs=pstmt.executeQuery();
			if(rs.next()) { 
				if(rs.getString(1).equals(userPw)) {
					return 1;
				}
				else
					return 0;
			}
			return -1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	public int join(User user) {
		String SQL="INSERT INTO USER VALUES(?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getUserId());
			pstmt.setString(3, user.getUserPw());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}

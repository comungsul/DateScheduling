//실제로 DB에 접근하여 데이터를 넣고 빼고 하는 class
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
			String dbURL="jdbc:mysql://localhost:3306/scheduling?useSSL=false&autoReconnection=true&characterEncoding=utf8";
			String dbID="root";
			String dbPassword="0603";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}//매개변수로 넘어온 id, pw
	public int login(String userId, String userPw) {
		String SQL="SELECT userPw FROM user where userId=?";
		try {
			pstmt=conn.prepareStatement(SQL);//문장을 데이터 베이스에 삽입, 인스턴스 가져옴.
			pstmt.setString(1, userId); //위 sql문에 1번째 물음표에 id를 삽입하겠다.
			rs=pstmt.executeQuery();//실행 결과값 넣는곳
			if(rs.next()) { //실행결과가 있다면
				if(rs.getString(1).equals(userPw)) {//이 함수 매개로 받은 pw와 db조회 결과값이 같다면
					return 1;//로그인 성공
				}
				else
					return 0;//비번 불일치이
			}
			return -1;//실행결과가 없다면 ,아이디가 업슴
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //db오류
	}
	public int join(User user) {
		String SQL="INSERT INTO USER VALUES(?,?,?)";//insert 성공시, 0이상의 값을 줌
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getUserId());
			pstmt.setString(3, user.getUserPw());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
}

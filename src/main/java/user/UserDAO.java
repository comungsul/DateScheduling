//������ DB�� �����Ͽ� �����͸� �ְ� ���� �ϴ� class
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
	}//�Ű������� �Ѿ�� id, pw
	public int login(String userId, String userPw) {
		String SQL="SELECT userPw FROM user where userId=?";
		try {
			pstmt=conn.prepareStatement(SQL);//������ ������ ���̽��� ����, �ν��Ͻ� ������.
			pstmt.setString(1, userId); //�� sql���� 1��° ����ǥ�� id�� �����ϰڴ�.
			rs=pstmt.executeQuery();//���� ����� �ִ°�
			if(rs.next()) { //�������� �ִٸ�
				if(rs.getString(1).equals(userPw)) {//�� �Լ� �Ű��� ���� pw�� db��ȸ ������� ���ٸ�
					return 1;//�α��� ����
				}
				else
					return 0;//��� ����ġ��
			}
			return -1;//�������� ���ٸ� ,���̵� ����
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //db����
	}
	public int join(User user) {
		String SQL="INSERT INTO USER VALUES(?,?,?)";//insert ������, 0�̻��� ���� ��
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getUserId());
			pstmt.setString(3, user.getUserPw());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db����
	}
}

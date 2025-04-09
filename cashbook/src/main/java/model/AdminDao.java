package model;
import java.sql.*;

import dto.Admin;


public class AdminDao {
	//1. 로그인 체크 
	//매개 변수로 받은 adminId, adminPw를 기준으로 db에서 일치하는 정보를 조회
	public Admin selectAdminByIdPw(String adminId, String adminPw) throws ClassNotFoundException, SQLException {
	Admin admin = null;
	// 1) 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	// 2) db 연결
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
	// 3) sql 쿼리
	String sql = "SELECT admin_id, admin_pw FROM admin WHERE admin_id = ? AND admin_pw = ?";
	// 4) 쿼리 실행을 위한 준비
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, adminId);	// 아이디 ? 
	stmt.setString(2, adminPw);	// 비밀번호 ?
	// 5) 쿼리 실행
	ResultSet rs = stmt.executeQuery();
	
	// 6) 결과가 있으면 admin 생성 및 값 저장
	if(rs.next()) {
		admin = new Admin();
		admin.setAdminId(rs.getString("admin_id"));
		admin.setAdminPw(rs.getString("admin_pw"));
	}
	// 7) 자원 정리
	rs.close();
	stmt.close();
	conn.close();
	
	// 8) 결과 반환 
	return admin;
	}
	
	public int updateAdminPw(String adminId, String oldPw, String newPw) throws ClassNotFoundException, SQLException {
		int row = 0;
		
		// 1. JDBC 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

        // 2. SQL 준비 - 현재 비밀번호 일치하는 경우만 변경!
        String sql = "UPDATE admin SET admin_pw = ? WHERE admin_id = ? AND admin_pw = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, newPw);
        stmt.setString(2, adminId);
        stmt.setString(3, oldPw);

        // 3. 실행
        row = stmt.executeUpdate();

        // 4. 자원 정리
        stmt.close();
        conn.close();

        // 5. 결과 반환
        return row; // 1이면 성공, 0이면 실패
    }
}
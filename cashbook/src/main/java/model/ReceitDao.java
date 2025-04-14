package model;
import java.io.File;
import java.sql.*;
import dto.Receit;


public class ReceitDao {
	
	// 1) 영수증 등록
	public int insertReceit(int cashNo, String filename) throws ClassNotFoundException, SQLException {
		int row = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

        String sql = "INSERT INTO receit (cash_no, filename, createdate) VALUES (?, ?, NOW())";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, cashNo);
        stmt.setString(2, filename);
        
        row = stmt.executeUpdate();
        
        stmt.close();
        conn.close();
		return row;
        
	
	}

	// 2) 영수증 조회 ( cash 번호 기준으로 1개 조회)
	public Receit selectReceitByCashNo(int cashNo) throws ClassNotFoundException, SQLException {
		Receit r = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
        
        String sql ="select * from receit where cash_no = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, cashNo);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
        	r = new Receit();
        	r.setCashNo(rs.getInt("cash_no"));
        	r.setFilename(rs.getString("filename"));
        	r.setCreatedate(rs.getTimestamp("createdate").toLocalDateTime());
        }
        
        rs.close();
        stmt.close();
        conn.close();
		return r;
        
	}
	
	//3) 영수증 삭제
	public int deleteReceit(int cashNo, String uploadPath) throws ClassNotFoundException, SQLException {
	    int row = 0;

	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection(
	        "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    // 1. 파일명 조회
	    String selectSql = "SELECT filename FROM receit WHERE cash_no = ?";
	    PreparedStatement selectStmt = conn.prepareStatement(selectSql);
	    selectStmt.setInt(1, cashNo);
	    ResultSet rs = selectStmt.executeQuery();

	    String filename = null;
	    if (rs.next()) {
	        filename = rs.getString("filename");
	    }
	    rs.close();
	    selectStmt.close();

	    // 2. 파일 삭제
	    if (filename != null) {
	        File file = new File(uploadPath + File.separator + filename);
	        if (file.exists()) {
	            file.delete();
	        }
	    }

	    // 3. DB에서 삭제
	    String deleteSql = "DELETE FROM receit WHERE cash_no = ?";
	    PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
	    deleteStmt.setInt(1, cashNo);
	    row = deleteStmt.executeUpdate();

	    deleteStmt.close();
	    conn.close();
	    return row;
	}
}

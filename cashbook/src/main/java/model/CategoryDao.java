package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import dto.Category;

public class CategoryDao {
	// 1) 카테고리 목록 조회
	public ArrayList<Category> selectCategoryList() throws ClassNotFoundException, SQLException {
		ArrayList<Category> list = new ArrayList<>();
		// 1) 드라이버 로딩
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2) db 연결
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		String sql = "SELECT category_no categoryNo, kind, title, createdate FROM category ORDER BY category_no ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
	while(rs.next()) {
		Category c = new Category();
		c.setCategoryNo(rs.getInt("categoryNo"));
		c.setKind(rs.getString("kind"));
		c.setTitle(rs.getString("title"));
		
		Timestamp ts = rs.getTimestamp("createdate");
		if (ts != null) {
			c.setCreatedate(ts.toLocalDateTime());
		}
		list.add(c);
	}
		
	rs.close();
	stmt.close();
	conn.close();

	return list;
	}

	public int insertCategory(Category category) throws ClassNotFoundException, SQLException {
		int row = 0;
		
				// 1) 드라이버 로딩
				Class.forName("com.mysql.cj.jdbc.Driver");
				// 2) db 연결
				Connection conn = null;
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
				String sql = "INSERT INTO category(kind, title, createdate) VALUES(?, ?, NOW())";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1,category.getKind());
				stmt.setString(2, category.getTitle());
				
				row = stmt.executeUpdate();
				
				stmt.close();
				conn.close();
		
		return row;
		
	}
	
	public boolean hasCashData(int categoryNo) throws Exception {
		boolean result = false;

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		String sql = "SELECT COUNT(*) FROM cash WHERE category_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		ResultSet rs = stmt.executeQuery();

		if (rs.next() && rs.getInt(1) > 0) {
			result = true;
		}

		rs.close();
		stmt.close();
		conn.close();

		return result;
	}
	
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		String sql = "DELETE FROM category WHERE category_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);

		row = stmt.executeUpdate();

		stmt.close();
		conn.close();

		return row;
	}
}
	
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import dto.Category;

public class CategoryDao {
	// 1) 카테고리 목록 조회
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> list = new ArrayList<>();
		// 1) 드라이버 로딩
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2) db 연결
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		String sql = "SELECT category_no, kind, title, createdate FROM category ORDER BY category_no ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
	while(rs.next()) {
		Category c = new Category();
		c.setCategoryNo(rs.getInt("category_no"));
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
}

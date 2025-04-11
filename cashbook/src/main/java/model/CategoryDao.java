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
		String sql = "SELECT category_no categoryNo, kind, title, color createdate FROM category ORDER BY category_no ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
	while(rs.next()) {
		Category c = new Category();
		c.setCategoryNo(rs.getInt("categoryNo"));
		c.setKind(rs.getString("kind"));
		c.setTitle(rs.getString("title"));
		c.setColor(rs.getString("color")); // ✅ 색상 컬럼 처리
		
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

	public int updateCategoryTitle(int categoryNo, String title ) throws ClassNotFoundException, SQLException {
		int row = 0;

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		String sql = "update category set title = ? where category_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setInt(2, categoryNo);
		
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
		
	}
	
	public Category selectCategoryOne(int categoryNo) throws Exception {
	    Category category = null;
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "SELECT category_no, kind, title, color FROM category WHERE category_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, categoryNo);
	    ResultSet rs = stmt.executeQuery();

	    if (rs.next()) {
	        category = new Category();
	        category.setCategoryNo(rs.getInt("category_no"));
	        category.setKind(rs.getString("kind")); // 💡 kind 값 가져옴
	        category.setTitle(rs.getString("title"));
	        category.setColor(rs.getString("color"));
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    return category;
	}
	// ✅ 2. 페이징 + 검색 목록 조회
	public ArrayList<Category> selectCategoryListByPaging(String searchWord, int beginRow, int rowPerPage) throws Exception {
		ArrayList<Category> list = new ArrayList<>();

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		String sql;
		PreparedStatement stmt;

		// 검색어가 있을 경우
		if (searchWord != null && !searchWord.equals("")) {
			sql = "SELECT category_no, kind, title, createdate " +
			      "FROM category WHERE title LIKE ? " +
			      "ORDER BY category_no DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);

		} else {
			// 검색어 없을 경우
			sql = "SELECT category_no, kind, title, createdate " +
			      "FROM category ORDER BY category_no DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		}

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("category_no"));
			c.setKind(rs.getString("kind"));
			c.setTitle(rs.getString("title"));
			c.setCreatedate(rs.getTimestamp("createdate").toLocalDateTime());
			list.add(c);
		}

		rs.close();
		stmt.close();
		conn.close();

		return list;
	}
		// 전체 카테고리 수
	public int countCategory(String searchWord) throws Exception {

		int count = 0;

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		String sql = "SELECT COUNT(*) FROM category";
		if (searchWord != null && !searchWord.equals("")) {
			sql += " WHERE title LIKE ?";
		}

		PreparedStatement stmt = conn.prepareStatement(sql);

		if (searchWord != null && !searchWord.equals("")) {
			stmt.setString(1, "%" + searchWord + "%");
		}

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			count = rs.getInt(1);
		}

		rs.close();
		stmt.close();
		conn.close();

		return count;
	}

	public ArrayList<Category> selectCategoryListByKind(String kind) throws Exception {
		ArrayList<Category> list = new ArrayList<>();

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		String sql = "SELECT category_no, kind, title, color FROM category WHERE kind = ? ORDER BY category_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, kind);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("category_no"));
			c.setKind(rs.getString("kind"));
			c.setTitle(rs.getString("title"));
			c.setColor(rs.getString("color"));
			list.add(c);
		}
		rs.close(); stmt.close(); conn.close();
		return list;
	}
}	
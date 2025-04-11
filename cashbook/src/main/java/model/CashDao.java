package model;


import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Cash;
import dto.ReportData;

public class CashDao {
	public HashMap<Integer, Integer> getDailyTotalMap(int year, int month) throws ClassNotFoundException, SQLException {
		HashMap<Integer, Integer> map = new HashMap<>();

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		String sql = "SELECT DAY(cash_date) AS day, SUM(amount) AS total " +
		             "FROM cash " +
		             "WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ? " +
		             "GROUP BY DAY(cash_date)";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month); // 주의: month는 1~12

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			int day = rs.getInt("day");
			int total = rs.getInt("total");
			map.put(day, total);
		}

		rs.close();
		stmt.close();
		conn.close();

		return map;
	}
	
	public HashMap<Integer, ArrayList<Cash>> selectCashListByMonth(int year, int month) throws Exception {
		HashMap<Integer, ArrayList<Cash>> map = new HashMap<>();

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		String sql = "SELECT c.cash_no, c.memo, c.amount AS price, DAY(c.cash_date) AS day, " +
		             "ct.title AS category_title, ct.color " +
		             "FROM cash c " +
		             "INNER JOIN category ct ON c.category_no = ct.category_no " +
		             "WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? " +
		             "ORDER BY DAY(c.cash_date), c.amount DESC";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			int day = rs.getInt("day");

			Cash c = new Cash();
			c.setCashNo(rs.getInt("cash_no"));
			c.setMemo(rs.getString("memo"));
			int price = rs.getInt("price");
			c.setPrice(price);
			c.setKind(price >= 0 ? "수입" : "지출");
			c.setCategoryTitle(rs.getString("category_title"));
			c.setColor(rs.getString("color")); // ✅ color 설정

			if (!map.containsKey(day)) {
				map.put(day, new ArrayList<>());
			}
			map.get(day).add(c);
		}

		rs.close();
		stmt.close();
		conn.close();
		return map;
	}			
	
	public ArrayList<Cash> selectCashListByDate(int year, int month, int date) throws ClassNotFoundException, SQLException {
	    ArrayList<Cash> list = new ArrayList<>();
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection(
	        "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "SELECT c.cash_no, c.memo, c.amount, c.cash_date, ct.title AS category_title " +
	                 "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no " +
	                 "WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? " +
	                 "ORDER BY c.cash_no DESC";

	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, year);
	    stmt.setInt(2, month);
	    stmt.setInt(3, date);

	    ResultSet rs = stmt.executeQuery();
	    while (rs.next()) {
	        Cash c = new Cash();
	        c.setCashNo(rs.getInt("cash_no"));
	        c.setMemo(rs.getString("memo"));

	        int amount = rs.getInt("amount");
	        c.setPrice(amount);
	        c.setKind(amount >= 0 ? "수입" : "지출"); // 🔥 kind 값을 amount로 판단

	        c.setCategoryTitle(rs.getString("category_title"));
	        c.setCashDate(rs.getString("cash_date"));

	        list.add(c);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    return list;
	}
	public Cash selectCashOne(int cashNo) throws ClassNotFoundException, SQLException {
		Cash cash = null; 
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		String sql = "SELECT c.cash_no, c.memo, c.amount, c.cash_date, ct.title AS category_title " +
	             "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no " +
	             "WHERE c.cash_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cash = new Cash();
			cash.setCashNo(rs.getInt("cash_no"));
			cash.setMemo(rs.getString("memo"));
			int price = rs.getInt("amount");
			cash.setPrice(price);
			cash.setKind(price >= 0 ? "수입" : "지출");
			cash.setCashDate(rs.getString("cash_date"));
			cash.setCategoryTitle(rs.getString("category_title"));
		}

		rs.close();
		stmt.close();
		conn.close();

		return cash;
	}
	
	public int insertCash(String cashDate, int categoryNo, String memo, int amount) throws ClassNotFoundException, SQLException {
	    int row = 0;
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection(
	        "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "INSERT INTO cash (cash_date, category_no, memo, amount, createdate, updatedate) " +
	                 "VALUES (?, ?, ?, ?, NOW(), NOW())";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, cashDate);
	    stmt.setInt(2, categoryNo);
	    stmt.setString(3, memo);
	    stmt.setInt(4, amount);

	    row = stmt.executeUpdate();

	    stmt.close();
	    conn.close();
	    return row;
	}

	public int updateCash(int cashNo, String cashDate, int categoryNo, String memo, int price) throws ClassNotFoundException, SQLException {
	    int row = 0;
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "UPDATE cash SET cash_date = ?, category_no = ?, memo = ?, amount = ? WHERE cash_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, cashDate);
	    stmt.setInt(2, categoryNo);
	    stmt.setString(3, memo);
	    stmt.setInt(4, price);
	    stmt.setInt(5, cashNo);

	    row = stmt.executeUpdate();

	    stmt.close();
	    conn.close();
	    return row;
	}

	public int deleteCash(int cashNo) throws ClassNotFoundException, SQLException {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "DELETE FROM cash WHERE cash_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, cashNo);
	    
	    int row = stmt.executeUpdate();
	    
	    stmt.close();
	    conn.close();
		return row;
	}

	// 📌 월별 카테고리별 합계
	public ArrayList<ReportData> getMonthlyCategoryUsage(int year, int month) throws Exception {
	    ArrayList<ReportData> list = new ArrayList<>();

	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = """
	        SELECT c.kind, c.title, c.color, SUM(cs.price) total
	        FROM category c
	        INNER JOIN cash cs ON c.category_no = cs.category_no
	        WHERE YEAR(cs.cash_date) = ? AND MONTH(cs.cash_date) = ?
	        GROUP BY c.category_no
	        ORDER BY FIELD(c.kind, '지출', '수입'), c.category_no
	    """;

	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, year);
	    stmt.setInt(2, month);
	    ResultSet rs = stmt.executeQuery();

	    while (rs.next()) {
	        ReportData r = new ReportData();
	        r.setKind(rs.getString("kind"));
	        r.setTitle(rs.getString("title"));
	        r.setColor(rs.getString("color"));
	        r.setTotal(rs.getInt("total"));
	        list.add(r);
	    }

	    conn.close();
	    return list;
	}

	// 예시: 월별 수입/지출 요약을 리턴하는 메서드
	public ArrayList<ReportData> getTotalStats(int year, int month) throws Exception {
	    ArrayList<ReportData> list = new ArrayList<>();

	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = """
	        SELECT ct.kind, ct.title, ct.color, SUM(ca.amount) AS total
	        FROM cash ca
	        INNER JOIN category ct ON ca.category_no = ct.category_no
	        WHERE YEAR(ca.cash_date) = ? AND MONTH(ca.cash_date) = ?
	        GROUP BY ca.category_no
	        ORDER BY FIELD(ct.kind, '지출', '수입'), ct.category_no
	    """;

	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, year);
	    stmt.setInt(2, month);
	    ResultSet rs = stmt.executeQuery();

	    while (rs.next()) {
	        ReportData rd = new ReportData();
	        rd.setKind(rs.getString("kind"));
	        rd.setTitle(rs.getString("title"));
	        rd.setColor(rs.getString("color"));
	        rd.setTotal(rs.getInt("total"));
	        list.add(rd);
	    }

	    conn.close();
	    return list;
	}

	public int insertCashWithFile(String cashDate, int categoryNo, String memo, int amount, String filename) throws ClassNotFoundException, SQLException {
	    int row = 0;
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection(
	        "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "INSERT INTO cash (cash_date, category_no, memo, amount, filename, createdate, updatedate) " +
	                 "VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, cashDate);
	    stmt.setInt(2, categoryNo);
	    stmt.setString(3, memo);
	    stmt.setInt(4, amount);
	    stmt.setString(5, filename);

	    row = stmt.executeUpdate();

	    stmt.close();
	    conn.close();
	    return row;
	}

	// cash 테이블에 insert 후 생성된 pk를 반환
	public int insertCashAndReturnKey(String cashDate, int categoryNo, String memo, int amount) throws SQLException {
	    int cashNo = 0;
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "INSERT INTO cash (cash_date, category_no, memo, amount, createdate, updatedate) " +
	                 "VALUES (?, ?, ?, ?, NOW(), NOW())";

	    PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	    stmt.setString(1, cashDate);
	    stmt.setInt(2, categoryNo);
	    stmt.setString(3, memo);
	    stmt.setInt(4, amount);

	    stmt.executeUpdate();
	    ResultSet rs = stmt.getGeneratedKeys();
	    if (rs.next()) {
	        cashNo = rs.getInt(1);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();

	    return cashNo;
	} 
	    
}	
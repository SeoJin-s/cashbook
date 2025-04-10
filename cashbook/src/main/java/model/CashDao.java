package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Cash;

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
		             "ct.title AS category_title " +
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

			// ✅ 카테고리 제목이 꼭 들어가야 함!
			c.setCategoryTitle(rs.getString("category_title"));

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
}
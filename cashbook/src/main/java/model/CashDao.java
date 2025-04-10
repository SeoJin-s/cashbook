package model;

import java.sql.*;
import java.util.HashMap;

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
}

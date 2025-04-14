package model;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.ReportData;

public class ReportDao {

    // 1. 전체 수입/지출 통계
    public ArrayList<ReportData> getTotalStats() throws ClassNotFoundException, SQLException {
        ArrayList<ReportData> list = new ArrayList<>();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
        String sql = "SELECT ct.kind, COUNT(*) cnt, SUM(cs.amount) total " +
                     "FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no " +
                     "GROUP BY ct.kind";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            ReportData r = new ReportData();
            r.setKind(rs.getString("kind"));
            r.setCount(rs.getInt("cnt"));
            r.setTotal(rs.getInt("total"));
            list.add(r);
        }

        rs.close();
        stmt.close();
        conn.close();
        return list;
    }

    // 2. 연도별 수입/지출 통계
    public ArrayList<ReportData> getStatsByYear() throws ClassNotFoundException, SQLException {
        ArrayList<ReportData> list = new ArrayList<>();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
        String sql = "SELECT YEAR(cs.cash_date) y, ct.kind, COUNT(*) cnt, SUM(cs.amount) total " +
                     "FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no " +
                     "GROUP BY YEAR(cs.cash_date), ct.kind ORDER BY y";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            ReportData r = new ReportData();
            r.setYear(rs.getInt("y"));
            r.setKind(rs.getString("kind"));
            r.setCount(rs.getInt("cnt"));
            r.setTotal(rs.getInt("total"));
            list.add(r);
        }

        rs.close();
        stmt.close();
        conn.close();
        return list;
    }

    // 3. 월별 수입/지출 통계
    public ArrayList<ReportData> getStatsByMonth() throws ClassNotFoundException, SQLException {
        ArrayList<ReportData> list = new ArrayList<>();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
        String sql = "SELECT MONTH(cs.cash_date) m, ct.kind, COUNT(*) cnt, SUM(cs.amount) total " +
                     "FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no " +
                     "GROUP BY MONTH(cs.cash_date), ct.kind ORDER BY m";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            ReportData r = new ReportData();
            r.setMonth(rs.getInt("m"));
            r.setKind(rs.getString("kind"));
            r.setCount(rs.getInt("cnt"));
            r.setTotal(rs.getInt("total"));
            list.add(r);
        }

        rs.close();
        stmt.close();
        conn.close();
        return list;
    }

    // 4. 특정년도 월별 수입/지출 통계
    public ArrayList<ReportData> getStatsByYearMonth(int year) throws ClassNotFoundException, SQLException {
        ArrayList<ReportData> list = new ArrayList<>();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
        String sql = "SELECT ? y, MONTH(cs.cash_date) m, ct.kind, COUNT(*) cnt, SUM(cs.amount) total " +
                     "FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no " +
                     "WHERE YEAR(cs.cash_date) = ? " +
                     "GROUP BY MONTH(cs.cash_date), ct.kind ORDER BY m";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, year);
        stmt.setInt(2, year);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            ReportData r = new ReportData();
            r.setYear(rs.getInt("y"));
            r.setMonth(rs.getInt("m"));
            r.setKind(rs.getString("kind"));
            r.setCount(rs.getInt("cnt"));
            r.setTotal(rs.getInt("total"));
            list.add(r);
        }

        rs.close();
        stmt.close();
        conn.close();
        return list;
    }
}

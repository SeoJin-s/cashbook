<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }

    String loginAdmin = (String) session.getAttribute("loginAdmin");

    Calendar cal = Calendar.getInstance();
    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH);

    if (request.getParameter("year") != null) {
        year = Integer.parseInt(request.getParameter("year"));
    }
    if (request.getParameter("month") != null) {
        month = Integer.parseInt(request.getParameter("month"));
    }

    CashDao cashDao = new CashDao();
    ArrayList<ReportData> usageList = cashDao.getTotalStats(year, month + 1);

    int totalIncome = 0, totalExpense = 0;
    List<ReportData> chartList = new ArrayList<>();
    for (ReportData r : usageList) {
        if (r.getTotal() != 0) {
            if ("지출".equals(r.getKind())) {
                r.setTotal(Math.abs(r.getTotal()));
                totalExpense += Math.abs(r.getTotal());
            } else if ("수입".equals(r.getKind())) {
                totalIncome += r.getTotal();
            }
            chartList.add(r);
        }
    }

    ReportDao dao = new ReportDao();
    ArrayList<ReportData> totalList = dao.getTotalStats();
    ArrayList<ReportData> yearList = dao.getStatsByYear();
    int selectedYear = Calendar.getInstance().get(Calendar.YEAR);
    if (request.getParameter("year") != null) {
        selectedYear = Integer.parseInt(request.getParameter("year"));
    }
    ArrayList<ReportData> yearMonthList = dao.getStatsByYearMonth(selectedYear);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f5f5f5;
        font-family: 'Pretendard', sans-serif;
        padding: 40px;
    }
    .section {
        background-color: #fff;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        padding: 30px;
        margin-bottom: 40px;
    }
    h2 {
        font-weight: 800;
        font-size: 1.6rem;
        color: #3c7ee6;
        margin-bottom: 20px;
        border-bottom: 2px solid #e0e0e0;
        padding-bottom: 10px;
    }
    .table th {
        background-color: #f1f3f5;
        color: #333;
    }
</style>
</head>
<body>
<div class="section">
        <h2>년도별 수입/지출 통계</h2>
        <table class="table table-bordered text-center">
            <thead class="table-secondary">
                <tr><th>연도</th><th>분류</th><th>건수</th><th>총액</th></tr>
            </thead>
            <tbody>
                <% for (ReportData r : yearList) { %>
                    <tr>
                        <td><%= r.getYear() %></td>
                        <td><%= r.getKind() %></td>
                        <td><%= r.getCount() %></td>
                        <td><%= String.format("%,d", r.getTotal()) %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    </div>
    <div class="text-center mt-4">
        <a href="totalset.jsp" class="btn btn-outline-secondary">
            ← 돌아가기
        </a>
    </div>
</body>
</html>
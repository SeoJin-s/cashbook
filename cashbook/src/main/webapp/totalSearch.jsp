<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }

    String loginAdmin = (String) session.getAttribute("loginAdmin");
    int selectedYear = Calendar.getInstance().get(Calendar.YEAR);
    if (request.getParameter("year") != null) {
        selectedYear = Integer.parseInt(request.getParameter("year"));
    }

    ReportDao dao = new ReportDao();
    ArrayList<ReportData> yearMonthList = dao.getStatsByYearMonth(selectedYear);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= selectedYear %>년 월별 통계</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Pretendard', sans-serif;
            padding: 40px;
        }

        .container-box {
            background-color: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        h2 {
            color: #3c7ee6;
            font-weight: 800;
            font-size: 1.6rem;
            margin-bottom: 30px;
        }

        .table th {
            background-color: #e0e0e0;
        }

        .btn-blue {
            background-color: #3c7ee6;
            color: white;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="container container-box">
    <h2><%= selectedYear %>년 월별 수입/지출 통계</h2>

    <form method="get" class="row g-3 align-items-center mb-4">
        <div class="col-auto">
            <input type="number" name="year" class="form-control" value="<%= selectedYear %>" required>
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-blue">조회</button>
        </div>
    </form>

    <table class="table table-bordered text-center">
        <thead>
            <tr>
                <th>월</th>
                <th>분류</th>
                <th>건수</th>
                <th>총액</th>
            </tr>
        </thead>
        <tbody>
            <% for (ReportData r : yearMonthList) { %>
                <tr>
                    <td><%= r.getMonth() %>월</td>
                    <td><%= r.getKind() %></td>
                    <td><%= r.getCount() %></td>
                    <td><%= String.format("%,d", r.getTotal()) %> 원</td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <div class="text-end mt-4">
        <a href="totalset.jsp" class="btn btn-outline-secondary">
            ← 돌아가기
        </a>
    </div>
</div>

</body>
</html>
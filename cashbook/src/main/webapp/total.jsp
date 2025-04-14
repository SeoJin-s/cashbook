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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가계부 통계</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Pretendard', sans-serif;
            padding: 40px;
        }
        h2, h4 {
            margin-bottom: 30px;
            font-weight: bold;
            color: #3c7ee6;
        }
        .summary-box {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
            margin-bottom: 40px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }
        canvas {
            max-width: 100%;
        }
        .text-end a {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="summary-box">
    <h4><%= year %>년 <%= month + 1 %>월 통계</h4>
    <div class="mb-2"><strong>INCOME.</strong> <span class="text-success fw-bold">₩ <%= String.format("%,d", totalIncome) %></span></div>
    <div class="mb-2"><strong>EXPENSES.</strong> <span class="text-danger fw-bold">₩ <%= String.format("%,d", totalExpense) %></span></div>
    <div class="mb-4"><strong>BANK BALANCE.</strong> <span class="fw-bold">₩ <%= String.format("%,d", totalIncome - totalExpense) %></span></div>

    <canvas id="expenseChart" width="400" height="400"></canvas>

</div>

<script>
const labels = [
    <% for (int i = 0; i < chartList.size(); i++) { %>
        "<%= chartList.get(i).getTitle() %>"<%= (i < chartList.size() - 1) ? "," : "" %>
    <% } %>
];

const data = [
    <% for (int i = 0; i < chartList.size(); i++) { %>
        <%= chartList.get(i).getTotal() %><%= (i < chartList.size() - 1) ? "," : "" %>
    <% } %>
];

const backgroundColor = [
    <% for (int i = 0; i < chartList.size(); i++) { %>
        "<%= chartList.get(i).getColor() %>"<%= (i < chartList.size() - 1) ? "," : "" %>
    <% } %>
];
const config = {
    type: 'pie',
    data: {
        labels: labels,
        datasets: [{
            data: data,
            backgroundColor: backgroundColor,
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { position: 'bottom' },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        let label = context.label || '';
                        let value = context.parsed;
                        return label + ": ₩ " + value.toLocaleString();
                    }
                }
            }
        }
    }
};

window.addEventListener('DOMContentLoaded', () => {
    const ctx = document.getElementById('expenseChart').getContext('2d');
    new Chart(ctx, config);
});
</script>
<div class="d-flex justify-content-center gap-3 mt-4">
    <a href="totalset.jsp" class="btn btn-primary">
        <i class="bi bi-bar-chart-line-fill me-1"></i> 통계
    </a>
    <a href="monthList.jsp" class="btn btn-primary">
        <i class="bi bi-calendar3 me-1"></i> 달력으로
    </a>
</div>
</body>
</html>

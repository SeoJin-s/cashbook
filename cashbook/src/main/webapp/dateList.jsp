<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
    // 로그인 확인
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }
    String loginAdmin = (String) session.getAttribute("loginAdmin");

    // 파라미터 요청  
    int year = Integer.parseInt(request.getParameter("year"));
    int month = Integer.parseInt(request.getParameter("month"));
    int date = Integer.parseInt(request.getParameter("date"));

    CashDao dao = new CashDao();
    ArrayList<Cash> list = dao.selectCashListByDate(year, month, date);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= year %>년 <%= month %>월 <%= date %>일 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <h3><%= year %>년 <%= month %>월 <%= date %>일 가계부 내역</h3>
    <hr>
    <table class="table table-bordered text-center">
        <thead class="table-secondary">
            <tr>
                <th>분류</th>
                <th>카테고리</th>
                <th>메모</th>
                <th>금액</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
		    <% 
		    int totalIncome = 0, totalExpense = 0;
		    for (Cash c : list) { 
		        String kindClass = "수입".equals(c.getKind()) ? "text-success" : "text-danger";
		        if (c.getPrice() >= 0) {
		            totalIncome += c.getPrice();
		        } else {
		            totalExpense += Math.abs(c.getPrice()); // 지출은 절댓값으로 처리
		        }
		    %>
		    <tr>
		        <td class="<%= kindClass %> fw-bold"><%= c.getKind() %></td> <!-- 여기서 kind 값을 출력 -->
		        <td><%= c.getCategoryTitle() %></td>
		        <td><%= c.getMemo() %></td>
		        <td><%= String.format("￦ %,d", c.getPrice()) %></td>
		        <td>
		            <a href="cashOne.jsp?cashNo=<%= c.getCashNo() %>" class="btn btn-sm btn-outline-primary">상세</a>
		        </td>
		    </tr>
		    <% } %>
</tbody>
    </table>

    <!-- 합계 -->
    <div class="mt-3">
        <p>총 수입: <strong class="text-success">￦ <%= String.format("%,d", totalIncome) %></strong></p>
        <p>총 지출: <strong class="text-danger">￦ <%= String.format("%,d", totalExpense) %></strong></p>
    </div>

    <!-- 이전 달로 이동 -->
    <a href="monthList.jsp?year=<%= year %>&month=<%= month == 1 ? 12 : month - 1 %>" class="btn btn-secondary mt-3">
        달력으로 돌아가기
    </a>
</div>
</body>
</html>
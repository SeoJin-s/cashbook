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
    <style>
     body {
      background-color: #fff;
      font-family: 'Segoe UI', sans-serif;
      color: #222;
    }

        .container {
            background-color: rgba(255, 255, 255, 0.85);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            margin-top: 60px;
        }

        h3 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 30px;
        }

        table {
            background-color: #fffde7;
            border: 2px solid #ccc;
        }

        th {
            background-color: #fff176 !important;
        }

        .btn-secondary {
            background-color: #ffd54f;
            border: none;
            color: #333;
        }

        .btn-secondary:hover {
            background-color: #ffca28;
            color: #111;
        }

        .modal-content {
            background-color: #fff;
        }
    </style>
</head>
<body>
<div class="container">
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
                <th>영수증</th>
            </tr>
        </thead>
        <tbody>
        <% ReceitDao receitDao = new ReceitDao(); int totalIncome = 0, totalExpense = 0;
            for (Cash c : list) {
                String kindClass = "수입".equals(c.getKind()) ? "text-success" : "text-danger";
                if (c.getPrice() >= 0) {
                    totalIncome += c.getPrice();
                } else {
                    totalExpense += Math.abs(c.getPrice());
                }
                Receit r = receitDao.selectReceitByCashNo(c.getCashNo());
        %>
        <tr>
            <td class="<%= kindClass %> fw-bold"><%= c.getKind() %></td>
            <td><%= c.getCategoryTitle() %></td>
            <td><%= c.getMemo() %></td>
            <td><%= String.format("￦ %,d", c.getPrice()) %></td>
            <td>
                <a href="cashOne.jsp?cashNo=<%= c.getCashNo() %>" class="btn btn-sm btn-outline-primary">상세</a>
            </td>
            <td>
                <% if (r != null && r.getFilename() != null && !r.getFilename().equals("")) { %>
                    <img src="<%= request.getContextPath() %>/upload/<%= r.getFilename() %>"
                         style="width:80px; cursor:pointer;"
                         data-bs-toggle="modal"
                         data-bs-target="#modal<%= c.getCashNo() %>">
                    <!-- 모달 -->
                    <div class="modal fade" id="modal<%= c.getCashNo() %>" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content">
                                <div class="modal-body text-center">
                                    <img src="<%= request.getContextPath() %>/upload/<%= r.getFilename() %>" style="width:100%; height:auto;">
                                </div>
                            </div>
                        </div>
                    </div>
                <% } else { %>
                    없음
                <% } %>
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
        ← 달력으로 돌아가기
    </a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

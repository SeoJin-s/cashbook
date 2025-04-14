<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
	String loginAdmin = (String) session.getAttribute("loginAdmin");

	int cashNo = Integer.parseInt(request.getParameter("cashNo"));

	CashDao dao = new CashDao();
	Cash cash = dao.selectCashOne(cashNo);

	if (cash == null) {
		out.println("<h4>존재하지 않는 항목입니다.</h4>");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Cash 상세 보기</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<style>
    body {
      background-color: #fff;
      font-family: 'Segoe UI', sans-serif;
      color: #222;
    }

		.container {
			background-color: rgba(255, 255, 255, 0.8);
			padding: 30px;
			margin-top: 60px;
			border-radius: 16px;
			box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
			max-width: 700px;
		}

		h3 {
			text-align: center;
			font-weight: 700;
			color: #d32f2f;
			margin-bottom: 30px;
		}

		.table {
			background-color: #fff;
			border-radius: 12px;
			overflow: hidden;
		}

		.table th {
			background-color: #ffecb3;
			color: #5d4037;
			width: 30%;
		}

		.table td {
			background-color: #fff;
			color: #333;
		}

		.btn-group a {
			margin: 5px 8px;
		}

		.btn-outline-primary, .btn-outline-danger, .btn-secondary {
			border-radius: 10px;
			font-weight: 500;
		}
	</style>
</head>
<body>
<div class="container">
	<h3><%= cash.getCashDate() %> - <%= cash.getKind() %> 상세</h3>

	<table class="table table-bordered">
		<tr>
			<th>카테고리</th>
			<td><%= cash.getCategoryTitle() %></td>
		</tr>
		<tr>
			<th>금액</th>
			<td class="<%= cash.getPrice() >= 0 ? "text-success" : "text-danger" %> fw-bold">
				￦ <%= String.format("%,d", cash.getPrice()) %>
			</td>
		</tr>
		<tr>
			<th>메모</th>
			<td><%= cash.getMemo() %></td>
		</tr>
	</table>

	<div class="text-center mt-4 btn-group">
		<a href="insertReceitForm.jsp?cashNo=<%= cash.getCashNo() %>" class="btn btn-sm btn-outline-primary">
			<i class="bi bi-paperclip"></i> 영수증 첨부
		</a>
		<a href="deleteReceit.jsp?cashNo=<%= cash.getCashNo() %>" 
		   onclick="return confirm('정말 영수증을 삭제하시겠습니까?');"
		   class="btn btn-sm btn-outline-danger">
			<i class="bi bi-trash3"></i> 영수증 삭제
		</a>
		<a href="updateCashForm.jsp?cashNo=<%= cash.getCashNo() %>" class="btn btn-outline-primary">
			<i class="bi bi-pencil-square"></i> 수정
		</a>
		<a href="deleteCash.jsp?cashNo=<%= cash.getCashNo() %>" class="btn btn-outline-danger"
		   onclick="return confirm('정말 삭제하시겠습니까?');">
			<i class="bi bi-x-circle"></i> 삭제
		</a>
		<a href="monthList.jsp" class="btn btn-secondary">
			<i class="bi bi-arrow-left-circle"></i> 돌아가기
		</a>
	</div>
</div>
</body>
</html>
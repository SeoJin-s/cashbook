<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// 로그인 확인
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
</head>
<body class="bg-light">
<div class="container mt-4">
	<h3><%= cash.getCashDate() %> - <%= cash.getKind() %> 상세</h3>
	<hr>
	<table class="table table-bordered w-50 mx-auto">
		<tr>
			<th class="table-secondary">카테고리</th>
			<td><%= cash.getCategoryTitle() %></td>
		</tr>
		<tr>
			<th class="table-secondary">금액</th>
			<td class="<%= cash.getPrice() >= 0 ? "text-success" : "text-danger" %>">
				<strong>￦ <%= String.format("%,d", cash.getPrice()) %></strong>
			</td>
		</tr>
		<tr>
			<th class="table-secondary">메모</th>
			<td><%= cash.getMemo() %></td>
		</tr>
	</table>

	<!-- 버튼 -->
	<div class="text-center mt-4">
			<a href="insertReceitForm.jsp?cashNo=<%= cash.getCashNo() %>" class="btn btn-sm btn-outline-primary">
    		<i class="bi bi-paperclip"></i> 영수증 첨부
			</a>
		<a href="updateCashForm.jsp?cashNo=<%= cash.getCashNo() %>" class="btn btn-outline-primary me-2">수정</a>
		<a href="deleteCash.jsp?cashNo=<%= cash.getCashNo() %>" class="btn btn-outline-danger"
		   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
		<a href="monthList.jsp" class="btn btn-secondary ms-2">돌아가기</a>
	</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Category" %>
<%@ page import="model.CategoryDao" %>
<%
	// 로그인 확인
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	// DAO 호출
	CategoryDao dao = new CategoryDao();
	ArrayList<Category> list = dao.selectCategoryList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>카테고리 목록</title>

	<!-- Pretendard Font -->
	<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">
	<!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Bootstrap Icons -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

	<style>
		body {
			background-color: #f5eee6;
			font-family: 'Pretendard', sans-serif;
		}

		.container-box {
			max-width: 900px;
			margin: 60px auto;
			background-color: #fffefc;
			padding: 40px;
			border-radius: 16px;
			box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05);
		}

		h2 {
			color: #5d4037;
			font-weight: 800;
			border-bottom: 3px solid #ffcc80;
			display: inline-block;
			padding-bottom: 8px;
			margin-bottom: 30px;
		}

		.table th {
			background-color: #fff8e1;
			color: #5d4037;
			text-align: center;
		}

		.table td {
			vertical-align: middle;
			text-align: center;
		}

		.btn-brown {
			background-color: #6d4c41;
			color: white;
			font-weight: 600;
			border-radius: 10px;
			box-shadow: 0 4px 10px rgba(109, 76, 65, 0.2);
			transition: all 0.2s ease-in-out;
		}

		.btn-brown:hover {
			background-color: #5d4037;
			transform: translateY(-2px);
			box-shadow: 0 6px 12px rgba(109, 76, 65, 0.3);
		}

		.btn-outline-success,
		.btn-outline-danger {
			font-weight: 600;
			border-radius: 8px;
		}

		.table td a {
			margin-right: 4px;
		}
	</style>
</head>
<body>

<div class="container-box">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h2 class="mb-0 d-flex align-items-center">
			<i class="bi bi-list-ul me-2 text-warning"></i>DIARY
		</h2>
		<div>
			<a href="insertCategoryForm.jsp" class="btn btn-brown me-2">
				<i class="bi bi-plus-circle me-1"></i> 추가
			</a>
		</div>
	</div>

	<table class="table table-bordered text-center mt-4">
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>제목</th>
				<th>생성일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (Category c : list) {
			%>
			<tr>
				<td><%=c.getCategoryNo()%></td>
				<td>
					<% if ("수입".equals(c.getKind())) { %>
						<span class="badge bg-primary">수입</span>
					<% } else if ("지출".equals(c.getKind())) { %>
						<span class="badge bg-danger">지출</span>
					<% } else { %>
						<%= c.getKind() %>
					<% } %>
				</td>
				<td><%= c.getTitle() %></td>
				<td><%= c.getCreatedate().toLocalDate() %></td>
				<td>
					<a href="deleteCategory.jsp?categoryNo=<%= c.getCategoryNo() %>"
					   class="btn btn-sm btn-outline-danger me-1"
					   onclick="return confirm('정말 삭제하시겠습니까?')">
						<i class="bi bi-trash"></i> 삭제
					</a>
					<a href="updateCategoryTitleForm.jsp?categoryNo=<%= c.getCategoryNo() %>"
					   class="btn btn-sm btn-outline-success">
						<i class="bi bi-pencil-square"></i> 수정
					</a>
				</td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</div>

</body>
</html>

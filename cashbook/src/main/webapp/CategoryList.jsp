<%@page import="java.util.Calendar"%>
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
		String loginAdmin = (String) session.getAttribute("loginAdmin"); // ✅ if 바깥으로 분리!
	
// 오늘 날짜 정보
	Calendar now = Calendar.getInstance();
	int thisYear = now.get(Calendar.YEAR);
	int thisMonth = now.get(Calendar.MONTH); // 0 ~ 11
	
	// 검색
	String searchWord = request.getParameter("searchWord");
	if (searchWord == null) searchWord = "";
	
	// 페이징
	int currentPage = 1;
	int rowPerPage = 10;

	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	int beginRow = (currentPage - 1) * rowPerPage;
	
	// DAO 호출
	CategoryDao dao = new CategoryDao();
	int totalRow = dao.countCategory(searchWord);
	int lastPage = (int)Math.ceil((double)totalRow / rowPerPage);
	ArrayList<Category> list = dao.selectCategoryListByPaging(searchWord, beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>LIST</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">
<style>
	body {
		background-color: #fbf5ef;
		font-family: 'Pretendard', sans-serif;
	}

	.container-box {
		max-width: 1000px;
		margin: 40px auto;
		background-color: #ffffff;
		padding: 40px;
		border-radius: 20px;
		box-shadow: 0 10px 30px rgba(139, 69, 19, 0.1);
	}

	h2 {
		color: #8b4513;
		font-weight: 800;
		border-bottom: 3px solid #d2b48c;
		display: inline-block;
		padding-bottom: 10px;
	}

	.table th {
		background-color: #e0ccb1;
		color: #8b4513;
	}

	.table td {
		vertical-align: middle;
		color: #5a3d1b;
	}

	.btn-brown {
		background-color: #8b4513;
		color: white;
		font-weight: 600;
		border-radius: 10px;
		box-shadow: 0 4px 12px rgba(139, 69, 19, 0.2);
		transition: all 0.2s ease-in-out;
	}

	.btn-brown:hover {
		background-color: #6a3210;
		transform: translateY(-2px);
		box-shadow: 0 6px 16px rgba(139, 69, 19, 0.3);
	}

	.btn-outline-success,
	.btn-outline-danger,
	.btn-outline-secondary {
		font-weight: 600;
		border-radius: 8px;
	}

	.form-control:focus {
		border-color: #d2b48c;
		box-shadow: 0 0 0 0.2rem rgba(210, 180, 140, 0.5);
	}

	.badge.bg-primary {
		background-color: #5f9ea0 !important;
	}

	.badge.bg-danger {
		background-color: #cd5c5c !important;
	}

	.page-link {
		color: #8b4513;
	}

	.page-item.active .page-link {
		background-color: #8b4513;
		border-color: #8b4513;
	}

	.page-link:hover {
		color: #6a3210;
	}

	.pagination .disabled .page-link {
		color: #d2b48c;
	}
</style>

</head>
<body>

<!-- 🔐 로그인 관리자 상단 표시 -->
<div class="container mt-3 mb-2">
	<div class="d-flex justify-content-between align-items-center">
		<span class="fw-semibold text-dark fs-5">
			<i class="bi bi-person-circle me-2"></i> <%= loginAdmin %> 님 환영합니다.
		</span>
		<div class="d-flex gap-2">
			<a href="/cashbook/logOut.jsp" class="btn btn-sm btn-outline-danger">
				<i class="bi bi-box-arrow-right me-1"></i> 로그아웃
			</a>
			<a href="/cashbook/index.jsp" class="btn btn-sm btn-outline-secondary">
				<i class="bi bi-house me-1"></i> 홈으로
			</a>
		</div>
	</div>
</div>

<!-- ✅ 본문 컨테이너 -->
<div class="container-box">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h2><i class="bi bi-journals me-2 text-warning"></i> LIST</h2>
		<a href="insertCategoryForm.jsp" class="btn btn-brown">
			<i class="bi bi-plus-circle me-1"></i> 추가
		</a>
	</div>

	<!-- 🔍 검색 -->
	<form method="get" action="CategoryList.jsp" class="mb-4">
		<div class="d-flex justify-content-center">
			<input type="text" name="searchWord" class="form-control w-50 me-2 rounded-3 shadow-sm"
				placeholder="제목으로 검색" value="<%= searchWord %>">
			<button type="submit" class="btn btn-outline-secondary rounded-3 fw-semibold">
				<i class="bi bi-search"></i> 검색
			</button>
		</div>
	</form>

	<!-- 📁 테이블 -->
	<table class="table table-bordered table-hover text-center align-middle">
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
			<% for (Category c : list) { %>
			<tr>
				<td><%= c.getCategoryNo() %></td>
				<td>
					<% if ("수입".equals(c.getKind())) { %>
						<span class="badge bg-primary">수입</span>
					<% } else { %>
						<span class="badge bg-danger">지출</span>
					<% } %>
				</td>
				<td><%= c.getTitle() %></td>
				<td><%= c.getCreatedate().toLocalDate() %></td>
				<td>
					<a href="updateCategoryTitleForm.jsp?categoryNo=<%= c.getCategoryNo() %>"
					   class="btn btn-sm btn-outline-success me-1">
						<i class="bi bi-pencil-square"></i> 수정
					</a>
					<a href="deleteCategory.jsp?categoryNo=<%= c.getCategoryNo() %>"
					   class="btn btn-sm btn-outline-danger"
					   onclick="return confirm('정말 삭제하시겠습니까?')">
						<i class="bi bi-trash"></i> 삭제
					</a>
				</td>
			</tr>
			<% } %>
		</tbody>
	</table>

	<!-- 📄 페이지네이션 -->
	<nav class="mt-4">
		<ul class="pagination justify-content-center">
			<li class="page-item <%= (currentPage == 1 ? "disabled" : "") %>">
				<a class="page-link" href="CategoryList.jsp?currentPage=<%= currentPage - 1 %>&searchWord=<%= searchWord %>">이전</a>
			</li>
			<% for (int i = 1; i <= lastPage; i++) { %>
				<li class="page-item <%= (i == currentPage ? "active" : "") %>">
					<a class="page-link" href="CategoryList.jsp?currentPage=<%= i %>&searchWord=<%= searchWord %>"><%= i %></a>
				</li>
			<% } %>
			<li class="page-item <%= (currentPage == lastPage ? "disabled" : "") %>">
				<a class="page-link" href="CategoryList.jsp?currentPage=<%= currentPage + 1 %>&searchWord=<%= searchWord %>">다음</a>
			</li>
		</ul>
	</nav>

<!-- 📆 월별 보기 (브라운톤 스타일) -->
<div class="text-center mt-4">
	<a href="monthList.jsp?year=<%= thisYear %>&month=<%= thisMonth %>" 
	   class="btn btn-brown px-4 py-2 rounded-pill shadow-sm">
		<i class="bi bi-journal-text me-2"></i> Calender
	</a>
</div>


</body>
</html>

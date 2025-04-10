<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Category" %>
<%@ page import="model.CategoryDao" %>
<%
	// 로그인 확인
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	// DAO 호출
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	CategoryDao dao = new CategoryDao();
	Category category = dao.selectCategoryOne(categoryNo); 
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<!-- Pretendard Font (둥글고 예쁜 글꼴) -->
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
	body {
		background-color: #f5eee6;
		font-family: 'Pretendard', 'Segoe UI', sans-serif;
		font-size: 1.05rem;
	}

	.container-box {
		max-width: 550px;
		margin: 100px auto;
		padding: 40px;
		background-color: #fffefc;
		border-radius: 16px;
		box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
	}

	h2 {
		text-align: center;
		color: #5d4037;
		font-weight: 800;
		margin-bottom: 30px;
		letter-spacing: 1px;
		border-bottom: 3px solid #ffcc80;
		display: inline-block;
		padding-bottom: 8px;
	}

	.table td, .table th {
		vertical-align: middle;
	}

	.table th {
		background-color: #fbe9e7;
		color: #4e342e;
		font-weight: 600;
	}

	.form-control {
		border-radius: 12px;
		font-size: 1.05rem;
	}

	.input-gradient {
		background: linear-gradient(135deg, #a1887f, #d7ccc8);
		color: #4e342e;
		border: none;
		border-radius: 12px;
		font-size: 1.05rem;
	}

	.input-gradient::placeholder {
		color: #6d4c41;
		opacity: 0.7;
	}

	.input-gradient:focus {
		background: linear-gradient(135deg, #a1887f, #d7ccc8);
		color: #3e2723;
		border: 2px solid #ffcc80;
		box-shadow: 0 0 0 0.2rem rgba(255, 204, 128, 0.3);
	}

	.btn-orange {
		background-color: #6d4c41;
		color: white;
		font-weight: 600;
		border-radius: 12px;
		font-size: 1.05rem;
		box-shadow: 0 4px 10px rgba(109, 76, 65, 0.3);
		transition: all 0.2s ease-in-out;
	}

	.btn-orange:hover {
		background-color: #fb8c00;
		box-shadow: 0 6px 14px rgba(251, 140, 0, 0.4);
		transform: translateY(-2px);
	}

	.alert {
		border-radius: 10px;
	}
</style>
</head>
<div class="container-box">
	<h2><i class="bi bi-pencil-square me-2 text-warning"></i>제목 수정</h2>
	
	<form action="/cashbook/updateCategoryTitleAction.jsp" method="post">
		<input type="hidden" name="categoryNo" value="<%= category.getCategoryNo() %>">

		<div class="mb-3">
			<label class="form-label">현재 제목</label>
			<input type="text" class="form-control" value="<%= category.getTitle() %>" readonly>
		</div>

		<div class="mb-3">
			<label class="form-label">새로운 제목</label>
			<input type="text" name="title" class="form-control" placeholder="새 제목 입력" required>
		</div>

		<div class="d-flex justify-content-between">
			<a href="/cashbook/CategoryList.jsp" class="btn btn-warning fw-semibold">
				<i class="bi bi-box-arrow-left me-1"></i> 목록으로
			</a>
			<button type="submit" class="btn btn-success fw-semibold">
				<i class="bi bi-check2-circle me-1"></i> 수정 완료
			</button>
		</div>
	</form>
</div>

</body>
</html>
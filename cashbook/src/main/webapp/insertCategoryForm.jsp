<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 확인
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>카테고리 추가</title>

	<!-- Pretendard Font -->
	<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Bootstrap Icons -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

	<style>
		body {
			background-color: #f5eee6;
			font-family: 'Pretendard', sans-serif;
		}
		.container-box {
			max-width: 550px;
			margin: 100px auto;
			background-color: #fffefc;
			padding: 40px;
			border-radius: 16px;
			box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05);
		}
		h2 {
			color: #5d4037;
			font-weight: 800;
			text-align: center;
			border-bottom: 3px solid #ffcc80;
			display: inline-block;
			padding-bottom: 10px;
			margin-bottom: 30px;
		}
		.form-label {
			font-weight: 600;
			color: #5d4037;
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
	</style>
</head>
<body>

<div class="container-box">
	<h2><i class="bi bi-plus-circle me-2 text-success"></i>내용추가</h2>

	<form action="insertCategoryAction.jsp" method="post">
		<div class="mb-3">
			<label class="form-label">구분</label>
			<select name="kind" class="form-select" required>
				<option value="">-- 선택 --</option>
				<option value="수입">수입</option>
				<option value="지출">지출</option>
			</select>
		</div>

		<div class="mb-3">
			<label class="form-label">제목</label>
			<input type="text" name="title" class="form-control" placeholder="카테고리 제목 입력" required>
		</div>

		<div class="d-grid">
			<button type="submit" class="btn btn-brown">
				<i class="bi bi-check-circle me-1"></i> 추가하기
			</button>
		</div>
	</form>
</div>

</body>
</html>
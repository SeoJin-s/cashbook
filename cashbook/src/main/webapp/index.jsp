<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String loginAdmin = (String) session.getAttribute("loginAdmin");
	if (loginAdmin == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cashbook 관리</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
	body {
		background-color: #f5eee6;
		font-family: 'Segoe UI', sans-serif;
	}

	.header-bar {
		max-width: 900px;
		margin: 20px auto 0;
		padding: 10px 20px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.index-container {
		max-width: 600px;
		margin: 40px auto;
		padding: 40px;
		background: #ffffff;
		border-radius: 18px;
		box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
		text-align: center;
	}

	h1 {
		font-size: 2rem;
		font-weight: 800;
		color: #4e342e;
		margin-bottom: 40px;
		letter-spacing: 1px;
		border-bottom: 3px solid #a1887f;
		display: inline-block;
		padding-bottom: 8px;
	}

	.btn-brown {
		background-color: #6d4c41;
		color: white;
		font-weight: 600;
		padding: 12px 20px;
		border-radius: 10px;
		box-shadow: 0 4px 12px rgba(109, 76, 65, 0.3);
		transition: all 0.2s ease-in-out;
		text-decoration: none;
	}

	.btn-brown:hover {
		background-color: #5d4037;
		box-shadow: 0 6px 16px rgba(109, 76, 65, 0.4);
		transform: translateY(-2px);
	}
</style>
</head>
<body>

	<!-- 🔐 상단 관리자 로그인 정보 -->
	<div class="header-bar">
		<div class="fw-semibold text-dark fs-5">
			<i class="bi bi-person-circle me-2"></i><%= loginAdmin %> 님
		</div>
		<a href="/cashbook/logout.jsp" class="btn btn-sm btn-outline-danger">
			<i class="bi bi-box-arrow-right"></i> 로그아웃
		</a>
	</div>

	<!-- 📦 메인 버튼 -->
	<div class="index-container">
		<h1>INVENTORY</h1>
		<div class="d-grid gap-3 mt-4">
			<a href="/cashbook/updateAdminPwForm.jsp" class="btn btn-brown">🔒 비밀번호 수정</a>
			<a href="/cashbook/CategoryList.jsp" class="btn btn-brown">📁 카테고리</a>
		</div>
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 로그인</title>

	<!-- Pretendard Font -->
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

		.login-container {
			max-width: 450px;
			margin: 100px auto;
			padding: 40px;
			background-color: #fffefc;
			border-radius: 16px;
			box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
		}

		h2 {
			text-align: center;
			font-weight: 800;
			color: #4e342e;
			letter-spacing: 1px;
			margin-bottom: 30px;
		}

		.title-box {
			display: inline-block;
			padding: 6px 20px;
			border-bottom: 3px solid #a1887f;
			box-shadow: 0 2px 5px rgba(0,0,0,0.05);
			border-radius: 8px;
			background-color: #fdfcf8;
		}

		.form-control {
			border-radius: 12px;
			font-size: 1.05rem;
		}

		.btn-brown {
			background-color: #6d4c41;
			color: white;
			font-weight: 600;
			border-radius: 12px;
			box-shadow: 0 4px 10px rgba(109, 76, 65, 0.3);
			transition: all 0.2s ease-in-out;
		}

		.btn-brown:hover {
			background-color: #5d4037;
			transform: translateY(-2px);
			box-shadow: 0 6px 14px rgba(109, 76, 65, 0.4);
		}

		.alert {
			border-radius: 12px;
			font-size: 0.95rem;
		}
	</style>
</head>
<body>

	<div class="login-container">
		<h2>
			<span class="title-box">BOOK</span>
		</h2>

		<% if ("1".equals(request.getParameter("error"))) { %>
			<div class="alert alert-danger text-center mt-3" role="alert">
				❌ 아이디 또는 비밀번호가 올바르지 않습니다.
			</div>
		<% } %>

		<form method="post" action="loginAction.jsp" class="mt-4">
			<div class="mb-3">
				<label for="adminId" class="form-label">아이디</label>
				<input type="text" id="adminId" name="adminId" class="form-control" required placeholder="아이디 입력">
			</div>

			<div class="mb-4">
				<label for="adminPw" class="form-label">비밀번호</label>
				<input type="password" id="adminPw" name="adminPw" class="form-control" required placeholder="비밀번호 입력">
			</div>

			<div class="d-grid">
				<button type="submit" class="btn btn-brown">
					<i class="bi bi-door-closed-fill me-1"></i> 로그인
				</button>
			</div>
		</form>
	</div>

</body>
</html>
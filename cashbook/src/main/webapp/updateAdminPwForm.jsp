<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
	String loginAdmin = (String) session.getAttribute("loginAdmin");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Pretendard -->
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<style>
	body {
		background-color: #fff;
		font-family: 'Pretendard', sans-serif;
		color: #111;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 40px 20px;
		min-height: 100vh;
	}
	.container-box {
		background-color: #f9f9f9;
		border-radius: 20px;
		padding: 40px;
		width: 100%;
		max-width: 500px;
		box-shadow: 0 8px 25px rgba(0, 0, 0, 0.05);
	}
	.section-header {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 10px;
		font-size: 1.5rem;
		font-weight: 700;
		color: #f32a3d;
		position: relative;
		padding-bottom: 12px;
		margin-bottom: 30px;
	}
	.section-header::after {
		content: "";
		height: 3px;
		width: 60px;
		background-color: #f32a3d;
		position: absolute;
		bottom: 0;
		left: 50%;
		transform: translateX(-50%);
		animation: slide-in 0.6s ease-out forwards;
		opacity: 0;
	}
	@keyframes slide-in {
		from {
			width: 0;
			opacity: 0;
		}
		to {
			width: 60px;
			opacity: 1;
		}
	}
	.section-header i {
		font-size: 1.6rem;
	}
	.form-label {
		font-weight: 600;
		color: #555;
	}
	.form-control {
		background-color: #fff;
		color: #111;
		border: 1px solid #ccc;
		border-radius: 8px;
	}
	.form-control:focus {
		border-color: #f32a3d;
		box-shadow: 0 0 0 0.2rem rgba(243, 42, 61, 0.25);
	}
	.btn-red {
		background-color: #f32a3d;
		color: white;
		font-weight: bold;
		border-radius: 8px;
		padding: 10px 18px;
		border: none;
		box-shadow: 0 4px 12px rgba(243, 42, 61, 0.3);
		transition: all 0.2s ease;
	}
	.btn-red:hover {
		background-color: #d7283a;
		box-shadow: 0 6px 16px rgba(243, 42, 61, 0.4);
		transform: translateY(-2px);
	}
	.alert {
		border-radius: 8px;
		font-size: 0.95rem;
	}
	.back-link {
		text-align: center;
		margin-top: 20px;
	}
	.back-link a {
		color: #666;
		text-decoration: none;
		font-size: 0.95rem;
	}
	.back-link a:hover {
		color: #000;
	}
</style>
</head>
<body>
<div class="container-box">
	<div class="section-header">
		<i class="bi bi-shield-lock-fill"></i>
		<span>비밀번호 변경</span>
	</div>

	<% if ("1".equals(request.getParameter("error"))) { %>
		<div class="alert alert-danger mt-2">❌ 현재 비밀번호가 일치하지 않습니다.</div>
	<% } else if ("success".equals(request.getParameter("result"))) { %>
		<div class="alert alert-success mt-2">✅ 비밀번호가 성공적으로 변경되었습니다.</div>
	<% } %>

	<form method="post" action="updateAdminPwAction.jsp" class="mt-4">
		<div class="mb-3">
			<label class="form-label">아이디</label>
			<input type="text" class="form-control" value="<%= loginAdmin %>" readonly>
		</div>
		<div class="mb-3">
			<label class="form-label">현재 비밀번호</label>
			<input type="password" name="oldPw" class="form-control" required placeholder="현재 비밀번호 입력">
		</div>
		<div class="mb-4">
			<label class="form-label">새 비밀번호</label>
			<input type="password" name="newPw" class="form-control" required placeholder="새 비밀번호 입력">
		</div>
		<div class="d-grid">
			<button type="submit" class="btn btn-red">
				<i class="bi bi-arrow-repeat me-1"></i> 비밀번호 변경
			</button>
		</div>
	</form>
	<div class="back-link">
		<a href="/cashbook/index.jsp">
			<i class="bi bi-arrow-left me-1"></i> 목록으로 돌아가기
		</a>
	</div>
</div>
</body>
</html>
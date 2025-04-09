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
<body>

<div class="container-box">
	<h2>비밀번호 변경</h2>

	<% if ("1".equals(request.getParameter("error"))) { %>
		<div class="alert alert-danger mt-3" role="alert">
			❌ 현재 비밀번호가 일치하지 않습니다.
		</div>
	<% } else if ("success".equals(request.getParameter("result"))) { %>
		<div class="alert alert-success mt-3" role="alert">
			✅ 비밀번호가 성공적으로 변경되었습니다.
		</div>
	<% } %>

	<form method="post" action="updateAdminPwAction.jsp" class="mt-4">
		<table class="table table-bordered">
			<tr>
				<th style="width: 35%;">아이디</th>
				<td><%= loginAdmin %></td>
			</tr>
			<tr>
				<th>현재 비밀번호</th>
				<td>
					<input type="password" name="oldPw" class="form-control input-gradient" required placeholder="현재 비밀번호 입력">
				</td>
			</tr>
			<tr>
				<th>새 비밀번호</th>
				<td>
					<input type="password" name="newPw" class="form-control input-gradient" required placeholder="새 비밀번호 입력">
				</td>
			</tr>
		</table>

		<div class="text-center mt-4">
			<button type="submit" class="btn btn-orange px-4">
				<i class="bi bi-arrow-repeat me-1"></i> 비밀번호 변경
			</button>
		</div>
	</form>
</div>

</body>
</html>

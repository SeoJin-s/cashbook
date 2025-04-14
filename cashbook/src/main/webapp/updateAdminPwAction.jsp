<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String loginAdmin = (String) session.getAttribute("loginAdmin");
	if (loginAdmin == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");

	AdminDao dao = new AdminDao();
	int row = dao.updateAdminPw(loginAdmin, oldPw, newPw);

	if (row == 1) {
		session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경 성공</title>
	<meta http-equiv="refresh" content="1;url=/cashbook/loginForm.jsp">

	<!-- Pretendard 폰트 -->
	<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">
	<!-- Bootstrap Icons -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

	<style>
		body {
			background-color: #ffffff;
			font-family: 'Pretendard', 'Segoe UI', sans-serif;
			display: flex;
			align-items: center;
			justify-content: center;
			height: 100vh;
			margin: 0;
		}

		.message-box {
			background-color: #fff;
			padding: 40px;
			border-radius: 16px;
			box-shadow: 0 8px 24px rgba(0, 0, 0, 0.06);
			text-align: center;
			border-top: 6px solid #f32a3d;
		}

		h2 {
			color: #f32a3d;
			font-weight: 800;
			margin-bottom: 15px;
		}

		p {
			color: #333;
			font-size: 1.05rem;
		}

		.icon-success {
			font-size: 40px;
			color: #f32a3d;
			margin-bottom: 10px;
		}
	</style>
</head>
<body>
	<div class="message-box">
		<div class="icon-success">
			<i class="bi bi-check-circle-fill"></i>
		</div>
		<h2>비밀번호 변경 완료</h2>
		<p>1초 후 로그인 페이지로 이동합니다...</p>
	</div>
</body>
</html>
<%
	} else {
		response.sendRedirect("updateAdminPwForm.jsp?error=1");
	}
%>
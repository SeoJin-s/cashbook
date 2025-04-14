<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
	<title>Cashbook 홈</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<style>
		body, html {
			height: 100%;
			margin: 0;
			padding: 0;
			background-color: #fff;
			color: #111;
			font-family: 'Pretendard', sans-serif;
		}

		.top-bar {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 15px 20px;
			background-color: #f1f1f1;
			border-bottom: 1px solid #ccc;
		}

		.center-wrapper {
			display: flex;
			justify-content: center;
			align-items: center;
			height: calc(100vh - 70px); /* 상단바 제외 */
		}

		.icon-grid {
			display: grid;
			grid-template-columns: repeat(2, 140px);
			gap: 24px;
			text-align: center;
		}

		.menu-btn {
			padding: 25px 10px;
			border-radius: 12px;
			text-decoration: none;
			font-weight: bold;
			transition: all 0.2s ease-in-out;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
			font-size: 1rem;
			border: 2px solid transparent;
		}

		.menu-btn i {
			font-size: 1.6rem;
			display: block;
			margin-bottom: 8px;
		}

		.menu-btn.red {
			background-color: #f32a3d;
			color: white;
			border-color: #e04848;
		}
		.menu-btn.green {
			background-color: #4caf50;
			color: white;
			border-color: #3d9442;
		}
		.menu-btn.yellow {
			background-color: #FFD600;
			color: #111;
			border-color: #e0c000;
		}
		.menu-btn.blue {
			background-color: #4d90fe;
			color: white;
			border-color: #3c7ee6;
		}

		.menu-btn:hover {
			transform: translateY(-4px);
			box-shadow: 0 8px 16px rgba(0,0,0,0.15);
		}
	</style>
</head>
<body>

<!-- 🔐 상단 로그인 상태 -->
<div class="top-bar">
	<div>
		<i class="bi bi-person-circle me-2"></i><%= loginAdmin %> 님
	</div>
	<a href="/cashbook/logOut.jsp" class="btn btn-sm btn-outline-dark">
		<i class="bi bi-box-arrow-right"></i> 로그아웃
	</a>
</div>

<!-- 🧩 메뉴 중앙 정렬 -->
<div class="center-wrapper">
	<div class="icon-grid">
		<a href="/cashbook/updateAdminPwForm.jsp" class="menu-btn red">
			<i class="bi bi-lock-fill"></i>비밀번호
		</a>
		<a href="/cashbook/CategoryList.jsp" class="menu-btn green">
			<i class="bi bi-folder-fill"></i>카테고리
		</a>
		<a href="/cashbook/monthList.jsp" class="menu-btn yellow">
			<i class="bi bi-calendar3"></i>달력
		</a>
		<a href="/cashbook/totalset.jsp" class="menu-btn blue">
			<i class="bi bi-bar-chart-line-fill"></i>통계
		</a>
	</div>
</div>

</body>
</html>
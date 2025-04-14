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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<style>
		body {
			background-color: #fff;
			color: white;
			font-family: 'Pretendard', sans-serif;
		}
		.top-bar {
			background-color: #fff;
			color: #111;
			border-bottom: 1px solid #ccc;
			padding: 15px 20px;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		.icon-grid {
			max-width: 800px;
			margin: 40px auto;
			display: grid;
			grid-template-columns: repeat(4, 1fr);
			gap: 20px;
			text-align: center;
		}
		.menu-btn {
			background: #4d90fe;
			border-radius: 12px;
			padding: 25px 15px;
			color: #fff;
			text-decoration: none;
			transition: all 0.2s ease-in-out;
			border: 1px solid #333;
		}
		.menu-btn:hover {
			background: #2c2c2c;
			transform: translateY(-3px);
		}
		.menu-btn i {
			font-size: 1.8rem;
			margin-bottom: 10px;
		}
		.title {
			background-color: #3c7ee6;
			color: #000;
			font-weight: bold;
			text-align: center;
			padding: 14px;
			font-size: 1rem;
			border-radius: 0 0 16px 16px;
		}
	</style>
</head>
<body>
<!-- 🔐 상단 로그인 상태 -->
<div class="top-bar" style="background-color: #fff; color: #111; border-bottom: 1px solid #ccc; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center;">
	<div>
		<i class="bi bi-person-circle me-2"></i><%= loginAdmin %> 님
	</div>
	<a href="/cashbook/logOut.jsp" class="btn btn-sm btn-outline-dark">
		<i class="bi bi-box-arrow-right"></i> 로그아웃
	</a>
</div>

<!-- 🧩 메뉴 그리드 -->
<div class="icon-grid">
	<a href="/cashbook/totalYear.jsp" class="menu-btn">
		<i class="bi bi-lock-fill"></i><br>전체년도
	</a>
	<a href="/cashbook/totalYearMonth.jsp" class="menu-btn">
		<i class="bi bi-folder-fill"></i><br>년도별 수입/지출 
	</a>
	<a href="/cashbook/total.jsp" class="menu-btn">
		<i class="bi bi-calendar3"></i><br>월별 수입/지출
	</a>
	<a href="/cashbook/totalSearch.jsp" class="menu-btn">
		<i class="bi bi-bar-chart-line-fill"></i><br>년도별 월별 수입/지출검색
	</a>
</div>
    </div>
        <div class="text-center mt-4">
         <a href="index.jsp" class="btn btn-primary">
      <i class="bi bi-plus-circle me-1"></i> 목록으로
    </a>
  </div>

</body>
</html>
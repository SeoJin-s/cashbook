<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
	String loginAdmin = (String) session.getAttribute("loginAdmin");
	if (loginAdmin == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	String cashDate = request.getParameter("cashDate");
	if (cashDate == null || cashDate.trim().equals("")) {
		Calendar today = Calendar.getInstance();
		int y = today.get(Calendar.YEAR);
		int m = today.get(Calendar.MONTH) + 1;
		int d = today.get(Calendar.DAY_OF_MONTH);
		cashDate = String.format("%04d-%02d-%02d", y, m, d);
	}

	String kind = request.getParameter("kind");

	ArrayList<Category> categoryList = new ArrayList<>();
	if (kind != null && !kind.equals("")) {
		CategoryDao dao = new CategoryDao();
		categoryList = dao.selectCategoryListByKind(kind);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>수입/지출 입력</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
	    body {
      background-color: #fff;
      font-family: 'Segoe UI', sans-serif;
      color: #222;
    }

		.memo-box {
			max-width: 600px;
			margin: 40px auto;
			padding: 20px 30px;
			background: #fffec5;
			border-radius: 10px;
			box-shadow: inset 0 0 0 2px #ffea00;
		}

		h3 {
			font-weight: 800;
			color: #111;
			margin-bottom: 20px;
			border-bottom: 2px dashed #ccc;
			padding-bottom: 10px;
		}

		.form-control, .form-select {
			background-color: transparent;
			border: none;
			border-bottom: 2px dashed #999;
			border-radius: 0;
			color: #111;
			font-weight: 600;
			box-shadow: none;
		}

		.form-control:focus, .form-select:focus {
			border-bottom: 2px solid #3c7ee6;
			box-shadow: none;
		}

		.btn-yellow {
			background-color: #ffd600;
			color: #111;
			font-weight: bold;
			border: none;
			border-radius: 8px;
			padding: 10px 20px;
			box-shadow: 0 4px 10px rgba(0,0,0,0.1);
			transition: 0.2s ease;
		}

		.btn-yellow:hover {
			background-color: #fbc02d;
			transform: scale(1.02);
		}
	</style>
</head>
<body>

<div class="memo-box">
	<h3>📌 수입/지출 선택</h3>
	<form method="post" action="insertCashForm.jsp" class="mb-4">
		<div class="mb-3">
			<input type="date" name="cashDate" value="<%= cashDate %>" class="form-control" required>
		</div>
		<div class="mb-3">
			<select name="kind" class="form-select" required>
				<option value="">-- 선택 --</option>
				<option value="수입" <%= "수입".equals(kind) ? "selected" : "" %>>수입</option>
				<option value="지출" <%= "지출".equals(kind) ? "selected" : "" %>>지출</option>
			</select>
		</div>
		<button type="submit" class="btn btn-yellow">확인</button>
	</form>

<% if (kind != null && !kind.equals("")) { %>
	<h3>📝 상세 입력</h3>
	<form method="post" enctype="multipart/form-data" action="insertCashAction.jsp">
		<input type="hidden" name="kind" value="<%= kind %>">
		<input type="hidden" name="cashDate" value="<%= cashDate %>">

		<div class="mb-3">
			<label class="form-label">카테고리</label>
			<select name="categoryNo" class="form-select" required>
				<% for (Category c : categoryList) {
					String style = "background-color:" + c.getColor() + "; color:#111;";
				%>
				<option value="<%= c.getCategoryNo() %>" style="<%= style %>">
					[<%= c.getKind() %>] <%= c.getTitle() %>
				</option>
				<% } %>
			</select>
		</div>

		<div class="mb-3">
			<label class="form-label">메모</label>
			<input type="text" name="memo" class="form-control" placeholder="내용을 입력하세요">
		</div>

		<div class="mb-3">
			<label class="form-label">금액</label>
			<input type="number" name="price" class="form-control" required>
		</div>

		<div class="mb-3">
			<label class="form-label">영수증 파일 첨부</label>
			<input type="file" name="receitFile" class="form-control">
		</div>

		<button type="submit" class="btn btn-yellow">저장</button>
	</form>
<% } %>
</div>
<div class="d-flex justify-content-center gap-3 mt-4">
    </a>
    <a href="monthList.jsp" class="btn btn-primary">
        <i class="bi bi-calendar3 me-1"></i> 뒤로가기
    </a>
</div>

</body>
</html>
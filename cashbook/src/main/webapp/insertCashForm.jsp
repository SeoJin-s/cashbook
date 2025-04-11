<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
    // 로그인 확인
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }

    // 날짜 기본값 처리
    String cashDate = request.getParameter("cashDate");
    if (cashDate == null || cashDate.trim().equals("")) {
        Calendar today = Calendar.getInstance();
        int y = today.get(Calendar.YEAR);
        int m = today.get(Calendar.MONTH) + 1;
        int d = today.get(Calendar.DAY_OF_MONTH);
        cashDate = String.format("%04d-%02d-%02d", y, m, d);
    }

    String kind = request.getParameter("kind");

    // 카테고리 목록 준비
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">

<h2 class="mb-3">수입/지출 선택</h2>
<form method="post" action="insertCashForm.jsp" class="mb-4">
    <input type="date" name="cashDate" value="<%= cashDate %>" class="form-control w-25 mb-2" required>
    <select name="kind" class="form-select w-50" required>
        <option value="">-- 선택 --</option>
        <option value="수입" <%= "수입".equals(kind) ? "selected" : "" %>>수입</option>
        <option value="지출" <%= "지출".equals(kind) ? "selected" : "" %>>지출</option>
    </select>
    <button type="submit" class="btn btn-outline-primary mt-2">선택</button>
</form>

<% if (kind != null && !kind.equals("")) { %>
<h2 class="mb-3">입력</h2>
<form method="post" enctype="multipart/form-data" action="insertCashAction.jsp">
    <input type="hidden" name="kind" value="<%= kind %>">
    <input type="hidden" name="cashDate" value="<%= cashDate %>">

    <div class="mb-3">
        <label class="form-label fw-bold">카테고리</label>
        <select name="categoryNo" class="form-select w-50" required>
            <% for (Category c : categoryList) {
                String style = "background-color:" + c.getColor() + "; color:#333;";
            %>
            <option value="<%= c.getCategoryNo() %>" style="<%= style %>">
                [<%= c.getKind() %>] <%= c.getTitle() %>
            </option>
            <% } %>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">메모</label>
        <input type="text" name="memo" class="form-control w-50">
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">금액</label>
        <input type="number" name="price" class="form-control w-25" required>
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">영수증 파일 첨부</label>
        <input type="file" name="receitFile" class="form-control w-50">
    </div>

    <button type="submit" class="btn btn-success">입력</button>
</form>
<% } %>

</body>
</html>
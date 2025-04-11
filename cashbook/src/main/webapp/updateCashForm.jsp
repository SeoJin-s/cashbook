<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
    // 로그인 확인
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }

    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
    
    CashDao cashDao = new CashDao();
    Cash cash = cashDao.selectCashOne(cashNo); // 기존 값 불러오기

    String kind = cash.getKind(); // 기존 kind 값 받아오기

    // kind에 맞는 카테고리 목록을 불러오기
    CategoryDao categoryDao = new CategoryDao();
    ArrayList<Category> categoryList = categoryDao.selectCategoryListByKind(kind);  // kind에 맞는 카테고리 목록을 필터링
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function updateCategoryList(kind) {
            // kind가 변경되면 해당 카테고리 목록을 동적으로 갱신
            var form = document.getElementById('updateCashForm');
            form.submit();
        }
    </script>
</head>
<body class="p-4">
    <h2 class="mb-4">수정</h2>
    <form id="updateCashForm" method="post" action="/cashbook/updateCashAction.jsp">
        <input type="hidden" name="cashNo" value="<%= cash.getCashNo() %>">

        <div class="mb-3">
            <label class="form-label">날짜</label>
            <input type="text" name="cashDate" class="form-control w-25" value="<%= cash.getCashDate() %>">
        </div>

        <div class="mb-3">
            <label class="form-label">수입/지출</label>
            <select name="kind" class="form-select w-50" onchange="updateCategoryList(this.value)" required>
                <option value="수입" <%= "수입".equals(kind) ? "selected" : "" %>>수입</option>
                <option value="지출" <%= "지출".equals(kind) ? "selected" : "" %>>지출</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">카테고리</label>
            <select name="categoryNo" class="form-select w-50" required>
                <% 
                    // 현재 kind에 맞는 카테고리 목록만 보여주기
                    for (Category c : categoryList) { 
                        String selected = (c.getCategoryNo() == cash.getCategoryNo()) ? "selected" : "";
                        String style = "background-color:" + c.getColor();
                %>
                    <option value="<%= c.getCategoryNo() %>" <%= selected %> style="<%= style %>">
                        [<%= c.getKind() %>] <%= c.getTitle() %>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">메모</label>
            <input type="text" name="memo" class="form-control w-50" value="<%= cash.getMemo() %>">
        </div>

        <div class="mb-3">
            <label class="form-label">금액</label>
            <input type="number" name="price" class="form-control w-25" value="<%= cash.getPrice() %>" required>
        </div>

        <button type="submit" class="btn btn-success">수정 완료</button>
        <a href="cashOne.jsp?cashNo=<%= cash.getCashNo() %>" class="btn btn-secondary">취소</a>
    </form>
</body>
</html>
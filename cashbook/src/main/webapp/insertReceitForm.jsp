<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영수증 첨부</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h3>영수증 첨부</h3>
    <form action="/cashbook/insertReceitAcion.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="cashNo" value="<%= cashNo %>">
        <div class="mb-3">
            <label for="receitFile" class="form-label">영수증 파일 선택</label>
            <input type="file" class="form-control" id="receitFile" name="receitFile" required>
        </div>
        <button type="submit" class="btn btn-primary">업로드</button>
        <a href="cashOne.jsp?cashNo=<%= cashNo %>" class="btn btn-secondary">뒤로</a>
    </form>
</body>
</html>
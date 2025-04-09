<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 확인
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>카테고리 추가</title>
</head>
<body>

	<h2>카테고리 추가</h2>

	<form action="insertCategoryAction.jsp" method="post">
		<table border="1">
			<tr>
				<th>구분</th>
				<td>
					<select name="kind" required>
						<option value="">-- 선택 --</option>
						<option value="수입">수입</option>
						<option value="지출">지출</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" required></td>
			</tr>
		</table>
		<br>
		<button type="submit">추가하기</button>
	</form>

</body>
</html>
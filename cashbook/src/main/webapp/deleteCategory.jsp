<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	CategoryDao dao = new CategoryDao();

	if (dao.hasCashData(categoryNo)) {
%>
		<script>
			alert("❌ 해당 카테고리에 연결된 수입/지출 내역이 있어 삭제할 수 없습니다.");
			location.href = "categoryList.jsp";
		</script>
<%
	} else {
		int row = dao.deleteCategory(categoryNo);
		if (row == 1) {
%>
			<script>
				alert("✅ 카테고리 삭제 완료!");
				location.href = "/cashbook/CategoryList.jsp";
			</script>
<%
		} else {
%>
			<script>
				alert("⚠️ 삭제에 실패했습니다. 다시 시도해주세요.");
				location.href = "/cashbook/CategoryList.jsp";
			</script>
<%
		}
	}
%>
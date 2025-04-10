<%@ page import="model.CategoryDao" %>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String title = request.getParameter("title");

	CategoryDao dao = new CategoryDao();
	int row = dao.updateCategoryTitle(categoryNo, title);

	if (row == 1) {
		response.sendRedirect("/cashbook/CategoryList.jsp");
	} else {
		response.sendRedirect("/cashbook/updateCategoryTitleForm.jsp?categoryNo=" + categoryNo);
	}
%>
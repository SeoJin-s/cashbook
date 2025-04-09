<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dto.*" %>
<%
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	// 1) 파라미터 받기
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	
	// 2) dto 에 저장
	Category category = new Category();
	category.setKind(kind);
	category.setTitle(title);
	
	// 3) dao 호출하기
	CategoryDao dao = new CategoryDao();
	int row = dao.insertCategory(category);
	
	// 4. 결과에 따라 리다이렉트
	if (row == 1) {
		// 성공 → 목록 페이지로
		response.sendRedirect("/cashbook/CategoryList.jsp");
	} else {
		// 실패 → 입력 폼으로
		response.sendRedirect("/cashbook/insertCategoryForm.jsp");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
	// 로그인 확인
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}


	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String memo = request.getParameter("memo");
	int price = Integer.parseInt(request.getParameter("price"));
	
	CashDao dao = new CashDao();
	int row = dao.updateCash(cashNo, cashDate, categoryNo, memo, price);
	
	if(row > 0) {
		// 성공 시 상세보기 페이지로 이동
		response.sendRedirect("/cashbook/cashOne.jsp?cashNo=" + cashNo);
	} else {
		// 실패 시 수정폼으로 다시 이동
		response.sendRedirect("/cashbook/updateCashForm.jsp?cashNo=" + cashNo);
	}
%>

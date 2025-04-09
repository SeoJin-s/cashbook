<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");

	AdminDao dao = new AdminDao();
	Admin loginAdmin = dao.selectAdminByIdPw(adminId, adminPw);

	if (loginAdmin != null) {
		System.out.println("[로그인 성공] ID: "+ loginAdmin.getAdminId());
		session.setAttribute("loginAdmin", loginAdmin.getAdminId());
		response.sendRedirect("/cashbook/index.jsp");
	} else {
		System.out.println("[로그인 실패] 아이디 또는 비밀번호 불일치");
		response.sendRedirect("/cashbook/loginForm.jsp?error=1");
	}
%>
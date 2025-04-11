<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.CashDao" %>
<%
    // 로그인 확인
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }
   
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	CashDao dao = new CashDao();
	int row = dao.deleteCash(cashNo);
	
	if (row > 0) {
		// 삭제 성공
		 response.sendRedirect("/cashbook/monthList.jsp");	
	} else {
		// 삭제 실패
		 response.sendRedirect("/cashbook/cashOne.jsp?cashNo=" + cashNo);
	}
    
 %>   
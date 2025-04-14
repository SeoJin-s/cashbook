<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
	// 1) 파라미터 받기
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	// 2) 업로드 된 파일 저장 경로 가져오기
	String uploadPath = request.getServletContext().getRealPath("/upload");
	
	// 3) dao 실행
	ReceitDao dao = new ReceitDao();
	int result = dao.deleteReceit(cashNo, uploadPath);
	
	// 4) 결과 처리
	if (result ==1) {
	%>
	    <script>
	        alert('영수증이 삭제되었습니다.');
	        location.href = 'cashOne.jsp?cashNo=<%= cashNo %>';
	    </script>
	<%
	    } else {
	%>
	    <script>
	        alert('영수증 삭제에 실패했습니다.');
	        history.back();
	    </script>
	<%
	    }
	%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 세션을 초기화
	session.invalidate();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그아웃</title>
	<!-- ✅ 1초 뒤 로그인 폼으로 이동 -->
	<meta http-equiv="refresh" content="1;url=/cashbook/loginForm.jsp">
</head>
<body>
	<h2>✅ 로그아웃 되었습니다. 로그인 페이지로 이동중 ...</h2>
</head>
<body>
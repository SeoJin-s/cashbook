<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="java.util.*, java.io.*, java.nio.file.*" %>
<%@ page import="model.*" %>

<%
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    int cashNo = Integer.parseInt(request.getParameter("cashNo"));

    String uploadPath = application.getRealPath("/upload");
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    String filename = "";

    Part filePart = request.getPart("receitFile");
    if (filePart != null && filePart.getSize() > 0) {
        String originalName = filePart.getSubmittedFileName();
        String ext = originalName.substring(originalName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().replace("-", "");
        filename = uuid + ext;

        filePart.write(uploadPath + File.separator + filename);
    }

    if (!filename.equals("")) {
        ReceitDao dao = new ReceitDao();
        dao.insertReceit(cashNo, filename);
    }

    response.sendRedirect("/cashbook/cashOne.jsp?cashNo=" + cashNo);
%>
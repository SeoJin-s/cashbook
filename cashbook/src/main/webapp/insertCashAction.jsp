<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.nio.file.*" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="model.*, dto.*" %>
<%
    // 로그인 확인
    if (session.getAttribute("loginAdmin") == null) {
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    // 입력값 수집
    String cashDate = request.getParameter("cashDate");
    int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
    String memo = request.getParameter("memo");
    int amount = Integer.parseInt(request.getParameter("price"));

    // 👉 카테고리에서 kind를 조회해서 지출이면 음수 처리
    CategoryDao categoryDao = new CategoryDao();
    Category category = categoryDao.selectCategoryOne(categoryNo);
    if ("지출".equals(category.getKind())) {
        amount = -amount;
    }

    // 업로드 경로 준비
    String uploadPath = application.getRealPath("/upload");
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    String filename = "";

    // 파일 업로드
    Part filePart = request.getPart("receitFile");
    if (filePart != null && filePart.getSize() > 0) {
        String originalName = filePart.getSubmittedFileName();
        String ext = originalName.substring(originalName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().replace("-", "");
        filename = uuid + ext;

        File file = new File(uploadPath, filename);
        try (InputStream input = filePart.getInputStream();
             OutputStream output = Files.newOutputStream(file.toPath())) {
            input.transferTo(output);
        }
    }

    // DB 저장
    CashDao cashDao = new CashDao();
    int cashNo = cashDao.insertCashAndReturnKey(cashDate, categoryNo, memo, amount); // kind 제거

    // 영수증 파일 DB 저장
    if (!filename.equals("")) {
        ReceitDao receitDao = new ReceitDao();
        receitDao.insertReceit(cashNo, filename);
    }

    // 리다이렉트
    Calendar cal = Calendar.getInstance();
    cal.setTime(java.sql.Date.valueOf(cashDate));
    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH); // 0~11

    response.sendRedirect("/cashbook/monthList.jsp?year=" + year + "&month=" + month);
%>
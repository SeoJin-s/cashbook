<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Category" %>
<%@ page import="model.CategoryDao" %>
<%
	// 로그인 확인
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
		String loginAdmin = (String) session.getAttribute("loginAdmin"); // ✅ if 바깥으로 분리!
	
// 오늘 날짜 정보
	Calendar now = Calendar.getInstance();
	int thisYear = now.get(Calendar.YEAR);
	int thisMonth = now.get(Calendar.MONTH); // 0 ~ 11
	
	// 검색
	String searchWord = request.getParameter("searchWord");
	if (searchWord == null) searchWord = "";
	
	// 페이징
	int currentPage = 1;
	int rowPerPage = 10;

	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	int beginRow = (currentPage - 1) * rowPerPage;
	
	// DAO 호출
	CategoryDao dao = new CategoryDao();
	int totalRow = dao.countCategory(searchWord);
	int lastPage = (int)Math.ceil((double)totalRow / rowPerPage);
	ArrayList<Category> list = dao.selectCategoryListByPaging(searchWord, beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카테고리 리스트</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">
  <style>
    body {
      background-color: #fff;
      color: #333;
      font-family: 'Pretendard', sans-serif;
    }
    .category-card {
      background-color: #dcebdc;
      border: 1px solid #ddd;
      padding: 20px;
      border-radius: 12px;
      transition: all 0.2s ease-in-out;
    }
    .category-card:hover {
      box-shadow: 0 6px 12px rgba(0,0,0,0.05);
      transform: translateY(-2px);
    }
    .badge-kind {
      font-size: 0.85rem;
      padding: 5px 10px;
      border-radius: 10px;
    }
    .badge-income {
      background-color: #4caf50;
    }
    .badge-expense {
      background-color: #f44336;
    }
    .btn-action {
      font-size: 0.85rem;
    }
    h4.title {
      color: #4caf50;
      font-weight: 700;
    }
    .btn-primary {
      background-color: #4caf50;
      border-color: #4caf50;
    }
    .btn-primary:hover {
      background-color: #449d48;
      border-color: #3d8b40;
    }
    .page-link {
      color: #4caf50;
    }
    .page-item.active .page-link {
      background-color: #4caf50;
      border-color: #4caf50;
    }
  </style>
</head>
<body>

<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="title"><i class="bi bi-folder-fill me-2"></i>카테고리 리스트</h4>
    <a href="insertCategoryForm.jsp" class="btn btn-primary">
      <i class="bi bi-plus-circle me-1"></i> 추가
    </a>
  </div>

  <form method="get" action="CategoryList.jsp" class="mb-4">
    <div class="input-group">
      <input type="text" name="searchWord" class="form-control" placeholder="제목으로 검색" value="<%= searchWord %>">
      <button type="submit" class="btn btn-primary">검색</button>
    </div>
  </form>

  <div class="row row-cols-1 g-3">
    <% for (Category c : list) { %>
    <div class="col">
      <div class="category-card d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center gap-3">
          <% if ("수입".equals(c.getKind())) { %>
            <span class="badge badge-kind badge-income">수입</span>
          <% } else { %>
            <span class="badge badge-kind badge-expense">지출</span>
          <% } %>
          <div>
            <div class="fw-bold fs-5"><%= c.getTitle() %></div>
            <div class="text-muted small">생성일: <%= c.getCreatedate().toLocalDate() %></div>
          </div>
        </div>
        <div class="d-flex gap-2">
          <a href="updateCategoryTitleForm.jsp?categoryNo=<%= c.getCategoryNo() %>" class="btn btn-sm btn-outline-success btn-action">수정</a>
          <a href="deleteCategory.jsp?categoryNo=<%= c.getCategoryNo() %>" class="btn btn-sm btn-outline-danger btn-action" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
        </div>
      </div>
    </div>
    <% } %>
  </div>

  <!-- 페이지네이션 -->
  <nav class="mt-4">
    <ul class="pagination justify-content-center">
      <li class="page-item <%= (currentPage == 1 ? "disabled" : "") %>">
        <a class="page-link" href="CategoryList.jsp?currentPage=<%= currentPage - 1 %>&searchWord=<%= searchWord %>">이전</a>
      </li>
      <% for (int i = 1; i <= lastPage; i++) { %>
        <li class="page-item <%= (i == currentPage ? "active" : "") %>">
          <a class="page-link" href="CategoryList.jsp?currentPage=<%= i %>&searchWord=<%= searchWord %>"><%= i %></a>
        </li>
      <% } %>
      <li class="page-item <%= (currentPage == lastPage ? "disabled" : "") %>">
        <a class="page-link" href="CategoryList.jsp?currentPage=<%= currentPage + 1 %>&searchWord=<%= searchWord %>">다음</a>
      </li>
    </ul>
  </nav>

  <div class="text-center mt-4">
    <a href="monthList.jsp?year=<%= thisYear %>&month=<%= thisMonth %>" class="btn btn-primary px-4">
      <i class="bi bi-journal-text me-2"></i> 달력
    </a>
    <a href="index.jsp" class="btn btn-outline-secondary ms-2 px-4">
      <i class="bi bi-house me-1"></i> 홈으로
    </a>
  </div>
</div>

</body>
</html>
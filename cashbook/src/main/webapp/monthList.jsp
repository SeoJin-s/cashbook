<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
	//로그인 확인
	if (session.getAttribute("loginAdmin") == null) {
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
		String loginAdmin = (String) session.getAttribute("loginAdmin"); // ✅ if 바깥으로 분리!
	// 요청 파라미터 (연도, 월)
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH); // 0~11

	if (request.getParameter("year") != null) {
		year = Integer.parseInt(request.getParameter("year"));
	}
	if (request.getParameter("month") != null) {
		month = Integer.parseInt(request.getParameter("month"));
	}

	cal.set(year, month, 1);

	// 달력 시작 요일과 말일 구하기
	int startBlank = cal.get(Calendar.DAY_OF_WEEK) - 1; // 1일의 요일 (일:1~토:7)
	int lastDate = cal.getActualMaximum(Calendar.DATE); // 말일
	int totalCell = startBlank + lastDate;

	// 월 이동 처리
	int prevYear = month == 0 ? year - 1 : year;
	int prevMonth = month == 0 ? 11 : month - 1;
	int nextYear = month == 11 ? year + 1 : year;
	int nextMonth = month == 11 ? 0 : month + 1;

	// 수입/지출 목록 조회
	CashDao cashDao = new CashDao();
	HashMap<Integer, ArrayList<Cash>> cashMap = cashDao.selectCashListByMonth(year, month + 1);

	// 🔥 [추가] 수입/지출 통계 조회
	ArrayList<ReportData> usageList = cashDao.getTotalStats(year, month + 1);
	int totalIncome = 0, totalExpense = 0;

	for (ReportData r : usageList) {
	    if ("수입".equals(r.getKind())) totalIncome = r.getTotal();
	    else if ("지출".equals(r.getKind())) totalExpense = r.getTotal();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>월별 가계부</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5eee6;
            font-family: 'Segoe UI', sans-serif;
        }

        .calendar-table {
            table-layout: fixed;
        }

        .calendar-table td {
		    height: 120px;
		    overflow-y: auto;
            vertical-align: top;
            padding: 6px;
            border: 1px solid #ddd;
        }

        .today {
            background-color: #fff3e0;
            font-weight: bold;
        }

        .container-box {
            max-width: 1000px;
            margin: 20px auto;
            padding: 30px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.05);
        }

        .login-bar {
            max-width: 1000px;
            margin: 30px auto 10px;
            padding: 0 20px;
        }

        .calendar-table th {
            background-color: #ffcc80 !important;
            color: #4e342e;
            text-align: center;
        }

        a.date-link {
            text-decoration: none;
            color: inherit;
        }

        a.date-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- 로그인 관리자 표시 -->
<div class="login-bar d-flex justify-content-between align-items-center flex-wrap">
    <span class="fw-semibold text-dark" style="font-size: 1rem;">
        <i class="bi bi-person-circle me-2"></i> <%= loginAdmin %> 님 환영합니다.
    </span>
    <div class="d-flex gap-2 mt-2 mt-sm-0">
        <a href="/cashbook/logOut.jsp" class="btn btn-sm btn-outline-danger">
            <i class="bi bi-box-arrow-right me-1"></i> 로그아웃
        </a>
        <a href="/cashbook/index.jsp" class="btn btn-sm btn-outline-secondary">
            <i class="bi bi-arrow-left me-1"></i> 홈으로
        </a>
    </div>
</div>
<!-- ✅ 카테고리별 통계 블럭만 출력 -->
<div class="container-box p-4 mb-3">
    <div class="row">
		<h6 class="fw-bold mb-2 d-flex justify-content-between align-items-center">
		    DETAILS PLAN
			<a href="total.jsp?year=<%= year %>&month=<%= month %>" class="text-secondary" title="월별 통계 보기">
			    <i class="bi bi-bar-chart-fill" style="font-size: 1.5rem;"></i>
			</a>
		</h6>
		
		<div class="row row-cols-2 g-3">
		    <% for (ReportData r : usageList) { %>
   			 <div class="col d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center">
            <span style="width: 10px; height: 10px; background-color: black; border-radius: 50%; display:inline-block; margin-right: 5px;"></span>
            <span style="background-color:<%= r.getColor() %>; border-radius:10px; padding:2px 8px;">
                <%= r.getTitle() %>
            </span>
        </div>
        <div class="<%= "지출".equals(r.getKind()) ? "text-danger" : "text-success" %> fw-semibold" style="font-size:0.9rem;">
            <%= String.format("%,d", r.getTotal()) %>
        </div>
    </div>
<% } %>
		</div>
	</div>
</div>
<!-- 달력 -->
<div class="container-box mt-2">
    <h4 class="text-center mb-4"><%= year %>년 <%= (month + 1) %>월</h4>
	   <!-- ✅ 입력 버튼 추가 -->
    <div class="text-end mb-3">
        <a href="insertCashForm.jsp" class="btn btn-sm btn-success">
            <i class="bi bi-pencil-square me-1"></i> 수입/지출 입력
        </a>
    </div>
    <table class="table table-bordered calendar-table">
        <thead class="text-center">
            <tr>
                <th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
            </tr>
        </thead>
        <tbody>
		<% 
			int cellCount = 0;
			out.println("<tr>");
			for (int i = 0; i < startBlank; i++) {
				out.println("<td></td>");
				cellCount++;
			}
			
			for (int date = 1; date <= lastDate; date++) {
				if (cellCount % 7 == 0 && cellCount != 0) {
					out.println("</tr><tr>");
				}
			
				boolean isToday = (year == Calendar.getInstance().get(Calendar.YEAR)) &&
				                  (month == Calendar.getInstance().get(Calendar.MONTH)) &&
				                  (date == Calendar.getInstance().get(Calendar.DATE));
			
				out.println("<td class='" + (isToday ? "today" : "") + "'>");
				out.println("<a href='dateList.jsp?year=" + year + "&month=" + (month + 1) + "&date=" + date + "' class='date-link'>");
				out.println("<strong>" + date + "</strong><br>");
			
				ArrayList<Cash> list = cashMap.get(date);
				if (list != null) {
					for (Cash c : list) {
						String kindClass = "수입".equals(c.getKind()) ? "text-success" : "text-danger";
						String bgStyle = "background-color:" + c.getColor() + "; padding:2px 6px; border-radius:10px;";
			
						out.println("<div style='margin-bottom:3px;'>");
						out.println("<span style='" + bgStyle + "; font-size:0.75rem;' class='" + kindClass + " fw-semibold'>");
						out.println(c.getCategoryTitle());
						out.println("</span> ");
						out.println("<span style='font-size:0.75rem;'>");
						out.println(c.getMemo() + " : ￦" + c.getPrice());
						out.println("</span>");
						out.println("</div>");
					}
					
				}
			
				out.println("</a></td>"); // ✅ 누락된 </td>
				cellCount++;              // ✅ 누락된 cellCount++
			}
			
			while (cellCount % 7 != 0) {
				out.println("<td></td>");
				cellCount++;
			}
			out.println("</tr>");
	%>
        </tbody>
    </table>

    <!-- 이전/다음 달 이동 -->
    <div class="d-flex justify-content-between mt-4">
        <a class="btn btn-outline-secondary" href="monthList.jsp?year=<%= prevYear %>&month=<%= prevMonth %>">
            ◀ 이전달
        </a>
        <a class="btn btn-outline-secondary" href="monthList.jsp?year=<%= nextYear %>&month=<%= nextMonth %>">
            다음달 ▶
        </a>
    </div>
</div>

</body>
</html>
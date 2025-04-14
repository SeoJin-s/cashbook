<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Pretendard -->
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet">
  <style>
    body {
      background-color: #111;
      font-family: 'Pretendard', sans-serif;
      color: #fff;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .login-box {
      width: 100%;
      max-width: 420px;
      background-color: #1e1e1e;
      border-radius: 16px;
      padding: 40px 30px;
      box-shadow: 0 6px 24px rgba(0,0,0,0.5);
    }

    .daum-logo {
      font-size: 38px;
      font-weight: 900;
      text-align: center;
      margin-bottom: 25px;
      letter-spacing: 1px;
    }

    .daum-logo span:nth-child(1) { color: #4285F4; }  /* D */
    .daum-logo span:nth-child(2) { color: #EA4335; }  /* a */
    .daum-logo span:nth-child(3) { color: #FBBC05; }  /* u */
    .daum-logo span:nth-child(4) { color: #34A853; }  
	.daum-logo span:nth-child(5) { color: #4285F4; }
	.daum-logo span:nth-child(6) { color: #FBBC05; }
	
    .notice-box {
      background-color: #2b2b2b;
      color: #f55;
      padding: 12px;
      border-radius: 8px;
      font-size: 0.95rem;
      text-align: center;
      margin-bottom: 20px;
    }

    .form-control {
      background-color: #111;
      border: 1px solid #444;
      color: white;
      font-size: 1rem;
      border-radius: 6px;
      transition: border 0.2s ease;
    }

    .form-control:focus {
      border-color: #4d90fe;
      box-shadow: none;
      background-color: #181818;
    }

    .form-control::placeholder {
      color: #aaa;
    }

    .btn-login {
      background-color: #4d90fe;
      border: none;
      font-weight: bold;
      font-size: 1.05rem;
      padding: 10px;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(77, 144, 254, 0.4);
      transition: all 0.2s ease;
    }

    .btn-login:hover {
      background-color: #3c7ee6;
      box-shadow: 0 6px 14px rgba(77, 144, 254, 0.5);
    }

    .extra-links {
      margin-top: 20px;
      font-size: 0.9rem;
      color: #aaa;
      text-align: center;
    }

    .extra-links a {
      color: #aaa;
      margin: 0 8px;
      text-decoration: none;
    }

    .extra-links a:hover {
      color: #fff;
    }
  </style>
</head>
<body>

  <div class="login-box">
    <div class="daum-logo">
      <span>S</span><span>e</span><span>o</span><span>J</span><span>i</span><span>n</span>
    </div>

    <div class="notice-box">
      카카오 계정으로 통합해주세요
    </div>

    <form method="post" action="loginAction.jsp">
      <div class="mb-3">
        <input type="text" class="form-control" name="adminId" placeholder="아이디" required>
      </div>
      <div class="mb-3">
        <input type="password" class="form-control" name="adminPw" placeholder="비밀번호" required>
      </div>
      <div class="d-grid">
        <button type="submit" class="btn btn-login">로그인</button>
      </div>
    </form>

    <div class="extra-links">
      <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
    </div>
  </div>

</body>
</html>
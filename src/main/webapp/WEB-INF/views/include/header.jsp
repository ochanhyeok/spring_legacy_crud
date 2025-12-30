<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD 게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #f5f5f5;
            padding-top: 60px; /* 고정 헤더 높이만큼 여백 */
        }

        /* ⭐ 헤더 스타일 개선 */
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 20px; /* 높이 줄임 */
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            z-index: 1000;
        }

        header .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            font-size: 20px; /* 크기 줄임 */
            font-weight: 600;
        }

        header h1 a {
            color: white;
            text-decoration: none;
        }

        nav {
            display: flex;
            gap: 15px; /* 간격 줄임 */
            align-items: center;
        }

        nav a, nav span {
            color: white;
            text-decoration: none;
            font-size: 14px; /* 크기 줄임 */
            padding: 6px 12px; /* 패딩 줄임 */
            border-radius: 5px;
            transition: background 0.3s;
        }

        nav a:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        nav button {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 6px 12px; /* 패딩 줄임 */
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px; /* 크기 줄임 */
            transition: background 0.3s;
        }

        nav button:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        /* 메인 컨텐츠 */
        main {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        /* 테이블 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
        }

        table tbody tr:hover {
            background-color: #f8f9fa;
        }

        table a {
            color: #667eea;
            text-decoration: none;
        }

        table a:hover {
            text-decoration: underline;
        }

        /* 폼 */
        input[type="text"],
        input[type="password"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            font-family: inherit;
        }

        /* 버튼 */
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }

        .btn-danger {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(245, 87, 108, 0.3);
        }

        .btn {
            background: #6c757d;
            color: white;
        }

        .btn:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>
<header>
    <div class="container">
        <h1>
            <a href="${pageContext.request.contextPath}/">CRUD 게시판</a>
        </h1>
        <nav>
            <a href="${pageContext.request.contextPath}/">게시판</a>

            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <span>환영합니다, ${sessionScope.loginUser.userName}님</span>
                    <form action="${pageContext.request.contextPath}/member/logout" method="post" style="display: inline;">
                        <button type="submit">로그아웃</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/member/login">로그인</a>
                    <a href="${pageContext.request.contextPath}/member/register">회원가입</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CRUD 게시판</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        nav { background: #333; color: white; padding: 10px 0; }
        nav ul { list-style: none; display: flex; gap: 20px; }
        nav a { color: white; text-decoration: none; }
        .btn { padding: 8px 16px; border: none; cursor: pointer; border-radius: 4px; }
        .btn-primary { background: #007bff; color: white; }
        .btn-danger { background: #dc3545; color: white; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background: #f8f9fa; }
    </style>
</head>
<body>
<nav>
    <div class="container">
        <ul>
            <li><a href="${pageContext.request.contextPath}/board/list">게시판</a></li>
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <li><a href="${pageContext.request.contextPath}/member/info">${sessionScope.loginUser.userName}님</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/register">회원가입</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
<div class="container">

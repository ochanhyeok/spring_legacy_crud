<%-- /WEB-INF/views/member/modify.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<h2>회원정보 수정</h2>

<form action="${pageContext.request.contextPath}/member/modify" method="post" style="max-width: 500px; margin: 50px auto;">
    <input type="hidden" name="userId" value="${member.userId}" />

    <table style="width: 100%;">
        <tr>
            <th width="30%">아이디</th>
            <td>${member.userId}</td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td>
                <input type="password" name="userPw" required style="width: 100%;" />
            </td>
        </tr>
        <tr>
            <th>이름</th>
            <td>
                <input type="text" name="userName" value="${member.userName}" required style="width: 100%;" />
            </td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>
                <input type="email" name="email" value="${member.email}" required style="width: 100%;" />
            </td>
        </tr>
    </table>

    <div style="margin-top: 20px; text-align: center;">
        <button type="submit" class="btn btn-primary">수정</button>
        <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/member/info'">취소</button>
    </div>
</form>

<%@ include file="../include/footer.jsp" %>

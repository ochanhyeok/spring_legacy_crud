<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<h2>로그인</h2>

<c:if test="${not empty error}">
    <div style="background: #f8d7da; color: #721c24; padding: 10px; margin: 20px 0; border-radius: 4px;">
            ${error}
    </div>
</c:if>

<form action="${pageContext.request.contextPath}/member/login" method="post" style="max-width: 400px; margin: 50px auto;">
    <table style="width: 100%;">
        <tr>
            <th width="30%">아이디</th>
            <td>
                <input type="text" name="userId" required style="width: 100%;" />
            </td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td>
                <input type="password" name="userPw" required style="width: 100%;" />
            </td>
        </tr>
    </table>

    <div style="margin-top: 20px; text-align: center;">
        <button type="submit" class="btn btn-primary" style="width: 100%;">로그인</button>
    </div>

    <div style="margin-top: 10px; text-align: center;">
        <a href="${pageContext.request.contextPath}/member/register">회원가입</a>
    </div>
</form>

<%@ include file="../include/footer.jsp" %>

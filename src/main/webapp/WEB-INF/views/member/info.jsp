<%-- /WEB-INF/views/member/info.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<h2>회원 정보</h2>

<c:if test="${not empty result}">
    <div style="background: #d4edda; color: #155724; padding: 10px; margin: 20px 0; border-radius: 4px;">
            ${result}
    </div>
</c:if>

<table style="max-width: 500px; margin: 50px auto;">
    <tr>
        <th width="30%">아이디</th>
        <td>${member.userId}</td>
    </tr>
    <tr>
        <th>이름</th>
        <td>${member.userName}</td>
    </tr>
    <tr>
        <th>이메일</th>
        <td>${member.email}</td>
    </tr>
    <tr>
        <th>가입일</th>
        <td><fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
    </tr>
</table>

<div style="margin-top: 20px; text-align: center;">
    <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/member/modify'">정보 수정</button>
    <button type="button" class="btn btn-danger" onclick="removeAccount()">회원 탈퇴</button>
    <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>
</div>

<form id="removeForm" action="${pageContext.request.contextPath}/member/remove" method="post">
</form>

<script>
    function removeAccount() {
        if(confirm('정말 탈퇴하시겠습니까?')) {
            document.getElementById('removeForm').submit();
        }
    }
</script>

<%@ include file="../include/footer.jsp" %>

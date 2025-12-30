<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<h2>게시판 목록</h2>

<div style="margin: 20px 0; text-align: right;">
    <c:if test="${not empty sessionScope.loginUser}">
        <a href="${pageContext.request.contextPath}/board/register" class="btn btn-primary">글쓰기</a>
    </c:if>
</div>

<table>
    <thead>
    <tr>
        <th width="10%">번호</th>
        <th width="50%">제목</th>
        <th width="15%">작성자</th>
        <th width="15%">작성일</th>
        <th width="10%">조회수</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${empty list}">
        <tr>
            <td colspan="5" style="text-align: center;">게시글이 없습니다.</td>
        </tr>
    </c:if>
    <c:forEach items="${list}" var="board">
        <tr>
            <td>${board.boardId}</td>
            <td>
                <a href="${pageContext.request.contextPath}/board/get?boardId=${board.boardId}">
                        ${board.title}
                </a>
            </td>
            <td>${board.writer}</td>
            <td>
                    <%-- ⭐ LocalDateTime 포맷 수정 --%>
                <c:set var="dateStr" value="${board.regDate.toString()}" />
                    ${dateStr.substring(0, 10)} ${dateStr.substring(11, 16)}
            </td>
            <td>${board.viewCnt != null ? board.viewCnt : 0}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<script>
    $(document).ready(function() {
        var result = '${result}';

        if(result === 'success') {
            alert('처리되었습니다.');
        }
    });
</script>

<%@ include file="../include/footer.jsp" %>

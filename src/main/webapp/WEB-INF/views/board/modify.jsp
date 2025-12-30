<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<h2>게시글 수정</h2>

<form action="${pageContext.request.contextPath}/board/modify" method="post">
    <input type="hidden" name="boardId" value="${board.boardId}" />

    <table>
        <tr>
            <th width="20%">번호</th>
            <td>${board.boardId}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td>
                <input type="text" name="title" value="${board.title}" style="width: 100%;" required />
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td>
                <textarea name="content" rows="10" style="width: 100%;" required>${board.content}</textarea>
            </td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${board.writer}</td>
        </tr>
        <tr>
            <th>작성일</th>
            <td>
                <%-- ⭐ LocalDateTime 포맷 수정 --%>
                <c:set var="regDateStr" value="${board.regDate.toString()}" />
                ${regDateStr.substring(0, 10)} ${regDateStr.substring(11, 19)}
            </td>
        </tr>
        <tr>
            <th>수정일</th>
            <td>
                <%-- ⭐ LocalDateTime 포맷 수정 --%>
                <c:if test="${board.updateDate != null}">
                    <c:set var="updateDateStr" value="${board.updateDate.toString()}" />
                    ${updateDateStr.substring(0, 10)} ${updateDateStr.substring(11, 19)}
                </c:if>
                <c:if test="${board.updateDate == null}">
                    -
                </c:if>
            </td>
        </tr>
    </table>

    <div style="margin-top: 20px; text-align: center;">
        <button type="submit" class="btn btn-primary">수정</button>
        <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/board/get?boardId=${board.boardId}'">취소</button>
    </div>
</form>

<%@ include file="../include/footer.jsp" %>

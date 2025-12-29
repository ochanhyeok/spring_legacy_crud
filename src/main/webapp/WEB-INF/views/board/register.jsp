<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<h2>게시글 등록</h2>

<form action="${pageContext.request.contextPath}/board/register" method="post">
    <table>
        <tr>
            <th width="20%">제목</th>
            <td>
                <input type="text" name="title" style="width: 100%;" required />
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td>
                <textarea name="content" rows="10" style="width: 100%;" required></textarea>
            </td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>
                <input type="text" name="writer" value="${sessionScope.loginUser.userId}" readonly />
            </td>
        </tr>
    </table>

    <div style="margin-top: 20px; text-align: center;">
        <button type="submit" class="btn btn-primary">등록</button>
        <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/board/list'">취소</button>
    </div>
</form>

<%@ include file="../include/footer.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<main style="max-width: 1200px; margin: 20px auto; padding: 20px;">

    <h2>게시판 목록</h2>

    <!-- ⭐ 글쓰기 버튼 (맨 위로) -->
    <div style="margin: 20px 0; text-align: right;">
        <c:if test="${not empty sessionScope.loginUser}">
            <a href="${pageContext.request.contextPath}/board/register" class="btn btn-primary">글쓰기</a>
        </c:if>
    </div>

    <!-- 검색 결과 표시 (검색했을 때만) -->
    <c:if test="${not empty search.keyword}">
        <div style="margin: 10px 0; padding: 10px; background: #f8f9fa; border-radius: 4px;">
            <strong>검색 결과:</strong>
            <c:choose>
                <c:when test="${search.searchType == 'title'}">제목</c:when>
                <c:when test="${search.searchType == 'writer'}">작성자</c:when>
                <c:when test="${search.searchType == 'content'}">내용</c:when>
                <c:when test="${search.searchType == 'titleOrContent'}">제목+내용</c:when>
            </c:choose>
            에서 "<strong>${search.keyword}</strong>" 검색
        </div>
    </c:if>

    <!-- ⭐ 게시글 목록 테이블 -->
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
                <td colspan="5" style="text-align: center; padding: 30px;">
                    <c:choose>
                        <c:when test="${not empty search.keyword}">
                            검색 결과가 없습니다.
                        </c:when>
                        <c:otherwise>
                            게시글이 없습니다.
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:if>
        <c:forEach items="${list}" var="board">
            <tr>
                <td style="text-align: center;">${board.boardId}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/board/get?boardId=${board.boardId}&searchType=${search.searchType}&keyword=${search.keyword}">
                            ${board.title}
                    </a>
                </td>
                <td style="text-align: center;">${board.writer}</td>
                <td style="text-align: center;">
                    <c:set var="dateStr" value="${board.regDate.toString()}" />
                        ${dateStr.substring(0, 10)} ${dateStr.substring(11, 16)}
                </td>
                <td style="text-align: center;">${board.viewCnt != null ? board.viewCnt : 0}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- ⭐ 검색 폼 (테이블 아래로 이동) -->
    <div style="margin: 30px 0; padding: 20px; background: #f8f9fa; border-radius: 8px;">
        <h3 style="margin: 0 0 15px 0; font-size: 16px; color: #333;">게시글 검색</h3>
        <form action="${pageContext.request.contextPath}/board/list" method="get" style="display: flex; gap: 10px; align-items: center;">
            <select name="searchType" style="padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;">
                <option value="title" ${search.searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="writer" ${search.searchType == 'writer' ? 'selected' : ''}>작성자</option>
                <option value="content" ${search.searchType == 'content' ? 'selected' : ''}>내용</option>
                <option value="titleOrContent" ${search.searchType == 'titleOrContent' ? 'selected' : ''}>제목+내용</option>
            </select>

            <input type="text" name="keyword" value="${search.keyword}"
                   placeholder="검색어를 입력하세요"
                   style="flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;" />

            <button type="submit" class="btn btn-primary" style="padding: 10px 20px;">검색</button>
            <a href="${pageContext.request.contextPath}/board/list" class="btn" style="padding: 10px 20px;">전체목록</a>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            var result = '${result}';
            if(result === 'success') {
                alert('처리되었습니다.');
            }
        });
    </script>

</main>

<%@ include file="../include/footer.jsp" %>

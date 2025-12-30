<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<h2>게시글 상세</h2>

<table>
    <tr>
        <th width="20%">번호</th>
        <td>${board.boardId}</td>
    </tr>
    <tr>
        <th>제목</th>
        <td>${board.title}</td>
    </tr>
    <tr>
        <th>내용</th>
        <td style="white-space: pre-wrap;">${board.content}</td>
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
    <tr>
        <th>조회수</th>
        <td>${board.viewCnt != null ? board.viewCnt : 0}</td>
    </tr>
</table>

<div style="margin-top: 20px; text-align: center;">
    <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>

    <c:if test="${sessionScope.loginUser.userId eq board.writer}">
        <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/board/modify?boardId=${board.boardId}'">수정</button>
        <button type="button" class="btn btn-danger" onclick="deleteBoard()">삭제</button>
    </c:if>
</div>

<!-- 댓글 영역 -->
<div style="margin-top: 40px;">
    <h3>댓글 <span id="replyCnt">0</span></h3>

    <c:if test="${not empty sessionScope.loginUser}">
        <div style="margin: 20px 0;">
            <textarea id="replyContent" rows="3" style="width: 100%;" placeholder="댓글을 입력하세요"></textarea>
            <button type="button" class="btn btn-primary" onclick="addReply()" style="margin-top: 10px;">댓글 등록</button>
        </div>
    </c:if>

    <div id="replyList"></div>
</div>

<form id="deleteForm" action="${pageContext.request.contextPath}/board/remove" method="post">
    <input type="hidden" name="boardId" value="${board.boardId}" />
</form>

<script>
    // 게시글 삭제
    function deleteBoard() {
        if(confirm('정말 삭제하시겠습니까?')) {
            document.getElementById('deleteForm').submit();
        }
    }

    // 댓글 목록 조회
    function getReplyList() {
        $.ajax({
            url: '${pageContext.request.contextPath}/replies/board/${board.boardId}',
            type: 'GET',
            success: function(data) {
                var html = '';
                $('#replyCnt').text(data.length);

                if(data.length === 0) {
                    html = '<p style="text-align: center; color: #999;">댓글이 없습니다.</p>';
                } else {
                    data.forEach(function(reply) {
                        html += '<div style="border-bottom: 1px solid #ddd; padding: 15px 0;">';
                        html += '<strong>' + reply.replyer + '</strong> ';
                        html += '<span style="color: #999; font-size: 0.9em;">' + formatDate(reply.regDate) + '</span>';
                        html += '<p style="margin: 10px 0;">' + reply.content + '</p>';

                        // 본인 댓글만 수정/삭제 가능
                        if('${sessionScope.loginUser.userId}' === reply.replyer) {
                            html += '<button class="btn" onclick="modifyReply(' + reply.replyId + ', \'' + reply.content + '\')">수정</button> ';
                            html += '<button class="btn btn-danger" onclick="removeReply(' + reply.replyId + ')">삭제</button>';
                        }
                        html += '</div>';
                    });
                }
                $('#replyList').html(html);
            }
        });
    }

    // 댓글 등록
    function addReply() {
        var content = $('#replyContent').val().trim();

        if(!content) {
            alert('댓글 내용을 입력하세요.');
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/replies',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                boardId: ${board.boardId},
                content: content,
                replyer: '${sessionScope.loginUser.userId}'
            }),
            success: function() {
                $('#replyContent').val('');
                getReplyList();
            }
        });
    }

    // 댓글 수정
    function modifyReply(replyId, content) {
        var newContent = prompt('댓글 수정', content);

        if(newContent && newContent.trim() !== '') {
            $.ajax({
                url: '${pageContext.request.contextPath}/replies/' + replyId,
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({
                    content: newContent
                }),
                success: function() {
                    getReplyList();
                }
            });
        }
    }

    // 댓글 삭제
    function removeReply(replyId) {
        if(confirm('댓글을 삭제하시겠습니까?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/replies/' + replyId,
                type: 'DELETE',
                success: function() {
                    getReplyList();
                }
            });
        }
    }

    // 날짜 포맷 (JavaScript)
    function formatDate(timestamp) {
        var date = new Date(timestamp);
        return date.getFullYear() + '-' +
            ('0' + (date.getMonth() + 1)).slice(-2) + '-' +
            ('0' + date.getDate()).slice(-2) + ' ' +
            ('0' + date.getHours()).slice(-2) + ':' +
            ('0' + date.getMinutes()).slice(-2);
    }

    // 페이지 로드 시 댓글 목록 조회
    $(document).ready(function() {
        getReplyList();
    });
</script>

<%@ include file="../include/footer.jsp" %>

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
        <td>
            <div style="min-height: 200px; white-space: pre-wrap;">${board.content}</div>
        </td>
    </tr>
    <tr>
        <th>작성자</th>
        <td>${board.writer}</td>
    </tr>
    <tr>
        <th>조회수</th>
        <td>${board.viewCnt != null ? board.viewCnt : 0}</td>
    </tr>
    <tr>
        <th>작성일</th>
        <td>
            <c:set var="dateStr" value="${board.regDate.toString()}" />
            ${dateStr.substring(0, 10)} ${dateStr.substring(11, 16)}
        </td>
    </tr>
    <c:if test="${board.updateDate != null}">
        <tr>
            <th>수정일</th>
            <td>
                <c:set var="updateStr" value="${board.updateDate.toString()}" />
                    ${updateStr.substring(0, 10)} ${updateStr.substring(11, 16)}
            </td>
        </tr>
    </c:if>
</table>

<div style="margin-top: 20px; text-align: center;">
    <button type="button" class="btn"
            onclick="location.href='${pageContext.request.contextPath}/board/list?searchType=${search.searchType}&keyword=${search.keyword}'">
        목록
    </button>

    <c:if test="${sessionScope.loginUser.userId eq board.writer}">
        <button type="button" class="btn btn-primary"
                onclick="location.href='${pageContext.request.contextPath}/board/modify?boardId=${board.boardId}&searchType=${search.searchType}&keyword=${search.keyword}'">
            수정
        </button>
        <button type="button" class="btn btn-danger" onclick="deleteBoard()">삭제</button>
    </c:if>
</div>

<!-- ⭐⭐⭐ 댓글 영역 ⭐⭐⭐ -->
<div style="margin-top: 40px;">
    <h3 style="border-bottom: 2px solid #667eea; padding-bottom: 10px;">
        댓글 <span id="replyCnt" style="color: #667eea;">(0)</span>
    </h3>

    <!-- 댓글 작성 폼 -->
    <c:if test="${not empty sessionScope.loginUser}">
        <div style="margin: 20px 0; padding: 15px; background: #f8f9fa; border-radius: 5px;">
            <textarea id="replyContent" rows="3" placeholder="댓글을 입력하세요"
                      style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; resize: vertical;"></textarea>
            <div style="text-align: right; margin-top: 10px;">
                <button type="button" class="btn btn-primary" onclick="registerReply()">댓글 등록</button>
            </div>
        </div>
    </c:if>

    <c:if test="${empty sessionScope.loginUser}">
        <div style="margin: 20px 0; padding: 15px; background: #f8f9fa; border-radius: 5px; text-align: center; color: #666;">
            댓글을 작성하려면 <a href="${pageContext.request.contextPath}/member/login" style="color: #667eea;">로그인</a>이 필요합니다.
        </div>
    </c:if>

    <!-- 댓글 목록 -->
    <div id="replyList" style="margin-top: 20px;">
        <!-- 댓글이 여기에 동적으로 추가됩니다 -->
    </div>
</div>

<form id="deleteForm" action="${pageContext.request.contextPath}/board/remove" method="post">
    <input type="hidden" name="boardId" value="${board.boardId}" />
    <input type="hidden" name="searchType" value="${search.searchType}" />
    <input type="hidden" name="keyword" value="${search.keyword}" />
</form>

<script>
    const boardId = ${board.boardId};
    const contextPath = '${pageContext.request.contextPath}';
    const loginUserId = '${sessionScope.loginUser != null ? sessionScope.loginUser.userId : ""}';

    // 게시글 삭제
    function deleteBoard() {
        if(confirm('정말 삭제하시겠습니까?')) {
            document.getElementById('deleteForm').submit();
        }
    }

    // 페이지 로드 시 댓글 목록 불러오기
    $(document).ready(function() {
        loadReplyList();

        var result = '${result}';
        if(result === 'success') {
            alert('처리되었습니다.');
        }
    });

    // 댓글 HTML 생성
    function makeReplyHtml(reply) {
        const regDate = new Date(reply.regDate);
        const dateStr = regDate.getFullYear() + '-' +
            String(regDate.getMonth() + 1).padStart(2, '0') + '-' +
            String(regDate.getDate()).padStart(2, '0') + ' ' +
            String(regDate.getHours()).padStart(2, '0') + ':' +
            String(regDate.getMinutes()).padStart(2, '0');

        let html = '<div class="reply-item" style="border-bottom: 1px solid #e0e0e0; padding: 15px 0;">';
        html += '  <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">';
        html += '    <div>';
        html += '      <strong style="color: #333;">' + reply.writer + '</strong>';
        html += '      <span style="color: #999; font-size: 13px; margin-left: 10px;">' + dateStr + '</span>';
        if(reply.updateDate) {
            html += '      <span style="color: #667eea; font-size: 12px; margin-left: 5px;">(수정됨)</span>';
        }
        html += '    </div>';

        // 본인 댓글만 수정/삭제 가능
        if(loginUserId === reply.writer) {
            html += '    <div>';
            html += '      <button class="btn" style="padding: 4px 8px; font-size: 12px; margin-right: 5px;" onclick="editReply(' + reply.replyId + ', \'' + reply.content.replace(/'/g, "\\'").replace(/\n/g, "\\n") + '\')">수정</button>';
            html += '      <button class="btn btn-danger" style="padding: 4px 8px; font-size: 12px;" onclick="deleteReply(' + reply.replyId + ')">삭제</button>';
            html += '    </div>';
        }

        html += '  </div>';
        html += '  <div id="replyContent' + reply.replyId + '" style="padding: 5px 0; white-space: pre-wrap; color: #555;">' + reply.content + '</div>';
        html += '  <div id="replyEdit' + reply.replyId + '" style="display: none;">';
        html += '    <textarea id="editContent' + reply.replyId + '" rows="3" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; resize: vertical;">' + reply.content + '</textarea>';
        html += '    <div style="text-align: right; margin-top: 8px;">';
        html += '      <button class="btn btn-primary" style="padding: 6px 12px; font-size: 13px; margin-right: 5px;" onclick="updateReply(' + reply.replyId + ')">저장</button>';
        html += '      <button class="btn" style="padding: 6px 12px; font-size: 13px;" onclick="cancelEdit(' + reply.replyId + ')">취소</button>';
        html += '    </div>';
        html += '  </div>';
        html += '</div>';

        return html;
    }

    // 댓글 목록 불러오기
    function loadReplyList() {
        $.ajax({
            url: contextPath + '/replies/board/' + boardId,  // ⭐ 수정
            type: 'GET',
            success: function(replies) {
                $('#replyCnt').text('(' + replies.length + ')');

                let html = '';
                if(replies.length === 0) {
                    html = '<div style="padding: 30px; text-align: center; color: #999;">첫 댓글을 작성해보세요!</div>';
                } else {
                    replies.forEach(function(reply) {
                        html += makeReplyHtml(reply);
                    });
                }
                $('#replyList').html(html);
            },
            error: function() {
                alert('댓글 목록을 불러오는데 실패했습니다.');
            }
        });
    }

    // 댓글 등록
    function registerReply() {
        const content = $('#replyContent').val().trim();

        if(!content) {
            alert('댓글 내용을 입력하세요.');
            $('#replyContent').focus();
            return;
        }

        $.ajax({
            url: contextPath + '/replies',  // ⭐ 수정
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                boardId: boardId,
                content: content,
                replyer: loginUserId  // ⭐ writer → replyer로 변경
            }),
            success: function(result) {
                if(result === 'success') {  // ⭐ result.message → result로 변경
                    $('#replyContent').val('');
                    loadReplyList();
                }
            },
            error: function(xhr) {
                if(xhr.status === 401) {
                    alert('로그인이 필요합니다.');
                    location.href = contextPath + '/member/login';
                } else {
                    alert('댓글 등록에 실패했습니다.');
                }
            }
        });
    }

    // 댓글 수정 저장
    function updateReply(replyId) {
        const content = $('#editContent' + replyId).val().trim();

        if(!content) {
            alert('댓글 내용을 입력하세요.');
            return;
        }

        $.ajax({
            url: contextPath + '/replies/' + replyId,  // ⭐ 수정
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify({
                content: content
            }),
            success: function(result) {
                if(result === 'success') {  // ⭐ result.message → result로 변경
                    loadReplyList();
                }
            },
            error: function(xhr) {
                if(xhr.status === 403) {
                    alert('수정 권한이 없습니다.');
                } else {
                    alert('댓글 수정에 실패했습니다.');
                }
            }
        });
    }

    // 댓글 삭제
    function deleteReply(replyId) {
        if(!confirm('댓글을 삭제하시겠습니까?')) {
            return;
        }

        $.ajax({
            url: contextPath + '/replies/' + replyId,  // ⭐ 수정
            type: 'DELETE',
            success: function(result) {
                if(result === 'success') {  // ⭐ result.message → result로 변경
                    loadReplyList();
                }
            },
            error: function(xhr) {
                if(xhr.status === 403) {
                    alert('삭제 권한이 없습니다.');
                } else {
                    alert('댓글 삭제에 실패했습니다.');
                }
            }
        });
    }

</script>

<%@ include file="../include/footer.jsp" %>

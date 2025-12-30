<%-- /WEB-INF/views/member/register.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<h2>회원가입</h2>

<c:if test="${not empty error}">
  <div style="background: #f8d7da; color: #721c24; padding: 10px; margin: 20px 0; border-radius: 4px;">
      ${error}
  </div>
</c:if>

<form action="${pageContext.request.contextPath}/member/register" method="post" style="max-width: 500px; margin: 50px auto;">
  <table style="width: 100%;">
    <tr>
      <th width="30%">아이디</th>
      <td>
        <input type="text" name="userId" id="userId" required style="width: 100%;" />
        <button type="button" class="btn" onclick="checkId()" style="margin-top: 5px;">중복 체크</button>
        <span id="idCheckResult"></span>
      </td>
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
        <input type="text" name="userName" required style="width: 100%;" />
      </td>
    </tr>
    <tr>
      <th>이메일</th>
      <td>
        <input type="email" name="email" required style="width: 100%;" />
      </td>
    </tr>
  </table>

  <div style="margin-top: 20px; text-align: center;">
    <button type="submit" class="btn btn-primary" style="width: 100%;">회원가입</button>
  </div>

  <div style="margin-top: 10px; text-align: center;">
    <a href="${pageContext.request.contextPath}/member/login">로그인</a>
  </div>
</form>

<script>
  function checkId() {
    var userId = $('#userId').val().trim();

    if(!userId) {
      alert('아이디를 입력하세요.');
      return;
    }

    $.ajax({
      url: '${pageContext.request.contextPath}/member/checkId',
      type: 'GET',
      data: { userId: userId },
      success: function(result) {
        if(result === 'duplicate') {
          $('#idCheckResult').html('<span style="color: red;">이미 사용 중인 아이디입니다.</span>');
        } else {
          $('#idCheckResult').html('<span style="color: green;">사용 가능한 아이디입니다.</span>');
        }
      }
    });
  }
</script>

<%@ include file="../include/footer.jsp" %>

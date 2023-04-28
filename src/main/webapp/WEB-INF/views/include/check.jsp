<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="./head.jsp" %>
  <c:if test="${empty userinfo}">
  	<script>
  	  alert("로그인 후 이용할 수 있습니다. 로그인 해 주세요.")
  	  location.href = "../index.jsp";
    </script>
  </c:if>
</head>
<body>

</body>
</html>
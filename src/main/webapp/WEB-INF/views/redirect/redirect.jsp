<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- jstl 사용하기 위한 코드 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF_8">
<title>Trip or Trip!</title>
<script>
  alert("${msg}");
  location.href = "${url}";
</script>
</head>
<body>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<link href="${root}/assets/css/main.css" type="text/css" rel="stylesheet">
</head>

<body>
	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<button id="plan-create" class="btn btn-primary"><strong>여행 경로 만들기</strong></button>
	
</body>
<script>
	document.querySelector("#plan-create").addEventListener("click", () => {
		location.href="${root}/plan/mvplan";
	});
</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N"
	crossorigin="anonymous"></script>

</html>
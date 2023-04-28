<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/head.jsp"%>
<link href="./assets/css/main.css" type="text/css" rel="stylesheet">
	<style>
      .bg-nav {
      	background-color: #7895B2;
      }
  	</style>
</head>

<body>
	<%@ include file="/include/nav.jsp"%>
	<c:if test="${article eq null}">
		<script>
		alert("글이 삭제되었거나 부적절한 URL 접근입니다.");
		location.href = "${root}/plan?action=mvplanlist";
		</script>
	</c:if>
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10 col-sm-12">
			<h2 class="my-3 py-3 shadow-sm bg-light text-center">
				<mark class="sky">글보기</mark>
			</h2>
		</div>
		<div class="col-lg-8 col-md-10 col-sm-12">
			<div class="row my-2">
				<h2 class="text-secondary px-5">${article.title}</h2>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="clearfix align-content-center">
						<img class="avatar me-2 float-md-start bg-light p-2"
							src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg" />
						<p>
							<span class="fw-bold">${article.userId}</span> <br /> <span
								class="text-secondary fw-light"> ${article.createdAt} 조회
								: ${article.updatedAt} </span>
						</p>
					</div>
				</div>
				<div class="col-md-4 align-self-center text-end">댓글 : 17</div>
				<div class="divider mb-3"></div>
				<!-- kakao map 보여주기 -->
				<div id="map" class="shadow rounded mx-auto p-2 mb-2"
					style="width: 60em; height: 35em;"></div>
				<!-- kakao map 영역 끝 -->
				<c:forEach items="${places}" var="place">
					<div class="place_name" style="display: none;">${place.name}</div>
					<div class="address" style="display: none;">${place.address}</div>
					<div class="lat" style="display: none;">${place.lat}</div>
					<div class="lng" style="display: none;">${place.lng}</div>
				</c:forEach>
				<div class="text-secondary">${article.description}</div>
				<div class="divider mt-3 mb-3"></div>
				<div class="d-flex justify-content-end">
					<button type="button" id="btn-list"
						class="btn btn-outline-primary mb-3">여행 목록</button>
					<!-- 본인일때만 글수정, 글 삭제 버튼 보이도록 함 -->
					<c:if test="${userinfo.id eq article.userId}">
						<button type="button" id="btn-mv-modify"
							class="btn btn-outline-success mb-3 ms-1">글수정</button>
						<button type="button" id="btn-delete"
							class="btn btn-outline-danger mb-3 ms-1">글삭제</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	</div>
	<script>
	  document.querySelector("#navbar").classList.add("navbar-dark");
      document.querySelector("#btn-list").addEventListener("click", function () {
        location.href = "${root}/plan?action=mvplanlist";
      });
      document.querySelector("#btn-mv-modify").addEventListener("click", function () {
        alert("글수정하자!!!");
        location.href = "${root}/article?action=mvmodify&articleno=${article.id}";
      });
      document.querySelector("#btn-delete").addEventListener("click", function () {
        alert("글삭제하자!!!");
        location.href = "${root}/article?action=delete&articleno=${article.id}";
      });
    </script>
</body>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=991fde334716cbc5bbcac85358cf5e88&libraries=services,clusterer,drawing"></script>
<script src="./assets/js/key.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N"
	crossorigin="anonymous"></script>
<script src="./assets/js/planView.js"></script>
</html>
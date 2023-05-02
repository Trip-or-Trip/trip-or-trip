<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
<link href="${root}/assets/css/main.css" type="text/css" rel="stylesheet">
	<style>
      .bg-nav {
      	background-color: #7895B2;
      }
  	</style>
</head>

<body>
<input type="hidden" id="root" value="${root}">
	<c:if test="${article eq null}">
		<script>
		alert("글이 삭제되었거나 부적절한 URL 접근입니다.");
		location.href = "${root}/plan?action=mvplanlist";
		</script>
	</c:if>
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10 col-sm-12">
			<h2 class="my-3 py-3 shadow-sm bg-light text-center">
				글보기
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
							<span class="fw-bold">${article.userId}</span> <br /> 
							<span class="text-secondary fw-light"> ${article.createdAt} 조회 : ${article.hit} </span>
						</p>
					</div>
				</div>
				<div class="col-md-4 align-self-center text-end">댓글 : 0</div>
				<div class="divider mb-3"></div>
				<div class="container">
					<div class="row">
						<!-- kakao map 보여주기 -->
						<div id="map" class="col-md-8 shadow rounded mx-auto p-2 mb-2" style="height: 25em;"></div>
						<!-- kakao map 영역 끝 -->
						<div class="plan-box container col-md-4" style="height: 25em;">
							<div class="row">
								<div class="col-md-6">
								<label for="register-id">등록자</label>
								<input id="register-id" type="text" readonly="readonly" value="${article.userId}" class="form-control">
								</div>
								<div class="col-md-6">
								<label for="register-date">등록일</label>
								<input id="register-date" type="text" readonly="readonly" value="${article.createdAt}" class="form-control">
								</div>
							</div>
							<label for="plan-title">계획 이름</label>
							<input id="plan-title" type="text" readonly="readonly" value="${article.title}" class="form-control">
							<div class="row">
								<div class="col-md-6">
								<label for="plan-start-date">출발일</label>
								<input id="plan-start-date" type="text" readonly="readonly" value="${article.startDate}" class="form-control">
								</div>
								<div class="col-md-6">
								<label for="plan-end-date">도착일</label>
								<input id="plan-end-date" type="text" readonly="readonly" value="${article.endDate}" class="form-control">
								</div>
							</div>
							<label for="plan-description">계획 상세</label>
							<input id="plan-description" type="text" readonly="readonly" value="${article.description}" class="form-control overflow-auto" style="height: 10em;">
						</div>
					</div>
				</div>
				<div class="divider mb-4"></div>
				<h2 align="center">추천 경로</h2>
				<div id="planmap" class="col-md-8 shadow rounded mx-auto p-2 mb-2" style="height: 25em;"></div>
				<div class="d-flex center flex-row">
					<c:forEach items="${fastPlaces}" var="fastPlace" varStatus="status">
					<div class="border border-4 rounded me-1 p-2" style="width: 20%">
						<div class="travel-info">
							<strong id="fast_place_name" class="fast_place_name">${fastPlace.name}</strong>
							<p id="fast_address" class="fast_address">${fastPlace.address}</p>
							<div id = "fast_lat" class="fast_lat" style="display: none;">${fastPlace.lat}</div>
							<div id = "fast_lng" class="fast_lng" style="display: none;">${fastPlace.lng}</div>
							<div id = "fast_img" class="fast_img" style="display: none;">${fastPlace.imageUrl}</div>
						</div>
					</div>
					<c:if test="${!status.last}">
						<div class="d-flex align-items-center">
							<img src="${root}/assets/img/icon/arrows.png" alt="화살표" style="width: 3em; height: 3em;">
						</div>
					</c:if>
					</c:forEach>
				</div>
				<div class="divider mb-3"></div>
				<div class="align-middle">
				<h2>타임 라인</h2>
				<c:forEach items="${places}" var="place" varStatus="status">
				<c:choose>
					<c:when test="${status.index%2==0}">
					<div class="mb-2 container row" style="margin:100 auto;">
						<div class="col-md-8 p-3 travel-box d-flex flex-row align-content-center border border-4 rounded" style="width: 50%; margin:0 auto;">
							<c:if test="${place.imageUrl eq '/'}">
							<img src="${root}/assets/img/noimage.png" alt="${place.name}" style="width: 50%" class="me-2">
							</c:if>
							<c:if test="${place.imageUrl ne '/'}">
							<img src="${place.imageUrl}" alt="${place.name}" style="width: 50%" class="me-2">
							</c:if>
							<div class="travel-info">
								<h2 class="place_name">${place.name}</h2>
								<p class="address">${place.address}</p>
								<div class="lat" style="display: none;">${place.lat}</div>
								<div class="lng" style="display: none;">${place.lng}</div>
							</div>
						</div>
						<div class="col-md-4" style="width: 10em;"></div>
					</div>
					</c:when>
					<c:otherwise>
					<div class="mb-2 row">
						<div style="width: 10em;" class="col-md-4"></div>
						<div class="col-md-8 p-3 travel-box d-flex flex-row align-content-center border border-4 rounded" style="width: 50%; margin:0 auto;">
							<c:if test="${place.imageUrl eq '/'}">
							<img src="${root}/assets/img/noimage.png" alt="${place.name}" style="width: 50%" class="me-2">
							</c:if>
							<c:if test="${place.imageUrl ne '/'}">
							<img src="${place.imageUrl}" alt="${place.name}" style="width: 50%" class="me-2">
							</c:if>
							<div class="travel-info">
								<h2 class="place_name">${place.name}</h2>
								<p class="address">${place.address}</p>
								<div class="lat" style="display: none;">${place.lat}</div>
								<div class="lng" style="display: none;">${place.lng}</div>
							</div>
						</div>
					</div>
					</c:otherwise>
				</c:choose>
				</c:forEach>
				</div>
				<div class="divider mt-3 mb-3"></div>
				<div class="d-flex justify-content-end">
					<button type="button" id="btn-list"
						class="btn submit-btn mb-3">여행 목록</button>
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
        location.href = "${root}/plan/mvplanlist?pgno=${param.pgno}&key=${param.key}&word=${param.word}";
      });
      document.querySelector("#btn-mv-modify").addEventListener("click", function () {
    	  alert("서비스 준비중입니다.");
        /* location.href = "${root}/plan/modify?articleno=${article.id}&pgno=${param.pgno}&key=${param.key}&word=${param.word}"; */
      });
      document.querySelector("#btn-delete").addEventListener("click", function () {
        if(confirm("정말로 삭제하시겠습니까?")){
	        location.href = "${root}/plan/delete?articleno=${article.id}";
        }
      });
    </script>
</body>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=59e882a5fca53baf25f45f5258f75f43&libraries=services,clusterer,drawing"></script>
<script src="${root}/assets/js/key.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N"
	crossorigin="anonymous"></script>
<script src="${root}/assets/js/planView.js"></script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</html>
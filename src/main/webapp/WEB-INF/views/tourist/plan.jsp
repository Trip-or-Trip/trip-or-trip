<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/head.jsp"%>
<link href="./assets/css/main.css" type="text/css" rel="stylesheet">
</head>

<body>
	<%@ include file="/include/nav.jsp"%>
	<main class="container">
	<div>
		<form class="d-flex my-3" onsubmit="return false;" role="search">
			<input id="search-keyword" class="form-control me-2" type="search"
				placeholder="검색어" aria-label="검색어" />
			<button id="btn-search" class="btn submit-btn" type="button"
				style="width: 10em">검색</button>
		</form>
	</div>
	<div class="">
		<section class="position-relative">
			<div class="position-absolute d-flex flex-row translate-middle-x z-3 buttons mb-2 mx-auto p-2" style="right: 0px;">
				<button
					class="z-3 btn delete-btn shadow p-2 me-2"
					id="plan-delete-btn" type="button" style="width: 4em; height: 2.5em; display: none;">초기화</button>
				<button
					class="place-add z-3 btn submit-btn shadow p-2"
					id="plan-add-btn" type="button" style="display: none; width: 4em; height: 2.5em;">추가</button>
			</div>
			<!-- map이 들어갈 위치 -->
			<!-- kakao map start -->
			<div id="map" class="shadow rounded mx-auto p-2"
				style="width: 90%; height: 35em;">
			</div>
			<!-- kakao map end -->
		</section>
		<div class="divider mb-5"></div>
		<aside>
			<!-- 여행 계획 들어가는 영역 -->
			<div class="d-flex flex-column justify-content-center mx-auto p-2"
				style="width: 100%; height: 35em;">
				<h3 id="plan-title" class="text-center p-2"><strong>여행 계획</strong></h3>
				<form id="plan-form" onsubmit="return false;" role="search"
					method="POST">
					<input type="hidden" name="action" value="save">
					<div>
						<div>
							<div id="plan-content" class ="rounded bg-light shadow mb-2 mx-auto p-2 overflow-auto d-flex justify-content-center" style= "width: 100%; height: 10em;">
							</div>
						</div>
						<div class="divider mb-3"></div>
						<div id="plan-detail" class = "d-flex flex-column align-items-center rounded mx-auto">
						    <label for="name" ><strong>계획 이름</strong></label>
						    <input type="text" name="title" id="title" placeholder="계획 이름" class="plan-detail-content align-middle ms-2 mt-2 rounded shadow border-light-subtle" style="width: 70%;">
						    <br>
						    <div class="plan-detail-date d-flex flex-row justify-content-between mb-3" style="width: 70%;">
							    <label for="start_datepicker" ><strong>출발일</strong></label>
							    <input type="date" name="start_date" id="start_datepicker" placeholder="년도-월-일" style="width: 8em; height: 1.8em;"class="plan-detail-content plan-detail-start ms-2 me-2 align-middle rounded shadow border-light-subtle">
							    <label for="end_datepicker"><strong>도착일</strong></label>
							    <input type="date" name="end_date" id="end_datepicker" placeholder="년도-월-일" style="width: 8em; height: 1.8em;" class="plan-detail-content plan-detail-end ms-2 me-2 align-middle rounded shadow border-light-subtle">
						    </div>
						    <label for="description"><strong>상세 계획</strong></label>
						    <textarea name="description" id="description" placeholder="상세 계획을 적어보자!" class="plan-detail-content align-middle ms-2 mt-2 rounded shadow border-light-subtle" style="width: 70%; height: 10em;"></textarea>
						    <br>
							<button
								class="place-add z-3 border rounded btn btn-primary shadow p-2"
								id="plan-save-btn" style="top: 5px; left: 120px;" type="button"><strong>여행 계획 저장</strong></button>
					    </div>
				    </div>
				</form>
			</div>
		</aside>
	</div>
	<div class="divider mb-5"></div>
	</main>
</body>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=991fde334716cbc5bbcac85358cf5e88&libraries=services,clusterer,drawing"></script>
<script src="./assets/js/key.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N"
	crossorigin="anonymous"></script>
<script src="./assets/js/plan.js"></script>

</html>
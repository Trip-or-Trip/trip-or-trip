<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<link href="${root}/assets/css/main.css" type="text/css" rel="stylesheet">
	<style>
      .bg-nav {
      	background-color: #7895B2;
      }
  	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10 col-sm-12">
			<h2 class="my-3 py-3 rounded shadow-sm bg-light text-center">
				여행 목록
			</h2>
		</div>
		<div class="col-lg-8 col-md-10 col-sm-12">
			<div class="row align-self-center mb-2">
				<div class="col-md-2 text-start">
						<button id="plan-create" class="btn submit-btn">
							<strong>여행 만들기</strong>
						</button>
				</div>
				<div class="col-md-7 offset-3">
					<form class="d-flex" id="form-search" action="">
						<input type="hidden" name="action" value="mvplanlist" /> <input
							type="hidden" name="pgno" value="1" /> <select name="key"
							id="key" class="form-select form-select-sm ms-5 me-1 w-50"
							aria-label="검색조건">
							<option selected>검색조건</option>
							<option value="id">글번호</option>
							<option value="title">제목</option>
							<option value="user_id">작성자</option>
						</select>
						<div class="input-group input-group-sm">
							<input type="text" name="word" id="word" class="form-control"
								placeholder="검색어..." />
							<button id="btn-search" class="btn btn-dark" type="button">검색</button>
						</div>
					</form>
				</div>
			</div>
			<table class="table table-hover">
				<thead>
					<tr class="text-center">
						<th scope="col">글번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">조회수</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articles}">
						<tr class="text-center">
							<th scope="row">${article.id}</th>
							<td class="text-start"><a href="#"
								class="article-title link-dark" data-no="${article.id}"
								style="text-decoration: none"> ${article.title} </a></td>
							<td>${article.userId}</td>
							<td>${article.hit}</td>
							<td>${article.createdAt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row">${navigation.navigator}</div>
	</div>
	</div>
	<form id="form-param" method="get" action="">
		<input type="hidden" id="p-action" name="action" value=""> <input
			type="hidden" id="p-pgno" name="pgno" value=""> <input
			type="hidden" id="p-key" name="key" value=""> <input
			type="hidden" id="p-word" name="word" value="">
	</form>
	<script>
	document.querySelector("#navbar").classList.add("navbar-dark");
	document.querySelector("#plan-create").addEventListener("click", function () {
		location.href="${root}/plan/mvplan?pgno=${param.pgno}&key=${param.key}&word=${param.word}";
	});
	</script>
	<script>
      let titles = document.querySelectorAll(".article-title");
      titles.forEach(function (title) {
        title.addEventListener("click", function () {
          console.log(this.getAttribute("data-no"));
          location.href = "${root}/plan/view?articleno=" + this.getAttribute("data-no")+"&pgno=${param.pgno}&key=${param.key}&word=${param.word}";
        });
      });
      
      document.querySelector("#btn-search").addEventListener("click", function () {
    	  let form = document.querySelector("#form-search");
          form.setAttribute("action", "${root}/plan");
          form.submit();
      });
      
      let pages = document.querySelectorAll(".page-link");
      pages.forEach(function (page) {
        page.addEventListener("click", function () {
          console.log(this.parentNode.getAttribute("data-pg"));
          document.querySelector("#p-action").value = "mvplanlist";
       	  document.querySelector("#p-pgno").value = this.parentNode.getAttribute("data-pg");
       	  document.querySelector("#p-key").value = "${param.key}";
       	  document.querySelector("#p-word").value = "${param.word}";
          document.querySelector("#form-param").submit();
        });
      });
    </script>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N"
	crossorigin="anonymous"></script>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/include/head.jsp" %>
  <script src="https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js" integrity="sha384-GNFwBvfVxBkLMJpYMOABq3c+d3KnQxudP/mGPkzpZSTYykLBNsZEnG2D9G/X/+7D" crossorigin="anonymous" async></script>
  <link rel="stylesheet" href="assets/css/main.css">
  
  <style>
    .bg-nav {
      background-color: #7895B2;
    }
  </style>
</head>
<body>
  <%@ include file="/include/nav.jsp" %>
  <!-- <%@ include file="/include/check.jsp" %> -->

  <main>
    <div class='m-5'>
      <div class='px-5'>
        <h3 class='mb-4' style='float: left;'>핫플레이스 목록</h3>
        <div style='float: right;'>
          <button class='btn submit-btn mt-2 px-3 py-1' data-bs-toggle="modal" data-bs-target="#hotplaceModal">핫플
            추가하기</button>
        </div>
        
        <!-- 핫플레이스 추가 modal start -->
        <form class="d-flex" id="hotplace-form" method="POST" role="search" enctype="multipart/form-data">
          <div class="modal fade mt-5" id="hotplaceModal" tabindex="-1" aria-labelledby="exampleModalLabel"
          aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">핫플 자랑하기</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <div class="login-container text-center">
                    <div style="display: inline-block; width: 25rem;">
                      <input type="hidden" id="action" name="action" value="insert">
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type='file' class="form-control my-3 px-3 py-2" accept="image/jpeg, image/png, image/jpg" id="hotplace-image" name="hotplace-image" placeholder="이미지" required>
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="text" class="form-control my-3 px-3 py-2" id="hotplace-tag1" name="hotplace-tag1" placeholder="해시태그1">
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="text" class="form-control my-3 px-3 py-2" id="hotplace-tag2" name="hotplace-tag2" placeholder="해시태그2">
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="date" class="form-control my-3 px-3 py-2" id="hotplace-join-date" name="hotplace-join-date" placeholder="방문 날짜">
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type='text' class="form-control my-3 px-3 py-2" id="hotplace-addr" name="hotplace-addr" placeholder="주소" required>
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <textarea rows="4" class="form-control my-3 px-3 py-2 h-20" id="hotplace-desc" name="hotplace-desc" placeholder="설명"></textarea>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" id='hotplace-btn' class="btn submit-btn">등록</button>
                </div>
              </div>
            </div>
          </div>
        </form>
        <!-- 핫플레이스 추가 modal end -->
      </div>
    </div>

    <div style='height: 70px;'></div>

    <div id='hotplace-container' class='px-3 mx-5'>
      <!-- 비동기로 핫플레이스 가져오기 -->
        
        <!-- 핫플 카드 start -->
        <c:forEach var="hotplace" items="${hotplaces}" varStatus="status">
        	<c:if test="${status.index % 3 == 0}">
        	  <div class="row">
        	</c:if>
	          <div class="col-lg-4 col-md-6 col-sm-12 mb-5 px-3">
		        <div class="card hotplace-card px-3 py-2 mx-2">
		          <div class="card-title mt-3 mb-3">
		            <div class="mx-2">
		              <img src="assets/img/user.png" class="hotplace-profile-img me-3">
		              <span>${hotplace.userId}</span>
		            </div>
		          </div>
		          <div class="card-img-container">
		            <img src="upload/hotplace/${hotplace.image}" class="card-img">
		          </div>
		            
		          <div class="card-body">
		            <div class="mt-2 cart-text">
		              <div class="mb-2">
		                <i class="hotplace-icon bi bi-chat-square-heart me-3"></i>
		                <i class="hotplace-icon bi bi-geo-alt me-3"></i>
		                <i class="hotplace-icon bi bi-sign-turn-right"></i>
		              </div>
		              <div>
		              	<c:if test="${tag1 ne ''}">
		              	<div class="mb-2">
		              	  <span class="me-2">${hotplace.tag1}</span>
		              	  <span class="me-2">${hotplace.tag2}</span>
		              	</div>
		              	</c:if>
		                <p class="mb-2">${hotplace.addr}</p>
		                <p class="mb-3">${hotplace.desc}</p>
		                <p style="font-size: 0.9rem;">${hotplace.joinDate}</p>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		    <c:if test="${status.index % 3 == 2}">
        	  </div>
        	</c:if>
        </c:forEach>
        <!-- 핫플 카드 end -->

		<!-- <img src="upload/hotplace/background.jpg"> -->
      </div>
    </div>
  </main>
  
  <script>
  	document.querySelector("#navbar").classList.add("navbar-dark");
  	document.getElementById("hotplace-btn").addEventListener("click", function() {
  		let image = document.querySelector("#hotplace-image").value;
  		let date = document.querySelector("#hotplace-join-date").value;
  		let addr = document.querySelector("#hotplace-addr").value;
  		let desc = document.querySelector("#hotplace-desc").value;
		if(!image) {
			alert("이미지를 첨부해 주세요.");
		}
		else if(!date) {
			alert("방문 날짜를 입력해 주세요.");
		}
		else if(!addr) {
			alert("주소를 입력해 주세요.");
		}
		else if(!desc || desc.length > 400)
  			alert("400자 이하로 입력해 주세요.");
  		else {
  			let form = document.querySelector("#hotplace-form");
  			form.setAttribute("action", "${root}/hotplace");
  			form.submit();
  		}
  	});
  </script>
  <%@ include file="/include/footer.jsp" %>
</body>
</html>
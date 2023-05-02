<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
  <link rel="stylesheet" href="${root}/assets/css/main.css">
  
  <style>
    .bg-nav {
      background-color: #7895B2;
    }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/nav.jsp" %>

  <main>
    <div class='m-5'>
      <div class='px-5'>
        <h3 class='mb-4' style='float: left;'>핫플레이스 목록</h3>
        <div style='float: right;'>
          <button class='btn submit-btn mt-2 px-3 py-1' data-bs-toggle="modal" data-bs-target="#hotplaceModal">핫플
            추가하기</button>
        </div>
        
        <!-- 핫플레이스 추가 modal start -->
        <form class="d-flex" id="hotplace-form" method="POST" action="${root}/hotplace/insert" role="search" enctype="multipart/form-data">
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
                      <input type="hidden" id="root" value="${root}">
                      <input type="hidden" id="hotplace-latitude" name="latitude">
                      <input type="hidden" id="hotplace-longitude" name="longitude">
                      <input type="hidden" id="hotplace-map-url" name="mapUrl">
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type='file' class="form-control my-3 px-3 py-2" accept="image/jpeg, image/png, image/jpg" id="hotplace-image" name="hotplace-image" placeholder="이미지" required>
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type='text' class="form-control my-3 py-2" id="hotplace-title" name="title" placeholder="장소명" required>
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="date" class="form-control my-3 px-3 py-2" id="hotplace-join-date" name="joinDate" placeholder="방문 날짜">
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <textarea rows="4" class="form-control my-3 px-3 py-2 h-20" id="hotplace-desc" name="desc" placeholder="설명"></textarea>
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="text" class="form-control my-3 px-3 py-2" id="hotplace-tag1" name="tag1" placeholder="해시태그1">
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="text" class="form-control my-3 px-3 py-2" id="hotplace-tag2" name="tag2" placeholder="해시태그2">
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
        
        
        <!-- 핫플레이스 수정 modal start -->
        <form class="d-flex" id="hotplace-update-form" method="POST" action="${root}/hotplace/update" role="search" enctype="multipart/form-data">
          <div class="modal fade mt-5" id="hotplaceUpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel"
          aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">핫플 수정하기</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <div class="login-container text-center">
                    <div style="display: inline-block; width: 25rem;">
                      <input type="hidden" id="hotplace-update-latitude" name="latitude">
                      <input type="hidden" id="hotplace-update-longitude" name="longitude">
                      <input type="hidden" id="hotplace-update-map-url" name="mapUrl">
                      <input type="hidden" id="hotplace-update-num" name="num" value="">
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type='file' class="form-control my-3 px-3 py-2" accept="image/jpeg, image/png, image/jpg" id="hotplace-update-image" name="hotplace-update-image" placeholder="이미지" required>
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type='text' class="form-control my-3 py-2" id="hotplace-update-title" name="title" placeholder="장소명" required>
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="date" class="form-control my-3 px-3 py-2" id="hotplace-update-join-date" name="joinDate" placeholder="방문 날짜">
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <textarea rows="4" class="form-control my-3 px-3 py-2 h-20" id="hotplace-update-desc" name="desc" placeholder="설명"></textarea>
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="text" class="form-control my-3 px-3 py-2" id="hotplace-update-tag1" name="tag1" placeholder="해시태그1">
                        </div>
                      </div>
                      <div class="row d-flex justify-content-center">
                        <div class="col-10">
                          <input type="text" class="form-control my-3 px-3 py-2" id="hotplace-update-tag2" name="tag2" placeholder="해시태그2">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" id='hotplace-update-btn' class="btn submit-btn">등록</button>
                </div>
              </div>
            </div>
          </div>
        </form>
        <!-- 핫플레이스 수정 modal end -->
        
      </div>
    </div>

    <div style='height: 70px;'></div>

    <div id='hotplace-container' class='px-3 mx-5'>
      <!-- 비동기로 핫플레이스 가져오기 -->
        
        <!-- 핫플 카드 start -->
       	<div class="row" data-masonry='{"percentPosition": true}'>
        <c:forEach var="hotplace" items="${hotplaces}" varStatus="status">
	          <div class="col-xxl-3 col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-5 px-3">
		        <div class="card hotplace-card px-3 py-2 mx-2">
		          <div class="card-title mt-3 mb-3">
		            <div class="row">
		              <div class="ms-2 col-8 justify-content-start">
		                <img src="${root}/assets/img/user.png" class="hotplace-profile-img me-3">
		                <span>${hotplace.userId}</span>
		              </div>
		              <div class="col-3 justify-content-end">
		              	<c:if test="${userinfo.id eq hotplace.userId}">
		      			  <div class="dropdown">
  							<button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
    						  menu
  							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
    						  <li><a class="dropdown-item ${hotplace.num}" id="hotplace-update-modal-btn">핫플레이스 수정</a></li>
   							  <li><a class="dropdown-item" href="${root}/hotplace/delete/${hotplace.num}">핫플레이스 삭제</a></li>
  							</ul>
						  </div>
		              	</c:if>
		              </div>
		            </div>
		            
		          </div>
		          <div class="card-img-container">
		            <img src="/hotplace/image/${hotplace.image}" class="card-img">
		          </div>
		            
		          <div class="card-body">
		            <div class="mt-2 cart-text">
		              <div class="mb-2">
		                <!-- <i class="hotplace-icon bi bi-chat-square-heart me-3"></i> -->
		                <i class="hotplace-icon bi bi-geo me-3" title="지도 보기"></i>
		                <a href="${hotplace.mapUrl}" target="_blank" style="color: black;"><i class="hotplace-icon bi bi-geo-alt me-3" title="카카오맵 검색"></i></a>
		                <a href="https://map.kakao.com/link/to/${hotplace.title},${hotplace.latitude},${hotplace.longitude}" target="_blank"  style="color: black;"><i class="hotplace-icon bi bi-sign-turn-right" title="길 찾기"></i></a>
		              </div>
		              <div>
		              	<c:if test="${tag1 ne ''}">
		              	<div class="mb-2">
		              	  <span class="me-2">#${hotplace.tag1}</span>
		              	  <span class="me-2">#${hotplace.tag2}</span>
		              	</div>
		              	</c:if>
		                <%-- <p class="mb-2">${hotplace.title}</p> --%>
		                <p class="mb-3">${hotplace.desc}</p>
		                <p style="font-size: 0.9rem;">${hotplace.joinDate}</p>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
        </c:forEach>
        </div>
        <!-- 핫플 카드 end -->

		<!-- <img src="upload/hotplace/background.jpg"> -->
      </div>
    </div>
  </main>
  
  <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=74afa46ef6c4beac029af5a59d571a47&libraries=services,clusterer,drawing"></script>
  <script src="https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js" integrity="sha384-GNFwBvfVxBkLMJpYMOABq3c+d3KnQxudP/mGPkzpZSTYykLBNsZEnG2D9G/X/+7D" crossorigin="anonymous" async></script>
  <script type="text/javascript" src="${root}/assets/js/hotplace.js"></script>
  <script>
    
    document.querySelector("#hotplace-update-modal-btn").addEventListener("click", function() {
    	let modal = new bootstrap.Modal(document.querySelector("#hotplaceUpdateModal"), {
    		backdrop: true,
            keyboard: false,
    	});
    	let num = this.className.split(" ")[1];
    	fetch(`${root}/hotplace/view/\${num}`)
    		.then((response) => response.json())
    		.then((data) => {
    			document.querySelector("#hotplace-update-num").value = num;
    			document.querySelector("#hotplace-update-latitude").value = data.latitude;
    			document.querySelector("#hotplace-update-longitude").value = data.longitude;
    			document.querySelector("#hotplace-update-map-url").value = data.mapUrl;
    			document.querySelector("#hotplace-update-title").value = data.title;
    			document.querySelector("#hotplace-update-join-date").value = data.joinDate.substr(0, 10);
    			document.querySelector("#hotplace-update-desc").value = data.desc;
    			document.querySelector("#hotplace-update-tag1").value = data.tag1;
    			document.querySelector("#hotplace-update-tag2").value = data.tag2;
    			modal.show();
    		});
    });
  </script>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
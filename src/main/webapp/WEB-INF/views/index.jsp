<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
  <link rel="stylesheet" href="${root}/assets/css/main.css">
</head>

<body>
  <%@ include file="/WEB-INF/views/include/nav.jsp" %>
  
  <main>
    <section class="mb-3">
      <div id="main-container">
        <div id="info-message">
          <h1 id="title-header" class="mb-5">
            <span>T</span><span>r</span><span>i</span><span>p</span>
            <span>o</span><span>r</span>
            <span>T</span><span>r</span><span>i</span><span>p</span><span>!</span>
            <!-- <b>Trip or Trip!</b> -->
          </h1>
          <p style="font-size: 1.5rem;">
            <b
              <c:if test="${not empty userinfo}">
    	  	    style="visibility: hidden;"
    		  </c:if>
    		>로그인 후 이용 가능합니다</b>
          </p>
        </div>
      </div>
    </section>
    <section id="service-list" class="service-list">
      <div class="container">
        <div class="row justify-content-center">
          <!-- 서비스 기능 start -->
          <div class="col-lg-3 col-md-3 service-item d-flex mb-3 mx-3" data-aos="fade-up">
            <div class="icon flex-shrink-0 me-3 mt-2">
              <!-- <i class="bi bi-globe-central-south-asia"></i> -->
              <i class="bi bi-search"></i>
            </div>
            <div class="mt-3 mb-2">
              <h4 class="title">지역별 검색</h4>
              <p class="description">
                검색 지역을 군/구 단위로 선택해 관광지를 검색합니다.<br />
                우리 동네에는 어떤 볼 것이 있을까요?
              </p>
              <a href="${root}/tourist/region">
                <span>Learn More</span><i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>
          <!-- 서비스 기능 end -->

          <!-- 서비스 기능 start -->
          <div class="col-lg-3 col-md-3 service-item d-flex mb-3 mx-3" data-aos="fade-up">
            <div class="icon flex-shrink-0 me-3 mt-2">
              <i class="bi bi-airplane-engines"></i>
            </div>
            <div class="mt-3 mb-2">
              <h4 class="title">여행 경로</h4>
              <p class="description">
                여행에 방문할 새로운 관광지를 추가하고 여행 경로를 확인합니다.<br />
                나만의 Trip or Trip!을 함께 떠나볼까요?
              </p>
              <a href="${root}/plan/mvplanlist?pgno=1&key=&word=">
                <span>Learn More</span><i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>
          <!-- 서비스 기능 end -->
		</div>
		<div class="row justify-content-center">
          <!-- 서비스 기능 start -->
          <div class="col-lg-3 col-md-3 service-item d-flex mb-3 mx-3" data-aos="fade-up">
            <div class="icon flex-shrink-0 me-3 mt-2">
              <!-- <i class="bi bi-moon-stars"></i> -->
              <i class="bi bi-bookmark-star"></i>
            </div>
            <div class="mt-3 mb-2">
              <h4 class="title">핫플레이스</h4>
              <p class="description">
                다른 사람에게 소개하고 싶은 나만의 장소가 있나요?<br>
                핫플레이스를 공유하고, 새로운 핫플레이스를 추천받으세요!
              </p>
              <a href="${root}/hotplace/list">
                <span>Learn More</span><i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>
          <!-- 서비스 기능 end -->
          
          <!-- 서비스 기능 start -->
          <div class="col-lg-3 col-md-3 service-item d-flex mb-3 mx-3" data-aos="fade-up">
            <div class="icon flex-shrink-0 me-3 mt-2">
              <!-- <i class="bi bi-moon-stars"></i> -->
              <i class="bi bi-archive"></i>
            </div>
            <div class="mt-3 mb-2">
              <h4 class="title">게시판</h4>
              <p class="description">
                Trip or Trip의 공지사항을 확인해보세요!<br>
                사람들과 다양한 이야기를 나누어 보세요!
              </p>
              <a href="${root}/board/list?pgno=1&key=&word=">
                <span>Learn More</span><i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>
          <!-- 서비스 기능 end -->
        </div>
      </div>
    </section>
  </main> 
  
  <script>	  
	  document.getElementById("delete-btn").addEventListener("click", function() {
		 if(confirm("진짜 탈퇴하시나요?")) {
			 location.href = "${root}/user/delete/${userinfo.id}";
		 }
	  });
	  
	  document.getElementById("update-btn").addEventListener("click", function() {
		  let pw = document.getElementById('update-password').value;
	
		  // 입력값 검증
		  if (pw == '') {
		    alert("빈칸이 없도록 입력해주세요.");
		    return;
		  } else {
		    let form = document.querySelector("#update-form");
		    form.submit();
		  }
	  });
  </script>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  
</body>
</html>
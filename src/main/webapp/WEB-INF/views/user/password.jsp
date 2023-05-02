<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
  <link rel="stylesheet" href="${root}/assets/css/main.css">
  
  <script type="text/javascript" src="${root}/assets/js/rsa.js"></script>
  <script type="text/javascript" src="${root}/assets/js/jsbn.js"></script>
  <script type="text/javascript" src="${root}/assets/js/prng4.js"></script>
  <script type="text/javascript" src="${root}/assets/js/rng.js"></script>
  
  <style>
    body {
	  text-align: center;
	}
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/nav.jsp" %>
  
  <div class="sign-container">
      <div class="find-password">
        <form id="find-form" method="POST" action="${root}/user/password" role="search">
          <input type="hidden" name="action" value="signin">
          <input type="hidden" id="signin-RSAModulus" value="${RSAModulus}"/>
    	  <input type="hidden" id="signin-RSAExponent" value="${RSAExponent}"/>
       	  <input type="hidden" id="signin-encode-id" name="encode-id">
       	  <input type="hidden" id="signin-encode-password" name="encode-password">
        		
          <div class="row mt-4 ms-2">
	        <h2>비밀번호 찾기</h2>
	      </div>
	      <hr>
	      <div class="row d-flex justify-content-center my-4">
	        <div class="col-10">
	          <input type="text" class="form-control" name="name" id="find-name" placeholder="이름">
			</div>
	      </div>
	      <div class="row d-flex justify-content-center mt-4 mb-3">
	        <div class="col-5">
	          <input type="text" class="form-control" name="emailId" id="find-email-id" placeholder="이메일">
	        </div>
	        <div class="col-1 mt-1">@</div>
	        <div class="col-4">
	          <select class="form-control" name="emailDomain" id="find-email-domain">
	          	<option value="none" selected="selected">도메인 선택</option>
	          	<option value="naver.com">naver.com</option>
	          	<option value="gmail.com">gmail.com</option>
	          </select>
	        </div>
	      </div>
	      <div class="row d-flex justify-content-center my-4">
	        <div class="col-10">
	          <button type="button" id="find-password-btn" class="btn submit-btn" style="width: 100%">비밀번호 찾기</button>
	        </div>
	      </div>
        </form>
      </div>
    </div>
  
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  
  <script>
  	document.querySelector("#find-password-btn").addEventListener("click", function() {
  		let name = document.querySelector("#find-name").value;
  		let emailId = document.querySelector("#find-email-id").value;
  		let emailDomain = document.querySelector("#find-email-domain").value;
  		
  		if(name == '' || emailId == '' || emailDomain == 'none')
  			alert("빈칸이 없도록 입력해 주세요.");
  		else {
			location.href = `${root}/user/password/\${name}/\${emailId}/\${emailDomain}`;
  		}
  	});
  	
  </script>
</body>
</html>
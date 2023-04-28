<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <%@ include file="/include/head.jsp" %>
  <link rel="stylesheet" href="assets/css/main.css">
  
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
<%@ include file="/include/nav.jsp" %>

	<div class="sign-container">
        <div class="signin">
        	<form id="signin-form" method="POST" role="search">
        		<input type="hidden" name="action" value="signin">
                <input type="hidden" id="signin-RSAModulus" value="${RSAModulus}"/>
    			<input type="hidden" id="signin-RSAExponent" value="${RSAExponent}"/>
       			<input type="hidden" id="signin-encode-id" name="signin-encode-id">
       			<input type="hidden" id="signin-encode-password" name="signin-encode-password">
        		
        		<div class="row mt-4 ms-2">
	            	<h2>로그인</h2>
	            </div>
	            <hr>
	            <div class="row d-flex justify-content-center my-4">
	            	<div class="col-10">
	                	<input type="text" class="form-control" name="signin-id" id="signin-id" placeholder="아이디">
					</div>
	            </div>
	            <div class="row d-flex justify-content-center my-4">
	            	<div class="col-10">
	                	<input type="password" class="form-control" name="signin-password" id="signin-password" placeholder="비밀번호">
	            	</div>
	            </div>
	            <div class="row d-flex justify-content-center my-4">
	                <div class="col-10">
	                	<button type="button" id="signin-btn" class="btn submit-btn" style="width: 100%">로그인</button>
	                </div>
	            </div>
        	</form>
        </div>
    </div>
    
    
    <script>
	  document.getElementById('signin-btn').addEventListener("click", function() {
		  let id = $("#signin-id").val();
	      let pw = $("#signin-password").val();
		  
		  // 입력값 검증
		  if(!document.querySelector("#signin-id").value) {
			alert("아이디를 입력해주세요.");
		  }
		  else if(!document.querySelector("#signin-password").value) {
			alert("비밀번호를 입력해주세요.");
		  }
		  else {
			  let rsa = new RSAKey();
			  rsa.setPublic($('#signin-RSAModulus').val(),$('#signin-RSAExponent').val());
				
			  $("#signin-encode-id").val(rsa.encrypt(id));
		      $("#signin-encode-password").val(rsa.encrypt(pw));
		        
		      document.getElementById('signin-id').value = "";
		      document.getElementById('signin-password').value = "";
		        
			  let form = document.querySelector("#signin-form");
			  form.setAttribute("action", "${root}/user");
			  form.submit();
		  }
	  });
    </script>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>
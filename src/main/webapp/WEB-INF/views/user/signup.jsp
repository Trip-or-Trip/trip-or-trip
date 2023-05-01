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
        <div class="signup">
        	<form id="signup-form" method="POST" action="${root}/user/signup" role="search">
        		<input type="hidden" name="action" value="signup">
                <input type="hidden" id="signup-RSAModulus" value="${RSAModulus}"/>
    			<input type="hidden" id="signup-RSAExponent" value="${RSAExponent}"/>
       			<input type="hidden" id="signup-encode-id" name="signup-encode-id">
       			<input type="hidden" id="signup-encode-password" name="signup-encode-password">
        		<input type="hidden" id="signup-encode-name" name="signup-encode-name">
       			<input type="hidden" id="signup-encode-email" name="signup-encode-email">
       			
        		<div class="row mt-4 ms-2">
	            	<h2>회원가입</h2>
	            </div>
	            <hr>
	            <div class="row d-flex justify-content-center my-4">
	            	<div class="col-10">
	                	<input type="text" class="form-control" name="id" id="signup-id" placeholder="아이디">
					</div>
	            </div>
	            <div class="row d-flex justify-content-center my-4">
	            	<div class="col-10">
	                	<div id="check-id-result"></div>
					</div>
	            </div>
	            <div class="row d-flex justify-content-center login_pw my-4">
	            	<div class="col-10">
	                	<input type="password" class="form-control" name="password" id="signup-password" placeholder="비밀번호">
	            	</div>
	            </div>
	            <div class="row d-flex justify-content-center login_pw my-4">
	            	<div class="col-10">
	                	<input type="password" class="form-control" name="signup-check-password" id="signup-check-password" placeholder="비밀번호 확인">
	            	</div>
	            </div>
	            <div class="row d-flex justify-content-center my-4">
	            	<div class="col-10">
	                	<input type="text" class="form-control" name="name" id="signup-name" placeholder="이름">
					</div>
	            </div>
	            <div class="row d-flex justify-content-center my-4">
	            	<div class="col-5">
	                	<input type="text" class="form-control" name="emailId" id="signup-email-id" placeholder="이메일">
					</div>
					@
					<div class="col-5">
						<select class="form-control" name="emailDomain" id="signup-email-domain">
							<option value="none" selected="selected">도메인 선택</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
					</div>
	            </div>
	            <div class="row d-flex justify-content-center submit my-4">
	                <div class="col-10">
	                	<button type="button" id="signup-btn" class="btn submit-btn" style="width: 100%">회원가입</button>
	                </div>
	            </div>
        	</form>
        </div>
    </div>


	<script>
		let isValidId = false;
		
		document.getElementById('signup-btn').addEventListener("click", function() {
		  let id = document.getElementById('signup-id').value;
		  let pw = document.getElementById('signup-password').value;
		  let pwCheck = document.getElementById('signup-check-password').value;
		  let name = document.getElementById('signup-name').value;
		  let emailId = document.getElementById('signup-email-id').value;
		  let emailDomain = document.getElementById('signup-email-domain').value;
	
		  // 입력값 검증
		  if (id == '' || pw == '' || name == '' || emailId == '' || emailDomain == 'none') {
		    alert("빈칸이 없도록 입력해 주세요.");
		    return;
		  }
		  else if(!isValidId) {
			  alert("중복된 아이디입니다. 다른 아이디를 사용해 주세요.");
		  }
		  else if(pw != pwCheck) {
			  alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		  }
		  else {
			  //let rsa = new RSAKey();
			  //rsa.setPublic($('#signup-RSAModulus').val(),$('#signup-RSAExponent').val());
			  
			  //$("#signup-encode-id").val(rsa.encrypt(id));
		      //$("#signup-encode-password").val(rsa.encrypt(pw));
		      //$("#signup-encode-name").val(rsa.encrypt(name));
		      //$("#signup-encode-email").val(rsa.encrypt(email));
		        
		      //document.getElementById('signup-id').value = "";
		      //document.getElementById('signup-password').value = "";
		      //document.getElementById('signup-name').value = "";
		      //document.getElementById('signup-email').value = "";
				
		      let form = document.querySelector("#signup-form");
		      form.submit();
		  }
	  	});
		
		document.getElementById("signup-id").addEventListener("keyup", function() {
			let resultElement = document.getElementById("check-id-result");
			
			if(this.value.length < 5) {
				resultElement.setAttribute("class", "ms-2 text-danger");
				resultElement.textContent  = "아이디는 5자 이상 가능합니다.";
				isValidId = false;
			}
			else {
				fetch("${root}/user/idcheck/" + this.value)
				.then(response => response.text())
				.then(data => {
					if(data == 0) {
						resultElement.setAttribute("class", "ms-2 text-primary");
						resultElement.textContent  = this.value + "는 사용 가능한 아이디입니다.";
						isValidId = true;
					}
					else {
						resultElement.setAttribute("class", "ms-2 text-danger");
						resultElement.textContent  = this.value + "는 사용할 수 없는 아이디입니다.";
						isValidId = false;
					}
				});
			}
		});
	</script>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
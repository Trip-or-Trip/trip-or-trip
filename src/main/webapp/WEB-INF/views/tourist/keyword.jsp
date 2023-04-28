<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/include/head.jsp" %>
  <link rel="stylesheet" href="../assets/css/main.css">
  
  <style>
  	body {
  	  text-align: center;
  	}
  	
  	.form-container {
  	  display: inline-block;
  	  width: 700px;
  	  margin-top: 2rem;
  	  border-radius: 0.5rem;
  	  border: 1px solid lightgray;
  	}
  	
  	.place-container {
  		display: inline-block;
  		width: 100%;
  		margin: 1.5rem 1rem;
  		text-align: center;
  	}
  </style>
</head>
<body>
  <!-- <%@ include file="/include/check.jsp" %> -->
  
  <div class="form-container">
  	<form>
  	  <div class="row justify-content-center form-group-row">
  	    <div class="col-7 mt-3">
  	      <input type="text" id="search-keyword" class="form-control" placeholder="장소명">
  	    </div>
  	    <div class="col-2 mt-3">
  	      <button type="button" id="keyword-search-btn" class="btn submit-btn" style="width: 100%;">검색</button>
  	    </div>
  	    <div class="col-2 mt-3">
  	      <button type="button" id="title-submit-btn" class="btn submit-btn" style="width: 100%;">선택</button>
  	    </div>
      </div>
      <div id="result-container" class="mt-3">
  	</form>

  
  <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=991fde334716cbc5bbcac85358cf5e88&libraries=services,clusterer,drawing"></script>
  <script type="text/javascript" src="${root}/assets/js/keyword.js"></script>
  <%@ include file="/include/footer.jsp" %>
  
</body>
</html>
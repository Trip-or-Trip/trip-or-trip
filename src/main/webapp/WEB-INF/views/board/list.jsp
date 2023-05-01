<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/include/head.jsp" %>
<%-- <%@ include file="/common/confirm.jsp" %> --%>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
      <div class="row justify-content-center">
        <div class="col-sm-12">
          <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="sky">글목록</mark>
          </h2>
        </div>
        <div class="col-sm-12">
          <div class="row align-self-center mb-2">
            <div class="col-md-2 text-start">
              <button type="button" id="btn-mv-register" class="btn btn-outline-primary btn-sm">
                글쓰기
              </button>
            </div>
            <div class="col-md-7 offset-3">
              <form class="d-flex" id="form-search" action="">
                <input type="hidden" name="" value=""/>
                <input type="hidden" name="pgno" value="1"/>
                <select
                  name="key"
                  id="key"
                  class="form-select form-select-sm ms-5 me-1 w-50"
                  aria-label="검색조건"
                >
                  <option selected>검색조건</option>
                  <option value="id">글번호</option>
                  <option value="title">제목</option>
                  <option value="user_id">작성자</option>
                  <option value="content">내용</option>
                </select>
                <div class="input-group input-group-sm">
                  <input type="text" name="word" id="word" class="form-control" placeholder="검색어..." />
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
	                <td class="text-start">
	                  <a
	                    href="#"
	                    class="article-title link-dark"
	                    data-no="${article.id}"
	                    style="text-decoration: none"
	                  >
	                    ${article.title}
	                  </a>
	                </td>
	                <td>${article.userId}</td>
	                <td>${article.hit}</td>
	                <td>${article.createdAt}</td>
	              </tr>            
				</c:forEach>   
            </tbody>
          </table>
        </div>
        <div class="row">
          ${navigation.navigator}
        </div>
      </div>
    </div>
    <form id="form-param" method="get" action="">
      <input type="hidden" id="p-action" name="action" value="">
      <input type="hidden" id="p-pgno" name="pgno" value="">
      <input type="hidden" id="p-key" name="key" value="">
      <input type="hidden" id="p-word" name="word" value="">
    </form>
    <script>
      let titles = document.querySelectorAll(".article-title");
      titles.forEach(function (title) {
        title.addEventListener("click", function () {
          console.log(this.getAttribute("data-no"));
          location.href = "${root}/board/view?articleno=" + this.getAttribute("data-no")+"&pgno=${param.pgno}&key=${param.key}&word=${param.word}";
        });
      });

      document.querySelector("#btn-mv-register").addEventListener("click", function () {
        location.href = "${root}/board/write?pgno=1&key=${param.key}&word=${param.word}";
      });
      
      document.querySelector("#btn-search").addEventListener("click", function () {
    	  let form = document.querySelector("#form-search");
          form.setAttribute("action", "${root}/board/list?pgno=${param.pgno}&key=${param.key}&word=${param.word}");
          form.submit();
      });
      
      let pages = document.querySelectorAll(".page-link");
      pages.forEach(function (page) {
        page.addEventListener("click", function () {
          console.log(this.parentNode.getAttribute("data-pg"));
          document.querySelector("#p-action").value = "list";
       	  document.querySelector("#p-pgno").value = this.parentNode.getAttribute("data-pg");
       	  document.querySelector("#p-key").value = "${param.key}";
       	  document.querySelector("#p-word").value = "${param.word}";
          document.querySelector("#form-param").submit();
        });
      });
    </script>
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>

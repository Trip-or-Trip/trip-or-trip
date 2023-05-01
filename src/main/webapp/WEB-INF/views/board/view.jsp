<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
 <%@ include file="/WEB-INF/views/include/head.jsp" %>

<c:if test="${article eq null}">
  <script>
    alert("글이 삭제되었거나 부적절한 URL 접근입니다.");
    location.href = "${root}/board/list";
  </script>
</c:if>
 <%@ include file="/WEB-INF/views/include/nav.jsp" %>
<div class="row justify-content-center">
  <div class="col-lg-8 col-md-10 col-sm-12">
    <h2 class="my-3 py-3 shadow-sm bg-light text-center">
      <mark class="sky">글보기</mark>
    </h2>
  </div>
  <div class="col-lg-8 col-md-10 col-sm-12">
    <div class="row my-2">
      <h2 class="text-secondary px-5">${article.id}. ${article.title}</h2>
    </div>
    <div class="row">
      <div class="col-md-8">
        <div class="clearfix align-content-center">
          <img
            class="avatar me-2 float-md-start bg-light p-2"
            src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg"
          />
          <p>
            <span class="fw-bold">${article.userId}</span> <br />
            <span class="text-secondary fw-light">
              ${article.createdAt} 조회 : ${article.hit}
            </span>
          </p>
        </div>
      </div>
      <div class="col-md-4 align-self-center text-end">댓글 : 0</div>
      <div class="divider mb-3"></div>
      <div class="text-secondary">${article.content}</div>
      <div class="divider mt-3 mb-3"></div>
      <div class="d-flex justify-content-end">
        <button type="button" id="btn-list" class="btn btn-outline-primary mb-3">글목록</button>
        <c:if test="${userinfo.id eq article.userId }">
          <button type="button" id="btn-mv-modify" class="btn btn-outline-success mb-3 ms-1">
            글수정
          </button>
          <button type="button" id="btn-delete" class="btn btn-outline-danger mb-3 ms-1">
            글삭제
          </button>
        </c:if>
      </div>
    </div>
  </div>
</div>
<script>
  document.querySelector("#btn-list").addEventListener("click", function () {
    location.href = "${root}/board/list?pgno=${param.pgno}&key=${param.key}&word=${param.word}";
  });
  document.querySelector("#btn-mv-modify").addEventListener("click", function () {
    location.href = "${root}/board/modify?articleno=" + ${article.id}+"&pgno=${param.pgno}&key=${param.key}&word=${param.word}";
  });
  document.querySelector("#btn-delete").addEventListener("click", function () {
	  abf = confirm("정말 삭제하시겠씁니까?");
	  if (abf == true) location.href = "${root}/board/delete?articleno=" + ${article.id};
    
  });
</script>
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>

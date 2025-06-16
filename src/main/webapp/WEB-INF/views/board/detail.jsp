<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="container-md mt-5 text-light">
	<h3 class="text-center display-6 mb-4">📄 Board Detail Page</h3>

	<c:set value="${bdto.bvo }" var="bvo" />

	<!-- 글 정보 입력란 -->
	<div class="bg-secondary rounded shadow p-4 mb-4">
		<div class="mb-3">
			<label class="form-label fw-bold">bno</label>
			<input type="text" class="form-control-plaintext bg-dark text-light ps-2 rounded" name="bno"
				value="${bvo.bno }" readonly placeholder="bno...">
		</div>
		<div class="mb-3">
			<label class="form-label fw-bold">title</label>
			<input type="text" class="form-control-plaintext bg-dark text-light ps-2 rounded" name="title"
				value="${bvo.title }" readonly placeholder="title...">
			<span class="badge bg-warning text-dark">${bvo.cmtQty }</span>
		</div>
		<div class="mb-3">
			<label class="form-label fw-bold">Writer</label>
			<input type="text" class="form-control-plaintext bg-dark text-light ps-2 rounded" name="writer"
				value="${bvo.writer }" readonly placeholder="Writer...">
		</div>
		<div class="mb-3">
			<label class="form-label fw-bold">regDate</label>
			<input type="text" class="form-control-plaintext bg-dark text-light ps-2 rounded" name="regDate"
				value="${bvo.regDate }" readonly placeholder="regDate...">
		</div>
		<div class="mb-3">
			<label class="form-label fw-bold">readCount</label>
			<input type="text" class="form-control-plaintext bg-dark text-light ps-2 rounded" name="readCount"
				value="${bvo.readCount }" readonly placeholder="readCount...">
		</div>
		<div class="mb-3">
			<label class="form-label fw-bold">cmtQty</label>
			<input type="text" class="form-control-plaintext bg-dark text-light ps-2 rounded" name="cmtQty"
				value="${bvo.cmtQty }" readonly>
		</div>
		<div class="mb-3">
			<label class="form-label fw-bold">fileQty</label>
			<input type="text" class="form-control-plaintext bg-dark text-light ps-2 rounded" name="fileQty"
				value="${bvo.fileQty }" readonly>
		</div>
		<div class="mb-3">
			<label class="form-label fw-bold">Content</label>
			<textarea class="form-control bg-dark text-light rounded" name="content"
				id="exampleFormControlTextarea1" rows="4" readonly>${bvo.content }</textarea>
		</div>
	</div>

	<!-- 첨부파일 리스트 -->
	<div class="mb-4">
		<ul class="list-group">
			<c:forEach items="${bdto.flist }" var="fvo">
				<li class="list-group-item bg-dark text-light border-secondary">
					<c:choose>
						<c:when test="${fvo.fileType > 0 }">
							<img src="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}"
								class="img-thumbnail mb-2" style="max-width: 200px;">
						</c:when>
						<c:otherwise>
							<a href="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}"
							   download class="text-info text-decoration-none fw-bold">${fvo.fileName}</a>
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								fill="currentColor" class="bi bi-arrow-down-square ms-2" viewBox="0 0 16 16">
								<path fill-rule="evenodd"
									d="M15 2a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1zM0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm8.5 2.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293z" />
							</svg>
						</c:otherwise>
					</c:choose>
					<div class="fw-bold mt-2">${fvo.fileName}</div>
					<span class="badge bg-primary">${fvo.regDate} / ${fvo.fileSize} Bytes</span>
				</li>
			</c:forEach>
		</ul>
	</div>

	<!-- 수정/삭제 버튼 -->
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.uvo.nickName" var="authNick" />
		<c:if test="${bvo.writer eq authNick }">
			<div class="d-flex gap-2 mb-3">
				<a href="/board/modify?bno=${bvo.bno }" class="btn btn-warning">✏️ Modify</a>
				<a href="/board/remove?bno=${bvo.bno }" class="btn btn-danger">🗑️ Delete</a>
			</div>
		</c:if>
	</sec:authorize>
	
	<!-- 이전글/다음글 네비게이션 -->
	<div class="d-flex justify-content-between align-items-center mb-4">
		<c:choose>
			<c:when test="${not empty bdto.prev}">
				<a href="/board/detail?bno=${bdto.prev.bno}"
					class="btn btn-outline-info"> ← Prev</a>
			</c:when>
			<c:otherwise>
				<span class="text-muted">← Prev X</span>
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when test="${not empty bdto.next}">
				<a href="/board/detail?bno=${bdto.next.bno}"
					class="btn btn-outline-info">Next →</a>
			</c:when>
			<c:otherwise>
				<span class="text-muted">X Next →</span>
			</c:otherwise>
		</c:choose>
	</div>


	<!-- 목록 버튼 -->
	<div class="mb-4">
		<a href="/board/list" class="btn btn-outline-light">Back to List</a>
	</div>

	<!-- 댓글 입력창 -->
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.uvo.nickName" var="authNick" />
		<c:set value="${authNick }" var="nick"></c:set>
		<div class="input-group mb-4">
			<span class="input-group-text bg-dark text-white" id="cmtWriter">${authNick }</span>
			<input type="text" id="cmtText" class="form-control" placeholder="Add Comment..." aria-label="Username">
			<button type="button" id="cmtAddBtn" class="btn btn-outline-info">Post</button>
		</div>
	</sec:authorize>

	<!-- 댓글 리스트 -->
	<ul class="list-group list-group-flush mb-3" id="cmtListArea">
		<li class="list-group-item bg-dark text-light">
			<div class="mb-2">
				<div class="fw-bold">writer</div>
				<div>content</div>
			</div>
			<span class="badge bg-secondary">regDate</span>
		</li>
	</ul>

	<!-- more 버튼 -->
	<div class="mb-4 text-center">
		<button type="button" id="moreBtn" data-page="1"
			class="btn btn-outline-light" style="visibility: hidden;">More +</button>
	</div>

	<!-- 댓글 수정 모달 -->
	<div class="modal fade" id="myModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content bg-dark text-white">
				<div class="modal-header">
					<h5 class="modal-title">Edit Comment</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<input type="text" id="cmtTextMod" class="form-control">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					<button type="button" id="cmtModBtn" class="btn btn-info">Save</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		const bnoValue = `<c:out value="${bvo.bno}"/>`;
		const loginNick = `<c:out value="${nick}"/>`;
		spreadCommentList(bnoValue);
	</script>
	<script src="/resources/js/boardDetailComment.js"></script>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

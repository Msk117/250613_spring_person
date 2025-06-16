<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md mt-5 text-light">
	<h3 class="text-center display-6 mb-4">✏️ Modify Post</h3>

	<form action="/board/update" method="post" enctype="multipart/form-data" class="bg-dark p-4 rounded shadow">

		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />

		<div class="mb-3">
			<label for="bnoInput" class="form-label">Post No</label>
			<input type="text" class="form-control bg-secondary text-white" id="bnoInput" name="bno" value="${bvo.bno}" readonly>
		</div>

		<div class="mb-3">
			<label for="titleInput" class="form-label">Title</label>
			<input type="text" class="form-control" id="titleInput" name="title" value="${bvo.title}" placeholder="Enter title...">
		</div>

		<div class="mb-3">
			<label for="writerInput" class="form-label">Writer</label>
			<input type="text" class="form-control bg-secondary text-white" id="writerInput" name="writer" value="${bvo.writer}" readonly>
		</div>

		<div class="mb-3">
			<label for="regDateInput" class="form-label">Reg Date</label>
			<input type="text" class="form-control bg-secondary text-white" id="regDateInput" name="regDate" value="${bvo.regDate}" readonly>
		</div>

		<input type="hidden" id="readCountInput" name="readCount" value="${bvo.readCount}">

		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label">Content</label>
			<textarea class="form-control" name="content" id="exampleFormControlTextarea1" rows="4">${bvo.content}</textarea>
		</div>

		<!-- 첨부 파일 리스트 -->
		<div class="mb-4">
			<ul class="list-group list-group-flush">
				<c:forEach items="${flist}" var="fvo">
					<li class="list-group-item bg-dark text-light border-secondary">
						<c:choose>
							<c:when test="${fvo.fileType > 0}">
								<img class="img-fluid rounded" src="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}" alt="${fvo.fileName}" />
							</c:when>
							<c:otherwise>
								<a class="text-info fw-bold" href="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}" download>
									⬇ ${fvo.fileName}
								</a>
							</c:otherwise>
						</c:choose>
						<div class="fw-bold mt-2">${fvo.fileName}</div>
						<span class="badge bg-secondary">${fvo.regDate} / ${fvo.fileSize} Bytes</span>
						<button type="button" class="btn btn-outline-danger btn-sm float-end file-x mt-2" data-uuid="${fvo.uuid}">✖</button>
					</li>
				</c:forEach>
			</ul>
		</div>

		<!-- 파일 업로드 -->
		<div class="mb-4">
			<input type="file" class="form-control d-none" name="files" id="file" multiple="multiple">
			<button type="button" class="btn btn-outline-info" id="trigger">Add Files</button>
		</div>

		<div class="mb-4" id="fileZone"></div>

		<div class="d-flex justify-content-between">
			<button type="submit" class="btn btn-warning">Update</button>
			<a href="/board/list" class="btn btn-primary">Back to List</a>
		</div>
	</form>

	<script type="text/javascript" src="/resources/js/boardModify.js"></script>
	<script type="text/javascript" src="/resources/js/boardRegisterFile.js"></script>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

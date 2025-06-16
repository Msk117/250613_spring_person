<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md mt-5 text-light">
	<h3 class="text-center display-6 mb-4">📝 New Post</h3>

	<sec:authentication property="principal.uvo.nickName" var="authNick" />

	<div class="card bg-dark shadow-lg p-4 border-0 rounded-4">
		<form action="/board/insert" method="post" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

			<div class="mb-4">
				<label for="title" class="form-label fw-semibold">Title</label>
				<input type="text" class="form-control form-control-lg" name="title" id="title" placeholder="Enter the title...">
			</div>

			<div class="mb-4">
				<label for="writer" class="form-label fw-semibold">Writer</label>
				<input type="text" class="form-control bg-secondary text-white" name="writer" id="writer" value="${authNick}" readonly>
			</div>

			<div class="mb-4">
				<label for="content" class="form-label fw-semibold">Content</label>
				<textarea class="form-control" name="content" id="content" rows="6" placeholder="Write your content here..."></textarea>
			</div>

			<div class="mb-4">
				<label class="form-label fw-semibold">Attachment</label>
				<div class="d-flex align-items-center gap-2">
					<button type="button" class="btn btn-outline-light" id="trigger">📎 Select Files</button>
					<input type="file" class="form-control d-none" name="files" id="file" multiple>
				</div>
				<div class="mt-3" id="fileZone"></div>
			</div>

			<div class="text-end">
				<button type="submit" class="btn btn-warning fw-bold px-4">Register</button>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript" src="/resources/js/boardRegisterFile.js"></script>
<jsp:include page="../layout/footer.jsp"></jsp:include>

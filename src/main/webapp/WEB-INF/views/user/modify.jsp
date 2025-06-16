<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md mt-5">
	<h3 class="text-center display-6 mb-4">User Modify Page</h3>

	<sec:authentication property="principal.uvo" var="uvo" />

	<form action="/user/modify" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

		<div class="card mx-auto shadow" style="width: 22rem;">
			<img src="/resources/image/pea1-1.jpg" class="card-img-top rounded-top" alt="Profile">
			<div class="card-body bg-dark text-light">
				<div class="mb-3">
					<label class="form-label fw-bold">Nickname</label>
					<input type="text" class="form-control" name="nickName" value="${uvo.nickName}">
				</div>
				<div class="mb-3">
					<label class="form-label fw-bold">New Password</label>
					<input type="password" class="form-control" name="pwd" placeholder="Enter new password...">
				</div>

				<input type="hidden" name="email" value="${uvo.email}">
				<p class="mb-1"><i class="bi bi-envelope-at-fill"></i> ${uvo.email}</p>
				<p class="mb-1"><i class="bi bi-calendar-event-fill"></i> Registered: ${uvo.regDate}</p>
				<p class="mb-3"><i class="bi bi-clock-fill"></i> Last Login: ${uvo.lastLogin} ago</p>

				<div class="mb-3">
					<c:forEach items="${uvo.authList}" var="auths">
						<span class="badge bg-info text-dark">${auths.auth}</span>
					</c:forEach>
				</div>

				<div class="d-flex justify-content-between">
					<button type="submit" class="btn btn-outline-warning w-50 me-2">Modify</button>
					<a href="/user/remove" class="btn btn-outline-danger w-50">Delete</a>
				</div>
			</div>
		</div>
	</form>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

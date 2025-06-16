<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container-md mt-5">
	<h3 class="text-center mb-4 display-6">User Login</h3>

	<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card shadow p-4">
				<form action="/user/login" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

					<div class="mb-3">
						<label for="e" class="form-label fw-bold">Email address</label>
						<input type="email" class="form-control" name="email" id="e"
							placeholder="name@example.com">
					</div>

					<div class="mb-3">
						<label for="p" class="form-label fw-bold">Password</label>
						<input type="password" class="form-control" name="pwd" id="p"
							placeholder="Password">
					</div>

					<c:if test="${param.errorMessage ne null}">
						<div class="alert alert-danger mt-2">${param.errorMessage}</div>
					</c:if>

					<div class="d-grid mt-4">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md mt-5">
	<h3 class="text-center display-6 mb-4"> User Register</h3>

	<div class="card mx-auto shadow p-4" style="max-width: 500px;">
		<form action="/user/register" method="post">
			<div class="mb-3">
				<label for="e" class="form-label fw-bold">Email Address</label>
				<input type="email" class="form-control form-control-lg" name="email" id="e" placeholder="name@example.com" required>
			</div>

			<div class="mb-3">
				<label for="p" class="form-label fw-bold">Password</label>
				<input type="password" class="form-control" name="pwd" id="p" placeholder="Enter a password..." required>
			</div>

			<div class="mb-3">
				<label for="n" class="form-label fw-bold">Nickname</label>
				<input type="text" class="form-control" name="nickName" id="n" placeholder="Choose a nickname..." required>
			</div>

			<div class="d-grid mt-4">
				<button type="submit" class="btn btn-primary btn-lg">Join</button>
			</div>
		</form>
	</div>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

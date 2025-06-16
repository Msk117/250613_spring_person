<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<sec:csrfMetaTags />
<meta name="_csrf" content="CSRF_TOKEN_VALUE">
<meta name="_csrf_header" content="X-CSRF-TOKEN">
<title>header page</title>
<link href="/resources/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
	@keyframes rotate360 {
		from {
			transform: rotate(360deg);
		}
		to {
			transform: rotate(0deg);
		}
	}

	.rotate-logo {
		animation: rotate360 12s linear infinite;
	}
	body::before {
		content: "";
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: url('/resources/image/back.jpg') no-repeat center center fixed;
		background-size: cover; 
		filter: blur(2px);      
		opacity: 0.1;
		z-index: -1;
	}

	
	.hover-effect {
		transition: transform 0.3s ease, filter 0.3s ease;
	}
	.hover-effect:hover {
		transform: scale(1.05);
		filter: brightness(1.2) saturate(1.2);
	}
	
	.hover-card {
  		transition: transform 0.3s ease;
	}
	.hover-card:hover {
 		transform: translateY(-5px) scale(1.02);
  		box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.3);
	}
	
	.hover-effect {
	transition: transform 0.3s ease, filter 0.3s ease;
	}
	.hover-effect:hover {
		transform: scale(1.05);
		filter: brightness(1.2) saturate(1.2);
	}
	
</style>

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
		<div class="container">
			<a class="navbar-brand d-flex align-items-center gap-2" href="/">
				<img src="/resources/image/daisy.jpg" alt="Logo" width="45" height="45" class="rounded-circle rotate-logo">
				<span class="fw-bold">Spring Board</span>
			</a>

			<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
						<a class="nav-link" href="/board/register">Register</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/board/list">Board List</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/user/list">User List</a>
					</li>
				</ul>

				<ul class="navbar-nav mb-2 mb-lg-0 ms-auto">
					<sec:authorize access="isAnonymous()">
						<li class="nav-item">
							<a class="nav-link" href="/user/register">Join</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/user/login">Login</a>
						</li>
					</sec:authorize>

					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="pri" />

						<li class="nav-item">
							<a class="nav-link" href="/user/modify">
								(${pri.username}) Modify
							</a>
						</li>

						<c:if test="${pri.uvo.authList.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">
							<li class="nav-item">
								<a class="nav-link" href="/user/modify">UserList(ADMIN)</a>
							</li>
						</c:if>

						<li class="nav-item">
							<form action="/user/logout" method="post" id="logoutForm" class="d-inline">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
								<a href="#" class="nav-link" id="logoutLink">Logout</a>
							</form>
						</li>
					</sec:authorize>
				</ul>
			</div>
		</div>
	</nav>

	<script type="text/javascript">
		document.getElementById('logoutLink')?.addEventListener('click', function(e) {
			e.preventDefault();
			document.getElementById('logoutForm').submit();
		});
	</script>

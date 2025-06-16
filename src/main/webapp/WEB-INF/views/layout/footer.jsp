<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>footer Page</title>
	<link href="/resources/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="/resources/dist/js/bootstrap.bundle.min.js"></script>
	<style>
	@keyframes rotate360 {
		from {
			transform: rotate(0deg);
		}
		to {
			transform: rotate(360deg);
		}
	}

	.rotate-logo {
		animation: rotate360 15ss linear infinite;
	}
</style>
	
</head>
<body class="bg-dark text-light d-flex flex-column min-vh-100">

	<div class="flex-grow-1"></div>

	
	<footer class="bg-dark text-secondary py-3 border-top mt-auto">
		<div class="container d-flex flex-wrap justify-content-center justify-content-md-between align-items-center">
			
			
			<div class="d-flex align-items-center mb-2 mb-md-0">
				<img src="/resources/image/daisy.jpg" alt="Logo" width="20" height="20" class="rounded-circle rotate-logo">
				<small>, © 2025 Company, Inc.</small>
			</div>

			
			<ul class="nav justify-content-center">
				<li class="nav-item"><a href="#" class="nav-link px-2 text-secondary">Terms</a></li>
				<li class="nav-item"><a href="#" class="nav-link px-2 text-secondary">Privacy</a></li>
				<li class="nav-item"><a href="#" class="nav-link px-2 text-secondary">Security</a></li>
				<li class="nav-item"><a href="#" class="nav-link px-2 text-secondary">Status</a></li>
				<li class="nav-item"><a href="#" class="nav-link px-2 text-secondary">Docs</a></li>
				<li class="nav-item"><a href="#" class="nav-link px-2 text-secondary">Contact</a></li>
				<li class="nav-item"><a href="#" class="nav-link px-2 text-secondary">Cookies</a></li>
				<li class="nav-item"><a href="#" class="nav-link px-2 text-secondary">Do not share</a></li>
			</ul>

		</div>
	</footer>

</body>
</html>

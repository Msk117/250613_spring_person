<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container-md mt-5 text-light">
	<h3 class="text-center display-6 mb-5">User List</h3>

	<div class="row row-cols-1 row-cols-md-3 g-4 justify-content-center">
		<c:forEach items="${userList}" var="uvo">
			<div class="col">
				<div class="card bg-dark text-light border-0 shadow-lg h-100 rounded-4">
					<img src="/resources/image/pea3-3.jpg" class="card-img-top rounded-top" alt="User Image" style="height: 200px; object-fit: cover;">
					<div class="card-body">
						<h5 class="card-title fw-bold">${uvo.nickName}</h5>
						<p class="card-text"><i class="bi bi-envelope"></i> ${uvo.email}</p>
						<p class="card-text"><i class="bi bi-calendar3"></i> Registered: ${uvo.regDate}</p>
						<p class="card-text text-muted"><small>Last Login: ${uvo.lastLogin}</small></p>
						<div class="mt-3">
							<c:forEach items="${uvo.authList}" var="auths">
								<span class="badge bg-warning text-dark">${auths.auth}</span>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

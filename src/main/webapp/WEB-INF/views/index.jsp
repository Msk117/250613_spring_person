<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="layout/header.jsp"></jsp:include>

<div class="container-md mt-5 text-light text-center">
	<h1 class="display-5 fw-bold mb-3">Welcome to Spring Board</h1>

	<p class="lead mb-4"><span class="text-warning fw-semibold">${serverTime}</span>.</p>

	
	<div class="my-5">
		<img src="/resources/image/pea2-1.jpg" alt="Main Illustration"
			class="img-fluid rounded-4 shadow hover-effect" style="max-width: 500px;">
		<p class="mt-3 text-muted">Personal Spring Project</p>
	</div>
</div>

<script>
	const modify_msg = `<c:out value="${modify_msg}" />`;
	if (modify_msg === 'ok') {
		alert('회원정보가 수정되었습니다. 다시 로그인해주세요.');
	}
	if (modify_msg === 'fail') {
		alert('회원정보 수정이 실패 되었습니다. 다시 시도해주세요.');
	}

	const remove_msg = `<c:out value="${remove_msg}"/>`;
	if (remove_msg === 'ok') {
		alert('회원 탈퇴 되었습니다.');
	}
	if (remove_msg === 'fail') {
		alert('회원 탈퇴가 실패 되었습니다. 다시 시도해주세요.');
	}
</script>

<jsp:include page="layout/footer.jsp"></jsp:include>

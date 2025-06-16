<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md mt-5 text-light">
	<h3 class="text-center display-6 mb-4">📋 Board List Page</h3>

	<!-- 검색 폼 -->
	<form class="d-flex mb-4 gap-2" role="search" action="/board/list" method="get">
		<select class="form-select w-auto" name="type" aria-label="Search type">
			<option ${ph.pgvo.type eq null ? 'selected' : '' }>Choose...</option>
			<option value="t" ${ph.pgvo.type eq 't' ? 'selected' : '' }>Title</option>
			<option value="w" ${ph.pgvo.type eq 'w' ? 'selected' : '' }>Writer</option>
			<option value="c" ${ph.pgvo.type eq 'c' ? 'selected' : '' }>Content</option>
			<option value="tw" ${ph.pgvo.type eq 'tw' ? 'selected' : '' }>Title + Writer</option>
			<option value="tc" ${ph.pgvo.type eq 'tc' ? 'selected' : '' }>Title + Content</option>
			<option value="wc" ${ph.pgvo.type eq 'wc' ? 'selected' : '' }>Writer + Content</option>
			<option value="twc" ${ph.pgvo.type eq 'twc' ? 'selected' : '' }>All</option>
		</select>
		<input class="form-control me-2" name="keyword" type="search" placeholder="Search" aria-label="Search"
			value="${ph.pgvo.keyword }" />
		<input type="hidden" name="pageNo" value="1">
		<input type="hidden" name="qty" value="${ph.pgvo.qty }">
		<button type="submit" class="btn btn-outline-info position-relative">
			Search
			<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
				${ph.totalCount}
			</span>
		</button>
	</form>
	<!-- 정렬 버튼 UI -->
	<div class="d-flex justify-content-end mb-3 gap-2">
		<a href="/board/list?pageNo=1&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}&sort=recent"
		   class="btn btn-outline-light btn-sm ${ph.pgvo.sort eq 'recent' ? 'active' : ''}">
			New
		</a>
		<a href="/board/list?pageNo=1&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}&sort=read"
		   class="btn btn-outline-light btn-sm ${ph.pgvo.sort eq 'read' ? 'active' : ''}">
			Most Viewed
		</a>
	</div>

	<!-- 게시글 테이블 -->
	<table class="table table-dark table-hover align-middle text-center shadow">
		<thead class="bg-dark text-warning border-bottom border-secondary">
			<tr>
				<th>#</th>
				<th>Title</th>
				<th>Writer</th>
				<th>Content</th>
				<th>Reg Date</th>
				<th>Views</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="bvo">
				<tr>
					<td>${bvo.bno}</td>
					<td class="text-start">
						<a href="/board/detail?bno=${bvo.bno}" class="text-decoration-none text-info fw-bold">
							${bvo.title}
						</a>
						<c:if test="${bvo.cmtQty > 0}">
							<span class="badge bg-danger ms-1">${bvo.cmtQty}</span>
						</c:if>
					</td>
					<td>${bvo.writer}</td>
					<td class="text-truncate" style="max-width: 250px;">${bvo.content}</td>
					<td>
						${bvo.regDate}
						<c:if test="${bvo.fileQty > 0}">
							<span class="badge bg-info ms-1">${bvo.fileQty}</span>
						</c:if>
					</td>
					<td>${bvo.readCount}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 페이지네이션 -->
	<nav aria-label="Page navigation">
		<ul class="pagination justify-content-center">
			<li class="page-item ${!ph.prev ? 'disabled' : ''}">
				<a class="page-link" href="/board/list?pageNo=${ph.startPage - 1}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">Prev</a>
			</li>
			<c:forEach begin="${ph.startPage}" end="${ph.endPage}" var="i">
				<li class="page-item ${ph.pgvo.pageNo eq i ? 'active' : ''}">
					<a class="page-link" href="/board/list?pageNo=${i}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">
						${i}
					</a>
				</li>
			</c:forEach>
			<li class="page-item ${!ph.next ? 'disabled' : ''}">
				<a class="page-link" href="/board/list?pageNo=${ph.endPage + 1}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">Next</a>
			</li>
		</ul>
	</nav>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Books - Library Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/common.css">
</head>
<body>
<%@ include file = "includes/header.jsp" %>

<div class="container-fluid">
<div class="row">
    <!-- Sidebar -->
    <%@ include file = "includes/sidebar.jsp" %>

    <!-- Main content -->
    <main class="col-md-9 ms-sm-auto col-lg-10">
        <div class="page-header header-with-btn">
            <h1 class="h2"><i class="bi bi-book-fill me-2"></i>Books Library</h1>
            <a href="BookController?action=showAddBook" class="btn-modern"><i class="bi bi-plus-circle"></i>Add New Book</a>
        </div>
        
        <c:if test="${not empty successMessage}">
	        <div class="alert alert-success alert-dismissible fade show" role="alert">
					<c:out value = "${successMessage}"/>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>
		
        <!-- Books Table -->
        <div class="table-container">
            <div class="table-responsive">
                <c:choose>
                	<c:when test="${not empty booklist }">
                		<table class="table table-hover align-middle">
		                    <thead>
		                        <tr>
		                            <th>#</th>
		                            <th>Title</th>
		                            <th>Author</th>
		                            <th>Category</th>
		                            <th>ISBN</th>
		                            <th>Status</th>
		                            <th>Actions</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                    <c:forEach var="book" items="${booklist}" varStatus="status">
		                    	<tr>
		                            <td><span class="badge bg-primary">${status.index + 1 }</span></td>
		                            <td><strong>${book.title }</strong></td>
		                            <td>${book.author }</td>
		                            <td><span class="badge badge-modern badge-fiction">${book.category }</span></td>
		                            <td><code>${book.isbn }</code></td>
		                            <td><span class="badge bg-success">${book.status }</span></td>
		                            <td>
		                                <a href="BookController?action=viewBook&bookId=${book.bookId }" class="action-btn edit" title="Edit Book"><i class="bi bi-pencil-square"></i></a>
<!-- 		                                <button class="action-btn delete" title="Delete Book"><i class="bi bi-trash-fill"></i></button> -->
		                            </td>
		                        </tr>
		                    </c:forEach>
		                    </tbody>
                		</table> 
                	</c:when>
                	<c:otherwise>
                		<div>
                			No Books Found....
                		</div>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>
</div>

<!-- Assign Modal -->


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

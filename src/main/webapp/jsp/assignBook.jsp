<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Assign Book - Library Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/common.css">
<style>
    .info-card {
        background: linear-gradient(135deg, rgba(52, 152, 219, 0.1) 0%, rgba(155, 89, 182, 0.1) 100%);
        border: 1px solid rgba(52, 152, 219, 0.2);
        border-radius: var(--border-radius);
        padding: 1.5rem;
        margin-bottom: 2rem;
    }

    .info-card .icon {
        font-size: 2rem;
        color: #3498db;
        margin-bottom: 1rem;
    }
</style>
</head>
<body>
<%@ include file = "includes/header.jsp" %>

<div class="container-fluid">
<div class="row">
    <!-- Sidebar -->
    <%@ include file = "includes/sidebar.jsp" %>

    <!-- Main content -->
	<main class="col-md-9 ms-sm-auto col-lg-10">
        <div class="page-header">
            <h1 class="h2"><i class="bi bi-arrow-right-circle me-2"></i>Assign Book to Member</h1>
        </div>
        
        <c:if test="${not empty successMessage}">
	        <div class="alert alert-success alert-dismissible fade show" role="alert">
					<c:out value = "${successMessage}"/>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>
		
		<c:if test="${not empty errorMessage}">
	        <div class="alert alert-danger alert-dismissible fade show" role="alert">
					<c:out value = "${errorMessage}"/>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>

        <!-- Info Card -->
        <!-- <div class="info-card">
            <div class="icon">
                <i class="bi bi-info-circle"></i>
            </div>
        </div> -->

        <div class="form-container" >
            <form action="BookController" method="post">
            <input type="hidden" name="action" value ="assignBook">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select class="form-select" id="bookId" name = "bookId">
                                <option value="selected" disabled>Choose a book</option>
                                <c:forEach var = "book" items="${bookList }" >
                                	<option value="${book.bookId }">
                                		<c:out value="${book.title }"/> - <c:out value="${book.author }"/>(Available - <c:out value="${book.availableCopies }"/>)
                                	</option>
                                </c:forEach>
                            </select>
                            <label for="selectBook"><i class="bi bi-book-fill me-2"></i>Select Book</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select class="form-select" id="userId" name="userId">
                                <option value="" disabled selected>Choose a book</option>
                                <c:forEach var="user" items="${userList }">
                                <option value="${user.userId }">
                                	<c:out value="${user.firstName }"/> <c:out value="${user.lastName }"/> - <c:out value="${user.email }"/>
                                </option>
                                </c:forEach>
                            </select>
                            <label for="selectMember"><i class="bi bi-person-fill me-2"></i>Select Member</label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="date" class="form-control" id="dueDate" name="dueDate">
                            <label for="dueDate"><i class="bi bi-calendar-event me-2"></i>Due Date</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
		                    <textarea class="form-control" id="assignmentNotes" placeholder="Notes" name="assignmentNotes"></textarea>
		                    <label for="notes"><i class="bi bi-card-text me-2"></i>Assignment Notes (Optional)</label>
                		</div>
                    </div>
                </div>


                <div class="form-actions">
                    <button type="submit" class="btn-modern">
                        <i class="bi bi-check-circle"></i>Assign Book
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Return Book - Library Management</title>
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
        <div class="page-header">
            <div>
                <h1 class="h2"><i class="bi bi-arrow-left-circle me-2"></i>Return Issued Books</h1>
                <p class="text-muted mb-0">Monitor borrowed books and record their safe return.</p>
            </div>
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

        <div class="table-container">
            <div class="table-responsive">
            <c:choose>
                	<c:when test="${not empty issuedList }">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Book</th>
                            <th>Member</th>
                            <th>Issued On</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="issueBook" items="${issuedList }" varStatus ="status">
                        <tr>
                            <td><span class="badge bg-primary">${status.index + 1 }</span></td>
                            <td>
                                <strong><c:out value="${issueBook.book.title }"/></strong>
                                <div class="text-muted small">ISBN: <code><c:out value="${issueBook.book.isbn }"/></code></div>
                            </td>
                            <td>
                                <div><c:out value="${issueBook.user.firstName }"/> <c:out value="${issueBook.user.lastName }"/></div>
                                <div class="text-muted small"><c:out value="${issueBook.user.email }"/></div>
                            </td>
                            <td>
							    <c:out value="${fn:substring(issueBook.issueDate, 0, 10)}"/>
							</td>
							<td>${issueBook.dueDate}</td>
                            <td>
	                            <c:choose>
								    <c:when test="${issueBook.dueDayStatus == 'Overdue'}">
								        <span class="badge bg-danger">Overdue</span>
								    </c:when>
								
								    <c:when test="${issueBook.dueDayStatus == 'Due Today'}">
								        <span class="badge bg-warning text-dark">Due Today</span>
								    </c:when>
								
								    <c:otherwise>
								        <span class="badge bg-success">
								            <c:out value="${issueBook.dueDayStatus}"/>
								        </span>
								    </c:otherwise>
								</c:choose>
                            </td>
                            <td>
                                <a href="BookController?action=showReturnBookDetails&issueId=${issueBook.issueId}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-arrow-return-left me-1"></i>Return
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </c:when>
                	<c:otherwise>
                		<div>
                			No Book Found....
                		</div>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

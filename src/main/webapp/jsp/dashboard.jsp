<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file = "includes/header.jsp" %>


<div class="container-fluid">
<div class="row">
    
    <%@ include file = "includes/sidebar.jsp" %>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
        <div class="page-header">
            <h1 class="h2"><i class="bi bi-speedometer2 me-2"></i>Dashboard</h1>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card text-white stat-card primary mb-3">
                    <div class="card-body">
                        <i class="bi bi-book-fill stat-icon"></i>
                        <h5 class="card-title">Total Books</h5>
                        <p class="card-text">
                        	<c:out value="${dashboardStats.totalBooks }" default ="0"/>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white stat-card warning mb-3">
                    <div class="card-body">
                        <i class="bi bi-arrow-right-circle-fill stat-icon"></i>
                        <h5 class="card-title">Books Assigned</h5>
                        <p class="card-text">
                        	<c:out value="${dashboardStats.boooksAssigned }" default ="0"/>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white stat-card success mb-3">
                    <div class="card-body">
                        <i class="bi bi-arrow-left-circle-fill stat-icon"></i>
                        <h5 class="card-title">Books Returned</h5>
                        <p class="card-text">
                        	<c:out value="${dashboardStats.booksReturned }" default ="0"/>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white stat-card info mb-3">
                    <div class="card-body">
                        <i class="bi bi-people-fill stat-icon"></i>
                        <h5 class="card-title">Users</h5>
                        <p class="card-text">
                        	<c:out value="${dashboardStats.totalUsers }" default ="0"/>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Books Table -->
        <h4 class="section-title">Currently Issued Books</h4>
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

<%-- <%@ include file = "includes/footer.jsp" %> --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


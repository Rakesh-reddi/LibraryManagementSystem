<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Users - Library Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/common.css">


<%@ include file = "includes/header.jsp" %>


<style>
    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: var(--primary-gradient);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        margin-right: 0.75rem;
    }

    .user-info {
        display: flex;
        align-items: center;
    }
</style>
</head>
<body>


<div class="container-fluid">
<div class="row">
    <!-- Sidebar -->
    <%@ include file = "includes/sidebar.jsp" %>

    <!-- Main content -->
    <main class="col-md-9 ms-sm-auto col-lg-10">
        <div class="page-header header-with-btn">
            <h1 class="h2"><i class="bi bi-people-fill me-2"></i>User Management</h1>
            <a href="UserController?action=showAddUser" class="btn-modern"><i class="bi bi-person-plus-fill"></i>Add New User</a>
        </div>
        
        
        <c:if test="${not empty successMessage}">
	        <div class="alert alert-success alert-dismissible fade show" role="alert">
					<c:out value = "${successMessage}"/>
					<c:remove var="successMessage" scope="session"/>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>
		
		  <c:if test="${not empty errorMessage}">
	        <div class="alert alert-danger alert-dismissible fade show" role="alert">
					<c:out value = "${errorMessage}"/>
					<c:remove var="errorMessage" scope="session"/>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>

        <!-- Users Table -->
        <div class="table-container">
            <div class="table-responsive">
            <c:choose>
                	<c:when test="${not empty userList }">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Phone No</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${userList}" varStatus="status">
                        <tr>
                            <td><span class="badge bg-primary">${status.index + 1 }</span></td>
                            <td>
                                <div class="user-info">
                                    <strong><c:out value="${user.firstName }"/></strong>
                                </div>
                            </td>
                            <td><c:out value="${user.lastName}"/></td>
                            <td><c:out value="${user.email }"/></td>
                            <td><c:out value="${user.phoneNo }"/></td>
                            <td>
                                <a href="UserController?action=viewUser&userId=${user.userId }" class="action-btn edit" title="Edit User"><i class="bi bi-pencil-square"></i></a>
<!--                                 <button class="action-btn delete" title="Delete User"><i class="bi bi-trash-fill"></i></button> -->
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </c:when>
                	<c:otherwise>
                		<div>
                			No User Found....
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

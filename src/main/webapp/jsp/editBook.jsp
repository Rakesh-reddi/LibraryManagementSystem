<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Book - Library Management</title>
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
            <h1 class="h2"><i class="bi bi-book-fill me-2"></i>Update Book</h1>
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
	

        <div class="form-container">
            <form action = "BookController" method = "post">
            <input type="hidden" name = "action" value = "updateBook">
            <input type="hidden" name = "bookId" value="${book.bookId }">
            
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="bookTitle" name = "bookTitle" placeholder="Book Title" value="${book.title }">
                            <label for="bookTitle"><i class="bi bi-book me-2"></i>Book Title</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="author" name = "author" placeholder="Author" value="${book.author }">
                            <label for="author"><i class="bi bi-person me-2"></i>Author</label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="isbn" name = "isbn" placeholder="ISBN" value="${book.isbn }">
                            <label for="isbn"><i class="bi bi-hash me-2"></i>ISBN Number</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select class="form-select" id="category" name = "category" value="${book.category }">
                                <option selected disabled value="">Select category</option>
                                <option value="fiction" <c:if test="${book.category == 'fiction'}">selected</c:if>>Fiction</option>
                                <option value="non-fiction" <c:if test="${book.category == 'non-fiction'}">selected</c:if>>Non-fiction</option>
                                <option value="science" <c:if test="${book.category == 'science'}">selected</c:if>>Science</option>
                                <option value="technology" <c:if test="${book.category == 'technology'}">selected</c:if>>Technology</option>
                                <option value="history" <c:if test="${book.category == 'history'}">selected</c:if>>History</option>
                                <option value="biography" <c:if test="${book.category == 'biography'}">selected</c:if>>Biography</option>
                                <option value="mystery" <c:if test="${book.category == 'mystery'}">selected</c:if>>Mystery</option>
                                <option value="romance" <c:if test="${book.category == 'romance'}">selected</c:if>>Romance</option>
                            </select>
                            <label for="category"><i class="bi bi-collection me-2"></i>Category</label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="publisher" name = "publisher" placeholder="Publisher" value="${book.publisher }">
                            <label for="publisher"><i class="bi bi-building me-2"></i>Publisher</label>
                        </div>
                    </div>
<!--                     <div class="col-md-6"> -->
<!--                         <div class="form-floating"> -->
<!--                             <input type="date" class="form-control" id="publishDate" name="publishDate" placeholder="Publication Date"> -->
<!--                             <label for="publishDate"><i class="bi bi-calendar me-2"></i>Publication Date</label> -->
<!--                         </div> -->
<!--                     </div> -->
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="number" class="form-control" id="availableCopies" name = "availableCopies" placeholder="Pages" value="${book.availableCopies }" readonly = "readonly">
                            <label for="pages"><i class="bi bi-file-text me-2"></i>Available Copies</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="number" class="form-control" id="copies" name = "numberOfCopies" placeholder="numberOfCopies" min="1" value="${book.totalCopies }">
                            <label for="copies"><i class="bi bi-stack me-2"></i>Number of Copies</label>
                        </div>
                    </div>
                </div>


                <div class="form-actions">
                    <button type="submit" class="btn-modern">
                        <i class="bi bi-save"></i>Update
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

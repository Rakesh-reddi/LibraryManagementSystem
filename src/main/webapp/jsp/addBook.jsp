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
            <h1 class="h2"><i class="bi bi-book-fill me-2"></i>Add New Book</h1>
        </div>
		
		<c:if test="${not empty errorMessage}">
	        <div class="alert alert-danger alert-dismissible fade show" role="alert">
					<c:out value = "${errorMessage}"/>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>
	

        <div class="form-container">
            <form action = "BookController" method = "post">
            <input type="hidden" name = "action" value = "addBook">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="bookTitle" name = "bookTitle" placeholder="Book Title">
                            <label for="bookTitle"><i class="bi bi-book me-2"></i>Book Title</label>
                            <div id="bookTitleError" class="text-danger small"></div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="author" name = "author" placeholder="Author">
                            <label for="author"><i class="bi bi-person me-2"></i>Author</label>
                            <div id="authorError" class="text-danger small"></div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="isbn" name = "isbn" placeholder="ISBN">
                            <label for="isbn"><i class="bi bi-hash me-2"></i>ISBN Number</label>
                            <div id="isbnError" class="text-danger small"></div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select class="form-select" id="category" name = "category">
                                <option selected disabled value="">Select category</option>
                                <option value="fiction">Fiction</option>
                                <option value="non-fiction">Non-fiction</option>
                                <option value="science">Science</option>
                                <option value="technology">Technology</option>
                                <option value="history">History</option>
                                <option value="biography">Biography</option>
                                <option value="mystery">Mystery</option>
                                <option value="romance">Romance</option>
                            </select>
                            <label for="category"><i class="bi bi-collection me-2"></i>Category</label>
                            <div id ="categoryError" class="text-danger small"></div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="publisher" name = "publisher" placeholder="Publisher">
                            <label for="publisher"><i class="bi bi-building me-2"></i>Publisher</label>
                            <div id="publisherError" class="text-danger small"></div>
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
                            <input type="number" class="form-control" id="availableCopies" name = "availableCopies" placeholder="Pages">
                            <label for="pages"><i class="bi bi-file-text me-2"></i>Available Copies</label>
                            <div id="availableCopiesError" class="text-danger small"></div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="number" class="form-control" id="copies" name = "numberOfCopies" placeholder="numberOfCopies" min="1" value="1">
                            <label for="copies"><i class="bi bi-stack me-2"></i>Number of Copies</label>
                            <div id="copiesError" class="text-danger small"></div>
                        </div>
                    </div>
                </div>


                <div class="form-actions">
                    <button type="submit" class="btn-modern">
                        <i class="bi bi-save"></i>Save Book
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
function setAddBookValidation() {
    const form = document.querySelector('form')

    if (!form) return

    form.addEventListener('submit', function (event) {
        let hasError = false

        const bookTitle = document.getElementById('bookTitle').value.trim()
        const author = document.getElementById('author').value.trim()
        const isbn = document.getElementById('isbn').value.trim()
        const category = document.getElementById('category').value
        const publisher = document.getElementById('publisher').value.trim()
        const availableCopies = document.getElementById('availableCopies').value
        const copies = document.getElementById('copies').value

        
        const bookTitleError = document.getElementById('bookTitleError')
        const authorError = document.getElementById('authorError')
        const isbnError = document.getElementById('isbnError')
        const categoryError = document.getElementById('categoryError')
        const publisherError = document.getElementById('publisherError')
        const availableCopiesError = document.getElementById('availableCopiesError')
        const copiesError = document.getElementById('copiesError')

        
        bookTitleError.textContent = ""
        authorError.textContent = ""
        isbnError.textContent = ""
        categoryError.textContent = ""
        publisherError.textContent = ""
        availableCopiesError.textContent = ""
        copiesError.textContent = ""

        
        if (!bookTitle) {
            bookTitleError.textContent = "Enter book title"
            hasError = true
        }

        if (!author) {
            authorError.textContent = "Enter author name"
            hasError = true
        }

        if (!isbn) {
            isbnError.textContent = "Enter ISBN"
            hasError = true
        }

        if (!category) {
            categoryError.textContent = "Select a category"
            hasError = true
        }

        if (!publisher) {
            publisherError.textContent = "Enter publisher"
            hasError = true
        }

        if (!availableCopies || availableCopies < 0) {
            availableCopiesError.textContent = "Enter valid copies (>= 0)"
            hasError = true
        }

        if (!copies || copies < 1) {
            copiesError.textContent = "Minimum 1 copy required"
            hasError = true
        }

        if (hasError) {
            event.preventDefault()
        }
    })
}

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', setAddBookValidation)
} else {
    setAddBookValidation()
}
</script>


</body>
</html>

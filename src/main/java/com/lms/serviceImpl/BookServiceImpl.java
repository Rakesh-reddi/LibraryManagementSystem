package com.lms.serviceImpl;


import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import com.lms.dao.BookDao;
import com.lms.daoImpl.BookDaoImpl;
import com.lms.pojo.Book;
import com.lms.pojo.BookIssued;
import com.lms.service.BookService;

public class BookServiceImpl implements BookService{
	
	BookDao bookDao = new BookDaoImpl();

	@Override
	public boolean addBook(Book book) {
		return bookDao.addBook(book);
	}

	@Override
	public boolean updateBook(Book book) {
		return bookDao.updateBook(book);
	}

	@Override
	public List<Book> getAllBookList() {
		return bookDao.getAllBookList();
	}

	@Override
	public List<Book> getAllBookByStatus(String status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Book getBookById(long bookId) {
		return bookDao.getBookById(bookId);
	}

	@Override
	public List<Book> getAllAvailableBookList() {
		return bookDao.getAllAvailableBookList();
	}

	@Override
	public boolean assignBook(BookIssued bookIssued) {
	    bookIssued.setIssueDate(LocalDateTime.now());
	    bookIssued.setStatus("ISSUED");

	    Book book = bookDao.getBookById(bookIssued.getBook().getBookId());
	    if (book == null || book.getAvailableCopies() <= 0) {
	        return false;
	    }

	    int availableCopies = book.getAvailableCopies() - 1;

	    boolean updateFlag = bookDao.updateAvailableBook(
	        book.getBookId(), availableCopies
	    );

	    if (!updateFlag) {
	        return false;
	    }

	    boolean assignFlag = bookDao.assignBook(bookIssued);

	    if (!assignFlag) {
	        bookDao.updateAvailableBook(book.getBookId(), book.getAvailableCopies());
	    }

	    return assignFlag;
	}

	@Override
	public List<BookIssued> getAllIssuedBookList() {
		return bookDao.getAllIssuedBookList();
	}

	@Override
	public boolean updateAvailableBook(long bookId, int availableCopies) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public BookIssued getIssuedBookById(long issueId) {
		return bookDao.getIssuedBookById(issueId);
	}

	@Override
	public boolean updateBookReturn(BookIssued bookIssued) {
	    bookIssued.setStatus("RETURN");

	    BookIssued existing = bookDao.getIssuedBookById(bookIssued.getIssueId());
	    if (existing == null) {
	        return false;
	    }

	    int availableCopies = existing.getBook().getAvailableCopies() + 1;

	    boolean updateCopies = bookDao.updateAvailableBook(
	        existing.getBook().getBookId(), availableCopies
	    );

	    if (!updateCopies) {
	        return false;
	    }

	    return bookDao.updateBookReturn(bookIssued);
	}

	@Override
	public List<BookIssued> getIssueBookListForDashboard() {
		return bookDao.getIssuedBookListForDashboard();
	}
	

}

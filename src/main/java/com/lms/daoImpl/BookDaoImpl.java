package com.lms.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lms.dao.BookDao;
import com.lms.pojo.Book;
import com.lms.pojo.BookIssued;
import com.lms.pojo.User;
import com.lms.util.DbUtil;

public class BookDaoImpl implements BookDao {

    @Override
    public boolean addBook(Book book) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "Insert into books(title, author, category, isbn, publisher, total_copies, available_copies, status, created_at)"
                       + " values(?,?,?,?,?,?,?,?,?)";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getCategory());
            ps.setString(4, book.getIsbn());
            ps.setString(5, book.getPublisher());
            ps.setInt(6, book.getTotalCopies());
            ps.setInt(7, book.getAvailableCopies());
            ps.setString(8, "AVAILABLE");
            ps.setDate(9, book.getCreatedAt());

            int i = ps.executeUpdate();
            if (i > 0) {
                return true;
            }
            return false;

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }

    @Override
    public boolean updateBook(Book book) {
    	Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "update books set title = ?, author = ?, category=?,isbn=?,publisher=?,total_copies=?"
            		+ " where book_id =?";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getCategory());
            ps.setString(4, book.getIsbn());
            ps.setString(5, book.getPublisher());
            ps.setInt(6, book.getTotalCopies());
            ps.setLong(7, book.getBookId());

            int i = ps.executeUpdate();
            if (i > 0) {
                return true;
            }
            return false;

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }

    @Override
    public List<Book> getAllBookList() {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        ArrayList<Book> bookList = new ArrayList<>();

        try {
            String sql = "Select * from books order by book_id desc";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Book book = new Book();

                book.setBookId(rs.getLong("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                book.setIsbn(rs.getString("isbn"));
                book.setPublisher(rs.getString("publisher"));
                book.setTotalCopies(rs.getInt("total_copies"));
                book.setAvailableCopies(rs.getInt("available_copies"));
                book.setStatus(rs.getString("status"));
                book.setCreatedAt(rs.getDate("created_at"));

                bookList.add(book);
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching books", e);
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return bookList;
    }

    @Override
    public List<Book> getAllBookByStatus(String status) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Book getBookById(long bookId) {

        String sql = "SELECT * FROM books WHERE book_id = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setLong(1, bookId);

            rs = ps.executeQuery();

            if (rs.next()) {
                Book book = new Book();

                book.setBookId(rs.getLong("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                book.setIsbn(rs.getString("isbn"));
                book.setPublisher(rs.getString("publisher"));
                book.setTotalCopies(rs.getInt("total_copies"));
                book.setAvailableCopies(rs.getInt("available_copies"));
                book.setStatus(rs.getString("status"));
                book.setCreatedAt(rs.getDate("created_at"));

                return book;
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching book by ID", e);
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return null;
    }

	@Override
	public List<Book> getAllAvailableBookList() {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        ArrayList<Book> bookList = new ArrayList<>();

        try {
            String sql = "Select * from books where available_copies > 0";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Book book = new Book();

                book.setBookId(rs.getLong("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                book.setIsbn(rs.getString("isbn"));
                book.setPublisher(rs.getString("publisher"));
                book.setTotalCopies(rs.getInt("total_copies"));
                book.setAvailableCopies(rs.getInt("available_copies"));
                book.setStatus(rs.getString("status"));

                bookList.add(book);
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching books", e);
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
		return bookList;
	}

	@Override
	public boolean assignBook(BookIssued bookIssued) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "Insert into book_issued(book_id, user_id, issue_date, due_date, status, assignment_notes)"
                       + " values(?,?,?,?,?,?)";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setLong(1, bookIssued.getBook().getBookId());
            ps.setLong(2, bookIssued.getUser().getUserId());
            
            ps.setTimestamp(3,
            	    java.sql.Timestamp.valueOf(bookIssued.getIssueDate()));
            
            ps.setDate(4, java.sql.Date.valueOf(bookIssued.getDueDate()));
            ps.setString(5, bookIssued.getStatus());
            ps.setString(6, bookIssued.getAssignmentNotes());

            int i = ps.executeUpdate();
            if (i > 0) {
                return true;
            }
            return false;

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
	}

	@Override
	public boolean updateAvailableBook(long bookId, int availableCopies) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "update books set available_copies = ? where book_id=?";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, availableCopies);
            ps.setLong(2, bookId);
 

            int i = ps.executeUpdate();
            if (i > 0) {
                return true;
            }
            return false;

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
		
	}

	@Override
	public List<BookIssued> getAllIssuedBookList() {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<BookIssued> issuedList = new ArrayList<>();

        try {
        	String sql = "select bi.issue_id, bi.book_id, bi.user_id, bi.issue_date, bi.due_date, bi.return_date, bi.status, "
					+ "bi.book_condition, bi.assignment_notes, bi.return_notes, "
					+ "b.title, b.author, b.category, b.isbn,b.publisher, b.total_copies,b.available_copies,"
					+ "u.first_name, u.last_name, u.email, u.phone_no "
					+ "from book_issued bi "
					+ "join books b on bi.book_id = b.book_id "
					+ "join users u on bi.user_id = u.user_id "
					+ "where bi.status = 'ISSUED'";
            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                issuedList.add(mapIssuedRecord(rs));
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching books", e);
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
		return issuedList;
	}

	private BookIssued mapIssuedRecord(ResultSet rs) throws SQLException {
		BookIssued bookIssued = new BookIssued();
		bookIssued.setIssueId(rs.getInt("issue_id"));
		java.sql.Timestamp ts = rs.getTimestamp("issue_date");
		if (ts != null) {
		    bookIssued.setIssueDate(ts.toLocalDateTime());
		}
		bookIssued.setDueDate(rs.getDate("due_date").toLocalDate());
		bookIssued.setStatus(rs.getString("status"));
		bookIssued.setBookCondition(rs.getString("book_condition"));
		bookIssued.setAssignmentNotes(rs.getString("assignment_notes"));
		bookIssued.setReturnNotes(rs.getString("return_notes"));
		
		Book book = new Book();
		book.setBookId(rs.getLong("book_id"));
		book.setTitle(rs.getString("title"));
		book.setAuthor(rs.getString("author"));
		book.setCategory(rs.getString("category"));
		book.setIsbn(rs.getString("isbn"));
		book.setPublisher(rs.getString("publisher"));
		book.setTotalCopies(rs.getInt("total_copies"));
		book.setAvailableCopies(rs.getInt("available_copies"));
		bookIssued.setBook(book);
		
		User user = new User();
		user.setUserId(rs.getLong("user_id"));
		user.setFirstName(rs.getString("first_name"));
		user.setLastName(rs.getString("last_name"));
		user.setEmail(rs.getString("email"));
		user.setPhoneNo(rs.getString("phone_no"));
		bookIssued.setUser(user);
		
		
		
		return bookIssued;
	}

	@Override
	public BookIssued getIssuedBookById(long issueId) {
		Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	
	    try {
	    	String sql = "SELECT bi.issue_id, bi.book_id, bi.user_id, bi.issue_date, bi.due_date, bi.return_date, bi.status, "
					+ "bi.book_condition, bi.assignment_notes, bi.return_notes, "
					+ "b.title, b.author, b.category, b.isbn, b.publisher, b.total_copies, b.available_copies, "
					+ "u.first_name, u.last_name, u.email, u.phone_no "
					+ "FROM book_issued bi "
					+ "JOIN books b ON bi.book_id = b.book_id "
					+ "JOIN users u ON bi.user_id = u.user_id "
					+ "WHERE bi.issue_id = ?";
	        conn = DbUtil.getConnection();
	        ps = conn.prepareStatement(sql);
	        ps.setLong(1, issueId);
	        rs = ps.executeQuery();
	
	        while (rs.next()) {
	            return mapIssuedRecord(rs);
	        }
	
	    } catch (Exception e) {
	        throw new RuntimeException("Error fetching books", e);
	    }
	    finally {
	        try {
	            if (rs != null) {
	                rs.close();
	            }
	            if (ps != null) {
	                ps.close();
	            }
	            if (conn != null) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
		return null;
	}

	@Override
	public boolean updateBookReturn(BookIssued bookIssued) {
		Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	
	    try {
	    	String sql = "update book_issued set return_date = ? , book_condition = ? , return_notes = ? , status = ? where issue_id = ?";
	        conn = DbUtil.getConnection();
	        ps = conn.prepareStatement(sql);
	        
	        ps.setDate(1, java.sql.Date.valueOf(bookIssued.getReturnDate()));
	        ps.setString(2, bookIssued.getBookCondition());
	        ps.setString(3, bookIssued.getReturnNotes());
	        ps.setString(4, bookIssued.getStatus());
	        ps.setInt(5, bookIssued.getIssueId());
	        
	        int i = ps.executeUpdate();
	        
	        if(i > 0) {
	        	return true;
	        }
	        
	    } catch (Exception e) {
	        throw new RuntimeException("Error fetching books", e);
	    }
	    finally {
	        try {
	            if (rs != null) {
	                rs.close();
	            }
	            if (ps != null) {
	                ps.close();
	            }
	            if (conn != null) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
		return false;
	}

	@Override
	public List<BookIssued> getIssuedBookListForDashboard() {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<BookIssued> issuedList = new ArrayList<>();

        try {
        	String sql = "select bi.issue_id, bi.book_id, bi.user_id, bi.issue_date, bi.due_date, bi.return_date, bi.status, "
					+ "bi.book_condition, bi.assignment_notes, bi.return_notes, "
					+ "b.title, b.author, b.category, b.isbn,b.publisher, b.total_copies,b.available_copies,"
					+ "u.first_name, u.last_name, u.email, u.phone_no "
					+ "from book_issued bi "
					+ "join books b on bi.book_id = b.book_id "
					+ "join users u on bi.user_id = u.user_id "
					+ "where bi.status = 'ISSUED'"
					+ "LIMIT 10";
            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                issuedList.add(mapIssuedRecord(rs));
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching books", e);
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
		return issuedList;
	}
}
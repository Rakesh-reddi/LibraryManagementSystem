CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    phone_no VARCHAR(20),
    address VARCHAR(255),
    created_at DATE
);

CREATE TABLE IF NOT EXISTS books (
    book_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    category VARCHAR(100),
    isbn VARCHAR(50),
    publisher VARCHAR(255),
    total_copies INT DEFAULT 0,
    available_copies INT DEFAULT 0,
    status VARCHAR(20),
    created_at DATE
);

CREATE TABLE IF NOT EXISTS book_issued (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    issue_date DATETIME,
    due_date DATE,
    return_date DATE,
    status VARCHAR(20),
    assignment_notes TEXT,
    book_condition VARCHAR(50),
    return_notes TEXT,
    CONSTRAINT fk_book_issued_book FOREIGN KEY (book_id) REFERENCES books(book_id),
    CONSTRAINT fk_book_issued_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT IGNORE INTO users (first_name, last_name, email, password, role, phone_no, address, created_at)
VALUES ('Admin', 'Librarian', 'admin@library.com', 'admin123', 'ADMIN', '9999999999', 'Central Library', CURDATE());

INSERT INTO books (title, author, category, isbn, publisher, total_copies, available_copies, status, created_at)
VALUES ('Clean Code', 'Robert C. Martin', 'Programming', '9780132350884', 'Prentice Hall', 5, 5, 'AVAILABLE', CURDATE());

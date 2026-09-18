# Library Management System

A Java Servlet + JSP based web application for managing library operations such as authentication, books, users, book issuance, returns, and dashboard reporting.

## Live Demo

Open the hosted app in your browser:

**https://affected-really-several-evaluating.trycloudflare.com/LibraryManagementSystem/**

Sign in with these demo credentials:

| Field | Value |
|---|---|
| Username | `admin@library.com` |
| Password | `admin123` |

The login form label says Username, but enter the **email** above.

These same credentials are seeded by `sql/schema.sql` for local runs.

## Features

- Login/logout with session-based authentication
- Dashboard with stats:
  - Total books
  - Total users
  - Books assigned
  - Books returned
- Book management:
  - Add book
  - List books
  - Edit/update book
- User management:
  - Add user
  - List users
  - Edit/update user
- Circulation flow:
  - Assign book to user
  - Return issued book
  - Due-date status (On Time, Due Today, Overdue)
- Request protection using servlet filter (`AuthFilter`)

## Tech Stack

- Java (Servlet API 4.0)
- JSP + JSTL
- JDBC
- MySQL
- Apache Tomcat 9+ (or any Jakarta/Javax-compatible servlet container for Servlet 4.0)
- Eclipse Dynamic Web Project structure

## Project Structure

```text
src/main/java/com/lms
  controller/     -> Servlet controllers
  dao/            -> DAO interfaces
  daoImpl/        -> DAO implementations (JDBC)
  filter/         -> Authentication filter
  pojo/           -> Entity/POJO classes
  service/        -> Service interfaces
  serviceImpl/    -> Service implementations
  util/           -> Utility classes (DB connection)

src/main/webapp
  jsp/            -> JSP views
  assets/css/     -> Stylesheets
  WEB-INF/
    web.xml       -> Web app configuration
    lib/          -> Project JAR dependencies
```

## Prerequisites

- JDK 8 or later
- Apache Tomcat 9.x
- MySQL 8.x
- Eclipse IDE for Enterprise Java and Web Developers (recommended)

## Dependencies (already present in `WEB-INF/lib`)

- `javax.servlet-api-4.0.1.jar`
- `jstl-1.2.jar`
- `jstl-api-1.2.jar`
- `mysql-connector-java-8.0.28.jar`

## Database Setup

1. Create a MySQL database named `library_db`.
2. Create required tables used by the application:
   - `users`
   - `books`
   - `book_issued`
3. Insert at least one user record so you can log in.

Minimum fields expected by the app include:

- `users`: `user_id`, `first_name`, `last_name`, `email`, `password`, `role`, `phone_no`, `address`, `created_at`
- `books`: `book_id`, `title`, `author`, `category`, `isbn`, `publisher`, `total_copies`, `available_copies`, `status`, `created_at`
- `book_issued`: `issue_id`, `book_id`, `user_id`, `issue_date`, `due_date`, `return_date`, `status`, `assignment_notes`, `book_condition`, `return_notes`

### Configure DB Connection

Update DB credentials in:

- `src/main/java/com/lms/util/DbUtil.java`

By default, the app uses:

- URL: `jdbc:mysql://localhost:3306/library_db?useSSL=false`
- Driver: `com.mysql.cj.jdbc.Driver`

## Run Locally (Eclipse + Tomcat)

1. Import as existing project in Eclipse.
2. Ensure it is configured as a Dynamic Web Project.
3. Add/configure Apache Tomcat server in Eclipse.
4. Deploy the project to Tomcat.
5. Start the server.
6. Open in browser:

```text
http://localhost:8080/LibraryManagementSystem/
```

The configured welcome page is:

- `jsp/login.jsp`

## Main Controller Routes

- `AuthenticationController?action=showLogin`
- `AuthenticationController?action=checkLogin`
- `AuthenticationController?action=signOut`
- `DashboardController?action=viewDashboard`
- `BookController?action=allBookList`
- `BookController?action=showAddBook`
- `BookController?action=showAssignBook`
- `BookController?action=showReturnBook`
- `UserController?action=allUserList`
- `UserController?action=showAddUser`

## Session and Security Notes

- Session timeout is configured to 10 minutes in `web.xml`.
- `AuthFilter` protects routes and redirects unauthenticated requests to login.
- Credentials are currently validated directly against stored values in DB. For production use, migrate to hashed passwords.

## Troubleshooting

- 404 on startup:
  - Verify app context path is `LibraryManagementSystem`.
  - Confirm project is deployed to Tomcat.
- DB connection errors:
  - Verify MySQL is running.
  - Check DB URL/user/password in `DbUtil`.
  - Ensure MySQL connector JAR is available.
- Login fails:
  - Confirm a matching row exists in `users` table for email/password.

## Future Improvements

- Move DB credentials to environment variables or external config
- Hash and salt passwords
- Add role-based authorization (Admin/User)
- Add SQL migration scripts (schema + seed data)
- Add unit/integration tests

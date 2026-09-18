package com.lms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.pojo.Book;
import com.lms.pojo.User;
import com.lms.service.BookService;
import com.lms.service.UserService;
import com.lms.serviceImpl.BookServiceImpl;
import com.lms.serviceImpl.UserServiceImpl;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if("showAddUser".equalsIgnoreCase(action)) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/addUser.jsp");
			dispatcher.forward(request, response);
		}
		else if("addUser".equalsIgnoreCase(action)){
			String firstname = request.getParameter("firstName");
			String lastname = request.getParameter("lastName");
			String email = request.getParameter("email");
			String phoneNo = request.getParameter("phone");
			String address = request.getParameter("address");
			
			User user = new User();
			user.setFirstName(firstname);
			user.setLastName(lastname);
			user.setEmail(email);
			user.setPhoneNo(phoneNo);
			user.setAddress(address);
			user.setRole("USER");
			
			String randomPass = UUID.randomUUID().toString().replace("-", "").substring(0,8);
			user.setPassword(randomPass);
			
			java.util.Date now = new java.util.Date();
			java.sql.Date sqlDate = new java.sql.Date(now.getTime());

			user.setCreatedAt(sqlDate);
			
			
			UserService userService = new UserServiceImpl();
			boolean addFlag = userService.addUser(user);
			
			if(addFlag) {
				List<User> userList = new ArrayList<>();
				
				userList = userService.getAllUserList();
				
				if(userList != null && userList.size() > 0) {
					request.setAttribute("userList", userList);
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/userList.jsp");
					dispatcher.forward(request, response);
				}
			}
			else {
				request.setAttribute("errorMessage", "Something went wrong");
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/addUser.jsp");
				dispatcher.forward(request, response);
			}
		}
		else if("allUserList".equalsIgnoreCase(action)) {
			List<User> userList = new ArrayList<>();
			
			String success = request.getParameter("success");

			if("1".equals(success)) {
			    request.setAttribute("successMessage", "User Updated Successfully...");
			}
			
			UserService userService = new UserServiceImpl();
			userList = userService.getAllUserList();
			
			if(userList != null && userList.size() > 0) {
				request.setAttribute("userList", userList);
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/userList.jsp");
				dispatcher.forward(request, response);
			}
		}
		else if("viewUser".equalsIgnoreCase(action)) {
			String userId = request.getParameter("userId");
			
			UserService userService = new UserServiceImpl();
			User user = userService.getUserById(Long.parseLong(userId));
			
			
			if(user != null) {
				request.setAttribute("user", user);
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/editUser.jsp");
				dispatcher.forward(request, response);
			}
			else {
				List<User> userList = new ArrayList<>();
				userList = userService.getAllUserList();
				
				if(userList != null && userList.size() > 0) {
					request.setAttribute("errorMessage", "User Not Found...");
					request.setAttribute("userList", userList);
					RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/userList.jsp");
					dispatcher.forward(request, response);
				}
			}
		}
		else if("updateUser".equalsIgnoreCase(action)) {
			
			Long userId =Long.parseLong(request.getParameter("userId"));
			String firstname = request.getParameter("firstName");
			String lastname = request.getParameter("lastName");
			String email = request.getParameter("email");
			String phoneNo = request.getParameter("phone");
			String address = request.getParameter("address");
			
			User user = new User();
			user.setUserId(userId);
			user.setFirstName(firstname);
			user.setLastName(lastname);
			user.setEmail(email);
			user.setPhoneNo(phoneNo);
			user.setAddress(address);

			
			
			UserService userService = new UserServiceImpl();
			boolean addFlag = userService.updateUser(user);
			
			if(addFlag) {
				request.setAttribute("successMessage", "User updated successfully...");
				response.sendRedirect("UserController?action=allUserList&success=1");
			}
			else {
				request.setAttribute("user", user);
				request.setAttribute("errorMessage", "Something went wrong");
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/updateUser.jsp");
				dispatcher.forward(request, response);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

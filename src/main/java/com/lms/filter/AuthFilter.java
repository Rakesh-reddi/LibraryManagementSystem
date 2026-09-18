package com.lms.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter{

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest httpServeletRequest = (HttpServletRequest) arg0;
		
		String url = httpServeletRequest.getRequestURI();
		HttpSession session = httpServeletRequest.getSession();
		
		boolean loggedIn = (session != null && session.getAttribute("user") != null);
		String contextPath = httpServeletRequest.getContextPath();
		boolean allowedMethod = url.equals(contextPath + "/") ||
				url.equals(contextPath + "/AuthenticationController") ||
				url.equals(contextPath + "/jsp/login.jsp") ||
				url.startsWith(contextPath + "/assets/")
				;
	
	if(loggedIn || allowedMethod) {
		arg2.doFilter(arg0, arg1);
	}
	else {
		RequestDispatcher dispatcher = arg0.getRequestDispatcher("jsp/login.jsp");
		dispatcher.forward(arg0, arg1);
	}
		
	}

}

package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.UserDAOimpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String email = req.getParameter("email");
		String password = req.getParameter("password");

		UserDAOimpl userDAO = new UserDAOimpl();
		User user = userDAO.getUserByEmail(email);

		if (user != null && user.getPassword().equals(password)) {

			HttpSession session = req.getSession();
			session.setAttribute("loggedInUser", user);

			String role = user.getRole();

			if ("CUSTOMER".equals(role)) {

				resp.sendRedirect(req.getContextPath() + "/home");

			} else if ("RESTAURANT_OWNER".equals(role)) {
				resp.sendRedirect(req.getContextPath() + "/ownerDashboard");
			

			} else if ("DELIVERY_PARTNER".equals(role)) {

				resp.sendRedirect(req.getContextPath() + "/deliveryDashboard");

			} else if ("ADMIN".equals(role)) {

				session.setAttribute("admin", user);
				resp.sendRedirect(req.getContextPath() + "/adminDashboard");

			} else {

				resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");

			}

		} else {

			req.setAttribute("error", "Invalid Email or Password");
			req.getRequestDispatcher("/JSP/login.jsp").forward(req, resp);

		}
	}
}
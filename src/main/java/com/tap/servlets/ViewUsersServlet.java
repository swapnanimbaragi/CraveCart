package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.UserDAOimpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminUsers")
public class ViewUsersServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Check admin login
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		// Get all users from database
		UserDAOimpl userDAO = new UserDAOimpl();
		List<User> users = userDAO.getAllUser();

		// Send users to JSP
		req.setAttribute("users", users);

		// Forward to JSP
		req.getRequestDispatcher("/JSP/viewUsers.jsp").forward(req, resp);
	}
}
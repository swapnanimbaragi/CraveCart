package com.tap.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAOimpl.UserDAOimpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminRestaurantOwners")
public class ViewRestaurantOwnersServlet extends HttpServlet {

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

		// Get all users
		UserDAOimpl userDAO = new UserDAOimpl();
		List<User> allUsers = userDAO.getAllUser();

		// Filter only restaurant owners
		List<User> owners = new ArrayList<User>();

		for (User user : allUsers) {
			if ("RESTAURANT_OWNER".equals(user.getRole())) {
				owners.add(user);
			}
		}

		req.setAttribute("owners", owners);

		req.getRequestDispatcher("/JSP/viewRestaurantOwners.jsp").forward(req, resp);
	}
}
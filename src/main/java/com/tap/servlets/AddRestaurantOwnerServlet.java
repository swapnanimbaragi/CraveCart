package com.tap.servlets;

import java.io.IOException;
import java.sql.Timestamp;

import com.tap.DAOimpl.UserDAOimpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/addRestaurantOwner")
public class AddRestaurantOwnerServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		User owner = new User();

		owner.setUserName(req.getParameter("userName"));
		owner.setEmail(req.getParameter("email"));
		owner.setPassword(req.getParameter("password"));
		owner.setAddress(req.getParameter("address"));
		owner.setRole("RESTAURANT_OWNER");
		owner.setCreatedDate(new Timestamp(System.currentTimeMillis()));
		owner.setLastLoginDate(new Timestamp(System.currentTimeMillis()));

		UserDAOimpl userDAO = new UserDAOimpl();
		userDAO.addUser(owner);

		resp.sendRedirect(req.getContextPath() + "/adminRestaurantOwners");
	}
}
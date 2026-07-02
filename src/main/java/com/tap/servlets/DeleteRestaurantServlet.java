package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.RestaurantDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteRestaurant")
public class DeleteRestaurantServlet extends HttpServlet {

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

		// Get restaurant id
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

		// Delete restaurant
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		restaurantDAO.deleteRestaurant(restaurantId);

		// Redirect back to restaurants page
		resp.sendRedirect(req.getContextPath() + "/adminRestaurants");
	}
}
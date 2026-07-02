package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminRestaurants")
public class ViewRestaurantsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Check admin is logged in or not
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		// Create DAO object
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

		// Get all restaurants from database
		List<Restaurant> restaurants = restaurantDAO.getAllRestaurant();

		// Send restaurant list to JSP
		req.setAttribute("restaurants", restaurants);

		// Forward to JSP page
		req.getRequestDispatcher("/JSP/viewRestaurants.jsp").forward(req, resp);
	}
}
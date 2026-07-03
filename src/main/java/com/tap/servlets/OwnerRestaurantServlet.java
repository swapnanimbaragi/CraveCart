package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ownerRestaurant")
public class OwnerRestaurantServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("loggedInUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");
			return;
		}

		User owner = (User) session.getAttribute("loggedInUser");

		if (!"RESTAURANT_OWNER".equals(owner.getRole())) {
			resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");
			return;
		}

		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		List<Restaurant> restaurants = restaurantDAO.getAllRestaurant();

		Restaurant ownerRestaurant = null;

		for (Restaurant restaurant : restaurants) {
			if (restaurant.getAdminUserId() == owner.getUserId()) {
				ownerRestaurant = restaurant;
				break;
			}
		}

		req.setAttribute("restaurant", ownerRestaurant);

		req.getRequestDispatcher("/JSP/ownerRestaurant.jsp").forward(req, resp);
	}
}
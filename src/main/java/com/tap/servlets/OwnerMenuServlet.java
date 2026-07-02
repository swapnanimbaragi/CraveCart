package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ownerMenu")
public class OwnerMenuServlet extends HttpServlet {

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

		// Find restaurant owned by this owner
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		List<Restaurant> restaurants = restaurantDAO.getAllRestaurant();

		Restaurant ownerRestaurant = null;

		for (Restaurant restaurant : restaurants) {
			if (restaurant.getAdminUserId() == owner.getUserId()) {
				ownerRestaurant = restaurant;
				break;
			}
		}

		if (ownerRestaurant == null) {
			req.setAttribute("message", "No restaurant assigned to you yet.");
			req.getRequestDispatcher("/JSP/ownerMenu.jsp").forward(req, resp);
			return;
		}

		// Get menu items of owner's restaurant
		MenuDAOImpl menuDAO = new MenuDAOImpl();
		List<Menu> menuList = menuDAO.getMenuByRestaurant(ownerRestaurant.getRestaurantId());

		req.setAttribute("restaurant", ownerRestaurant);
		req.setAttribute("menuList", menuList);

		req.getRequestDispatcher("/JSP/ownerMenu.jsp").forward(req, resp);
	}
}
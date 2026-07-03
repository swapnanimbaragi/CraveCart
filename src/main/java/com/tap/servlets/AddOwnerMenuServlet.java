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

@WebServlet("/addOwnerMenu")
public class AddOwnerMenuServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
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

		if (ownerRestaurant == null) {
			resp.sendRedirect(req.getContextPath() + "/ownerMenu");
			return;
		}

		int restaurantId = ownerRestaurant.getRestaurantId();

		String itemName = req.getParameter("itemName");
		String description = req.getParameter("description");
		double price = Double.parseDouble(req.getParameter("price"));
		String category = req.getParameter("category");
		String imageUrl = req.getParameter("imageUrl");
		boolean isAvailable = Boolean.parseBoolean(req.getParameter("isAvailable"));
		boolean isVeg = Boolean.parseBoolean(req.getParameter("isVeg"));
		double rating = Double.parseDouble(req.getParameter("rating"));
		boolean isBestSeller = Boolean.parseBoolean(req.getParameter("isBestSeller"));
		String spiceLevel = req.getParameter("spiceLevel");
		String portionSize = req.getParameter("portionSize");
		double discountPercentage = Double.parseDouble(req.getParameter("discountPercentage"));
		boolean isRecommended = Boolean.parseBoolean(req.getParameter("isRecommended"));

		Menu menu = new Menu(
				restaurantId,
				itemName,
				description,
				price,
				category,
				imageUrl,
				isAvailable,
				isVeg,
				rating,
				isBestSeller,
				spiceLevel,
				portionSize,
				discountPercentage,
				isRecommended
		);

		MenuDAOImpl menuDAO = new MenuDAOImpl();
		menuDAO.addMenu(menu);

		resp.sendRedirect(req.getContextPath() + "/ownerMenu");
	}
}
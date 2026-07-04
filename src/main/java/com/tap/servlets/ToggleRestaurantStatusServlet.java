package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/toggleRestaurantStatus")
public class ToggleRestaurantStatusServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);

		restaurant.setActive(!restaurant.isActive());

		restaurantDAO.updateRestaurant(restaurant);

		resp.sendRedirect(req.getContextPath() + "/adminRestaurants");
	}
}
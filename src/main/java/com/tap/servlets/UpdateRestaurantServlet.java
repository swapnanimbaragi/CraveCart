package com.tap.servlets;

import java.io.IOException;
import java.sql.Time;

import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateRestaurant")
public class UpdateRestaurantServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Check admin login
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		// Read form values
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		String restaurantName = req.getParameter("restaurantName");
		String restaurantImg = req.getParameter("restaurantImg");
		String cuisineType = req.getParameter("cuisineType");
		int deliveryTime = Integer.parseInt(req.getParameter("deliveryTime"));
		String address = req.getParameter("address");
		double rating = Double.parseDouble(req.getParameter("rating"));
		boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));
		String description = req.getParameter("description");

		Time openingTime = Time.valueOf(req.getParameter("openingTime") + ":00");
		Time closingTime = Time.valueOf(req.getParameter("closingTime") + ":00");

		String contactNumber = req.getParameter("contactNumber");
		double minimumOrderAmount = Double.parseDouble(req.getParameter("minimumOrderAmount"));
		double deliveryFee = Double.parseDouble(req.getParameter("deliveryFee"));
		String signatureDish = req.getParameter("signatureDish");
		String restaurantTag = req.getParameter("restaurantTag");
		int adminUserId = Integer.parseInt(req.getParameter("adminUserId"));
		double latitude = Double.parseDouble(req.getParameter("latitude"));
		double longitude = Double.parseDouble(req.getParameter("longitude"));

		// Create restaurant object
		Restaurant restaurant = new Restaurant(
				restaurantId,
				restaurantName,
				restaurantImg,
				cuisineType,
				deliveryTime,
				address,
				rating,
				isActive,
				description,
				openingTime,
				closingTime,
				contactNumber,
				minimumOrderAmount,
				deliveryFee,
				signatureDish,
				restaurantTag,
				adminUserId,
				latitude,
				longitude
		);

		// Update restaurant
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		restaurantDAO.updateRestaurant(restaurant);

		// Redirect back
		resp.sendRedirect(req.getContextPath() + "/adminRestaurants");
	}
}
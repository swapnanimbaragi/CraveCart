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

@WebServlet("/addRestaurant")
public class AddRestaurantServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		String restaurantName = req.getParameter("restaurantName");
		String restaurantImg = req.getParameter("restaurantImg");
		String cuisineType = req.getParameter("cuisineType");
		int deliveryTime = Integer.parseInt(req.getParameter("deliveryTime"));
		String address = req.getParameter("address");
		double rating = Double.parseDouble(req.getParameter("rating"));
		boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));
		String description = req.getParameter("description");

		String opening = req.getParameter("openingTime");
		String closing = req.getParameter("closingTime");

		if (opening.length() == 5) {
			opening = opening + ":00";
		}

		if (closing.length() == 5) {
			closing = closing + ":00";
		}

		Time openingTime = Time.valueOf(opening);
		Time closingTime = Time.valueOf(closing);

		String contactNumber = req.getParameter("contactNumber");
		double minimumOrderAmount = Double.parseDouble(req.getParameter("minimumOrderAmount"));
		double deliveryFee = Double.parseDouble(req.getParameter("deliveryFee"));
		String signatureDish = req.getParameter("signatureDish");
		String restaurantTag = req.getParameter("restaurantTag");
		int adminUserId = Integer.parseInt(req.getParameter("adminUserId"));
		double latitude = Double.parseDouble(req.getParameter("latitude"));
		double longitude = Double.parseDouble(req.getParameter("longitude"));

		Restaurant restaurant = new Restaurant(
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

		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		restaurantDAO.addRestaurant(restaurant);

		resp.sendRedirect(req.getContextPath() + "/adminRestaurants");
	}
}
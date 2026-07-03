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

@WebServlet("/updateOwnerRestaurant")
public class UpdateOwnerRestaurantServlet extends HttpServlet {

	private RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

			Restaurant oldRestaurant = restaurantDAO.getRestaurant(restaurantId);

			String opening = req.getParameter("openingTime");
			String closing = req.getParameter("closingTime");

			if (opening.length() == 5) {
				opening = opening + ":00";
			}

			if (closing.length() == 5) {
				closing = closing + ":00";
			}

			Restaurant restaurant = new Restaurant();

			restaurant.setRestaurantId(restaurantId);
			restaurant.setRestaurantName(req.getParameter("restaurantName"));
			restaurant.setRestaurantImg(req.getParameter("restaurantImg"));
			restaurant.setCuisineType(req.getParameter("cuisineType"));
			restaurant.setDeliveryTime(Integer.parseInt(req.getParameter("deliveryTime")));
			restaurant.setAddress(req.getParameter("address"));
			restaurant.setRating(Double.parseDouble(req.getParameter("rating")));
			restaurant.setDescription(req.getParameter("description"));
			restaurant.setOpeningTime(Time.valueOf(opening));
			restaurant.setClosingTime(Time.valueOf(closing));
			restaurant.setContactNumber(req.getParameter("contactNumber"));
			restaurant.setMinimumOrderAmount(Double.parseDouble(req.getParameter("minimumOrderAmount")));
			restaurant.setDeliveryFee(Double.parseDouble(req.getParameter("deliveryFee")));
			restaurant.setSignatureDish(req.getParameter("signatureDish"));
			restaurant.setRestaurantTag(req.getParameter("restaurantTag"));

			// Keep old values
			restaurant.setActive(oldRestaurant.isActive());
			restaurant.setAdminUserId(oldRestaurant.getAdminUserId());
			restaurant.setLatitude(oldRestaurant.getLatitude());
			restaurant.setLongitude(oldRestaurant.getLongitude());

			restaurantDAO.updateRestaurant(restaurant);

			resp.sendRedirect(req.getContextPath() + "/ownerRestaurant");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath() + "/ownerRestaurant");
		}
	}
}
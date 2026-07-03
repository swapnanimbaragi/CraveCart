package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/editOwnerRestaurant")
public class EditOwnerRestaurantServlet extends HttpServlet {

	private RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

		Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);

		req.setAttribute("restaurant", restaurant);
		req.getRequestDispatcher("/JSP/editOwnerRestaurant.jsp").forward(req, resp);
	}
}
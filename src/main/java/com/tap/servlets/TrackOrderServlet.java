package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Order;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/trackOrder")
public class TrackOrderServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int orderId = Integer.parseInt(req.getParameter("orderId"));

		OrderDAOImpl orderDAO = new OrderDAOImpl();
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

		Order order = orderDAO.getOrder(orderId);
		Restaurant restaurant = null;

		if (order != null) {
			restaurant = restaurantDAO.getRestaurant(order.getRestaurantId());
		}

		req.setAttribute("order", order);
		req.setAttribute("restaurant", restaurant);

		req.getRequestDispatcher("/JSP/trackOrder.jsp").forward(req, resp);
	}
}
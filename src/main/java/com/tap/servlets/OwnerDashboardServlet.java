package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ownerDashboard")
public class OwnerDashboardServlet extends HttpServlet {

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

		if (ownerRestaurant == null) {
			req.setAttribute("message", "No restaurant assigned to you yet.");
			req.getRequestDispatcher("/JSP/ownerDashboard.jsp").forward(req, resp);
			return;
		}

		MenuDAOImpl menuDAO = new MenuDAOImpl();
		List<Menu> menuList = menuDAO.getMenuByRestaurant(ownerRestaurant.getRestaurantId());

		OrderDAOImpl orderDAO = new OrderDAOImpl();
		List<Order> allOrders = orderDAO.getAllOrder();

		int totalOrders = 0;
		int pendingOrders = 0;
		int completedOrders = 0;

		for (Order order : allOrders) {
			if (order.getRestaurantId() == ownerRestaurant.getRestaurantId()) {

				totalOrders++;

				if ("PLACED".equals(order.getOrderStatus())
						|| "ACCEPTED".equals(order.getOrderStatus())
						|| "PREPARING".equals(order.getOrderStatus())
						|| "READY_FOR_PICKUP".equals(order.getOrderStatus())) {
					pendingOrders++;
				}

				if ("DELIVERED".equals(order.getOrderStatus())) {
					completedOrders++;
				}
			}
		}

		req.setAttribute("restaurant", ownerRestaurant);
		req.setAttribute("totalMenuItems", menuList.size());
		req.setAttribute("totalOrders", totalOrders);
		req.setAttribute("pendingOrders", pendingOrders);
		req.setAttribute("completedOrders", completedOrders);

		req.getRequestDispatcher("/JSP/ownerDashboard.jsp").forward(req, resp);
	}
}
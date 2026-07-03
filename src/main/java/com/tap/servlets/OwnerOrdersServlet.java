package com.tap.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.DAOimpl.OrderItemDAOImpl;
import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ownerOrders")
public class OwnerOrdersServlet extends HttpServlet {

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
			req.getRequestDispatcher("/JSP/ownerOrders.jsp").forward(req, resp);
			return;
		}

		OrderDAOImpl orderDAO = new OrderDAOImpl();
		List<Order> allOrders = orderDAO.getAllOrder();

		List<Order> ownerOrders = new ArrayList<Order>();

		for (Order order : allOrders) {
			if (order.getRestaurantId() == ownerRestaurant.getRestaurantId()) {
				ownerOrders.add(order);
			}
		}

		OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
		MenuDAOImpl menuDAO = new MenuDAOImpl();

		Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<Integer, List<OrderItem>>();
		Map<Integer, String> menuNameMap = new HashMap<Integer, String>();

		for (Order order : ownerOrders) {
			List<OrderItem> items = orderItemDAO.getOrderItemsByOrder(order.getOrderId());
			orderItemsMap.put(order.getOrderId(), items);

			for (OrderItem item : items) {
				Menu menu = menuDAO.getMenu(item.getMenuId());

				if (menu != null) {
					menuNameMap.put(item.getMenuId(), menu.getItemName());
				}
			}
		}

		req.setAttribute("restaurant", ownerRestaurant);
		req.setAttribute("orders", ownerOrders);
		req.setAttribute("orderItemsMap", orderItemsMap);
		req.setAttribute("menuNameMap", menuNameMap);

		req.getRequestDispatcher("/JSP/ownerOrders.jsp").forward(req, resp);
	}
}
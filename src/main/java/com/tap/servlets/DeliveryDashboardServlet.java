package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.model.Order;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/deliveryDashboard")
public class DeliveryDashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("loggedInUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");
			return;
		}

		User deliveryPartner = (User) session.getAttribute("loggedInUser");

		if (!"DELIVERY_PARTNER".equals(deliveryPartner.getRole())) {
			resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");
			return;
		}

		OrderDAOImpl orderDAO = new OrderDAOImpl();

		List<Order> availableOrders = orderDAO.getOrdersByStatus("READY_FOR_PICKUP");
		List<Order> pickedOrders = orderDAO.getOrdersByStatus("PICKED_UP");
		List<Order> outForDeliveryOrders = orderDAO.getOrdersByStatus("OUT_FOR_DELIVERY");
		List<Order> deliveredOrders = orderDAO.getOrdersByStatus("DELIVERED");

		req.setAttribute("availableCount", availableOrders.size());
		req.setAttribute("pickedCount", pickedOrders.size() + outForDeliveryOrders.size());
		req.setAttribute("completedCount", deliveredOrders.size());
		req.setAttribute("deliveryPartner", deliveryPartner);

		req.getRequestDispatcher("/JSP/deliveryDashboard.jsp").forward(req, resp);
	}
}
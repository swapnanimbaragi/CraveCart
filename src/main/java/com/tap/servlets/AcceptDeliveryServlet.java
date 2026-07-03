package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.model.Order;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/acceptDelivery")
public class AcceptDeliveryServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Check login session
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

		// Get order id
		int orderId = Integer.parseInt(req.getParameter("orderId"));

		OrderDAOImpl orderDAO = new OrderDAOImpl();

		Order order = orderDAO.getOrder(orderId);

		if (order != null) {

			// When delivery partner accepts order
			order.setOrderStatus("PICKED_UP");

			orderDAO.updateOrder(order);
		}

		resp.sendRedirect(req.getContextPath() + "/deliveryOrders");
	}
}
package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.model.Order;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/deliveryOrders")
public class DeliveryOrdersServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Check login session
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("loggedInUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");
			return;
		}

		User deliveryPartner = (User) session.getAttribute("loggedInUser");

		// Only delivery partner can access this page
		if (!"DELIVERY_PARTNER".equals(deliveryPartner.getRole())) {
			resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");
			return;
		}

		// Get orders which are ready for pickup
		OrderDAOImpl orderDAO = new OrderDAOImpl();

		List<Order> availableOrders =
				orderDAO.getOrdersByStatus("READY_FOR_PICKUP");

		// Send orders to JSP
		req.setAttribute("availableOrders", availableOrders);

		// Forward to delivery orders page
		req.getRequestDispatcher("/JSP/deliveryOrders.jsp").forward(req, resp);
	}
}
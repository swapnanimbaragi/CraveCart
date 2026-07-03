package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.DeliveryPartnerDAOImpl;
import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.model.Order;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateDeliveryStatus")
public class UpdateDeliveryStatusServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
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

		int orderId = Integer.parseInt(req.getParameter("orderId"));
		String orderStatus = req.getParameter("orderStatus");

		OrderDAOImpl orderDAO = new OrderDAOImpl();
		Order order = orderDAO.getOrder(orderId);

		if (order != null) {

			order.setOrderStatus(orderStatus);
			orderDAO.updateOrder(order);

			// If order delivered, increase delivery count
			if ("DELIVERED".equals(orderStatus)) {

				DeliveryPartnerDAOImpl partnerDAO = new DeliveryPartnerDAOImpl();

				// Rahul deliveryPartnerId = 1 in delivery_partner table
				partnerDAO.incrementDeliveryCount(1);
			}
		}

		resp.sendRedirect(req.getContextPath() + "/myDeliveries");
	}
}
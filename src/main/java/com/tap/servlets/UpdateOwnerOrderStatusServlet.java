package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateOwnerOrderStatus")
public class UpdateOwnerOrderStatusServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("loggedInUser") == null) {
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
		}

		resp.sendRedirect(req.getContextPath() + "/ownerOrders");
	}
}
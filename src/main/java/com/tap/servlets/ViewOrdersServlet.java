package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminOrders")
public class ViewOrdersServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		OrderDAOImpl orderDAO = new OrderDAOImpl();
		List<Order> orders = orderDAO.getAllOrder();

		req.setAttribute("orders", orders);

		req.getRequestDispatcher("/JSP/viewOrders.jsp").forward(req, resp);
	}
}
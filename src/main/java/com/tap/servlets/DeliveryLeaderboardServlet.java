package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.DeliveryPartnerDAOImpl;
import com.tap.model.DeliveryPartner;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/deliveryLeaderboard")
public class DeliveryLeaderboardServlet extends HttpServlet {

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

		DeliveryPartnerDAOImpl partnerDAO = new DeliveryPartnerDAOImpl();
		List<DeliveryPartner> partners = partnerDAO.getAllDeliveryPartners();

		req.setAttribute("partners", partners);

		req.getRequestDispatcher("/JSP/deliveryLeaderboard.jsp").forward(req, resp);
	}
}
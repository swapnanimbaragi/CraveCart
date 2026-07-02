package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.DeliveryPartnerDAOImpl;
import com.tap.model.DeliveryPartner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminDeliveryPartners")
public class ViewDeliveryPartnersServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		DeliveryPartnerDAOImpl partnerDAO = new DeliveryPartnerDAOImpl();
		List<DeliveryPartner> partners = partnerDAO.getAllDeliveryPartners();

		req.setAttribute("partners", partners);

		req.getRequestDispatcher("/JSP/viewDeliveryPartners.jsp").forward(req, resp);
	}
}
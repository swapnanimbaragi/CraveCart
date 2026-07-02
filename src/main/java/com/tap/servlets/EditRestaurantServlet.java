package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editRestaurant")
public class EditRestaurantServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Check admin login
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		// Get restaurant id from URL
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

		// Get restaurant details from DB
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);

		// Send restaurant object to JSP
		req.setAttribute("restaurant", restaurant);

		// Open edit page
		req.getRequestDispatcher("/JSP/editRestaurant.jsp").forward(req, resp);
	}
}
package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.AdminDashboardDAOImpl;
import com.tap.model.DashboardStats;
import com.tap.model.TopRestaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Check admin login session
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("admin") == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp");
			return;
		}

		User admin = (User) session.getAttribute("admin");

		// DAO object
		AdminDashboardDAOImpl dashboardDAO = new AdminDashboardDAOImpl();

		// Get dashboard data from database
		DashboardStats stats = dashboardDAO.getDashboardStats();
		List<TopRestaurant> topRestaurants = dashboardDAO.getTopRestaurants();

		// Send data to JSP
		req.setAttribute("admin", admin);
		req.setAttribute("stats", stats);
		req.setAttribute("topRestaurants", topRestaurants);

		// Forward to admin dashboard page
		req.getRequestDispatcher("/JSP/adminDashboard.jsp").forward(req, resp);
	}
}
package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.AdminDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String email = req.getParameter("email");
		String password = req.getParameter("password");

		AdminDAOImpl adminDAO = new AdminDAOImpl();
		User admin = adminDAO.adminLogin(email, password);

		if (admin != null) {
			HttpSession session = req.getSession();
			session.setAttribute("admin", admin);

			resp.sendRedirect(req.getContextPath() + "/adminDashboard");
		} else {
			resp.sendRedirect(req.getContextPath() + "/JSP/adminLogin.jsp?error=invalid");
		}
	}
}
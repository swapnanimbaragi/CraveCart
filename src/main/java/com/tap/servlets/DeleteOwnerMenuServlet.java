package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.MenuDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/deleteOwnerMenu")
public class DeleteOwnerMenuServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int menuId = Integer.parseInt(req.getParameter("menuId"));

		MenuDAOImpl menuDAO = new MenuDAOImpl();
		menuDAO.deleteMenu(menuId);

		resp.sendRedirect(req.getContextPath() + "/ownerMenu");
	}
}
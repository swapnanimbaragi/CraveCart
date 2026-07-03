package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/editOwnerMenu")
public class EditOwnerMenuServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int menuId = Integer.parseInt(req.getParameter("menuId"));

		MenuDAOImpl menuDAO = new MenuDAOImpl();

		Menu menu = menuDAO.getMenu(menuId);

		req.setAttribute("menu", menu);

		req.getRequestDispatcher("/JSP/editOwnerMenu.jsp").forward(req, resp);
	}
}
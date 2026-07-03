package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateOwnerMenu")
public class UpdateOwnerMenuServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int menuId = Integer.parseInt(req.getParameter("menuId"));

		MenuDAOImpl menuDAO = new MenuDAOImpl();

		Menu oldMenu = menuDAO.getMenu(menuId);

		if (oldMenu != null) {

			oldMenu.setItemName(req.getParameter("itemName"));
			oldMenu.setDescription(req.getParameter("description"));
			oldMenu.setPrice(Double.parseDouble(req.getParameter("price")));
			oldMenu.setCategory(req.getParameter("category"));
			oldMenu.setImageUrl(req.getParameter("imageUrl"));
			oldMenu.setRating(Double.parseDouble(req.getParameter("rating")));

			menuDAO.updateMenu(oldMenu);
		}

		resp.sendRedirect(req.getContextPath() + "/ownerMenu");
	}
}
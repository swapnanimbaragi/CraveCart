package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        MenuDAOImpl menuDAO = new MenuDAOImpl();

        List<Menu> menuList = menuDAO.getMenuByRestaurantId(restaurantId);

        req.setAttribute("menuList", menuList);

        req.getRequestDispatcher("/JSP/menu.jsp").forward(req, resp);
    }
}
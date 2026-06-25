package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

        List<Restaurant> restaurantList = restaurantDAO.getAllRestaurant();

        req.setAttribute("restaurantList", restaurantList);

        req.getRequestDispatcher("/JSP/home.jsp").forward(req, resp);
    }
}

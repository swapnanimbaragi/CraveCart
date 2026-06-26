package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.UserDAOimpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAOimpl userDAO = new UserDAOimpl();

        User user = userDAO.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {

            HttpSession session = req.getSession();

            session.setAttribute("loggedInUser", user);

            resp.sendRedirect("home");

        } else {

            req.setAttribute("error", "Invalid Email or Password");
            req.getRequestDispatcher("/JSP/login.jsp").forward(req, resp);

        }
    }
}
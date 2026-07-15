package com.tap.servlets;

import java.io.IOException;

import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if(session == null ||
           session.getAttribute("loggedInUser") == null){

            resp.sendRedirect(
                req.getContextPath()+"/JSP/login.jsp");

            return;
        }

        User user =
        (User)session.getAttribute("loggedInUser");
        
        
        System.out.println(user);
        System.out.println("Name = " + user.getUserName());
        System.out.println("Email = " + user.getEmail());
        System.out.println("Address = " + user.getAddress());

        req.setAttribute("user", user);

        req.getRequestDispatcher("/JSP/profile.jsp")
           .forward(req, resp);
    }
}
package com.tap.servlets;

import java.io.IOException;

import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if(session == null ||
           session.getAttribute("loggedInUser")==null){

            resp.sendRedirect(req.getContextPath()+"/JSP/login.jsp");
            return;
        }

        User user=(User)session.getAttribute("loggedInUser");

        req.setAttribute("user", user);

        req.getRequestDispatcher("/JSP/editProfile.jsp")
        .forward(req, resp);
    }
}
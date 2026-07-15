package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.UserDAOimpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException,IOException{

        int id=Integer.parseInt(req.getParameter("userId"));

        String name=req.getParameter("userName");
        String email=req.getParameter("email");
        String address=req.getParameter("address");
        String password=req.getParameter("password");

        UserDAOimpl dao=new UserDAOimpl();

        User user=dao.getUser(id);

        user.setUserName(name);
        user.setEmail(email);
        user.setAddress(address);
        user.setPassword(password);

        dao.updateUser(user);

        User updatedUser=dao.getUser(id);

        HttpSession session=req.getSession();

        session.setAttribute("loggedInUser",updatedUser);

        resp.sendRedirect(req.getContextPath()+"/profile");
    }

}
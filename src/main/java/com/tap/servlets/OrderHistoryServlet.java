package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.model.Order;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if(session==null){
            resp.sendRedirect(req.getContextPath()+"/JSP/login.jsp");
            return;
        }

        User user=(User)session.getAttribute("loggedInUser");

        if(user==null){
            resp.sendRedirect(req.getContextPath()+"/JSP/login.jsp");
            return;
        }

        OrderDAOImpl dao=new OrderDAOImpl();

        List<Order> orders=dao.getOrdersByUser(user.getUserId());

        req.setAttribute("orders",orders);

        req.getRequestDispatcher("/JSP/orderHistory.jsp")
           .forward(req,resp);
    }
}
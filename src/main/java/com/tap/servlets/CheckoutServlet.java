package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.CartDAOImpl;
import com.tap.DAOimpl.CartItemDAOImpl;
import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.DAOimpl.RestaurantDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession();

		User user = (User) session.getAttribute("loggedInUser");

		if (user == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");
			return;
		}

		CartDAOImpl cartDAO = new CartDAOImpl();
		CartItemDAOImpl cartItemDAO = new CartItemDAOImpl();
		MenuDAOImpl menuDAO = new MenuDAOImpl();
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

		Cart cart = cartDAO.getCartByUserId(user.getUserId());

		if (cart == null) {
			resp.sendRedirect(req.getContextPath() + "/cart");
			return;
		}

		List<CartItem> cartItems = cartItemDAO.getCartItemsByCartId(cart.getCartId());

		Restaurant restaurant = null;

		if (cartItems != null && !cartItems.isEmpty()) {

			CartItem firstItem = cartItems.get(0);

			Menu menu = menuDAO.getMenu(firstItem.getMenuId());

			if (menu != null) {
				restaurant = restaurantDAO.getRestaurant(menu.getRestaurantId());
			}
		}

		req.setAttribute("cart", cart);
		req.setAttribute("cartItems", cartItems);
		req.setAttribute("restaurant", restaurant);

		String couponCode = req.getParameter("couponCode");
		String discountAmount = req.getParameter("discountAmount");

		req.setAttribute("couponCode", couponCode);
		req.setAttribute("discountAmount", discountAmount);

		req.getRequestDispatcher("/JSP/checkout.jsp").forward(req, resp);
	}
}
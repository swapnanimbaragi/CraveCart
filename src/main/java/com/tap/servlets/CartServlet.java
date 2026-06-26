package com.tap.servlets;

import java.io.IOException;

import com.tap.DAOimpl.CartDAOImpl;
import com.tap.DAOimpl.CartItemDAOImpl;
import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession();

		User user = (User) session.getAttribute("loggedInUser");
		System.out.println("Cart user = " + user);

		if (user == null) {
			resp.sendRedirect(req.getContextPath() + "/JSP/login.jsp");
			return;
		}

		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));

		MenuDAOImpl menuDAO = new MenuDAOImpl();
		Menu menu = menuDAO.getMenu(menuId);

		CartDAOImpl cartDAO = new CartDAOImpl();
		Cart cart = cartDAO.getCartByUserId(user.getUserId());

		if (cart == null) {

			cart = new Cart();

			cart.setUserId(user.getUserId());
			cart.setCouponCode("");
			cart.setDiscountAmount(0);
			cart.setDeliveryFee(40);
			cart.setPlatformFee(10);
			cart.setGstAmount(0);
			cart.setSpecialInstructions("");
			cart.setDeliveryAddress(user.getAddress());
			cart.setEstimatedDeliveryTime(30);

			cartDAO.addCart(cart);

			cart = cartDAO.getCartByUserId(user.getUserId());
		}

		CartItemDAOImpl cartItemDAO = new CartItemDAOImpl();

		CartItem existingItem =
		        cartItemDAO.getCartItemByCartIdAndMenuId(cart.getCartId(), menuId);

		if (existingItem != null) {

		    existingItem.setQuantity(existingItem.getQuantity() + quantity);

		    existingItem.setItemTotal(
		            existingItem.getQuantity() * menu.getPrice());

		    cartItemDAO.updateCartItem(existingItem);

		} else {

		    CartItem cartItem = new CartItem();

		    cartItem.setCartId(cart.getCartId());
		    cartItem.setMenuId(menuId);
		    cartItem.setQuantity(quantity);
		    cartItem.setItemTotal(menu.getPrice() * quantity);
		    cartItem.setSavedForLater(false);

		    cartItemDAO.addCartItem(cartItem);
		}

		resp.sendRedirect(req.getContextPath() + "/cart");
	}

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

	    Cart cart = cartDAO.getCartByUserId(user.getUserId());

	    if (cart != null) {
	        req.setAttribute("cart", cart);
	        req.setAttribute("cartItems", cartItemDAO.getCartItemsByCartId(cart.getCartId()));
	    }

	    req.getRequestDispatcher("/JSP/cart.jsp").forward(req, resp);
	}
}

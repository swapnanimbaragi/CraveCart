package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOimpl.CartDAOImpl;
import com.tap.DAOimpl.CartItemDAOImpl;
import com.tap.DAOimpl.MenuDAOImpl;
import com.tap.DAOimpl.OrderDAOImpl;
import com.tap.DAOimpl.OrderItemDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
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
		OrderDAOImpl orderDAO = new OrderDAOImpl();
		OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();

		Cart cart = cartDAO.getCartByUserId(user.getUserId());

		if (cart == null) {
			resp.sendRedirect(req.getContextPath() + "/cart");
			return;
		}

		List<CartItem> cartItems = cartItemDAO.getCartItemsByCartId(cart.getCartId());

		if (cartItems == null || cartItems.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/cart");
			return;
		}

		String deliveryAddress = req.getParameter("deliveryAddress");
		String specialInstructions = req.getParameter("specialInstructions");
		String paymentMode = req.getParameter("paymentMode");
		String couponCode = req.getParameter("couponCode");

		double discountAmount = Double.parseDouble(req.getParameter("discountAmount"));
		double grandTotal = Double.parseDouble(req.getParameter("grandTotal"));

		double deliveryLatitude = 0;
		double deliveryLongitude = 0;

		String latParam = req.getParameter("deliveryLatitude");
		String lonParam = req.getParameter("deliveryLongitude");

		if (latParam != null && !latParam.equals("")) {
			deliveryLatitude = Double.parseDouble(latParam);
		}

		if (lonParam != null && !lonParam.equals("")) {
			deliveryLongitude = Double.parseDouble(lonParam);
		}

		Menu firstMenu = menuDAO.getMenu(cartItems.get(0).getMenuId());
		int restaurantId = firstMenu.getRestaurantId();

		Order order = new Order(
				user.getUserId(),
				restaurantId,
				grandTotal,
				paymentMode,
				"PLACED",
				deliveryAddress,
				specialInstructions,
				couponCode,
				discountAmount,
				cart.getDeliveryFee(),
				30
		);

		order.setDeliveryLatitude(deliveryLatitude);
		order.setDeliveryLongitude(deliveryLongitude);

		int orderId = orderDAO.addOrderAndReturnId(order);

		for (CartItem cartItem : cartItems) {

			Menu menu = menuDAO.getMenu(cartItem.getMenuId());

			OrderItem orderItem = new OrderItem(
					orderId,
					cartItem.getMenuId(),
					cartItem.getQuantity(),
					menu.getPrice(),
					menu.getPrice() * cartItem.getQuantity(),
					"",
					0.0,
					""
			);

			orderItemDAO.addOrderItem(orderItem);

			cartItemDAO.deleteCartItem(cartItem.getCartItemId());
		}

		resp.sendRedirect(req.getContextPath() + "/orderSuccess?orderId=" + orderId);
	}
}
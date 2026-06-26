<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.DAOimpl.MenuDAOImpl"%>
<%@ page import="com.tap.DAOimpl.RestaurantDAOImpl"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cart | CraveCart</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/cart.css">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<header class="navbar">

	<div class="logo">CraveCart</div>

	<nav>
		<a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/home#restaurants">Restaurants</a>
		<a href="${pageContext.request.contextPath}/cart">Cart</a>
	</nav>

</header>

<!-- ================= CART ================= -->

<section class="cart-page">

	<h1 class="cart-title">🛒 My Cart</h1>

	<%
	Cart cart = (Cart) request.getAttribute("cart");
	List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");

	MenuDAOImpl menuDAO = new MenuDAOImpl();
	RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

	double itemsTotal = 0;

	if (cartItems != null && !cartItems.isEmpty()) {
	%>

	<div class="cart-layout">

		<!-- LEFT -->

		<div>

			<%
			for (CartItem item : cartItems) {

				Menu menu = menuDAO.getMenu(item.getMenuId());

				Restaurant restaurant = restaurantDAO.getRestaurant(menu.getRestaurantId());

				double subtotal = menu.getPrice() * item.getQuantity();

				itemsTotal += subtotal;
			%>

			<div class="cart-item">

				<img
					src="${pageContext.request.contextPath}/images/<%=menu.getImageUrl()%>">

				<div class="item-info">

					<h3><%=menu.getItemName()%></h3>

					<p class="restaurant-name">
						<%=restaurant.getRestaurantName()%>
					</p>

					<p>⭐ <%=menu.getRating()%></p>

					<div class="price">
						₹<%=menu.getPrice()%>
					</div>

					<div class="qty-row">

						<div class="qty-box">

							<button class="minus">-</button>

							<span class="quantity"><%=item.getQuantity()%></span>

							<button class="plus">+</button>

						</div>

						<strong>₹<%=subtotal%></strong>

						<a href="#" class="remove-btn">
							🗑 Remove
						</a>

					</div>

				</div>

			</div>

			<%
			}
			%>

		</div>

		<!-- RIGHT -->

		<div class="bill-box">

			<h2>Bill Details</h2>

			<div class="bill-row">

				<span>Items Total</span>

				<span>₹<%=itemsTotal%></span>

			</div>

			<div class="bill-row">

				<span>Delivery Fee</span>

				<span>₹<%=cart.getDeliveryFee()%></span>

			</div>

			<div class="bill-row">

				<span>Platform Fee</span>

				<span>₹<%=cart.getPlatformFee()%></span>

			</div>

			<div class="bill-row">

				<span>GST</span>

				<span>₹<%=cart.getGstAmount()%></span>

			</div>

			<div class="bill-row">

				<span>Discount</span>

				<span>- ₹<%=cart.getDiscountAmount()%></span>

			</div>

			<div class="bill-row total">

				<span>Grand Total</span>

				<span>

					₹<%=itemsTotal
		+ cart.getDeliveryFee()
		+ cart.getPlatformFee()
		+ cart.getGstAmount()
		- cart.getDiscountAmount()%>

				</span>

			</div>

			<button class="checkout-btn">

				Proceed To Checkout →

			</button>

		</div>

	</div>

	<%
	} else {
	%>

	<div class="empty-cart">

		<h2>Your Cart is Empty</h2>

		<br>

		<a href="${pageContext.request.contextPath}/home">

			← Continue Shopping

		</a>

	</div>

	<%
	}
	%>

</section>

<script src="${pageContext.request.contextPath}/js/cart.js"></script>

</body>
</html>
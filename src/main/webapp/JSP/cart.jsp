<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css?v=20">
</head>

<body>

<header class="navbar">
	<div class="logo">CraveCart</div>

	<nav>
		<a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/home#restaurants">Restaurants</a>
		<a href="${pageContext.request.contextPath}/home#categories">Categories</a>
		<a href="${pageContext.request.contextPath}/orders">My Orders</a>
		<a href="${pageContext.request.contextPath}/contact">Contact</a>
	</nav>
</header>

<section class="cart-page">

<%
Cart cart = (Cart) request.getAttribute("cart");
List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");

MenuDAOImpl menuDAO = new MenuDAOImpl();
RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

double itemsTotal = 0;
double deliveryFee = 0;
double platformFee = 0;
double gstAmount = 0;
double discountAmount = 0;

String couponCode = request.getParameter("couponCode");
String couponMessage = "";

if (couponCode != null) {
	couponCode = couponCode.trim().toUpperCase();
}
%>

	<div class="cart-title">
		<div class="cart-icon">🛒</div>
		<div>
			<h1>My <span>Cart</span></h1>
			<p>Review your food items before checkout</p>
		</div>
	</div>

<%
if (cartItems != null && !cartItems.isEmpty() && cart != null) {
%>

	<div class="cart-layout">

		<div class="cart-left">

<%
for (CartItem item : cartItems) {

	Menu menu = menuDAO.getMenu(item.getMenuId());

	if (menu == null) {
		continue;
	}

	Restaurant restaurant = restaurantDAO.getRestaurant(menu.getRestaurantId());

	double subtotal = menu.getPrice() * item.getQuantity();
	itemsTotal += subtotal;
%>

			<div class="cart-card">

				<div class="food-img">
					<img src="${pageContext.request.contextPath}/images/<%=menu.getImageUrl()%>"
						alt="<%=menu.getItemName()%>">
				</div>

				<div class="food-details">
					<h2><%=menu.getItemName()%></h2>

					<p class="restaurant">
						🏪 <%=restaurant != null ? restaurant.getRestaurantName() : "Restaurant"%>
					</p>

					<div class="meta">
						<span>⭐ <%=menu.getRating()%></span>
						<span class="fresh">Fresh</span>
					</div>

					<h3>₹<%=menu.getPrice()%></h3>
				</div>

				<div class="cart-actions">

					<div class="qty-box">
						<a href="<%=request.getContextPath()%>/cart?action=decrease&cartItemId=<%=item.getCartItemId()%><%=couponCode != null ? "&couponCode=" + couponCode : ""%>">-</a>

						<span><%=item.getQuantity()%></span>

						<a href="<%=request.getContextPath()%>/cart?action=increase&cartItemId=<%=item.getCartItemId()%><%=couponCode != null ? "&couponCode=" + couponCode : ""%>">+</a>
					</div>

					<div class="subtotal">
						<small>Subtotal</small>
						<strong>₹<%=subtotal%></strong>
					</div>

					<a class="remove-btn"
						href="<%=request.getContextPath()%>/cart?action=remove&cartItemId=<%=item.getCartItemId()%><%=couponCode != null ? "&couponCode=" + couponCode : ""%>">
						🗑 Remove
					</a>

				</div>

			</div>

<%
}

deliveryFee = cart.getDeliveryFee();
platformFee = cart.getPlatformFee();
gstAmount = cart.getGstAmount();

if (couponCode != null && !couponCode.equals("")) {

	if (couponCode.equals("SAVE50")) {
		if (itemsTotal >= 299) {
			discountAmount = 50;
			couponMessage = "SAVE50 applied successfully!";
		} else {
			couponMessage = "SAVE50 valid only above ₹299";
		}
	} 
	else if (couponCode.equals("SAVE10")) {
		if (itemsTotal >= 199) {
			discountAmount = itemsTotal * 0.10;
			couponMessage = "SAVE10 applied successfully!";
		} else {
			couponMessage = "SAVE10 valid only above ₹199";
		}
	} 
	else if (couponCode.equals("FREESHIP")) {
		if (itemsTotal >= 149) {
			discountAmount = deliveryFee;
			couponMessage = "FREESHIP applied successfully!";
		} else {
			couponMessage = "FREESHIP valid only above ₹149";
		}
	} 
	else {
		couponMessage = "Invalid coupon code";
	}
}

double grandTotal = itemsTotal + deliveryFee + platformFee + gstAmount - discountAmount;

if (grandTotal < 0) {
	grandTotal = 0;
}
%>

			<div class="trust-strip">
				<div>🛡️ <span>Safe Payments</span></div>
				<div>📦 <span>Hygienic Packaging</span></div>
				<div>🛵 <span>On-time Delivery</span></div>
				<div>🏅 <span>Best Quality</span></div>
			</div>

		</div>

		<div class="bill-box">

			<div class="bill-heading">
				<div class="bill-icon">🧾</div>
				<div>
					<h2>Bill Details</h2>
					<div class="green-line"></div>
				</div>
			</div>

			<form action="<%=request.getContextPath()%>/cart" method="get" class="coupon-box">
				<input type="text" name="couponCode" placeholder="Enter coupon code"
					value="<%=couponCode != null ? couponCode : ""%>">
				<button type="submit">Apply</button>
			</form>

			<%
			if (couponCode != null && !couponCode.equals("")) {
			%>
				<a href="<%=request.getContextPath()%>/cart" class="remove-coupon">Remove Coupon</a>
			<%
			}
			%>

			<%
			if (!couponMessage.equals("")) {
			%>
				<p class="coupon-msg"><%=couponMessage%></p>
			<%
			}
			%>

			<div class="bill-row">
				<span>Items Total</span>
				<strong>₹<%=itemsTotal%></strong>
			</div>

			<div class="bill-row">
				<span>Delivery Fee</span>
				<strong>₹<%=deliveryFee%></strong>
			</div>

			<div class="bill-row">
				<span>Platform Fee</span>
				<strong>₹<%=platformFee%></strong>
			</div>

			<div class="bill-row">
				<span>GST</span>
				<strong>₹<%=gstAmount%></strong>
			</div>

			<div class="bill-row discount-row">
				<span>Discount</span>
				<strong>- ₹<%=discountAmount%></strong>
			</div>

			<div class="grand-total">
				<span>Grand Total</span>
				<strong>₹<%=grandTotal%></strong>
			</div>

			<a class="checkout-btn"
				href="<%=request.getContextPath()%>/checkout?couponCode=<%=couponCode != null ? couponCode : ""%>&discountAmount=<%=discountAmount%>">
				<span>Proceed To Checkout</span>
				<b>→</b>
			</a>

			<p class="coin-text">🪙 You will earn <b>146 CraveCoins</b> on this order</p>

		</div>

	</div>

<%
} else {
%>

	<div class="empty-cart">
		<h2>Your Cart is Empty</h2>
		<p>Looks like you haven't added anything yet.</p>
		<a href="${pageContext.request.contextPath}/home">← Continue Shopping</a>
	</div>

<%
}
%>

</section>

</body>
</html>
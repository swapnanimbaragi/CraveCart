<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.DAOimpl.MenuDAOImpl"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout | CraveCart</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css">

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
</head>

<body>

<header class="navbar">
	<div class="logo">CraveCart</div>

	<nav>
		<a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/cart">Cart</a>
	</nav>
</header>

<section class="checkout-page">

	<div class="checkout-header">
		<div class="checkout-badge">✅ CHECKOUT</div>
		<h1>Almost <span>There.</span></h1>
		<p>Confirm your address, choose payment mode, and place your order.</p>
	</div>

<%
User user = (User) session.getAttribute("loggedInUser");
Cart cart = (Cart) request.getAttribute("cart");
List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");

String couponCode = (String) request.getAttribute("couponCode");
String discountStr = (String) request.getAttribute("discountAmount");

double discountAmount = 0;

if (discountStr != null && !discountStr.equals("")) {
	discountAmount = Double.parseDouble(discountStr);
}

MenuDAOImpl menuDAO = new MenuDAOImpl();

double itemsTotal = 0;

if (cartItems != null) {
	for (CartItem item : cartItems) {
		Menu menu = menuDAO.getMenu(item.getMenuId());

		if (menu != null) {
			itemsTotal += menu.getPrice() * item.getQuantity();
		}
	}
}

double deliveryFee = cart.getDeliveryFee();
double platformFee = cart.getPlatformFee();
double gstAmount = cart.getGstAmount();

double grandTotal = itemsTotal + deliveryFee + platformFee + gstAmount - discountAmount;

if (grandTotal < 0) {
	grandTotal = 0;
}
%>

	<div class="checkout-layout">

		<div class="checkout-left">

			<div class="checkout-card">

				<div class="section-title">
					<div class="section-icon">📍</div>
					<div>
						<h2>Delivery Details</h2>
						<div class="green-line"></div>
					</div>
				</div>

				<form action="${pageContext.request.contextPath}/placeOrder" method="post">

					<input type="hidden" name="couponCode"
						value="<%=couponCode != null ? couponCode : ""%>">

					<input type="hidden" name="discountAmount"
						value="<%=discountAmount%>">

					<input type="hidden" name="grandTotal"
						value="<%=grandTotal%>">

					<label>Delivery Address</label>

						<div class="address-actions">
							<button type="button" class="location-btn" onclick="useCurrentLocation()">
								📍 Use Current Location
							</button>
						
							<button type="button" class="location-btn secondary-btn" onclick="clearLocation()">
								✏️ Enter Manually
							</button>
						</div>
						
						<textarea id="deliveryAddress" name="deliveryAddress" required><%=user != null && user.getAddress() != null ? user.getAddress() : ""%></textarea>
						
						<div class="map-card">
							<div id="checkoutMap"></div>
						</div>
						
						<p id="locationStatus" class="location-status">
							Select current location to show map preview.
						</p>
						
						<div id="selectedAddressCard" class="selected-address-card">
							<div class="selected-icon">📍</div>
						
							<div>
								<h3>Delivering to Current Location</h3>
								<p id="selectedAddressText">Your detected address will appear here.</p>
							</div>
						</div>

					<label>Special Instructions</label>
					<textarea name="specialInstructions"
						placeholder="Example: Less spicy, call before delivery..."></textarea>

					<label>Payment Mode</label>
					<select name="paymentMode" required>
						<option value="COD">Cash On Delivery</option>
						<option value="UPI">UPI</option>
						<option value="CARD">Card</option>
					</select>

					<button type="submit" class="place-order-btn">
						Place Order →
					</button>

				</form>

			</div>

		</div>

		<div class="summary-card">

			<div class="section-title">
				<div class="section-icon">🧾</div>
				<div>
					<h2>Order Summary</h2>
					<div class="green-line"></div>
				</div>
			</div>

			<div class="summary-row">
				<span>Items Total</span>
				<strong>₹<%=itemsTotal%></strong>
			</div>

			<div class="summary-row">
				<span>Delivery Fee</span>
				<strong>₹<%=deliveryFee%></strong>
			</div>

			<div class="summary-row">
				<span>Platform Fee</span>
				<strong>₹<%=platformFee%></strong>
			</div>

			<div class="summary-row">
				<span>GST</span>
				<strong>₹<%=gstAmount%></strong>
			</div>

			<div class="summary-row discount-row">
				<span>Discount</span>
				<strong>- ₹<%=discountAmount%></strong>
			</div>

			<div class="total-box">
				<span>Grand Total</span>
				<strong>₹<%=grandTotal%></strong>
			</div>

		</div>

	</div>

</section>
<script src="${pageContext.request.contextPath}/js/checkout.js"></script>
</body>
</html>
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

<!-- ================= CSS FILES ================= -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css">

<!-- ================= LEAFLET MAP CSS & JS ================= -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
</head>

<body>

<!-- ================= NAVBAR ================= -->
<header class="navbar">
	<div class="logo">CraveCart</div>

	<nav>
		<a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/cart">Cart</a>
	</nav>
</header>

<!-- ================= CHECKOUT PAGE ================= -->
<section class="checkout-page">

	<!-- ================= CHECKOUT HEADER ================= -->
	<div class="checkout-header">
		<div class="checkout-badge">✅ CHECKOUT</div>
		<h1>Almost <span>There.</span></h1>
		<p>Confirm your address, choose payment mode, and place your order.</p>
	</div>

<%
/* ================= BACKEND DATA FETCHING ================= */

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

	<!-- ================= MAIN CHECKOUT LAYOUT ================= -->
	<div class="checkout-layout">

		<!-- ================= LEFT SIDE : DELIVERY DETAILS ================= -->
		<div class="checkout-left">

			<div class="checkout-card">

				<!-- ================= SECTION TITLE ================= -->
				<div class="section-title">
					<div class="section-icon">📍</div>
					<div>
						<h2>Delivery Setup</h2>
						
					</div>
				</div>

				<!-- ================= PLACE ORDER FORM ================= -->
				<form action="${pageContext.request.contextPath}/placeOrder" method="post">

					<!-- Hidden values sent to PlaceOrderServlet -->
					<input type="hidden" name="couponCode"
						value="<%=couponCode != null ? couponCode : ""%>">

					<input type="hidden" name="discountAmount"
						value="<%=discountAmount%>">

					<input type="hidden" name="grandTotal"
						value="<%=grandTotal%>">

					<!-- ================= DELIVERY ADDRESS HEADER ================= -->
					<div class="checkout-subtitle">
						<h3>Where should we deliver?</h3>
						<p>Choose your location and verify it on the map.</p>
					</div>

					<!-- ================= ADDRESS ACTION BUTTONS ================= -->
					<div class="address-actions">

						<button type="button" class="location-btn" onclick="useCurrentLocation()">
							📍 Use Current Location
						</button>

						<button type="button" class="location-btn secondary-btn" onclick="clearLocation()">
							✏️ Enter Manually
						</button>

					</div>

					<!-- ================= ADDRESS TEXTAREA ================= -->
					<!-- This is submitted to backend. It can be hidden later if you want. -->
					<textarea id="deliveryAddress" name="deliveryAddress" required><%=user != null && user.getAddress() != null ? user.getAddress() : ""%></textarea>

					<!-- ================= SELECTED ADDRESS CARD ================= -->
					<div id="selectedAddressCard" class="selected-address-card">

						<div class="selected-icon">📍</div>

						<div class="selected-content">
							<span>Delivering To</span>
							<h3>Current Location</h3>
							<p id="selectedAddressText">Select current location to detect your address.</p>
							<small>🟢 GPS Verified</small>
						</div>

					</div>

					<!-- ================= MAP SECTION ================= -->
					<div class="map-section">

						<div class="map-title">
							<h3>Map Preview</h3>
							<p>Drag and zoom the map to verify your delivery point.</p>
						</div>

						<div class="map-card">
							<div id="checkoutMap"></div>
						</div>

						<p id="locationStatus" class="location-status">
							Select current location to show map preview.
						</p>

					</div>

					<!-- ================= SAVED ADDRESSES ================= -->
					<div class="saved-addresses">

						<h3>Saved Addresses</h3>

						<div class="saved-grid">

							<div class="saved-card"
								onclick="selectSavedAddress('Home', 'BTM Layout, Bengaluru, Karnataka 560076')">
								<div>🏠</div>
								<strong>Home</strong>
								<p>BTM Layout</p>
							</div>

							<div class="saved-card"
								onclick="selectSavedAddress('Office', 'Electronic City, Bengaluru, Karnataka 560100')">
								<div>🏢</div>
								<strong>Office</strong>
								<p>Electronic City</p>
							</div>

							<div class="saved-card" onclick="useCurrentLocation()">
								<div>📍</div>
								<strong>Current</strong>
								<p>Use GPS</p>
							</div>

						</div>

					</div>

					<!-- ================= SPECIAL INSTRUCTIONS ================= -->
					<label>Special Instructions</label>
					<textarea name="specialInstructions"
						placeholder="Example: Less spicy, call before delivery..."></textarea>

					<!-- ================= PAYMENT MODE ================= -->
					<label>Payment Mode</label>
					<select name="paymentMode" required>
						<option value="COD">Cash On Delivery</option>
						<option value="UPI">UPI</option>
						<option value="CARD">Card</option>
					</select>

					<!-- ================= PLACE ORDER BUTTON ================= -->
					<button type="submit" class="place-order-btn">
						Place Order →
					</button>

				</form>

			</div>

		</div>

		<!-- ================= RIGHT SIDE : ORDER SUMMARY ================= -->
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

<!-- ================= CHECKOUT JS ================= -->
<script src="${pageContext.request.contextPath}/js/checkout.js"></script>

</body>
</html>
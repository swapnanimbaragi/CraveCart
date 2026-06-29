<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.DAOimpl.MenuDAOImpl"%>
<%@ page import="com.tap.model.Restaurant"%>

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
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
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

		<!-- ================= LEFT SIDE : DELIVERY SETUP ================= -->
		<div class="checkout-left">

			<div class="checkout-card">

				<!-- ================= SECTION TITLE ================= -->
				<div class="section-title">
					<div class="section-icon">📍</div>
					<div>
						<h2>Delivery Setup</h2>
						<div class="green-line"></div>
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

					<input type="hidden" id="deliveryLatitude" name="deliveryLatitude">
					
					<input type="hidden" id="deliveryLongitude" name="deliveryLongitude">

					<!-- ================= ADDRESS CHOICE HEADER ================= -->
					<div class="checkout-subtitle">
						<h3>Where should we deliver?</h3>
						<p>Use live GPS, enter manually, or choose a saved address.</p>
					</div>

					<!-- ================= ADDRESS ACTION BUTTONS ================= -->
					<div class="address-actions">

						<button type="button" class="location-btn" onclick="useCurrentLocation()">
							📍 Use Current Location
						</button>

						<button type="button" class="location-btn secondary-btn" onclick="showManualAddress()">
							✏️ Enter Manually
						</button>

					</div>
					
					<div class="live-search-wrapper">
						<input type="text" id="addressSearchInput"
							placeholder="🔍 Search area, street, landmark..."
							oninput="liveSearchAddress()">
					
						<div id="searchResults" class="search-results"></div>
					</div>
					
					

					<!-- ================= HIDDEN ADDRESS FIELD ================= -->
					<!-- This value is submitted to backend as deliveryAddress -->
					<textarea id="deliveryAddress" name="deliveryAddress" required hidden><%=user != null && user.getAddress() != null ? user.getAddress() : ""%></textarea>

					<!-- ================= SELECTED ADDRESS CARD ================= -->
					<div id="selectedAddressCard" class="selected-address-card">

						<div class="selected-icon">📍</div>

						<div class="selected-content">
							<span>Delivering To</span>
							<h3 id="selectedAddressTitle">Current Location</h3>
							<p id="selectedAddressText">Select current location or choose a saved address.</p>
							<small id="selectedAddressBadge">🟢 GPS Verified</small>

							<div class="save-address-actions">
								<button type="button" onclick="saveCurrentAddressAs('Home')">Save as Home</button>
								<button type="button" onclick="saveCurrentAddressAs('Office')">Save as Office</button>
							</div>
						</div>

					</div>
					
					<!-- ================= DELIVERY ETA CARD ================= -->
					<div id="etaCard" class="eta-card" style="display:none;">
					
						<div class="eta-item">
							<div class="eta-icon">📏</div>
							<div>
								<span>Distance</span>
								<h3 id="distanceText">-- km</h3>
							</div>
						</div>
					
						<div class="eta-item">
							<div class="eta-icon">🛵</div>
							<div>
								<span>Estimated Delivery</span>
								<h3 id="etaText">-- mins</h3>
							</div>
						</div>
					
					</div>

					<!-- ================= MANUAL ADDRESS SECTION ================= -->
					<div id="manualAddressSection" class="manual-address-section" style="display:none;">

						<label>Complete Delivery Address</label>

						<textarea id="manualAddressInput"
							placeholder="House No., Building, Street, Area, Landmark..."></textarea>

						<div class="manual-actions">
							<button type="button" onclick="confirmManualAddress()" class="manual-save-btn">
								✅ Use This Address
							</button>
						</div>

					</div>

					<!-- ================= MAP SECTION ================= -->
					<div id="mapSection" class="map-section" style="display:none;">

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

							<!-- These cards are updated from localStorage using checkout.js -->
							<div id="homeAddressCard" class="saved-card empty-saved-card"
								onclick="handleSavedAddressClick('Home')">
								<div>🏠</div>
								<strong>Home</strong>
								<p id="homeAddressText">Not saved yet</p>
							</div>

							<div id="officeAddressCard" class="saved-card empty-saved-card"
								onclick="handleSavedAddressClick('Office')">
								<div>🏢</div>
								<strong>Office</strong>
								<p id="officeAddressText">Not saved yet</p>
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
<script>

const restaurantLat = <%= restaurant != null ? restaurant.getLatitude() : 12.934533 %>;
const restaurantLon = <%= restaurant != null ? restaurant.getLongitude() : 77.610116 %>;

</script>
<script src="${pageContext.request.contextPath}/js/checkout.js"></script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Order"%>
<%@ page import="com.tap.model.Restaurant"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Track Order | CraveCart</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/trackOrder.css">

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body>

<%
Order order = (Order) request.getAttribute("order");
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");

String deliveryAddress = order != null && order.getDeliveryAddress() != null ? order.getDeliveryAddress() : "";
deliveryAddress = deliveryAddress.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ");

double restaurantLat = restaurant != null ? restaurant.getLatitude() : 12.934533;
double restaurantLon = restaurant != null ? restaurant.getLongitude() : 77.610116;
String restaurantName = restaurant != null ? restaurant.getRestaurantName() : "Restaurant";
%>

<header class="navbar">
	<div class="logo">CraveCart</div>
	<nav>
		<a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/orders">My Orders</a>
	</nav>
</header>

<section class="tracking-page">

	<div class="tracking-left">

		<div class="top-summary">
			<div>
				<span>Order ID</span>
				<strong>#<%=order.getOrderId()%></strong>
			</div>

			<div>
				<span>Total Amount</span>
				<strong>₹<%=order.getTotalAmount()%></strong>
			</div>

			<div>
				<span>ETA</span>
				<strong id="topEta">-- mins</strong>
				<small>Updated live</small>
			</div>
		</div>

		<div class="timeline">

			<div class="track-step" id="stepPlaced">
				<div class="circle">✅</div>
				<div>
					<h3>Order Placed</h3>
					<p>Your order has been received.</p>
				</div>
				<span class="status-badge">Pending</span>
			</div>

			<div class="track-step" id="stepPreparing">
				<div class="circle">👨‍🍳</div>
				<div>
					<h3>Preparing</h3>
					<p>Restaurant is preparing your food.</p>
				</div>
				<span class="status-badge">Pending</span>
			</div>

			<div class="track-step" id="stepPacking">
				<div class="circle">📦</div>
				<div>
					<h3>Packing</h3>
					<p>Your food is being packed safely.</p>
				</div>
				<span class="status-badge">Pending</span>
			</div>

			<div class="track-step" id="stepPicked">
				<div class="circle">🛵</div>
				<div>
					<h3>Picked Up</h3>
					<p>Delivery partner has picked your order.</p>
				</div>
				<span class="status-badge">Pending</span>
			</div>

			<div class="track-step" id="stepOut">
				<div class="circle">📍</div>
				<div>
					<h3>Out For Delivery</h3>
					<p>Delivery partner is coming to your location.</p>
				</div>
				<span class="status-badge">Pending</span>
			</div>

			<div class="track-step" id="stepDelivered">
				<div class="circle">🏠</div>
				<div>
					<h3>Delivered</h3>
					<p>Enjoy your food!</p>
				</div>
				<span class="status-badge">Pending</span>
			</div>

		</div>

		<div class="reach-box">
			⏱️ We'll reach you in <b id="reachEta">-- mins</b>
			<p>Your order status updates live on this page.</p>
		</div>

	</div>

	<div class="tracking-right">

		<div class="partner-card">
			<div class="partner-avatar">🧑‍🍳</div>

			<div>
				<h2>Rahul Kumar <span>4.8 ⭐</span></h2>
				<p>Your delivery partner</p>
			</div>
		</div>

		<div class="partner-meta">
			<div>🛵 Bike</div>
			<div>📞 98765 43210</div>
			<div>KA 01 JD 1234</div>
		</div>

		<div class="live-map-card">
			<div class="map-head">
				<div>
					<h3>🟢 Live Tracking</h3>
					<p>Real-time delivery simulation</p>
				</div>
				<span>Live Updates On</span>
			</div>

			<div id="trackMap"></div>
		</div>

		<div class="live-info">
			<div>
				<span>Estimated Delivery</span>
				<strong id="mapEta">-- mins</strong>
			</div>

			<div>
				<span>Distance Left</span>
				<strong id="distanceLeft">-- km</strong>
			</div>

			<div>
				<span>Delivery To</span>
				<strong id="deliveryArea">Your Location</strong>
			</div>
		</div>

	</div>

</section>

<script>

const contextPath = "${pageContext.request.contextPath}";

const restaurantLat = <%=restaurantLat%>;
const restaurantLon = <%=restaurantLon%>;

const restaurantName = "<%=restaurantName.replace("\"", "\\\"")%>";

const customerAddress = "<%=deliveryAddress%>";

const customerLat =
<%= order != null ? order.getDeliveryLatitude() : 0 %>;

const customerLon =
<%= order != null ? order.getDeliveryLongitude() : 0 %>;

console.log("Restaurant :", restaurantLat, restaurantLon);
console.log("Customer Address :", customerAddress);
console.log("Customer Lat :", customerLat);
console.log("Customer Lon :", customerLon);

</script>

<script src="${pageContext.request.contextPath}/js/trackOrder.js"></script>


</body>
</html>
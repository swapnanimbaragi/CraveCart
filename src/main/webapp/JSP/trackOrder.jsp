<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Order"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Track Order | CraveCart</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/trackOrder.css">
</head>

<body>

<%
Order order = (Order) request.getAttribute("order");

String status = "PLACED";

if (order != null && order.getOrderStatus() != null) {
	status = order.getOrderStatus();
}
%>

<header class="navbar">
	<div class="logo">CraveCart</div>

	<nav>
		<a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/orders">My Orders</a>
	</nav>
</header>

<section class="track-page">

	<div class="track-header">
		<div class="track-badge">🛵 LIVE ORDER TRACKING</div>
		<h1>Your Food is <span>On The Way.</span></h1>
		<p>Follow your order from kitchen to doorstep.</p>
	</div>

	<div class="track-layout">

		<div class="track-card">

			<div class="order-summary">
				<div>
					<span>Order ID</span>
					<h2>#<%=order != null ? order.getOrderId() : 0%></h2>
				</div>

				<div>
					<span>Total Amount</span>
					<h2>₹<%=order != null ? order.getTotalAmount() : 0%></h2>
				</div>

				<div>
					<span>ETA</span>
					<h2><%=order != null ? order.getEstimatedDeliveryTime() : 30%> mins</h2>
				</div>
			</div>

			<div class="timeline">

				<div class="step active">
					<div class="step-icon">✅</div>
					<div>
						<h3>Order Placed</h3>
						<p>Your order has been received.</p>
					</div>
				</div>

				<div class="step <%=status.equals("PREPARING") || status.equals("PACKING") || status.equals("PICKED_UP") || status.equals("OUT_FOR_DELIVERY") || status.equals("DELIVERED") ? "active" : ""%>">
					<div class="step-icon">👨‍🍳</div>
					<div>
						<h3>Preparing</h3>
						<p>Restaurant is preparing your food.</p>
					</div>
				</div>

				<div class="step <%=status.equals("PACKING") || status.equals("PICKED_UP") || status.equals("OUT_FOR_DELIVERY") || status.equals("DELIVERED") ? "active" : ""%>">
					<div class="step-icon">📦</div>
					<div>
						<h3>Packing</h3>
						<p>Your food is being packed safely.</p>
					</div>
				</div>

				<div class="step <%=status.equals("PICKED_UP") || status.equals("OUT_FOR_DELIVERY") || status.equals("DELIVERED") ? "active" : ""%>">
					<div class="step-icon">🛵</div>
					<div>
						<h3>Picked Up</h3>
						<p>Delivery partner has picked your order.</p>
					</div>
				</div>

				<div class="step <%=status.equals("OUT_FOR_DELIVERY") || status.equals("DELIVERED") ? "active" : ""%>">
					<div class="step-icon">📍</div>
					<div>
						<h3>Out For Delivery</h3>
						<p>Delivery partner is coming to your location.</p>
					</div>
				</div>

				<div class="step <%=status.equals("DELIVERED") ? "active" : ""%>">
					<div class="step-icon">🎉</div>
					<div>
						<h3>Delivered</h3>
						<p>Enjoy your food!</p>
					</div>
				</div>

			</div>

		</div>

		<div class="delivery-card">

			<div class="partner-box">
				<div class="partner-img">🧑‍🚀</div>

				<div>
					<h2>Delivery Partner</h2>
					<p>Rahul is assigned to your order</p>
				</div>
			</div>

			<div class="partner-info">
				<div>
					<span>Vehicle</span>
					<strong>🛵 Bike</strong>
				</div>

				<div>
					<span>Rating</span>
					<strong>⭐ 4.8</strong>
				</div>
			</div>

			<div class="delivery-map-placeholder">
				🗺️ Live map coming soon
			</div>

		</div>

	</div>

</section>

</body>
</html>
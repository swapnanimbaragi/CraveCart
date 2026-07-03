<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.model.Restaurant"%>

<%
User owner = (User) session.getAttribute("loggedInUser");

if (owner == null || !"RESTAURANT_OWNER".equals(owner.getRole())) {
	response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
	return;
}

Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Restaurant | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/ownerDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/ownerMenu">Menu</a>
		<a href="<%=request.getContextPath()%>/ownerOrders">Orders</a>
		<a href="<%=request.getContextPath()%>/ownerRestaurant">My Restaurant</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>My <span>Restaurant</span></h1>
				<p>Manage your restaurant profile.</p>
			</div>
		</div>

		<%
		if (restaurant == null) {
		%>
			<div class="table-container">
				<p>No restaurant assigned to you yet.</p>
			</div>
		<%
		} else {
		%>

		<div class="owner-restaurant-card">

			<div class="owner-restaurant-img">
				<img src="<%=request.getContextPath() + "/images/" + restaurant.getRestaurantImg()%>"
					alt="<%=restaurant.getRestaurantName()%>">
			</div>

			<div class="owner-restaurant-content">

				<div class="owner-title-row">
					<h2><%=restaurant.getRestaurantName()%></h2>

					<span class="owner-status">
						🟢 <%=restaurant.isActive() ? "Active" : "Inactive"%>
					</span>
				</div>

				<div class="owner-stat-grid">

					<div class="owner-stat-box">
						<span>⭐ Rating</span>
						<strong><%=restaurant.getRating()%></strong>
					</div>

					<div class="owner-stat-box">
						<span>🍕 Cuisine</span>
						<strong><%=restaurant.getCuisineType()%></strong>
					</div>

					<div class="owner-stat-box">
						<span>⏱ Delivery Time</span>
						<strong><%=restaurant.getDeliveryTime()%> mins</strong>
					</div>

					<div class="owner-stat-box">
						<span>📞 Contact</span>
						<strong><%=restaurant.getContactNumber()%></strong>
					</div>

					<div class="owner-stat-box">
						<span>₹ Minimum Order</span>
						<strong>₹<%=restaurant.getMinimumOrderAmount()%></strong>
					</div>

					<div class="owner-stat-box">
						<span>🚚 Delivery Fee</span>
						<strong>₹<%=restaurant.getDeliveryFee()%></strong>
					</div>

				</div>

			</div>

		</div>

		<div class="owner-section-card">
			<h2>Description</h2>
			<p><%=restaurant.getDescription()%></p>
		</div>

		<div class="owner-section-card">
			<h2>Restaurant Details</h2>

			<div class="owner-detail-row">
				<span>📍 Address</span>
				<strong><%=restaurant.getAddress()%></strong>
			</div>

			<div class="owner-detail-row">
				<span>🍽 Signature Dish</span>
				<strong><%=restaurant.getSignatureDish()%></strong>
			</div>

			<div class="owner-detail-row">
				<span>🏷 Restaurant Tag</span>
				<strong><%=restaurant.getRestaurantTag()%></strong>
			</div>

			<div class="owner-detail-row">
				<span>🕙 Opening Time</span>
				<strong><%=restaurant.getOpeningTime()%></strong>
			</div>

			<div class="owner-detail-row">
				<span>🌙 Closing Time</span>
				<strong><%=restaurant.getClosingTime()%></strong>
			</div>
		</div>

		<div class="owner-edit-wrap">
			<a class="add-btn" href="#">
				✏ Edit Restaurant
			</a>
		</div>

		<%
		}
		%>

	</main>

</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/ownerRestaurant.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/ownerDashboard"> Dashboard</a>
		<a href="<%=request.getContextPath()%>/ownerMenu"> Menu</a>
		<a href="<%=request.getContextPath()%>/ownerRestaurant">Orders</a>
		<a class="active" href="<%=request.getContextPath()%>/ownerRestaurant">My Restaurant</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1><em>My</em> <span>Restaurant</span></h1>
				<p>Manage your restaurant profile and details</p>
			</div>
		</div>

		<% if (restaurant == null) { %>

			<div class="owner-section-card">
				<p>No restaurant assigned to you yet.</p>
			</div>

		<% } else { %>

		<div class="restaurant-modern-card">

			<div class="restaurant-modern-image">
				<img src="<%=request.getContextPath()%>/images/<%=restaurant.getRestaurantImg()%>"
					alt="<%=restaurant.getRestaurantName()%>">
			</div>

			<div class="restaurant-modern-content">

				<div class="restaurant-modern-header">
					<h2><%=restaurant.getRestaurantName()%></h2>
					<span class="restaurant-active-badge">
						● <%=restaurant.isActive() ? "Active" : "Inactive"%>
					</span>
				</div>

				<div class="restaurant-modern-grid">

					<div class="restaurant-info-box">
						<div class="info-icon yellow">⭐</div>
						<div><span>Rating</span><strong><%=restaurant.getRating()%></strong></div>
					</div>

					<div class="restaurant-info-box">
						<div class="info-icon orange">🍕</div>
						<div><span>Cuisine</span><strong><%=restaurant.getCuisineType()%></strong></div>
					</div>

					<div class="restaurant-info-box">
						<div class="info-icon blue">🕘</div>
						<div><span>Delivery Time</span><strong><%=restaurant.getDeliveryTime()%> mins</strong></div>
					</div>

					<div class="restaurant-info-box">
						<div class="info-icon purple">📞</div>
						<div><span>Contact</span><strong><%=restaurant.getContactNumber()%></strong></div>
					</div>

					<div class="restaurant-info-box">
						<div class="info-icon green">₹</div>
						<div><span>Minimum Order</span><strong>₹<%=restaurant.getMinimumOrderAmount()%></strong></div>
					</div>

					<div class="restaurant-info-box">
						<div class="info-icon red">🚚</div>
						<div><span>Delivery Fee</span><strong>₹<%=restaurant.getDeliveryFee()%></strong></div>
					</div>

				</div>
			</div>
		</div>

		<div class="owner-section-card">
			<h2>▧ Description</h2>
			<p><%=restaurant.getDescription()%></p>
		</div>

		<div class="owner-section-card">
			<h2>▤ Restaurant Details</h2>

			<div class="restaurant-details-grid">

				<div class="restaurant-detail-item">
					<div class="info-icon red">📍</div>
					<div><span>Address</span><strong><%=restaurant.getAddress()%></strong></div>
				</div>

				<div class="restaurant-detail-item">
					<div class="info-icon red">⏰</div>
					<div><span>Opening Time</span><strong><%=restaurant.getOpeningTime()%></strong></div>
				</div>

				<div class="restaurant-detail-item">
					<div class="info-icon blue">🍽</div>
					<div><span>Signature Dish</span><strong><%=restaurant.getSignatureDish()%></strong></div>
				</div>

				<div class="restaurant-detail-item">
					<div class="info-icon blue">🌙</div>
					<div><span>Closing Time</span><strong><%=restaurant.getClosingTime()%></strong></div>
				</div>

				<div class="restaurant-detail-item">
					<div class="info-icon orange">🏷</div>
					<div><span>Restaurant Tag</span><strong><%=restaurant.getRestaurantTag()%></strong></div>
				</div>

			</div>
		</div>

		<div class="restaurant-edit-center">
			<a class="restaurant-edit-btn"
			   href="<%=request.getContextPath()%>/editOwnerRestaurant?restaurantId=<%=restaurant.getRestaurantId()%>">
				Edit Restaurant
			</a>
		</div>

		<% } %>

	</main>
</div>

</body>
</html>
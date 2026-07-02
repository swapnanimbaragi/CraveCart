<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User"%>

<%
User admin = (User) session.getAttribute("admin");

if (admin == null) {
	response.sendRedirect(request.getContextPath() + "/JSP/adminLogin.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Restaurant | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/adminDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/adminRestaurants">Restaurants</a>
		<a href="<%=request.getContextPath()%>/adminRestaurantOwners">Restaurant Owners</a>
		<a href="<%=request.getContextPath()%>/adminOrders">Orders</a>
		<a href="<%=request.getContextPath()%>/adminUsers">Users</a>
		<a href="<%=request.getContextPath()%>/adminDeliveryPartners">Delivery Partners</a>
		<a href="<%=request.getContextPath()%>/adminLogout">
		    Logout
		</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Add <span>Restaurant</span></h1>
				<p>Add a new restaurant to CraveCart.</p>
			</div>

			<a class="add-btn" href="<%=request.getContextPath()%>/adminRestaurants">
				← Back
			</a>
		</div>

		<div class="form-container">

			<form action="<%=request.getContextPath()%>/addRestaurant" method="post">

				<label>Restaurant Name</label>
				<input type="text" name="restaurantName" required>

				<label>Image File Name</label>
				<input type="text" name="restaurantImg" placeholder="example: meghana.webp" required>

				<label>Cuisine Type</label>
				<input type="text" name="cuisineType" placeholder="Biryani / Pizza / North Indian" required>

				<label>Delivery Time</label>
				<input type="number" name="deliveryTime" placeholder="25" required>

				<label>Address</label>
				<input type="text" name="address" required>

				<label>Rating</label>
				<input type="number" step="0.1" name="rating" placeholder="4.5" required>

				<label>Status</label>
				<select name="isActive">
					<option value="true">Active</option>
					<option value="false">Inactive</option>
				</select>

				<label>Description</label>
				<textarea name="description" required></textarea>

				<label>Opening Time</label>
				<input type="time" name="openingTime" required>

				<label>Closing Time</label>
				<input type="time" name="closingTime" required>

				<label>Contact Number</label>
				<input type="text" name="contactNumber" required>

				<label>Minimum Order Amount</label>
				<input type="number" step="0.01" name="minimumOrderAmount" required>

				<label>Delivery Fee</label>
				<input type="number" step="0.01" name="deliveryFee" required>

				<label>Signature Dish</label>
				<input type="text" name="signatureDish" required>

				<label>Restaurant Tag</label>
				<input type="text" name="restaurantTag" placeholder="Best Seller / Open Late" required>

				<label>Admin User ID</label>
				<input type="number" name="adminUserId" value="1" required>

				<label>Latitude</label>
				<input type="number" step="0.000001" name="latitude" value="12.9716" required>

				<label>Longitude</label>
				<input type="number" step="0.000001" name="longitude" value="77.5946" required>

				<button type="submit" class="submit-btn">Add Restaurant</button>

			</form>

		</div>

	</main>

</div>

</body>
</html>
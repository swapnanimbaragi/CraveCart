<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.model.Restaurant"%>

<%
User admin = (User) session.getAttribute("admin");

if (admin == null) {
	response.sendRedirect(request.getContextPath() + "/JSP/adminLogin.jsp");
	return;
}

Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");

if (restaurant == null) {
	response.sendRedirect(request.getContextPath() + "/adminRestaurants");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Restaurant | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/adminDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/adminRestaurants">Restaurants</a>
		<a href="<%=request.getContextPath()%>/adminOrders">Orders</a>
		<a href="<%=request.getContextPath()%>/adminUsers">Users</a>
		<a href="#">Delivery Partners</a>
		<a href="<%=request.getContextPath()%>/adminLogout">
		    Logout
		</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Edit <span>Restaurant</span></h1>
				<p>Update restaurant details.</p>
			</div>

			<a class="add-btn" href="<%=request.getContextPath()%>/adminRestaurants">
				← Back
			</a>
		</div>

		<div class="form-container">

			<form action="<%=request.getContextPath()%>/updateRestaurant" method="post">

				<input type="hidden" name="restaurantId"
					value="<%=restaurant.getRestaurantId()%>">

				<label>Restaurant Name</label>
				<input type="text" name="restaurantName"
					value="<%=restaurant.getRestaurantName()%>" required>

				<label>Image File Name</label>
				<input type="text" name="restaurantImg"
					value="<%=restaurant.getRestaurantImg()%>" required>

				<label>Cuisine Type</label>
				<input type="text" name="cuisineType"
					value="<%=restaurant.getCuisineType()%>" required>

				<label>Delivery Time</label>
				<input type="number" name="deliveryTime"
					value="<%=restaurant.getDeliveryTime()%>" required>

				<label>Address</label>
				<input type="text" name="address"
					value="<%=restaurant.getAddress()%>" required>

				<label>Rating</label>
				<input type="number" step="0.1" name="rating"
					value="<%=restaurant.getRating()%>" required>

				<label>Status</label>
				<select name="isActive">
					<option value="true" <%=restaurant.isActive() ? "selected" : ""%>>
						Active
					</option>

					<option value="false" <%=!restaurant.isActive() ? "selected" : ""%>>
						Inactive
					</option>
				</select>

				<label>Description</label>
				<textarea name="description" required><%=restaurant.getDescription()%></textarea>

				<label>Opening Time</label>
				<input type="time" name="openingTime"
					value="<%=restaurant.getOpeningTime()%>" required>

				<label>Closing Time</label>
				<input type="time" name="closingTime"
					value="<%=restaurant.getClosingTime()%>" required>

				<label>Contact Number</label>
				<input type="text" name="contactNumber"
					value="<%=restaurant.getContactNumber()%>" required>

				<label>Minimum Order Amount</label>
				<input type="number" step="0.01" name="minimumOrderAmount"
					value="<%=restaurant.getMinimumOrderAmount()%>" required>

				<label>Delivery Fee</label>
				<input type="number" step="0.01" name="deliveryFee"
					value="<%=restaurant.getDeliveryFee()%>" required>

				<label>Signature Dish</label>
				<input type="text" name="signatureDish"
					value="<%=restaurant.getSignatureDish()%>" required>

				<label>Restaurant Tag</label>
				<input type="text" name="restaurantTag"
					value="<%=restaurant.getRestaurantTag()%>" required>

				<label>Admin User ID</label>
				<input type="number" name="adminUserId"
					value="<%=restaurant.getAdminUserId()%>" required>

				<label>Latitude</label>
				<input type="number" step="0.000001" name="latitude"
					value="<%=restaurant.getLatitude()%>" required>

				<label>Longitude</label>
				<input type="number" step="0.000001" name="longitude"
					value="<%=restaurant.getLongitude()%>" required>

				<button type="submit" class="submit-btn">
					Update Restaurant
				</button>

			</form>

		</div>

	</main>

</div>

</body>
</html>
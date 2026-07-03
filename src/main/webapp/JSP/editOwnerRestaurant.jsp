<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.model.Restaurant"%>

<%
User owner = (User) session.getAttribute("loggedInUser");

if(owner == null || !"RESTAURANT_OWNER".equals(owner.getRole())){
	response.sendRedirect(request.getContextPath()+"/JSP/login.jsp");
	return;
}

Restaurant restaurant=(Restaurant)request.getAttribute("restaurant");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Edit Restaurant | CraveCart</title>

<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/admin.css">

<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/editOwnerRestaurant.css">

</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">

		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/ownerDashboard">Dashboard</a>

		<a href="<%=request.getContextPath()%>/ownerMenu">Menu</a>

		<a href="<%=request.getContextPath()%>/ownerOrders">Orders</a>

		<a class="active"
		href="<%=request.getContextPath()%>/ownerRestaurant">
		My Restaurant
		</a>

		<a href="<%=request.getContextPath()%>/adminLogout">
		Logout
		</a>

	</aside>


	<main class="main-content">

		<div class="page-header">

			<h1>Edit <span>Restaurant</span></h1>

			

		</div>


<form action="<%=request.getContextPath()%>/updateOwnerRestaurant"
      method="post"
      class="restaurant-form">

<input type="hidden" name="restaurantId" value="<%=restaurant.getRestaurantId()%>">


<div class="form-grid">

<div class="form-group">

<label>Restaurant Name</label>

<input type="text"
name="restaurantName"
value="<%=restaurant.getRestaurantName()%>"
required>

</div>


<div class="form-group">

<label>Cuisine</label>

<input type="text"
name="cuisineType"
value="<%=restaurant.getCuisineType()%>">

</div>



<div class="form-group">

<label>Restaurant Image</label>

<input type="text"
name="restaurantImg"
value="<%=restaurant.getRestaurantImg()%>">

</div>



<div class="form-group">

<label>Delivery Time</label>

<input type="number"
name="deliveryTime"
value="<%=restaurant.getDeliveryTime()%>">

</div>



<div class="form-group">

<label>Contact Number</label>

<input type="text"
name="contactNumber"
value="<%=restaurant.getContactNumber()%>">

</div>



<div class="form-group">

<label>Rating</label>

<input type="text"
name="rating"
value="<%=restaurant.getRating()%>">

</div>



<div class="form-group">

<label>Minimum Order</label>

<input type="number"
step="0.01"
name="minimumOrderAmount"
value="<%=restaurant.getMinimumOrderAmount()%>">

</div>



<div class="form-group">

<label>Delivery Fee</label>

<input type="number"
step="0.01"
name="deliveryFee"
value="<%=restaurant.getDeliveryFee()%>">

</div>



<div class="form-group">

<label>Opening Time</label>

<input type="time"
name="openingTime"
value="<%=restaurant.getOpeningTime()%>">

</div>



<div class="form-group">

<label>Closing Time</label>

<input type="time"
name="closingTime"
value="<%=restaurant.getClosingTime()%>">

</div>



<div class="form-group full-width">

<label>Address</label>

<input type="text"
name="address"
value="<%=restaurant.getAddress()%>">

</div>



<div class="form-group full-width">

<label>Description</label>

<textarea
name="description"
rows="4"><%=restaurant.getDescription()%></textarea>

</div>



<div class="form-group">

<label>Signature Dish</label>

<input type="text"
name="signatureDish"
value="<%=restaurant.getSignatureDish()%>">

</div>



<div class="form-group">

<label>Restaurant Tag</label>

<input type="text"
name="restaurantTag"
value="<%=restaurant.getRestaurantTag()%>">

</div>

</div>


<div class="button-group">

<button type="submit" class="restaurant-save-btn">Save Changes</button>

<a href="<%=request.getContextPath()%>/ownerRestaurant" class="restaurant-cancel-btn">Cancel</a>

</div>

</form>

</main>

</div>

</body>
</html>
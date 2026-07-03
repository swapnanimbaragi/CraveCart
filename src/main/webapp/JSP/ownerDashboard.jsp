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
String message = (String) request.getAttribute("message");

Integer totalMenuItems = (Integer) request.getAttribute("totalMenuItems");
Integer totalOrders = (Integer) request.getAttribute("totalOrders");
Integer pendingOrders = (Integer) request.getAttribute("pendingOrders");
Integer completedOrders = (Integer) request.getAttribute("completedOrders");

if (totalMenuItems == null) totalMenuItems = 0;
if (totalOrders == null) totalOrders = 0;
if (pendingOrders == null) pendingOrders = 0;
if (completedOrders == null) completedOrders = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Owner Dashboard | CraveCart</title>

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

		<h1>Owner <span>Dashboard</span></h1>

		<p>
			Welcome <b><%=owner.getUserName()%></b>,
			manage your restaurant here.
		</p>

		<%
		if (message != null) {
		%>
			<div class="table-container">
				<p><%=message%></p>
			</div>
		<%
		} else {
		%>

		<div class="table-container">
			<h2><%=restaurant.getRestaurantName()%></h2>
			<p>
				<%=restaurant.getCuisineType()%> |
				⭐ <%=restaurant.getRating()%> |
				<%=restaurant.getDeliveryTime()%> mins
			</p>
		</div>

		<div class="cards">

			<div class="card">
				<h3>Total Menu Items</h3>
				<p><%=totalMenuItems%></p>
			</div>

			<div class="card">
				<h3>Total Orders</h3>
				<p><%=totalOrders%></p>
			</div>

			<div class="card">
				<h3>Pending Orders</h3>
				<p><%=pendingOrders%></p>
			</div>

			<div class="card">
				<h3>Completed Orders</h3>
				<p><%=completedOrders%></p>
			</div>

		</div>

		<%
		}
		%>

	</main>

</div>

<script src="<%=request.getContextPath()%>/js/admin.js"></script>

</body>
</html>
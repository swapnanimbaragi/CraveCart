<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.DashboardStats"%>
<%@ page import="com.tap.model.TopRestaurant"%>
<%@ page import="com.tap.model.User"%>

<%
User admin = (User) session.getAttribute("admin");

if (admin == null) {
	response.sendRedirect(request.getContextPath() + "/JSP/adminLogin.jsp");
	return;
}

DashboardStats stats = (DashboardStats) request.getAttribute("stats");
List<TopRestaurant> topRestaurants = (List<TopRestaurant>) request.getAttribute("topRestaurants");

if (stats == null) {
	response.sendRedirect(request.getContextPath() + "/adminDashboard");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | CraveCart</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<!-- Sidebar -->
	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="${pageContext.request.contextPath}/adminDashboard">Dashboard</a>
		<a href="${pageContext.request.contextPath}/adminRestaurants">Restaurants</a>
		<a href="#">Orders</a>
		<a href="${pageContext.request.contextPath}/adminUsers">Users</a>
		<a href="#">Delivery Partners</a>
		<a href="${pageContext.request.contextPath}/adminLogout">Logout</a>
	</aside>

	<!-- Main Content -->
	<main class="main-content">

		<h1>Admin <span>Dashboard</span></h1>
		<p>Welcome <b><%=admin.getUserName()%></b>, manage CraveCart from one place.</p>

		<!-- Dashboard Cards -->
		<div class="cards">

			<div class="card">
				<h3>Total Customers</h3>
				<p><%=stats.getTotalCustomers()%></p>
			</div>

			<div class="card">
				<h3>Total Restaurants</h3>
				<p><%=stats.getTotalRestaurants()%></p>
			</div>

			<div class="card">
				<h3>Total Orders</h3>
				<p><%=stats.getTotalOrders()%></p>
			</div>

			<div class="card">
				<h3>Delivery Partners</h3>
				<p><%=stats.getTotalDeliveryPartners()%></p>
			</div>

		</div>

		<!-- Top Restaurants Leaderboard -->
		<div class="table-container">
			<h2>🏆 Top Restaurants Leaderboard</h2>
			<p class="section-subtitle">Restaurants with highest number of orders</p>

			<table>
				<thead>
					<tr>
						<th>Rank</th>
						<th>Restaurant Name</th>
						<th>Total Orders</th>
					</tr>
				</thead>

				<tbody>
					<%
					if (topRestaurants != null && !topRestaurants.isEmpty()) {
						for (TopRestaurant restaurant : topRestaurants) {
					%>
							<tr>
								<td>#<%=restaurant.getRank()%></td>
								<td><%=restaurant.getRestaurantName()%></td>
								<td><%=restaurant.getTotalOrders()%></td>
							</tr>
					<%
						}
					} else {
					%>
						<tr>
							<td colspan="3">No orders available yet</td>
						</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

	</main>

</div>

<script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.User"%>

<%
User admin = (User) session.getAttribute("admin");

if (admin == null) {
	response.sendRedirect(request.getContextPath() + "/JSP/adminLogin.jsp");
	return;
}

List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Management | CraveCart</title>

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
		<a href="#">Users</a>
		<a href="#">Delivery Partners</a>
		<a href="${pageContext.request.contextPath}/JSP/adminLogin.jsp">Logout</a>
	</aside>

	<!-- Main Content -->
	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Restaurant <span>Management</span></h1>
				<p>View all restaurants and manage them.</p>
			</div>

			<a class="add-btn" href="${pageContext.request.contextPath}/JSP/addRestaurant.jsp">
				+ Add Restaurant
			</a>
		</div>

		<div class="table-container">

			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Image</th>
						<th>Restaurant Name</th>
						<th>Cuisine</th>
						<th>Rating</th>
						<th>Delivery Time</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (restaurants != null && !restaurants.isEmpty()) {
					for (Restaurant restaurant : restaurants) {
				%>

					<tr>
						<td><%=restaurant.getRestaurantId()%></td>

						<td>
							<img class="table-img"
								src="<%=restaurant.getRestaurantImg()%>"
								alt="Restaurant Image">
						</td>

						<td><%=restaurant.getRestaurantName()%></td>

						<td><%=restaurant.getCuisineType()%></td>

						<td>⭐ <%=restaurant.getRating()%></td>

						<td><%=restaurant.getDeliveryTime()%> mins</td>

						<td>
							<%
							if (restaurant.isActive()) {
							%>
								<span class="status active">Active</span>
							<%
							} else {
							%>
								<span class="status inactive">Inactive</span>
							<%
							}
							%>
						</td>

						<td>
							<a class="btn btn-green" href="#">
								Edit
							</a>

							<a class="btn btn-red" href="#"
								onclick="return confirm('Are you sure you want to delete this restaurant?')">
								Delete
							</a>
						</td>
					</tr>

				<%
					}
				} else {
				%>

					<tr>
						<td colspan="8">No Restaurants Available</td>
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
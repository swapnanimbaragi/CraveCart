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

	List<Restaurant> restaurants =
	(List<Restaurant>) request.getAttribute("restaurants");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Restaurant Management | CraveCart</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/admin.css">

</head>

<body>

<div class="admin-layout">

	<!-- ================= Sidebar ================= -->

	<aside class="sidebar">

		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/adminDashboard">
			Dashboard
		</a>

		<a href="<%=request.getContextPath()%>/adminRestaurants">
			Restaurants
		</a>
		<a href="<%=request.getContextPath()%>/adminRestaurantOwners">Restaurant Owners</a>

		<a href="<%=request.getContextPath()%>/adminOrders">Orders</a>

		<a href="<%=request.getContextPath()%>/adminUsers">Users</a>

		<a href="<%=request.getContextPath()%>/adminDeliveryPartners">Delivery Partners</a>

		<a href="<%=request.getContextPath()%>/adminLogout">
		    Logout
		</a>
	</aside>

	<!-- ================= Main Content ================= -->

	<main class="main-content">

		<div class="page-header">

			<div>

				<h1>Restaurant <span>Management</span></h1>

				<p>
					View all restaurants and manage them.
				</p>

			</div>

			<a class="add-btn"
				href="<%=request.getContextPath()%>/JSP/addRestaurant.jsp">

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

						<td>
							<%=restaurant.getRestaurantId()%>
						</td>

						<td>

							<img class="table-img"
								src="<%=request.getContextPath() + "/images/" + restaurant.getRestaurantImg()%>"
								alt="<%=restaurant.getRestaurantName()%>">

						</td>

						<td>

							<%=restaurant.getRestaurantName()%>

						</td>

						<td>

							<%=restaurant.getCuisineType()%>

						</td>

						<td>

							⭐ <%=restaurant.getRating()%>

						</td>

						<td>

							<%=restaurant.getDeliveryTime()%> mins

						</td>

						<td>

							<%
							if (restaurant.isActive()) {
							%>

								<span class="status active">

									Active

								</span>

							<%
							}
							else {
							%>

								<span class="status inactive">

									Inactive

								</span>

							<%
							}
							%>

						</td>

						<td>

							<a class="btn btn-green"
								href="<%=request.getContextPath()%>/editRestaurant?restaurantId=<%=restaurant.getRestaurantId()%>">
								Edit
							</a>

							<a class="btn <%=restaurant.isActive() ? "btn-red" : "btn-green"%>"
							   href="<%=request.getContextPath()%>/toggleRestaurantStatus?restaurantId=<%=restaurant.getRestaurantId()%>"
							   onclick="return confirm('Are you sure you want to change restaurant status?')">
							
								<%=restaurant.isActive() ? "Make Inactive" : "Make Active"%>
							
							</a>

						</td>

					</tr>

				<%
					}

				}
				else {
				%>

					<tr>

						<td colspan="8">

							No Restaurants Available

						</td>

					</tr>

				<%
				}
				%>

				</tbody>

			</table>

		</div>

	</main>

</div>

<script src="<%=request.getContextPath()%>/js/admin.js"></script>

</body>
</html>
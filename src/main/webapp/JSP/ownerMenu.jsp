<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.Menu"%>

<%
User owner = (User) session.getAttribute("loggedInUser");

if (owner == null || !"RESTAURANT_OWNER".equals(owner.getRole())) {
	response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
	return;
}

Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Owner Menu | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/ownerDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/ownerMenu">Menu</a>
		<a href="#">Orders</a>
		<a href="#">My Restaurant</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Menu <span>Management</span></h1>

				<%
				if (restaurant != null) {
				%>
					<p>Manage menu items for <b><%=restaurant.getRestaurantName()%></b></p>
				<%
				}
				%>
			</div>

			<%
			if (restaurant != null) {
			%>
				<a class="add-btn" href="<%=request.getContextPath()%>/JSP/addOwnerMenu.jsp">
					+ Add Menu Item
				</a>
			<%
			}
			%>
		</div>

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

			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Image</th>
						<th>Item Name</th>
						<th>Category</th>
						<th>Price</th>
						<th>Veg</th>
						<th>Available</th>
						<th>Rating</th>
						<th>Actions</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (menuList != null && !menuList.isEmpty()) {
					for (Menu menu : menuList) {
				%>

					<tr>
						<td><%=menu.getMenuId()%></td>

						<td>
							<img class="table-img"
								src="<%=request.getContextPath() + "/images/" + menu.getImageUrl()%>"
								alt="<%=menu.getItemName()%>">
						</td>

						<td><%=menu.getItemName()%></td>
						<td><%=menu.getCategory()%></td>
						<td>₹<%=menu.getPrice()%></td>

						<td>
							<%=menu.isVeg() ? "Veg" : "Non-Veg"%>
						</td>

						<td>
							<%
							if (menu.isAvailable()) {
							%>
								<span class="status active">Available</span>
							<%
							} else {
							%>
								<span class="status inactive">Not Available</span>
							<%
							}
							%>
						</td>

						<td>⭐ <%=menu.getRating()%></td>

						<td>
							<a class="btn btn-green" href="#">
								Edit
							</a>

							<a class="btn btn-red" href="#">
								Delete
							</a>
						</td>
					</tr>

				<%
					}
				} else {
				%>

					<tr>
						<td colspan="9">No menu items available</td>
					</tr>

				<%
				}
				%>

				</tbody>
			</table>

		</div>

		<%
		}
		%>

	</main>

</div>

<script src="<%=request.getContextPath()%>/js/admin.js"></script>

</body>
</html>
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
<title>Add Restaurant Owner | CraveCart</title>
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
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Add <span>Restaurant Owner</span></h1>
				<p>Create a new restaurant owner account.</p>
			</div>

			<a class="add-btn" href="<%=request.getContextPath()%>/adminRestaurantOwners">
				← Back
			</a>
		</div>

		<div class="form-container">

			<form action="<%=request.getContextPath()%>/addRestaurantOwner" method="post">

				<label>Owner Name</label>
				<input type="text" name="userName" required>

				<label>Email</label>
				<input type="email" name="email" required>

				<label>Password</label>
				<input type="password" name="password" required>

				<label>Address</label>
				<input type="text" name="address" required>

				<button type="submit" class="submit-btn">
					Add Restaurant Owner
				</button>

			</form>

		</div>

	</main>

</div>

</body>
</html>
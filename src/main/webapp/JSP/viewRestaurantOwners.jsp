<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.User"%>

<%
User admin = (User) session.getAttribute("admin");

if (admin == null) {
	response.sendRedirect(request.getContextPath() + "/JSP/adminLogin.jsp");
	return;
}

List<User> owners = (List<User>) request.getAttribute("owners");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Owners | CraveCart</title>

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
				<h1>Restaurant Owner <span>Management</span></h1>
				<p>View all registered restaurant owners.</p>
			</div>
		</div>

		<div class="table-container">

			<table>
				<thead>
					<tr>
						<th>Owner ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Address</th>
						<th>Role</th>
						<th>Created Date</th>
						<th>Last Login</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (owners != null && !owners.isEmpty()) {
					for (User owner : owners) {
				%>

					<tr>
						<td><%=owner.getUserId()%></td>
						<td><%=owner.getUserName()%></td>
						<td><%=owner.getEmail()%></td>
						<td><%=owner.getAddress()%></td>

						<td>
							<span class="status active">
								<%=owner.getRole()%>
							</span>
						</td>

						<td><%=owner.getCreatedDate()%></td>
						<td><%=owner.getLastLoginDate()%></td>
					</tr>

				<%
					}
				} else {
				%>

					<tr>
						<td colspan="7">No restaurant owners available</td>
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
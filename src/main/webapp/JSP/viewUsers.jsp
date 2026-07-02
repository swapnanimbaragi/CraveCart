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

List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Management | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<!-- Sidebar -->
	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/adminDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/adminRestaurants">Restaurants</a>
		<a href="#">Orders</a>
		<a href="<%=request.getContextPath()%>/adminUsers">Users</a>
		<a href="#">Delivery Partners</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<!-- Main Content -->
	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Customer <span>Management</span></h1>
				<p>View all registered customers and users.</p>
			</div>
		</div>

		<div class="table-container">

			<table>
				<thead>
					<tr>
						<th>User ID</th>
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
				if (users != null && !users.isEmpty()) {
					for (User user : users) {
				%>

					<tr>
						<td><%=user.getUserId()%></td>
						<td><%=user.getUserName()%></td>
						<td><%=user.getEmail()%></td>
						<td><%=user.getAddress()%></td>

						<td>
							<span class="status active">
								<%=user.getRole()%>
							</span>
						</td>

						<td><%=user.getCreatedDate()%></td>
						<td><%=user.getLastLoginDate()%></td>
					</tr>

				<%
					}
				} else {
				%>

					<tr>
						<td colspan="7">No users available</td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.model.DeliveryPartner"%>

<%
User admin = (User) session.getAttribute("admin");

if (admin == null) {
	response.sendRedirect(request.getContextPath() + "/JSP/adminLogin.jsp");
	return;
}

List<DeliveryPartner> partners = (List<DeliveryPartner>) request.getAttribute("partners");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delivery Partners | CraveCart</title>

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
				<h1>Delivery Partner <span>Management</span></h1>
				<p>View delivery partners and their current status.</p>
			</div>
		</div>

		<div class="table-container">

			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Partner Name</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Vehicle</th>
						<th>Status</th>
						<th>Total Deliveries</th>
						<th>Rating</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (partners != null && !partners.isEmpty()) {
					for (DeliveryPartner partner : partners) {
				%>

					<tr>
						<td><%=partner.getDeliveryPartnerId()%></td>
						<td><%=partner.getPartnerName()%></td>
						<td><%=partner.getEmail()%></td>
						<td><%=partner.getPhoneNumber()%></td>
						<td><%=partner.getVehicleNumber()%></td>

						<td>
							<span class="status active">
								<%=partner.getStatus()%>
							</span>
						</td>

						<td><%=partner.getTotalDeliveries()%></td>
						<td>⭐ <%=partner.getRating()%></td>
					</tr>

				<%
					}
				} else {
				%>

					<tr>
						<td colspan="8">No delivery partners available</td>
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
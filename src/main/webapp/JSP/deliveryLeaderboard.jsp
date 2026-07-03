<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.model.DeliveryPartner"%>

<%
User deliveryPartner = (User) session.getAttribute("loggedInUser");

if (deliveryPartner == null || !"DELIVERY_PARTNER".equals(deliveryPartner.getRole())) {
	response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
	return;
}

List<DeliveryPartner> partners = (List<DeliveryPartner>) request.getAttribute("partners");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delivery Leaderboard | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/deliveryDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/deliveryOrders">Available Orders</a>
		<a href="<%=request.getContextPath()%>/myDeliveries">My Deliveries</a>
		<a href="<%=request.getContextPath()%>/deliveryLeaderboard">Leaderboard</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Delivery <span>Leaderboard</span></h1>
				<p>Top delivery partners based on completed deliveries and rating.</p>
			</div>
		</div>

		<div class="table-container">

			<table>
				<thead>
					<tr>
						<th>Rank</th>
						<th>Partner Name</th>
						<th>Email</th>
						<th>Vehicle</th>
						<th>Total Deliveries</th>
						<th>Rating</th>
						<th>Status</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (partners != null && !partners.isEmpty()) {

					int rank = 1;

					for (DeliveryPartner partner : partners) {
				%>

					<tr>
						<td>#<%=rank++%></td>
						<td><%=partner.getPartnerName()%></td>
						<td><%=partner.getEmail()%></td>
						<td><%=partner.getVehicleNumber()%></td>
						<td><%=partner.getTotalDeliveries()%></td>
						<td>⭐ <%=partner.getRating()%></td>

						<td>
							<span class="status active">
								<%=partner.getStatus()%>
							</span>
						</td>
					</tr>

				<%
					}
				} else {
				%>

					<tr>
						<td colspan="7">No delivery partners available</td>
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
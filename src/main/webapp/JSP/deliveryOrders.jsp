<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Order"%>
<%@ page import="com.tap.model.User"%>

<%
User deliveryPartner = (User) session.getAttribute("loggedInUser");

if (deliveryPartner == null || !"DELIVERY_PARTNER".equals(deliveryPartner.getRole())) {
	response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
	return;
}

List<Order> availableOrders =
	(List<Order>) request.getAttribute("availableOrders");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Orders | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/deliveryDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/deliveryOrders">Available Orders</a>
		<a href="#">My Deliveries</a>
		<a href="#">Leaderboard</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Available <span>Orders</span></h1>
				<p>Orders ready for pickup from restaurants.</p>
			</div>
		</div>

		<div class="table-container">

			<table>
				<thead>
					<tr>
						<th>Order ID</th>
						<th>Restaurant ID</th>
						<th>Amount</th>
						<th>Payment</th>
						<th>Address</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (availableOrders != null && !availableOrders.isEmpty()) {
					for (Order order : availableOrders) {
				%>

					<tr>
						<td>#<%=order.getOrderId()%></td>
						<td><%=order.getRestaurantId()%></td>
						<td>₹<%=order.getTotalAmount()%></td>
						<td><%=order.getPaymentMode()%></td>
						<td><%=order.getDeliveryAddress()%></td>

						<td>
							<span class="status active">
								<%=order.getOrderStatus()%>
							</span>
						</td>

						<td>
							<form action="<%=request.getContextPath()%>/acceptDelivery"
								method="post">

								<input type="hidden" name="orderId"
									value="<%=order.getOrderId()%>">

								<button type="submit" class="small-btn">
									Accept Delivery
								</button>

							</form>
						</td>
					</tr>

				<%
					}
				} else {
				%>

					<tr>
						<td colspan="7">No available orders right now</td>
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
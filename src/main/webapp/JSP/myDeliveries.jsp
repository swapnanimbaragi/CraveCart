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

List<Order> myDeliveries = (List<Order>) request.getAttribute("myDeliveries");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Deliveries | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/deliveryDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/deliveryOrders">Available Orders</a>
		<a href="<%=request.getContextPath()%>/myDeliveries">My Deliveries</a>
		<a href="#">Leaderboard</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>My <span>Deliveries</span></h1>
				<p>Orders accepted by you for delivery.</p>
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
						<th>Update</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (myDeliveries != null && !myDeliveries.isEmpty()) {
					for (Order order : myDeliveries) {
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
							<form action="<%=request.getContextPath()%>/updateDeliveryStatus" method="post">

								<input type="hidden" name="orderId"
									value="<%=order.getOrderId()%>">

								<select name="orderStatus" class="status-select">
									<option value="PICKED_UP" <%=order.getOrderStatus().equals("PICKED_UP") ? "selected" : ""%>>
										PICKED UP
									</option>

									<option value="OUT_FOR_DELIVERY" <%=order.getOrderStatus().equals("OUT_FOR_DELIVERY") ? "selected" : ""%>>
										OUT FOR DELIVERY
									</option>

									<option value="DELIVERED" <%=order.getOrderStatus().equals("DELIVERED") ? "selected" : ""%>>
										DELIVERED
									</option>
								</select>

								<button type="submit" class="small-btn">
									Save
								</button>

							</form>
						</td>
					</tr>

				<%
					}
				} else {
				%>

					<tr>
						<td colspan="7">No active deliveries</td>
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
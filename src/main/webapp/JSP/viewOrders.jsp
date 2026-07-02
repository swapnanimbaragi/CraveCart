<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Order"%>
<%@ page import="com.tap.model.User"%>

<%
User admin = (User) session.getAttribute("admin");

if (admin == null) {
	response.sendRedirect(request.getContextPath() + "/JSP/adminLogin.jsp");
	return;
}

List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Management | CraveCart</title>

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
				<h1>Order <span>Management</span></h1>
				<p>View and update all customer orders.</p>
			</div>
		</div>

		<div class="table-container">

			<table>
				<thead>
					<tr>
						<th>Order ID</th>
						<th>User ID</th>
						<th>Restaurant ID</th>
						<th>Amount</th>
						<th>Payment</th>
						<th>Status</th>
						<th>Address</th>
						<th>Order Date</th>
						<th>Update</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (orders != null && !orders.isEmpty()) {
					for (Order order : orders) {
				%>

					<tr>
						<td><%=order.getOrderId()%></td>
						<td><%=order.getUserId()%></td>
						<td><%=order.getRestaurantId()%></td>
						<td>₹<%=order.getTotalAmount()%></td>
						<td><%=order.getPaymentMode()%></td>

						<td>
							<span class="status active">
								<%=order.getOrderStatus()%>
							</span>
						</td>

						<td><%=order.getDeliveryAddress()%></td>
						<td><%=order.getOrderDate()%></td>

						<td>
							<form action="<%=request.getContextPath()%>/updateOrderStatus" method="post">

								<input type="hidden" name="orderId"
									value="<%=order.getOrderId()%>">

								<select name="orderStatus" class="status-select">
									<option value="PLACED" <%=order.getOrderStatus().equals("PLACED") ? "selected" : ""%>>PLACED</option>
									<option value="PREPARING" <%=order.getOrderStatus().equals("PREPARING") ? "selected" : ""%>>PREPARING</option>
									<option value="OUT_FOR_DELIVERY" <%=order.getOrderStatus().equals("OUT_FOR_DELIVERY") ? "selected" : ""%>>OUT FOR DELIVERY</option>
									<option value="DELIVERED" <%=order.getOrderStatus().equals("DELIVERED") ? "selected" : ""%>>DELIVERED</option>
									<option value="CANCELLED" <%=order.getOrderStatus().equals("CANCELLED") ? "selected" : ""%>>CANCELLED</option>
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
						<td colspan="9">No orders available</td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.Order"%>
<%@ page import="com.tap.model.OrderItem"%>

<%
User owner = (User) session.getAttribute("loggedInUser");

if (owner == null || !"RESTAURANT_OWNER".equals(owner.getRole())) {
	response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
	return;
}

Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
List<Order> orders = (List<Order>) request.getAttribute("orders");

Map<Integer, List<OrderItem>> orderItemsMap =
	(Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");

Map<Integer, String> menuNameMap =
	(Map<Integer, String>) request.getAttribute("menuNameMap");

String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Owner Orders | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/ownerDashboard">Dashboard</a>
		<a href="<%=request.getContextPath()%>/ownerMenu">Menu</a>
		<a href="<%=request.getContextPath()%>/ownerOrders">Orders</a>
		<a href="<%=request.getContextPath()%>/ownerRestaurant">My Restaurant</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Restaurant <span>Orders</span></h1>

				<% if (restaurant != null) { %>
					<p>Orders for <b><%=restaurant.getRestaurantName()%></b></p>
				<% } %>
			</div>
		</div>

		<% if (message != null) { %>

			<div class="table-container">
				<p><%=message%></p>
			</div>

		<% } else { %>

		<div class="table-container">

			<table>
				<thead>
					<tr>
						<th>Order ID</th>
						<th>Items</th>
						<th>Total</th>
						<th>Payment</th>
						<th>Status</th>
						<th>Address</th>
						<th>Date</th>
						<th>Update</th>
					</tr>
				</thead>

				<tbody>

				<%
				if (orders != null && !orders.isEmpty()) {
					for (Order order : orders) {
				%>

					<tr>
						<td>#<%=order.getOrderId()%></td>

						<td>
							<%
							List<OrderItem> items = orderItemsMap.get(order.getOrderId());

							if (items != null && !items.isEmpty()) {
								for (OrderItem item : items) {
									String itemName = menuNameMap.get(item.getMenuId());

									if (itemName == null) {
										itemName = "Menu ID: " + item.getMenuId();
									}
							%>
									<div>
										<%=itemName%> × <%=item.getQuantity()%>
									</div>
							<%
								}
							} else {
							%>
								No items
							<%
							}
							%>
						</td>

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
							<form action="<%=request.getContextPath()%>/updateOwnerOrderStatus"
								method="post">

								<input type="hidden" name="orderId"
									value="<%=order.getOrderId()%>">

								<select name="orderStatus" class="status-select">
									<option value="PLACED" <%=order.getOrderStatus().equals("PLACED") ? "selected" : ""%>>PLACED</option>
									<option value="ACCEPTED" <%=order.getOrderStatus().equals("ACCEPTED") ? "selected" : ""%>>ACCEPTED</option>
									<option value="PREPARING" <%=order.getOrderStatus().equals("PREPARING") ? "selected" : ""%>>PREPARING</option>
									<option value="READY_FOR_PICKUP" <%=order.getOrderStatus().equals("READY_FOR_PICKUP") ? "selected" : ""%>>READY FOR PICKUP</option>
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
						<td colspan="8">No orders available for this restaurant</td>
					</tr>

				<%
				}
				%>

				</tbody>
			</table>

		</div>

		<% } %>

	</main>

</div>

<script src="<%=request.getContextPath()%>/js/admin.js"></script>

</body>
</html> 
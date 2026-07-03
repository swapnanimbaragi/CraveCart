<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User"%>

<%
User deliveryPartner = (User) session.getAttribute("loggedInUser");

if (deliveryPartner == null || !"DELIVERY_PARTNER".equals(deliveryPartner.getRole())) {
	response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
	return;
}

Integer availableCount = (Integer) request.getAttribute("availableCount");
Integer pickedCount = (Integer) request.getAttribute("pickedCount");
Integer completedCount = (Integer) request.getAttribute("completedCount");

if (availableCount == null) availableCount = 0;
if (pickedCount == null) pickedCount = 0;
if (completedCount == null) completedCount = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delivery Dashboard | CraveCart</title>

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

		<h1>Delivery <span>Dashboard</span></h1>

		<p>
			Welcome <b><%=deliveryPartner.getUserName()%></b>,
			manage your deliveries here.
		</p>

		<div class="cards">

			<div class="card">
				<h3>Available Orders</h3>
				<p><%=availableCount%></p>
			</div>

			<div class="card">
				<h3>Active Deliveries</h3>
				<p><%=pickedCount%></p>
			</div>

			<div class="card">
				<h3>Completed Deliveries</h3>
				<p><%=completedCount%></p>
			</div>

			<div class="card">
				<h3>Status</h3>
				<p>Ready</p>
			</div>

		</div>

	</main>

</div>

<script src="<%=request.getContextPath()%>/js/admin.js"></script>

</body>
</html>
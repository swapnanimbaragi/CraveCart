<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Order"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Success | CraveCart</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/orderSuccess.css">

</head>

<body>

<%
Order order = (Order) request.getAttribute("order");
%>

<header class="navbar">

	<div class="logo">CraveCart</div>

	<nav>
		<a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/orders">My Orders</a>
	</nav>

</header>

<section class="success-page">

	<div class="success-card">

		<div class="success-icon">
			✅
		</div>

		<h1>
			Order <span>Placed!</span>
		</h1>

		<p class="success-text">
			Your order has been placed successfully.
			The restaurant has started preparing your food.
		</p>

		<div class="success-info">

			<div class="info-box">

				<span>Order ID</span>

				<strong>
					#<%=order.getOrderId()%>
				</strong>

			</div>

			<div class="info-box">

				<span>Total Paid</span>

				<strong>
					₹<%=order.getTotalAmount()%>
				</strong>

			</div>

			<div class="info-box">

				<span>Estimated Delivery</span>

				<strong>
					<%=order.getEstimatedDeliveryTime()%> mins
				</strong>

			</div>

		</div>

		<div class="success-buttons">

			<a class="track-btn"
				href="${pageContext.request.contextPath}/trackOrder?orderId=<%=order.getOrderId()%>">

				Track Order →

			</a>

			<a class="home-btn"
				href="${pageContext.request.contextPath}/home">

				Order More Food

			</a>

		</div>

	</div>

</section>

</body>
</html>
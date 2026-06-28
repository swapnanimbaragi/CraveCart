<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.DAOimpl.MenuDAOImpl"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout | CraveCart</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
</head>

<body>

<header class="navbar">
	<div class="logo">CraveCart</div>
	<nav>
		<a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/cart">Cart</a>
	</nav>
</header>

<section class="cart-page">

	<div class="cart-header">
		<div class="cart-badge">✅ CHECKOUT</div>
		<h1>Almost <span>There.</span></h1>
		<p>Confirm your address, choose payment mode, and place your order.</p>
	</div>

<%
User user = (User) session.getAttribute("loggedInUser");
Cart cart = (Cart) request.getAttribute("cart");
List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");

String couponCode = (String) request.getAttribute("couponCode");
String discountStr = (String) request.getAttribute("discountAmount");

double discountAmount = 0;

if (discountStr != null && !discountStr.equals("")) {
	discountAmount = Double.parseDouble(discountStr);
}

MenuDAOImpl menuDAO = new MenuDAOImpl();

double itemsTotal = 0;

if (cartItems != null) {
	for (CartItem item : cartItems) {
		Menu menu = menuDAO.getMenu(item.getMenuId());
		if (menu != null) {
			itemsTotal += menu.getPrice() * item.getQuantity();
		}
	}
}

double deliveryFee = cart.getDeliveryFee();
double platformFee = cart.getPlatformFee();
double gstAmount = cart.getGstAmount();

double grandTotal = itemsTotal + deliveryFee + platformFee + gstAmount - discountAmount;

if (grandTotal < 0) {
	grandTotal = 0;
}
%>

	<div class="cart-layout">

		<div class="cart-left">

			<div class="bill-box" style="position: static; max-width: 100%;">

				<div class="bill-heading">
					<div class="bill-icon">📍</div>
					<div>
						<h2>Delivery Details</h2>
						<div class="green-line"></div>
					</div>
				</div>

				<form action="${pageContext.request.contextPath}/placeOrder" method="post">

					<input type="hidden" name="couponCode" value="<%=couponCode != null ? couponCode : ""%>">
					<input type="hidden" name="discountAmount" value="<%=discountAmount%>">
					<input type="hidden" name="grandTotal" value="<%=grandTotal%>">

					<label>Delivery Address</label>
					<textarea name="deliveryAddress" required
						style="width:100%; height:100px; padding:15px; border-radius:16px; border:1px solid #dce9d8; margin:10px 0 20px;"><%=user != null ? user.getAddress() : ""%></textarea>

					<label>Special Instructions</label>
					<textarea name="specialInstructions"
						placeholder="Example: Less spicy, call before delivery..."
						style="width:100%; height:90px; padding:15px; border-radius:16px; border:1px solid #dce9d8; margin:10px 0 20px;"></textarea>

					<label>Payment Mode</label>
					<select name="paymentMode" required
						style="width:100%; height:55px; padding:12px; border-radius:16px; border:1px solid #dce9d8; margin:10px 0 25px;">
						<option value="COD">Cash On Delivery</option>
						<option value="UPI">UPI</option>
						<option value="CARD">Card</option>
					</select>

					<button type="submit" class="checkout-btn">
						<span>Place Order</span>
						<b>→</b>
					</button>

				</form>

			</div>

		</div>

		<div class="bill-box">

			<div class="bill-heading">
				<div class="bill-icon">🧾</div>
				<div>
					<h2>Order Summary</h2>
					<div class="green-line"></div>
				</div>
			</div>

			<div class="bill-row">
				<span>Items Total</span>
				<strong>₹<%=itemsTotal%></strong>
			</div>

			<div class="bill-row">
				<span>Delivery Fee</span>
				<strong>₹<%=deliveryFee%></strong>
			</div>

			<div class="bill-row">
				<span>Platform Fee</span>
				<strong>₹<%=platformFee%></strong>
			</div>

			<div class="bill-row">
				<span>GST</span>
				<strong>₹<%=gstAmount%></strong>
			</div>

			<div class="bill-row discount-row">
				<span>Discount</span>
				<strong>- ₹<%=discountAmount%></strong>
			</div>

			<div class="grand-total">
				<span>Grand Total</span>
				<strong>₹<%=grandTotal%></strong>
			</div>

		</div>

	</div>

</section>

</body>
</html>
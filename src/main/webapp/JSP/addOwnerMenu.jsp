<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User"%>

<%
User owner = (User) session.getAttribute("loggedInUser");

if (owner == null || !"RESTAURANT_OWNER".equals(owner.getRole())) {
	response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Menu Item | CraveCart</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
</head>

<body>

<div class="admin-layout">

	<aside class="sidebar">
		<h2>CraveCart</h2>

		<a href="<%=request.getContextPath()%>/ownerMenu">Menu</a>
		<a href="#">Orders</a>
		<a href="#">My Restaurant</a>
		<a href="<%=request.getContextPath()%>/adminLogout">Logout</a>
	</aside>

	<main class="main-content">

		<div class="page-header">
			<div>
				<h1>Add <span>Menu Item</span></h1>
				<p>Add a new food item to your restaurant menu.</p>
			</div>

			<a class="add-btn" href="<%=request.getContextPath()%>/ownerMenu">
				← Back
			</a>
		</div>

		<div class="form-container">

			<form action="<%=request.getContextPath()%>/addOwnerMenu" method="post">

				<label>Item Name</label>
				<input type="text" name="itemName" required>

				<label>Description</label>
				<textarea name="description" required></textarea>

				<label>Price</label>
				<input type="number" step="0.01" name="price" required>

				<label>Category</label>
				<input type="text" name="category" placeholder="Pizza / Biryani / Starter" required>

				<label>Image File Name</label>
				<input type="text" name="imageUrl" placeholder="example: pizza.webp" required>

				<label>Available</label>
				<select name="isAvailable">
					<option value="true">Available</option>
					<option value="false">Not Available</option>
				</select>

				<label>Veg / Non-Veg</label>
				<select name="isVeg">
					<option value="true">Veg</option>
					<option value="false">Non-Veg</option>
				</select>

				<label>Rating</label>
				<input type="number" step="0.1" name="rating" value="4.5" required>

				<label>Best Seller</label>
				<select name="isBestSeller">
					<option value="true">Yes</option>
					<option value="false">No</option>
				</select>

				<label>Spice Level</label>
				<select name="spiceLevel">
					<option value="Mild">Mild</option>
					<option value="Medium">Medium</option>
					<option value="Spicy">Spicy</option>
				</select>

				<label>Portion Size</label>
				<input type="text" name="portionSize" placeholder="Regular / Large / Full" required>

				<label>Discount Percentage</label>
				<input type="number" step="0.01" name="discountPercentage" value="0" required>

				<label>Recommended</label>
				<select name="isRecommended">
					<option value="true">Yes</option>
					<option value="false">No</option>
				</select>

				<button type="submit" class="submit-btn">
					Add Menu Item
				</button>

			</form>

		</div>

	</main>

</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Menu"%>

<%
Menu menu = (Menu) request.getAttribute("menu");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Edit Menu Item</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css">

</head>

<body>

<div class="admin-layout">

	<main class="main-content">

		<h1>Edit Menu Item</h1>

		<form action="${pageContext.request.contextPath}/updateOwnerMenu"
			  method="post">

			<input type="hidden"
				   name="menuId"
				   value="<%=menu.getMenuId()%>">

			Item Name

			<input type="text"
				   name="itemName"
				   value="<%=menu.getItemName()%>"
				   required>

			<br><br>

			Description

			<input type="text"
				   name="description"
				   value="<%=menu.getDescription()%>"
				   required>

			<br><br>

			Price

			<input type="number"
				   step="0.01"
				   name="price"
				   value="<%=menu.getPrice()%>"
				   required>

			<br><br>

			Category

			<input type="text"
				   name="category"
				   value="<%=menu.getCategory()%>"
				   required>

			<br><br>

			Image

			<input type="text"
				   name="imageUrl"
				   value="<%=menu.getImageUrl()%>"
				   required>

			<br><br>

			Rating

			<input type="number"
				   step="0.1"
				   name="rating"
				   value="<%=menu.getRating()%>"
				   required>

			<br><br>

			<input type="submit"
				   value="Update Menu">

		</form>

	</main>

</div>

</body>
</html>
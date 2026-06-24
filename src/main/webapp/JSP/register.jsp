<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>

	<h1>User Registration</h1>

		<form action="${pageContext.request.contextPath}/register" method="post">

		User Name:
		<input type="text" name="userName">
		<br><br>

		Email:
		<input type="email" name="email">
		<br><br>

		Password:
		<input type="password" name="password">
		<br><br>

		Address:
		<input type="text" name="address">
		<br><br>

		Role:
		<select name="role">
			<option value="Customer">Customer</option>
			<option value="Admin">Admin</option>
			<option value="Delivery Partner">Delivery Partner</option>
		</select>
		<br><br>

		<input type="submit" value="Register">

	</form>

</body>
</html>
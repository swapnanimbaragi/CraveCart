<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login | CraveCart</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css">
</head>

<body>

<div class="login-container">

	<div class="login-card">

		<h1>CraveCart Admin</h1>
		<p>Login to manage restaurants and orders</p>

		<%
		String error = request.getParameter("error");
		if (error != null) {
		%>
			<div class="error">Invalid email or password</div>
		<%
		}
		%>

		<form action="${pageContext.request.contextPath}/adminLogin" method="post">

			<label>Email</label>
			<input type="email" name="email" required>

			<label>Password</label>
			<input type="password" name="password" required>

			<button type="submit">Login</button>

		</form>

	</div>

</div>

<script src="${pageContext.request.contextPath}/js/admin.js"></script>

</body>
</html>
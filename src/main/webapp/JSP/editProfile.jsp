<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User"%>

<%
User user=(User)request.getAttribute("user");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Edit Profile</title>

<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/common.css">

<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/editProfile.css">

</head>

<body>

<header class="navbar">

<div class="logo">
CraveCart
</div>

<nav>

<a href="<%=request.getContextPath()%>/home">Home</a>

<a href="<%=request.getContextPath()%>/profile">
Profile
</a>

</nav>

</header>


<div class="edit-container">

<h1>Edit Profile</h1>

<form
action="<%=request.getContextPath()%>/updateProfile"
method="post">

<input
type="hidden"
name="userId"
value="<%=user.getUserId()%>">


<label>Name</label>

<input
type="text"
name="userName"
value="<%=user.getUserName()%>"
required>


<label>Email</label>

<input
type="email"
name="email"
value="<%=user.getEmail()%>"
required>


<label>Address</label>

<input
type="text"
name="address"
value="<%=user.getAddress()%>"
required>


<label>Password</label>

<input
type="password"
name="password"
value="<%=user.getPassword()%>"
required>


<button type="submit">

Save Changes

</button>

</form>

</div>

</body>

</html>
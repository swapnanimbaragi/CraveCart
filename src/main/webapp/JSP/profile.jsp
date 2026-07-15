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

<title>My Profile</title>

<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/common.css">

<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/profile.css">

</head>

<body>

<header class="navbar">

    <div class="logo">
        CraveCart
    </div>

    <nav>

        <a href="<%=request.getContextPath()%>/home">Home</a>

        <a href="<%=request.getContextPath()%>/home#restaurants">
            Restaurants
        </a>

        <a href="<%=request.getContextPath()%>/home#categories">
            Categories
        </a>

        <a href="<%=request.getContextPath()%>/orderHistory">
            My Orders
        </a>

        <a href="<%=request.getContextPath()%>/cart">
            Cart
        </a>

        <a href="<%=request.getContextPath()%>/profile"
           class="profile-btn active">

            👤 <%=user.getUserName()%>

        </a>

    </nav>

</header>



<div class="profile-container">

    <h1>My Profile</h1>

    <div class="profile-card">

        <div class="profile-header">

            <div class="avatar">
                👤
            </div>

            <a href="<%=request.getContextPath()%>/editProfile"
			class="edit-btn">
			    Edit
			</a>

        </div>

        <table>

            <tr>
                <td>Name</td>
                <td><%=user.getUserName()%></td>
            </tr>

            <tr>
                <td>Email</td>
                <td><%=user.getEmail()%></td>
            </tr>

            <tr>
                <td>Address</td>
                <td><%=user.getAddress()%></td>
            </tr>

            <tr>
                <td>Role</td>
                <td><%=user.getRole()%></td>
            </tr>

            <tr>
                <td>Member Since</td>
                <td><%=user.getCreatedDate()%></td>
            </tr>

        </table>

    </div>

    <div class="logout-box">

        <a href="<%=request.getContextPath()%>/logout"
           class="logout-btn">
           Logout
        </a>

    </div>

</div>

</div>

</body>

</html>
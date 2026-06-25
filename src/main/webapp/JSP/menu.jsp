<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Menu"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Menu | CraveCart</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/common.css">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/menu.css">

</head>

<body>

<!-- ================= NAVBAR START ================= -->

<header class="navbar">

    <div class="logo">CraveCart</div>

    <nav>
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/home#restaurants">Restaurants</a>
        <a href="#">Cart</a>
    </nav>

</header>

<!-- ================= NAVBAR END ================= -->


<!-- ================= PAGE TITLE ================= -->

<section class="menu-header">

    <h1>Explore Delicious Meals</h1>

    <p>
        Freshly prepared dishes waiting for you.
    </p>

</section>


<!-- ================= MENU ITEMS ================= -->

<section class="menu-section">

<div class="menu-container">

<%

List<Menu> menuList=(List<Menu>)request.getAttribute("menuList");

if(menuList!=null){

for(Menu menu:menuList){

%>

<div class="menu-card">

    <img src="${pageContext.request.contextPath}/images/<%=menu.getImageUrl()%>"
    alt="<%=menu.getItemName()%>">

    <div class="menu-info">

        <h3><%=menu.getItemName()%></h3>

        <p><%=menu.getDescription()%></p>

        <div class="menu-bottom">

            <span class="price">
                ₹<%=menu.getPrice()%>
            </span>

            <a href="#" class="add-btn">
                Add +
            </a>

        </div>

    </div>

</div>

<%

}

}

%>

</div>

</section>

</body>
</html>
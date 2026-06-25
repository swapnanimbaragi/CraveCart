<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Menu"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Menu | CraveCart</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
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

<section class="menu-header">
    <h1>Explore Delicious Meals</h1>
    <div class="title-line">✤</div>
    <p>Freshly prepared dishes waiting for you.</p>
</section>

<section class="menu-section">
    <div class="menu-container">

        <%
            List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");

            if(menuList != null && !menuList.isEmpty()) {
                for(Menu menu : menuList) {
        %>

        <div class="menu-card">

            <div class="menu-image-box">
                <img src="<%= request.getContextPath() %>/images/<%= menu.getImageUrl() %>"
                     alt="<%= menu.getItemName() %>">

                <% if(menu.isBestSeller()) { %>
                    <span class="best-badge">🔥 Best Seller</span>
                <% } %>

                <% if(menu.isVeg()) { %>
                    <span class="food-type veg-dot">● Veg</span>
                <% } else { %>
                    <span class="food-type nonveg-dot">● Non-Veg</span>
                <% } %>
            </div>

            <div class="menu-info">

                <div class="rating-row">
                    <span class="rating">⭐ <%= menu.getRating() %></span>
                    <span class="price">₹<%= menu.getPrice() %></span>
                </div>

                <h3><%= menu.getItemName() %></h3>

                <p><%= menu.getDescription() %></p>

                <div class="details-row">
                    <span>🌶 <%= menu.getSpiceLevel() %> Spice</span>
                    <span>🍽 <%= menu.getPortionSize() %></span>
                </div>

	                <div class="qty-box">
					    <button class="minus">-</button>
					    <span class="quantity">1</span>
					    <button class="plus">+</button>
					</div>

                    <a href="#" class="add-btn">🛒 Add +</a>
                </div>

            </div>

        </div>

        <%
                }
            } else {
        %>

        <p class="empty-menu">No menu items available.</p>

        <%
            }
        %>

    </div>
</section>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
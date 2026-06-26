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


<!-- ================= MENU HEADER START ================= -->
<section class="menu-header">

    <div class="section-badge">
        🍽 MENU COLLECTION
    </div>

    <h2>
        Crafted for
        <span>Every Craving</span>
    </h2>

    <p>
        Freshly prepared dishes, authentic flavors, and irresistible meals made just for you.
    </p>

</section>
<!-- ================= MENU HEADER END ================= -->


<!-- ================= MENU ITEMS START ================= -->
<section class="menu-section">

    <div class="food-grid">

        <%
            List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");

            if(menuList != null && !menuList.isEmpty()) {
                for(Menu menu : menuList) {
        %>

        <div class="food-card">

            <div class="food-image-box">
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

            <div class="food-info">

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

                <div class="cart-row">
                    <div class="qty-box">
                        <button type="button" class="minus">-</button>
                        <span class="quantity">1</span>
                        <button type="button" class="plus">+</button>
                    </div>

                    <form action="${pageContext.request.contextPath}/cart" method="post">

					    <input type="hidden" name="menuId"
					           value="<%=menu.getMenuId()%>">
					
					    <input type="hidden" name="restaurantId"
					           value="<%=menu.getRestaurantId()%>">
					
					    <input type="hidden" name="quantity"
					           class="qtyInput"
					           value="1">
					
					    <button type="submit" class="add-btn">
					         Add 
					    </button>
					
					</form>
					
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
<!-- ================= MENU ITEMS END ================= -->


<script src="${pageContext.request.contextPath}/js/menu.js"></script>

</body>
</html>
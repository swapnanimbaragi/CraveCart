<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CraveCart | Home</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>

<body>

<header class="navbar">
    <div class="logo">CraveCart</div>

    <nav>
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="#restaurants">Restaurants</a>
        <a href="#categories">Categories</a>
        <a href="#">My Orders</a>
        <a href="#">Contact</a>
    </nav>

    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
</header>


<section class="hero">
    <video autoplay muted playsinline class="hero-video" id="heroVideo">
        <source id="heroSource" src="${pageContext.request.contextPath}/videos/Veggs.mp4" type="video/mp4">
    </video>

    <div class="hero-overlay"></div>

    <div class="hero-content">
        <h1>
            From Your Favorite Kitchen
            <br>
            To Your Doorstep.
        </h1>

        <p>Discover top restaurants, fresh meals, and fast delivery with CraveCart.</p>

        <div class="search-box">
            <input type="text" placeholder="Search restaurants, cuisines or dishes...">
            <button>Search</button>
        </div>

        <div class="hero-buttons">
            <a href="#restaurants" class="main-btn">Explore Restaurants</a>
            <a href="#categories" class="secondary-btn">Browse Categories</a>
        </div>
    </div>
</section>


<section class="categories" id="categories">

    <div class="section-badge">🍽️ POPULAR CATEGORIES</div>

    <h2 class="category-title">
        Choose. Crave.
        <span>Celebrate.</span>
    </h2>

    <p class="category-subtitle">
        Every craving begins here. Fresh flavors, endless choices, delivered with love.
    </p>

    <div class="category-container">

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/biriyani.webp" alt="Biryani">
            <h3>Biryani</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/burger.webp" alt="Burger">
            <h3>Burger</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/chole.webp" alt="Chole">
            <h3>Chole</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/dosa.webp" alt="Dosa">
            <h3>South Indian</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/north.webp" alt="North Indian">
            <h3>North Indian</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/paneer.webp" alt="Paneer">
            <h3>Paneer</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/pizza.webp" alt="Pizza">
            <h3>Pizza</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/ramen.webp" alt="Ramen">
            <h3>Ramen</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/sweet.webp" alt="Desserts">
            <h3>Desserts</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/salad.webp" alt="Salad">
            <h3>Salad</h3>
        </div>

    </div>
</section>


<section class="restaurants" id="restaurants">

    <div class="section-badge">⭐ TOP RESTAURANTS</div>

    <h2>Curated for <span>Every Craving</span></h2>

    <p>
        Discover exceptional restaurants, signature dishes, and flavors you'll keep coming back for.
    </p>

    <div class="restaurant-container">

        <%
            List<Restaurant> restaurants =
                (List<Restaurant>) request.getAttribute("restaurants");

            if (restaurants != null && !restaurants.isEmpty()) {

                for (Restaurant restaurant : restaurants) {
        %>

        <div class="restaurant-card">

            <div class="restaurant-image">
                <img src="<%= request.getContextPath() %>/images/<%= restaurant.getRestaurantImg() %>"
                     alt="<%= restaurant.getRestaurantName() %>">

                <span class="time">⏱ <%= restaurant.getDeliveryTime() %> mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">

                <h3>
                    <%= restaurant.getRestaurantName() %>
                    <span class="verified">✔</span>
                </h3>

                <p><%= restaurant.getCuisineType() %></p>

                <div class="restaurant-meta">
                    <span>⭐ <%= restaurant.getRating() %></span>
                    <span>₹<%= restaurant.getMinimumOrderAmount() %>+</span>
                    <span><%= restaurant.getSignatureDish() %></span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag green">
                        <%= restaurant.getRestaurantTag() %>
                    </span>

                    <a href="<%= request.getContextPath() %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
                       class="menu-btn">
                        View Menu →
                    </a>
                </div>

            </div>

        </div>

        <%
                }
            }
            else {
        %>

        <p>No restaurants available.</p>

        <%
            }
        %>

    </div>

    <a href="#" class="view-all-btn">View All Restaurants →</a>

</section>


<section class="why">
    <h2>Why Choose CraveCart?</h2>

    <div class="why-container">

        <div class="why-card">
            <h3>🚀 Fast Delivery</h3>
            <p>Get your favorite meals delivered quickly.</p>
        </div>

        <div class="why-card">
            <h3>⭐ Top Rated</h3>
            <p>Order from trusted and highly rated restaurants.</p>
        </div>

        <div class="why-card">
            <h3>🎁 Offers</h3>
            <p>Enjoy exciting coupons and special discounts.</p>
        </div>

        <div class="why-card">
            <h3>🍽 Variety</h3>
            <p>Explore biryani, pizza, paneer, chicken and more.</p>
        </div>

    </div>
</section>


<footer>
    <h3>CraveCart</h3>
    <p>From your favorite kitchen to your doorstep.</p>
    <p>© 2026 CraveCart. All Rights Reserved.</p>
</footer>

<script src="${pageContext.request.contextPath}/js/home.js"></script>

</body>
</html>
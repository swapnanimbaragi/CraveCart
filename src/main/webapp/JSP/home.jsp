<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CraveCart | Home</title>

<!-- CSS FILES -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>

<body>

<!-- ================= NAVBAR START ================= -->
<header class="navbar">
    <div class="logo">CraveCart</div>

    <nav>
        <a href="#">Home</a>
        <a href="#restaurants">Restaurants</a>
        <a href="#categories">Categories</a>
        <a href="#">My Orders</a>
        <a href="#">Contact</a>
    </nav>

    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
</header>
<!-- ================= NAVBAR END ================= -->


<!-- ================= HERO SECTION START ================= -->
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
<!-- ================= HERO SECTION END ================= -->


<!-- ================= CATEGORY SECTION START ================= -->
<section class="categories" id="categories">
    <h2>Explore Food Categories</h2>
    <p>Choose from your favorite dishes and cuisines.</p>

    <div class="category-container">

        <!-- CATEGORY 1 -->
        <div class="category-card">
            <video autoplay muted loop playsinline>
                <source src="${pageContext.request.contextPath}/videos/Veggs.mp4" type="video/mp4">
            </video>
            <h3>Veg Specials</h3>
        </div>

        <!-- CATEGORY 2 -->
        <div class="category-card">
            <video autoplay muted loop playsinline>
                <source src="${pageContext.request.contextPath}/videos/Panner2.mp4" type="video/mp4">
            </video>
            <h3>Paneer Delights</h3>
        </div>

        <!-- CATEGORY 3 -->
        <div class="category-card">
            <video autoplay muted loop playsinline>
                <source src="${pageContext.request.contextPath}/videos/Biriyani.mp4" type="video/mp4">
            </video>
            <h3>Biryani</h3>
        </div>

        <!-- CATEGORY 4 -->
        <div class="category-card">
            <video autoplay muted loop playsinline>
                <source src="${pageContext.request.contextPath}/videos/Chicken.mp4" type="video/mp4">
            </video>
            <h3>Chicken</h3>
        </div>

        <!-- CATEGORY 5 -->
        <div class="category-card">
            <video autoplay muted loop playsinline>
                <source src="${pageContext.request.contextPath}/videos/Chicken2.mp4" type="video/mp4">
            </video>
            <h3>Spicy Bites</h3>
        </div>

    </div>
</section>
<!-- ================= CATEGORY SECTION END ================= -->


<!-- ================= RESTAURANT SECTION START ================= -->
<section class="restaurants" id="restaurants">
    <h2>Popular Restaurants Near You</h2>
    <p>Handpicked restaurants loved by food lovers.</p>

    <div class="restaurant-container">

        <!-- RESTAURANT CARD 1 -->
        <div class="restaurant-card">
            <img src="${pageContext.request.contextPath}/images/restaurant1.jpg" alt="Restaurant">

            <div class="restaurant-info">
                <h3>Meghana Foods</h3>
                <p>Biryani • South Indian</p>
                <span>⭐ 4.7</span>
                <span> • 30 mins</span>
                <p class="tag">Best Seller</p>

                <a href="${pageContext.request.contextPath}/menu?restaurantId=1">
                    View Menu
                </a>
            </div>
        </div>

        <!-- RESTAURANT CARD 2 -->
        <div class="restaurant-card">
            <img src="${pageContext.request.contextPath}/images/restaurant2.jpg" alt="Restaurant">

            <div class="restaurant-info">
                <h3>Pizza Hub</h3>
                <p>Pizza • Italian • Fast Food</p>
                <span>⭐ 4.5</span>
                <span> • 25 mins</span>
                <p class="tag">Hot Deals</p>

                <a href="${pageContext.request.contextPath}/menu?restaurantId=2">
                    View Menu
                </a>
            </div>
        </div>

        <!-- RESTAURANT CARD 3 -->
        <div class="restaurant-card">
            <img src="${pageContext.request.contextPath}/images/restaurant3.jpg" alt="Restaurant">

            <div class="restaurant-info">
                <h3>Green Bowl</h3>
                <p>Veg • Healthy • Salads</p>
                <span>⭐ 4.6</span>
                <span> • 20 mins</span>
                <p class="tag">Recommended</p>

                <a href="${pageContext.request.contextPath}/menu?restaurantId=3">
                    View Menu
                </a>
            </div>
        </div>

    </div>
</section>
<!-- ================= RESTAURANT SECTION END ================= -->


<!-- ================= WHY CHOOSE SECTION START ================= -->
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
<!-- ================= WHY CHOOSE SECTION END ================= -->


<!-- ================= FOOTER START ================= -->
<footer>
    <h3>CraveCart</h3>
    <p>From your favorite kitchen to your doorstep.</p>
    <p>© 2026 CraveCart. All Rights Reserved.</p>
</footer>
<!-- ================= FOOTER END ================= -->

<script src="${pageContext.request.contextPath}/js/home.js"></script>

</body>
</html>
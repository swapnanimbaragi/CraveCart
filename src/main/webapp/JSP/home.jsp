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
    <h2>Choose. Crave. Celebrate.</h2>
    <p>Every craving begins here. Fresh flavors, endless choices, delivered with love.</p>

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
            <h3>Chole Bhature</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/dosa.webp" alt="Dosa">
            <h3>Dosa Idali</h3>
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
<!-- ================= CATEGORY SECTION END ================= -->


<!-- ================= RESTAURANTS SECTION START ================= -->
<section class="restaurants" id="restaurants">

    <h2>Top Restaurants Around You</h2>
    <p>
        Handpicked restaurants serving delicious meals with fast delivery.
    </p>

    <div class="restaurant-container">

        <!-- Restaurant 1 -->
        <div class="restaurant-card">
            <img src="${pageContext.request.contextPath}/images/meghana.webp">
            <div class="restaurant-info">
                <h3>Meghana Foods</h3>

                <p>Biryani • Andhra</p>

                <div class="restaurant-details">
                    <span>⭐ 4.8</span>
                    <span>25 mins</span>
                </div>

                <div class="restaurant-tag">
                    Best Seller
                </div>

                <a href="#">View Menu</a>
            </div>
        </div>

        <!-- Restaurant 2 -->
        <div class="restaurant-card">
            <img src="${pageContext.request.contextPath}/images/empire.webp">

            <div class="restaurant-info">
                <h3>Empire Restaurant</h3>

                <p>North Indian • Mughlai</p>

                <div class="restaurant-details">
                    <span>⭐ 4.6</span>
                    <span>30 mins</span>
                </div>

                <div class="restaurant-tag">
                    Open Late
                </div>

                <a href="#">View Menu</a>
            </div>
        </div>

        <!-- Restaurant 3 -->
        <div class="restaurant-card">

            <img src="${pageContext.request.contextPath}/images/pizzahut.webp">

            <div class="restaurant-info">

                <h3>Pizza Hut</h3>

                <p>Pizza • Italian</p>

                <div class="restaurant-details">
                    <span>⭐ 4.5</span>
                    <span>28 mins</span>
                </div>

                <div class="restaurant-tag">
                    Cheesy Favourite
                </div>

                <a href="#">View Menu</a>

            </div>

        </div>

        <!-- Restaurant 4 -->

        <div class="restaurant-card">

            <img src="${pageContext.request.contextPath}/images/dominos.webp">

            <div class="restaurant-info">

                <h3>Domino's Pizza</h3>

                <p>Pizza • Fast Food</p>

                <div class="restaurant-details">

                    <span>⭐ 4.4</span>

                    <span>20 mins</span>

                </div>

                <div class="restaurant-tag">
                    Fast Delivery
                </div>

                <a href="#">View Menu</a>

            </div>

        </div>

        <!-- Restaurant 5 -->

        <div class="restaurant-card">

            <img src="${pageContext.request.contextPath}/images/kfc2.jpg">

            <div class="restaurant-info">

                <h3>KFC</h3>

                <p>Chicken • Burgers</p>

                <div class="restaurant-details">

                    <span>⭐ 4.5</span>

                    <span>22 mins</span>

                </div>

                <div class="restaurant-tag">
                    Crispy Chicken
                </div>

                <a href="#">View Menu</a>

            </div>

        </div>

        <!-- Restaurant 6 -->

        <div class="restaurant-card">

            <img src="${pageContext.request.contextPath}/images/california.webp">

            <div class="restaurant-info">

                <h3>California Burrito</h3>

                <p>Mexican • Healthy</p>

                <div class="restaurant-details">

                    <span>⭐ 4.7</span>

                    <span>24 mins</span>

                </div>

                <div class="restaurant-tag">
                    Healthy Choice
                </div>

                <a href="#">View Menu</a>

            </div>

        </div>

        <!-- Restaurant 7 -->

        <div class="restaurant-card">

            <img src="${pageContext.request.contextPath}/images/beijingbites.webp">

            <div class="restaurant-info">

                <h3>Beijing Bites</h3>

                <p>Chinese</p>

                <div class="restaurant-details">

                    <span>⭐ 4.5</span>

                    <span>26 mins</span>

                </div>

                <div class="restaurant-tag">
                    Chinese Special
                </div>

                <a href="#">View Menu</a>

            </div>

        </div>

        <!-- Restaurant 8 -->

        <div class="restaurant-card">

            <img src="${pageContext.request.contextPath}/images/a2b.webp">

            <div class="restaurant-info">

                <h3>A2B</h3>

                <p>South Indian</p>

                <div class="restaurant-details">

                    <span>⭐ 4.6</span>

                    <span>18 mins</span>

                </div>

                <div class="restaurant-tag">
                    Pure Veg
                </div>

                <a href="#">View Menu</a>

            </div>

        </div>

        <!-- Restaurant 9 -->

        <div class="restaurant-card">

            <img src="${pageContext.request.contextPath}/images/bbq2.jpg">

            <div class="restaurant-info">

                <h3>Barbeque Nation</h3>

                <p>BBQ • Grill</p>

                <div class="restaurant-details">

                    <span>⭐ 4.7</span>

                    <span>35 mins</span>

                </div>

                <div class="restaurant-tag">
                    Premium Dining
                </div>

                <a href="#">View Menu</a>

            </div>

        </div>

    </div>

</section>
<!-- ================= RESTAURANTS SECTION END ================= -->


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